;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; develop.lisp --- run a dev shell

(uiop:define-package #:vix/src/develop
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/develop)

(def- develop/options ()
  "Return the options for the `develop' command."
  (list
   (clingon:make-option :string
                        :description "command"
                        :short-name #\c
                        :long-name "command"
                        :required nil
                        :key :opt-command)))

(def- develop/handler (cmd)
  "Handler for the `devolp' command."
  (let* ((args (clingon:command-arguments cmd))
         (opt-command (clingon:getopt cmd :opt-command))
         (full-args (append args
                            (when opt-command '("--command")))))
    (nrun "develop" full-args)))

(define-command nil develop (d)
  "rebuild the system"
  "[-c]"
  (develop/options)
  #'develop/handler
  nil
  "Run a dev shell"
  "d"
  "Run a dev and run `make' inside"
  "d -c make")

(define-command nil make (m)
  "run make inside a dev shell"
  nil
  nil
  (lambda (cmd)
    (let ((args (clingon:command-arguments cmd)))
      (nrun "develop" "--command" "make" args)))
  nil
  "Run `make' inside a dev shell"
  "m")
