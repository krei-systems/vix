;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; search.lisp --- search packages

(uiop:define-package #:vix/src/search
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/search)

(define-command nil search (s)
  "search for packages"
  "package..."                          ; usage
  nil                                   ; options
  nil                                   ; handler
  nil                                   ; sub
  "Search in Nixpkgs for packages named `firefox'"
  "search nixpkgs firefox")
