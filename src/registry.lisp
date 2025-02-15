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
  "y l")

(define-command registry add (a)
  "create a flake in the current directory"
  "flake location"
  nil
  t
  nil
  "Set the `nixpkgs' flake identifier to a specific branch of Nixpkgs"
  "y a nixpkgs github:NixOS/nixpkgs/nixos-20.03")

(define-command registry remove (r)
  "remove flake from user flake registry"
  "flake"
  nil
  t
  nil
  "Remove the `nixpkgs' flake from the registry"
  "y r nixpkgs")

(define-command registry pin (p)
  "pin a flake to its current version"
  "flake"
  nil
  t
  nil
  "Pin the `nixpkgs' flake to its most recent revision"
  "y p nixpkgs")

(define-sub-commands registry
  list add remove pin)

(define-command nil registry (y)
  "manipulate the Nix registry"
  "command"
  nil
  #'usage
  t)
