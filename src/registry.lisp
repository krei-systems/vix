;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; registry.lisp --- manipulate the Nix registry

(uiop:define-package #:vix/src/registry
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/registry)

(define-command registry list (l)
  "list available Nix flakes"
  ""
  nil
  t
  nil
  "Show the contents of all registries"
  "r l")

(define-command registry add (a)
  "create a flake in the current directory"
  "<flake> <location>"
  nil
  t
  nil
  "Set the `nixpkgs' flake identifier to a specific branch of Nixpkgs"
  "r a nixpkgs github:NixOS/nixpkgs/nixos-20.03")

(define-command registry remove (r)
  "remove flake from user flake registry"
  "<flake>"
  nil
  t
  nil
  "Remove the `nixpkgs' flake from the registry"
  "r r nixpkgs")

(define-command registry pin (p)
  "pin a flake to its current version"
  "<flake>"
  nil
  t
  nil
  "Pin the `nixpkgs' flake to its most recent revision"
  "r p nixpkgs")

(define-command nil registry (r)
  "manipulate the Nix registry"
  "<command>"
  nil
  #'print-usage
  (list add remove pin))
