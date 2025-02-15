;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; derivation.lisp --- work with derivations

(uiop:define-package #:vix/src/derivation
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/derivation)

(define-command derivation add (a)
  "add a store derivation"
  "path"
  nil
  t
  nil
  "Add a derivation"
  "v a path")

(define-command derivation show (s)
  "show the contents of a store derivation"
  "derivation"
  t
  t
  nil
  "Show the `hello' derivation"
  "v s nixpkgs#hello")

(define-sub-commands derivation
  add show)

(define-command nil derivation (v)
  "work with derivations"
  "command"
  nil
  #'usage
  t)
