;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; vix-tests.asd --- test ASDF file for vix

(defsystem #:vix-tests
    :name "vix-tests"
    :long-name "vix"
    :description ""
    :long-description ""
    :version (:read-file-form #P"version-tests.lisp")
    :author "Rommel Martínez <ebzzry@icloud.com>"
    :license ""
    :homepage ""
    :bug-tracker ""
    :source-control ""
    :class :package-inferred-system
    :depends-on (#:fiveam
                 #:marie
                 #:vix
                 #:vix/t/core-tests
                 #:vix/t/driver-tests
                 #:vix/t/user-tests)
    :perform (test-op (o c) (uiop:symbol-call :vix/t/core-tests :run-tests)))
