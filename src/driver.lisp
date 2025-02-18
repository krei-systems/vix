;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; driver.lisp --- symbol driver

(uiop:define-package #:vix/src/driver
  (:nicknames #:vix)
  (:use #:uiop/common-lisp)
  (:use-reexport #:vix/src/specials
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
                 #:vix/src/nar
                 #:vix/src/main))

(provide "vix")
(provide "VIX")
