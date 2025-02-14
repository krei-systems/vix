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

(defv- *vix-config*
  (uiop:merge-pathnames* "vix.lisp"
                         (home ".config/vix/"))
  "The default location of Vix config.")

(def- read-config ()
  "Read the contents of the vix config."
  (mapcar #'read-from-string (uiop:read-file-lines *vix-config*)))

(def- default-flake ()
  "Return the default flake."
  (destructuring-bind (flake &rest args)
      (read-config)
    (declare (ignore args))
    flake))

(def pipe-args (args)
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

(defm define-options (name &rest args)
  "Return a list for defining options."
  (let ((%fname (read-from-string (cat (prin1-to-string name) "/OPTIONS")))
        (%description (fmt "Return the options for the `~A' command." name)))
    `(def- ,%fname ()
       ,%description
       (append
        (list
         ;; (clingon:make-option :flag
         ;;                           :description "toggle Nixpkgs"
         ;;                           :short-name #\n
         ;;                           :long-name "nixpkgs"
         ;;                           :required nil
         ;;                           :key :opt-nixpkgs)
         )
        ,@args))))

(defm define-handler (name command)
  "Define a function for handling command."
  (let ((%fname (read-from-string (cat (prin1-to-string name) "/HANDLER")))
        (%description (fmt "The handler for the `~A' command." name)))
    `(def- ,%fname (cmd)
       ,%description
       (let* ((args (clingon:command-arguments cmd))
              (opt-nixpkgs (clingon:getopt cmd :opt-nixpkgs))
              (final-args (cond (opt-nixpkgs (append ',command (uiop:split-string (pipe-args args))))
                                (t (append ',command args)))))
         (apply #'nrun final-args)))))

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

(defm define-command (group cmd aliases
                      desc
                      usage options handler
                      &rest examples)
  "Return a function for CLINGON:MAKE-COMMAND."
  (let* ((%group (when group (prin1-downcase group)))

         (%cmd-raw (prin1-downcase (get-raw-name cmd)))
         (%cmd (prin1-downcase (get-name cmd)))

         (%fn (read-cat %cmd "/command"))

         (%aliases (when aliases (mapcar #'prin1-downcase aliases)))
         (%options (read-cat %cmd "/options"))
         (%handler (read-cat "#'" %cmd "/handler")))
    `(def ,%fn ()
       (clingon:make-command
        :name ,%cmd
        :aliases ',%aliases
        :description ,desc
        :usage (if (null ,usage) "[option...]" ,usage)
        :options (if (eql t ,options)
                     (,%options)
                     ,options)
        :handler (cond ((eql t ,handler) ,%handler)
                       ((null ,handler)
                        (lambda (cmd)
                          (let* ((args (clingon:command-arguments cmd))
                                 (grp ,%group)
                                 (final-args
                                   (if grp
                                       (list grp ,%cmd-raw args)
                                       (list ,%cmd-raw args))))
                            (apply #'nrun final-args))))
                       (t ,handler))
        :examples (mini-help ,@examples)))))
