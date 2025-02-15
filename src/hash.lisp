;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; hash.lisp --- compute and convert cryptographic hashes

(uiop:define-package #:vix/src/hash
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/hash)

(define-command hash file (f)
  "print hash of a regular file"
  "file"
  nil
  t
  nil
  "Print hash of `file.txt'"
  "h f file.txt")

(define-command hash path (p)
  "print hash of the NAR serialisation of a path"
  "path"
  nil
  t
  nil
  "Print hash of path `/foo/bar/'"
  "h p /foo/bar/")

(define-command hash convert (c)
  "convert between hash formats"
  "path"
  nil
  t
  nil
  "Convert a hash"
  "h c -- --hash-algo sha1 800d59cfcd3c05e900cb4e214be48f6b886a08df")

(define-sub-commands hash
  file path convert)

(define-command nil hash (h)
  "compute and convert cryptographic hashes"
  "command"
  nil
  #'usage
  t)
