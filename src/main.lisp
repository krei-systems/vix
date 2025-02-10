;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; main.lisp --- main entry point

(uiop:define-package #:vix/src/main
  (:use #:cl
        #:marie
        #:vix/src/specials
        #:vix/src/core
        #:vix/src/rebuild
        #:vix/src/profile
        #:vix/src/flake
        #:vix/src/search
        #:vix/src/develop
        #:vix/src/etc
        #:vix/src/registry
        #:vix/src/config))

(in-package #:vix/src/main)


;;; fns

(def- top-level/options ()
  "Return the options for the top-level command."
  (list
   (clingon:make-option :counter
                        :description "Verbosity"
                        :short-name #\v
                        :long-name "verbose"
                        :key :verbose)))

(def- top-level/sub-commands ()
  "Returns the list of sub-commands for the top-level command"
  (macrolet ((%list (&rest commands)
               `(list
                 ,@(loop :for command :in commands
                         :for name := (read-cat command "/command")
                         :collect `(,name)))))
    (%list install remove upgrade list rollback history wipe-history diff-closures
           rebuild search
           init metadata show update new clone check archive prefetch
           develop make
           build run bundle copy edit eval fmt repl why-depends
           registry-add registry-remove registry-list registry-pin
           config-show config-check)))

(def- top-level/handler (cmd)
  "The handler for the top-level command. Prints the command usage."
  (clingon:print-usage-and-exit cmd t))

(def- top-level/command ()
  "Return the top-level command"
  (clingon:make-command
   :name +project-name+
   :version +project-version+
   :description +project-name+
   :long-description (fmt "~:(~A~) is a program for interacting with the Nix ecosystem" +project-name+)
   :authors '("Rommel Martínez <ebzzry@icloud.com>")
   :handler #'top-level/handler
   :options (top-level/options)
   :sub-commands (top-level/sub-commands)))


;;; entry point

(def main (&rest args)
  "The main entry point of the program."
  (let ((app (top-level/command)))
    (handler-case (clingon:run app)
      (#+sbcl sb-sys:interactive-interrupt
       #+ccl ccl:interrupt-signal-condition
       #+clisp system::simple-interrupt-condition
       #+ecl ext:interactive-interrupt
       #+allegro excl:interrupt-signal
       #+lispworks mp:process-interrupt
       () nil)
      (error (c)
        (format t "Oof, an unknown error occured:~&~A~&" c)))))
