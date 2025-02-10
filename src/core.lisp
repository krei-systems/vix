;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; core.lisp --- core functions

(uiop:define-package #:vix/src/core
  (:use #:cl
        #:marie))

(in-package #:vix/src/core)


;;; utils

(def run! (cmd)
  "Run CMD."
  (uiop:run-program cmd :input :interactive :output :interactive :error-output :interactive))

(def nrun (&rest args)
  "Use the command `nix' to run ARGS."
  (run! (append (list "nix") (flatten-list args))))

(def pipe-args (args)
  "Return a string from ARGS suitable for the `install' command."
  (format nil "~{nixpkgs#~A~^ ~}" args))

(def or-args (args)
  "Return a string from ARGS suitable for the `search' command."
  (format nil "~{~A~^|~}" args))

(def mini-help (&rest args)
  "Return a list suitable for the example usage of a command."
  (let ((parts (partition args 2)))
    (loop :for (desc usage) :in parts
          :collect (cons (fmt "~A:" desc) usage))))

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
        (list (clingon:make-option :flag
                                   :description "toggle Nixpkgs"
                                   :short-name #\n
                                   :long-name "nixpkgs"
                                   :required nil
                                   :key :opt-nixpkgs))
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

(defm define-command (sname fname aliases
                      desc
                      usage options handler
                      &rest examples)
  "Return a function for CLINGON:MAKE-COMMAND."
  (let* ((%sname (when sname (prin1-downcase sname)))
         (%fname (prin1-downcase fname))
         (%aliases (when aliases (mapcar #'prin1-downcase aliases)))
         (%options (read-cat %fname "/options"))
         (%handler-name (read-cat "#'" %fname "/handler"))
         (%fn-name (read-cat %fname "/command")))
    `(def ,%fn-name ()
       (clingon:make-command
        :name ,%fname
        :aliases ',%aliases
        :description ,desc
        :usage (if (null ,usage) "[option...]" ,usage)
        :options (if (eql t ,options)
                     (,%options)
                     ,options)
        :handler (cond ((eql t ,handler) ,%handler-name)
                       ((null ,handler)
                        (lambda (cmd)
                          (let* ((args (clingon:command-arguments cmd))
                                 (sub ,%sname)
                                 (final-args
                                   (if sub
                                       (list sub ,%fname args)
                                       (list ,%fname args))))
                            (apply #'nrun final-args))))
                       (t ,handler))
        :examples (mini-help ,@examples)))))
