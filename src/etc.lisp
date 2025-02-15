;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; etc.lisp --- etc the system

(uiop:define-package #:vix/src/etc
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/etc)

(define-command nil build (b)
  "build a derivation or fetch a store path"
  nil
  nil
  t
  nil
  "Build the default package from the flake in the current directory"
  "b"
  "Build `hello' and `cowsay' from Nixpkgs, leaving two result symlinks"
  "b nixpkgs#hello nixpkgs#cowsay"
  )

(define-command nil run (r)
  "run a Nix application"
  nil
  nil
  t
  nil
  "Run `vim' from the `nixpkgs' flake"
  "r nixpkgs#vim")

(define-command nil bundle (u)
  "bundle an application so that it works outside of the Nix store"
  nil
  nil
  t
  nil
  "Bundle `hello'"
  "u nixpkgs#vim")

(define-command nil copy (c)
  "start an interactive environment for evaluating Nix expressions"
  nil
  nil
  t
  nil
  "Copy all store paths from a local binary cache"
  "c -- --all --from file:///tmp/cache")

(define-command nil edit (ed)
  "open the Nix expression of a Nix package in $EDITOR"
  nil
  nil
  t
  nil
  "Open the Nix expression of the `hello' package"
  "ed hello")

(define-command nil eval (e)
  "evaluate a Nix expression"
  nil
  nil
  t
  nil
  "Evaluate a Nix expression given on the command line"
  "e -- --expr '1 + 2'")

(define-command nil fmt ()
  "reformat your code in the standard style"
  nil
  nil
  t
  nil
  "Format the current flake"
  "fmt")

(define-command nil repl ()
  "start an interactive environment for evaluating Nix expressions"
  nil
  nil
  t
  nil
  "Evaluate some simple Nix expressions"
  "repl")

(define-command nil path-info (info)
  "query information about store paths"
  nil
  nil
  t
  nil
  "Print the store path produced by nixpkgs#hello"
  "i nixpkgs#hello")

(define-command nil why-depends (w)
  "show why a package has another package in its closure"
  nil
  nil
  t
  nil
  "Show one path through the dependency graph leading from `hello' to `glibc'"
  "w hello glibc")

(define-command nil shell (sh)
  "run a shell in which the specified packages are available"
  nil
  nil
  (lambda (cmd)
    (let ((args (clingon:command-arguments cmd)))
      (nrun "env" "shell" args)))
  nil
  "Start a shell providing `yt-dlp' from the `nixpkgs' flake"
  "sh nixpkgs#yt-dlp")

(define-command nil print-dev-env (print)
  "print shell code of derivation"
  nil
  nil
  t
  nil
  "Get the build environment"
  "print hello")

(define-command nil daemon (dm)
  "daemon to perform store operations on behalf of non-root clients"
  nil
  nil
  t
  nil
  "Run the daemon"
  "dm"
  "Run the daemon and force all connections to be trusted"
  "dm -- --force-trusted")

(define-command nil realisation-info (rinfo)
  "manipulate a Nix realisation"
  nil
  nil
  t
  nil
  "Show some information about the realisation of the package `hello'"
  "rinfo hello")

(define-command nil upgrade-nix (upgrade)
  "upgrade Nix to the latest stable version"
  ""
  nil
  t
  nil
  "Upgrade Nix to the stable version declared in Nixpkgs"
  "upgrade")
