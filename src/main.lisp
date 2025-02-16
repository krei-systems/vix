;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; main.lisp --- main entry point

(uiop:define-package #:vix/src/main
  (:use #:cl
        #:marie
        #:vix/src/specials
        #:vix/src/core
        #:vix/src/registry
        #:vix/src/rebuild
        #:vix/src/profile
        #:vix/src/flake
        #:vix/src/store
        #:vix/src/etc
        #:vix/src/config
        #:vix/src/derivation
        #:vix/src/hash
        #:vix/src/key
        #:vix/src/nar))

(in-package #:vix/src/main)


;;; fns

(def- main/options ()
  "Return the options for the main command."
  (list
   (clingon:make-option :counter
                        :description "Verbosity"
                        :short-name #\v
                        :long-name "verbose"
                        :key :verbose)))

(define-command nil zsh-completions (zsh)
  "generate the Zsh completion script"
  ""
  nil
  (lambda (cmd)
    (let ((parent (clingon:command-parent cmd)))
      (clingon:print-documentation :zsh-completions parent t)))
  nil
  "Generate the Zsh completions of Vix and enable them"
  "zsh-completions > ~/.zsh-completions/_vix
cat >>! ~/.zshenv << EOF
fpath=(~/.zsh-completions $fpath)
autoload -U compinit
compinit
EOF")

(define-command nil print-doc (doc)
  "print the documentation"
  ""
  nil
  (lambda (cmd)
    (clingon:print-documentation :markdown (clingon:command-parent cmd) t))
  nil
  "Generate the Markdown documentation of Vix and save it to README.md"
  "print-doc > README.md")

(def main/sub-commands ()
  "Return the list of sub-commands for the main command"
  (macrolet ((%mac (&rest commands)
               `(list
                 ,@(loop :for command :in commands
                         :for name := (read-cat command '/command)
                         :collect `(,name)))))
    (%mac profile
          flake
          develop
          make
          rebuild
          search
          find
          run
          repl
          registry
          store
          eval
          shell
          build
          bundle
          copy
          edit
          daemon
          config
          hash
          key
          nar
          fmt
          path-info
          derivation
          why-depends
          print-dev-env
          realisation
          upgrade-nix
          collect-garbage
          zsh-completions
          print-doc)))

(def- main/handler (cmd)
  "The handler for the main command. Prints the command usage."
  (clingon:print-usage-and-exit cmd t))

(def- main/command ()
  "Return the main command"
  (clingon:make-command
   :name +project-name+
   :version +project-version+
   :description "a program for interacting with the Nix ecosystem"
   :handler #'main/handler
   :options (main/options)
   :sub-commands (main/sub-commands)))


;;; entry point

(def main (&rest args)
  "The main entry point of the program."
  (let ((app (main/command)))
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
