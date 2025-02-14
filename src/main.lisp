;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; main.lisp --- main entry point

(uiop:define-package #:vix/src/main
  (:use #:cl
        #:marie
        #:vix/src/specials
        #:vix/src/core
        #:vix/src/rebuild
        #:vix/src/search
        #:vix/src/profile
        #:vix/src/flake
        #:vix/src/develop
        #:vix/src/etc
        #:vix/src/registry
        #:vix/src/config
        #:vix/src/derivation
        #:vix/src/hash
        #:vix/src/key
        #:vix/src/nar
        #:vix/src/store))

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

(def- zsh-completion/command ()
  "Returns a command for generating the Zsh completion script"
  (clingon:make-command
   :name "zsh-completion"
   :description "generate the Zsh completion script"
   :usage ""
   :handler (lambda (cmd)
              (let ((parent (clingon:command-parent cmd)))
                (clingon:print-documentation :zsh-completions parent t)))))

(defun print-doc/command ()
  "Returns a command which will print the app's documentation"
  (clingon:make-command
   :name "print-doc"
   :description "print the documentation"
   :usage ""
   :handler (lambda (cmd)
              (clingon:print-documentation :markdown (clingon:command-parent cmd) t))))

(def top-level/sub-commands ()
  "Returns the list of sub-commands for the top-level command"
  (macrolet ((%mac (&rest commands)
               `(list
                 ,@(loop :for command :in commands
                         :for name := (read-cat command "/command")
                         :collect `(,name)))))
    (%mac install
          remove
          upgrade
          list
          rollback
          history
          wipe-history
          diff-closures

          init
          metadata
          show
          update
          new
          clone
          check
          archive
          prefetch

          rebuild
          search

          develop
          make

          build
          run
          bundle
          copy
          edit
          eval
          fmt
          repl

          path-info
          why-depends
          env-shell
          print-dev-env
          daemon
          realisation-info
          upgrade-nix

          registry-add
          registry-pin
          registry-remove
          registry-list

          config-show
          config-check

          derivation-add
          derivation-show

          hash-file
          hash-path
          hash-convert

          key-convert
          key-generate

          nar-cat
          nar-dump-path
          nar-ls

          store-add
          store-cat
          store-copy-log
          store-copy-sigs
          store-delete
          store-diff-closures
          store-dump-path
          store-gc
          store-info
          store-ls
          store-make-content-addressed
          store-optimise
          store-path-from-hash-part
          store-prefetch-file
          store-repair
          store-sign
          store-verify

          zsh-completion
          print-doc)))

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
