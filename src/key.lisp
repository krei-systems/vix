;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; key.lisp --- generate and convert Nix signing keys

(uiop:define-package #:vix/src/key
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/key)

(define-command key convert (c)
  "generate a public key for verifying store paths"
  "<key>"
  nil
  t
  nil
  "Convert a secret key to a public key"
  "k c foo")

(define-command key generate (g)
  "generate a secret key for signing store paths"
  ""
  nil
  t
  nil
  "Generate a new secret key"
  "k g -- --key-name cache.example.org-1 > ./secret-key")

(define-command nil key (k)
  "generate and convert Nix signing keys"
  "<command>"
  nil
  #'print-usage
  (convert generate))
