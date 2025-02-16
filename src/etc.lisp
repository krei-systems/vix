;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; etc.lisp --- etc the system

(uiop:define-package #:vix/src/etc
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/etc)

(define-command nil develop (d)
  "run a dev shell"
  nil
  nil
  nil
  nil
  "Run a dev shell"
  "d"
  "Run a dev shell and run `make' inside"
  "d -- -c make")

(define-command nil make (m)
  "run `make' inside a dev shell"
  nil
  nil
  (lambda (cmd)
    (let ((args (clingon:command-arguments cmd)))
      (nrun "develop" "--command" "make" args)))
  nil
  "Run `make' inside a dev shell"
  "m")

(define-command nil search (s)
  "search for packages"
  "[-n|<flake>] <package>..."
  t
  (lambda (cmd)
    (let* ((args (clingon:command-arguments cmd))
           (opt-nixpkgs (clingon:getopt cmd :opt-nixpkgs))
           (final-args (cond (opt-nixpkgs (list "search" "nixpkgs" (or-args args)))
                             (t (cons "search" args)))))
      (apply #'nrun final-args)))
  nil
  "Search in `nixpkgs' flake for packages named `firefox'"
  "s nixpkgs firefox")

(define-command nil find (fd)
  "search for packages in the `nixpkgs' flake"
  "<package>..."
  t
  (lambda (cmd)
    (let* ((args (clingon:command-arguments cmd))
           (final-args (list "search" "nixpkgs" (or-args args))))
      (apply #'nrun final-args)))
  nil
  "Search in `nixpkgs' flake for packages named `firefox'"
  "fd firefox")

(define-command nil build (b)
  "build a derivation or fetch a store path"
  nil
  t
  t
  nil
  "Build the default package from the flake in the current directory"
  "b"
  "Build `hello' and `cowsay' from `nixpkgs' flake, leaving two result symlinks"
  "b nixpkgs#hello nixpkgs#cowsay"
  )

(define-command nil run (r)
  "run a Nix application"
  nil
  t
  t
  nil
  "Run `vim' from the `nixpkgs' flake"
  "r nixpkgs#vim")

(define-command nil bundle (u)
  "bundle an application so that it works outside of the Nix store"
  nil
  t
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
  t
  t
  nil
  "Open the Nix expression of the `hello' package"
  "ed nixpkgs#hello")

(define-command nil eval (e)
  "evaluate a Nix expression"
  nil
  nil
  t
  nil
  "Evaluate a Nix expression given on the command line"
  "e -- --expr '1 + 2'"
  "Print the store path of the `hello' package"
  "e -- --raw nixpkgs#hello")

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
  t
  t
  nil
  "Print the store path produced by nixpkgs#hello"
  "i nixpkgs#hello")

(define-command nil why-depends (w)
  "show why a package has another package in its closure"
  nil
  t
  t
  nil
  "Show one path through the dependency graph leading from `hello' to `glibc'"
  "w nixpkgs#hello nixpkgs#glibc")

(define-command nil shell (sh)
  "run a shell in which the specified packages are available"
  nil
  t
  (lambda (cmd)
    (let ((args (clingon:command-arguments cmd)))
      (nrun "env" "shell" args)))
  nil
  "Start a shell providing `yt-dlp' from the `nixpkgs' flake"
  "sh nixpkgs#yt-dlp")

(define-command nil print-dev-env (print)
  "print shell code of derivation"
  nil
  t
  t
  nil
  "Get the build environment of `hello'"
  "print nixpkgs#hello")

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

(define-command nil realisation (real)
  "manipulate a Nix realisation"
  nil
  t
  t
  nil
  "Show some information about the realisation of the package `hello'"
  "real info nixpkgs#hello")

(define-command nil upgrade-nix (upgrade)
  "upgrade Nix to the latest stable version"
  ""
  nil
  t
  nil
  "Upgrade Nix to the stable version declared in `nixpkgs' flake"
  "upgrade")

(define-command nil collect-garbage (g)
  "run the garbage collector"
  nil
  nil
  (lambda (cmd)
    (let ((args (clingon:command-arguments cmd)))
      (dbg args)
      (run! `("nix-collect-garbage" ,@args))))
  nil
  "Garbage collect"
  "g"
  "Gargage collect and delete old versions"
  "g -- -d")
