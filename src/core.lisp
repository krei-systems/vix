;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; core.lisp --- core functions

(uiop:define-package #:vix/src/core
  (:use #:cl
        #:marie
        #:vix/src/specials))

(in-package #:vix/src/core)


;;; utils

(def run! (cmd)
  "Run CMD."
  (uiop:run-program cmd :input :interactive :output :interactive :error-output :interactive))

(def nrun (&rest args)
  "Use the command `nix' to run ARGS."
  (run! (append (list "nix") (flatten-list args))))

(defv- *nix-directory*
  (uiop:subpathname (asdf:system-source-directory (asdf:find-system :vix))
                    #P"nix/")
  "The location of the nix skeleton files.")

(def nix-path (path)
  "Return a path from PATH relevant to the project directory."
  (uiop:subpathname *nix-directory* path))

(defv- *vix-config*
  (uiop:merge-pathnames* "vix.lisp" (home ".config/vix/"))
  "The default location of vix config.")

(def- read-config (&optional key)
  "Read the contents of the vix config."
  (let ((expr (uiop:read-file-form *vix-config*)))
    (if key
        (getf expr key)
        expr)))

(def- default-flake ()
  "Return the default flake."
  (read-config :flake))

(def fence-args (args)
  (let* ((flake (default-flake))
         (fmt-args (if (empty-string-p flake)
                       `("~{~A~^ ~}" ,args)
                       `(,(cat "~{" flake "#~A~^ ~}") ,args))))
    (apply #'format nil fmt-args)))

(def or-args (args)
  "Return a string from ARGS suitable for the `search' command."
  (format nil "~{~A~^|~}" args))

(def mini-help (&rest args)
  "Return a list suitable for the example usage of a command."
  (let ((parts (partition args 2)))
    (loop :for (desc usage) :in parts
          :collect (cons (fmt "~A:" desc) (fmt "~A ~A" +project-name+ usage)))))

(def cmd-handler (cmd fn)
  "Define a function that parses the command arguments from CCMD and runs the
Nix command CMD from it."
  (let ((args (clingon:command-arguments cmd)))
    (funcall fn args)))


;;; entry points

(def- prefix-command (prefix cmd)
  "Return a prefix string for CMD if PREFIX is true."
  (let ((prefix-string (if prefix (prin1-to-string prefix) "")))
    (if (¬ (empty-string-p prefix-string))
        (cat prefix-string "/" cmd)
        cmd)))

(defm make-opt (name type value &rest rest)
  "Return an option object from NAME."
  (let* ((%name name)
         (%char (aref %name 0))
         (%opt-name (read-cat ":" "opt-" %name))
         (%desc (fmt "use the `~A' option" %name)))
    `(clingon:make-option
      ,type
      :description ,%desc
      :short-name ,%char
      :long-name ,%name
      :required nil
      :key ,%opt-name
      :initial-value ,value
      ,@rest)))

(defm define-options (group command &rest args)
  "Return a list for defining options."
  (flet ((prefix (command)
           (prefix-command group command)))
    (let ((%fn (read-cat (prefix command) '/options))
          (%doc (fmt "Return the options for the `~A' command." command)))
      `(def- ,%fn ()
         ,%doc
         (append
          (list (make-opt "nixpkgs" :flag :true))
          ,@args)))))

(def usage (cmd)
  "Print usage of CMD then exit."
  (clingon:print-usage-and-exit cmd t))

(defm define-handler (group command command-list)
  "Define a handler for COMMAND."
  (flet ((prefix (command)
           (prefix-command group command)))
    (let ((%fn (read-cat (prefix command) '/handler))
          (%doc (fmt "The handler for the `~A' command." command)))
      `(def- ,%fn (cmd)
         ,%doc
         (let* ((args (clingon:command-arguments cmd))
                (opt-nixpkgs (clingon:getopt cmd :opt-nixpkgs))
                (final-args (cond (opt-nixpkgs
                                   (append ',command-list
                                           (uiop:split-string (fence-args args))))
                                  (t (append ',command-list args)))))
           (apply #'nrun final-args))))))

(defm define-basic-handler (group command)
  "Define a basic handler for handling COMMAND."
  (flet ((prefix (command)
           (prefix-command group command)))
    (let ((%fn (read-cat (prefix command) '/handler))
          (%doc (fmt "The basic handler for the `~A' command." command)))
      `(def- ,%fn (cmd)
         ,%doc
         (if (null args)
             (usage cmd)
             (apply #'nrun final-args))))))

(def- split-name (symbol &key (separator '(#\^)))
  "Return the split of SYMBOL by SEPARATOR."
  (uiop:split-string (prin1-to-string symbol) :separator separator))

(def- get-raw-name (symbol)
  (destructuring-bind (main-name &optional alt-name)
      (split-name symbol)
    (declare (ignore alt-name))
    (read-from-string main-name)))

(def- get-name (symbol)
  (destructuring-bind (main-name &optional alt-name)
      (split-name symbol)
    (declare (ignorable alt-name))
    (if alt-name
        (read-from-string alt-name)
        (read-from-string main-name))))

(defm define-sub-commands (name &rest sub-commands)
  "Return a list of subcommands for NAME from ARGS."
  (let ((%name (read-cat name '/sub-commands)))
    `(def- ,%name ()
       (list
        ,@(loop :for command :in sub-commands
                :for fname := (read-cat name #\/ command '/command)
                :collect `(,fname))))))

(defm define-command (group command aliases
                      description
                      usage
                      options
                      handler
                      sub-command
                      &rest examples)
  "Define a function for CLINGON:MAKE-COMMAND.

GROUP is the name of the group, like `flake'.

COMMAND is the name of the command from a group, or standalone, like `init'.

ALIASES is a list of alternative names, like `i' for `init'.

DESCRIPTION is the command description that will show up in help.

OPTIONS is the name of the function, that will be called to the program options;
or T, which means to generate a default set of options.

HANDLER is a function object that accepts a single argument that will handle the
command itself; T to define a handler that accepts a group and (sub) command; or
NIL to define a basic handler that acts like T, but without the group parameter.

SUB-COMMAND is T, to indicate that the command being defined will handle
sub-commands.

EXAMPLES is a list of description & command-line usage pairs for the command.
"
  (flet ((prefix (command)
           (prefix-command group command)))
    (let* ((%group (when group (prin1-downcase group)))
           (%command-raw (prin1-downcase (get-raw-name command)))
           (%command (prin1-downcase (get-name command)))
           (%aliases (when aliases (mapcar #'prin1-downcase aliases)))
           (%fn (read-cat (prefix %command) '/command))
           (%options (read-cat (prefix %command) '/options))
           (%handler (read-cat "#'" (prefix %command) '/handler))
           (%sub-commands (read-cat (prefix %command) '/sub-commands)))
      `(progn
         ,(when (eql t options) `(define-options ,group ,command))
         ,(cond ((eql t handler)
                 `(define-handler ,group ,command (,%group ,%command-raw)))
                ((null handler)
                 `(define-basic-handler ,group ,command))
                (t nil))
         (def ,%fn ()
           (clingon:make-command
            :name ,%command
            :aliases ',%aliases
            :description ,description
            :usage ,(if (null usage) "[argument...|option...]" usage)
            :options ,(cond ((eql t options)
                             `(,%options))
                            (t options))
            :handler ,(cond ((∨ (eql t handler) (null handler))
                             %handler)
                            (t handler))
            ,@(when sub-command `(:sub-commands (,%sub-commands)))
            ,@(when examples `(:examples (mini-help ,@examples)))))))))
