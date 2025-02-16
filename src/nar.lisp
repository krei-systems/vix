;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; nar.lisp --- create or inspect NAR files

(uiop:define-package #:vix/src/nar
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/nar)

(define-command nar cat (c)
  "print the contents of a file inside a NAR file on stdout"
  "<file>"
  nil
  t
  nil
  "To display a file in a NAR file"
  "n c ./hello.nar /share/man/man1/hello.1.gz | gunzip")

(define-command nar dump-path (d)
  "serialise a path to stdout in NAR format"
  "<path>"
  nil
  t
  nil
  "To serialise directory `foo' as a NAR file"
  "n d ./foo > foo.nar")

(define-command nar ls (l)
  "show information about a path inside a NAR file"
  "<path>"
  nil
  t
  nil
  "To list a specific file in a NAR file"
  "n l -- --long ./hello.nar /bin/hello")

(define-sub-commands nar
  cat dump-path ls)

(define-command nil nar (n)
  "create or inspect nar files"
  "<command>"
  nil
  #'print-usage
  t)
