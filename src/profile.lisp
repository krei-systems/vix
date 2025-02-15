;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; profile.lisp --- Nix profile commands

(uiop:define-package #:vix/src/profile
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/profile)

(define-command profile install (i)
  "install a package into a profile"
  "package..."
  nil
  t
  nil
  "Install a package from Nixpkgs"
  "install hello"
  "Install a package from a specific Nixpkgs revision"
  "install nixpkgs/d734#hello")

(define-command profile remove (r)
  "uninstall packages from a profile"
  "package..."
  nil
  t
  nil
  "Remove a package by name"
  "uninstall hello"
  "Remove all packages"
  "uninstall -- --all")

(define-command profile upgrade (u)
  "upgrade packages using their most recent flake"
  "package..."
  nil
  t
  nil
  "Upgrade a specific package by name"
  "upgrade hello")

(define-command profile list (l)
  "list the installed packages"
  ""
  nil
  t
  nil
  "List packages installed in the default profile"
  "list")

(define-command profile rollback (b)
  "roll back to a previous version of a profile"
  ""
  nil
  t
  nil
  "Roll back your default profile to the previous version"
  "rollback"
  "Roll back your default profile to an older version"
  "rollback -- --to profile")

(define-command profile history (h)
  "show all versions of a profile"
  ""
  nil
  t
  nil
  "Show the changes between each version of your default profile"
  "history")

(define-command profile wipe-history (w)
  "delete non-current versions of a profile"
  ""
  nil
  t
  nil
  "Delete all versions of the default profile older than 30 days"
  "wipe-history -- --profile /tmp/profile --older-than 30d")

(define-command profile diff-closures (d)
  "show the closure difference between each version of a profile"
  ""
  nil
  t
  nil
  "Show what changed between each version of the NixOS system profile"
  "diff-closures -- --profile /nix/var/nix/profiles/system")

(define-sub-commands profile
  install remove upgrade list
  rollback history wipe-history diff-closures)

(define-command nil profile (p)
  "profile commands"
  "command"
  nil
  #'usage
  t)
