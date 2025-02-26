;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; profile.lisp --- Nix profile commands

(uiop:define-package #:vix/src/profile
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/profile)

(define-command profile install (i)
  "install a package into a profile"
  "<package>..."
  t
  t
  nil
  "Install a package from Nixpkgs"
  "p i n#hello"
  "Install a package from a specific Nixpkgs revision"
  "p i nixpkgs/d734#hello")

(define-command profile remove (r)
  "uninstall packages from a profile"
  "<package>..."
  nil
  t
  nil
  "Remove a package by name"
  "p r hello"
  "Remove all packages"
  "p r -- --all")

(define-command profile upgrade (u)
  "upgrade packages using their most recent flake"
  "<package>..."
  nil
  t
  nil
  "Upgrade a specific package by name"
  "p u hello")

(define-command profile list (l)
  "list the installed packages"
  ""
  nil
  t
  nil
  "List packages installed in the default profile"
  "p l")

(define-command profile rollback (rb)
  "roll back to a previous version of a profile"
  ""
  nil
  t
  nil
  "Roll back your default profile to the previous version"
  "p rb"
  "Roll back your default profile to version 500"
  "p rb -- --to 500")

(define-command profile history (h)
  "show all versions of a profile"
  ""
  nil
  t
  nil
  "Show the changes between each version of your default profile"
  "p h")

(define-command profile wipe-history (w)
  "delete non-current versions of a profile"
  ""
  nil
  t
  nil
  "Delete all versions of the default profile older than 30 days"
  "p w -- --profile /tmp/profile --older-than 30d")

(define-command profile diff-closures (d)
  "show the closure difference between each version of a profile"
  ""
  nil
  t
  nil
  "Show what changed between each version of the NixOS system profile"
  "p d -- --profile /nix/var/nix/profiles/system")

(define-command nil profile (p)
  "profile commands"
  "<command>"
  nil
  #'print-usage
  (install remove upgrade list rollback history wipe-history diff-closures))
