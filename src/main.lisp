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
        #:vix/src/ext
        #:vix/src/config
        #:vix/src/derivation
        #:vix/src/hash
        #:vix/src/key
        #:vix/src/nar))

(in-package #:vix/src/main)


;;; entry point

(define-main-command
    (("verbose" "verbosity" :counter 0))
    (profile
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
     print-doc))

(define-main)
