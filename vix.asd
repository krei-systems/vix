;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; vix.asd --- top-level ASDF file for vix

(defsystem #:vix
    :name "vix"
    :long-name "vix"
    :description ""
    :long-description ""
    :version (:read-file-form #P"version.lisp")
    :author "Rommel Martínez <ebzzry@icloud.com>"
    :license ""
    :homepage ""
    :bug-tracker ""
    :source-control ""
    :class :package-inferred-system
    :depends-on (#:marie
                 #:clingon
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
                 #:vix/src/nar
                 #:vix/src/main
                 #:vix/src/driver
                 #:vix/src/user)
    :in-order-to ((test-op (test-op "vix-tests")))
    :build-operation "program-op"
    :build-pathname "vix"
    :entry-point "vix/src/main:main")
