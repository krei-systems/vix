;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; config.lisp --- config the Nix settings

(uiop:define-package #:vix/src/config
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/config)

(define-command config show^config-show ()
  "show the Nix configuration or the value of a specific setting"
  nil nil nil
  "Show configuration"
  "config-show")

(define-command config check^config-check ()
  "check your system for potential problems"
  nil nil nil
  "Check for problems"
  "config-check")
