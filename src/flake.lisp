;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; flake.lisp --- direct nix flake commands

(uiop:define-package #:vix/src/flake
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/flake)

(def- flake/init/handler (cmd)
  "Define a function for handling the `flake init' command."
  (let ((args (clingon:command-arguments cmd)))
    (with-output-file (out #P"flake.nix")
      (format out "
{
  description = \"A flake\";
  inputs = {
    nixpkgs.url = \"github:nixos/nixpkgs/nixpkgs-unstable\";
    flake-utils.url = \"github:numtide/flake-utils\";
  };
  outputs = { self, nixpkgs, flake-utils }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        apps = import ./apps.nix { inherit pkgs; };
        devShells = import ./shells.nix { inherit nixpkgs pkgs; };
      });
}
"))
    (with-output-file (out #P"apps.nix")
      (format out "
{ pkgs }: rec {
  hello = {
    type = \"app\";
    program = \"${pkgs.hello}/bin/hello\";
  };
  default = hello;
}
"))
    (with-output-file (out #P"shells.nix")
      (format out "
{ nixpkgs, pkgs, ... }:
with pkgs; rec {
  hello = mkShell { buildInputs = [ pkgs.hello ]; };
  default = hello;
}
"))))

(define-command flake init (i)
  "create a flake in the current directory"
  ""
  nil
  #'flake/init/handler
  nil
  "Create a flake using the default template"
  "f i")

(define-command flake metadata (m)
  "show flake metadata"
  ""
  nil
  t
  nil
  "Show flake metadata"
  "f m")

(define-command flake show (s)
  "show the outputs provided by a flake"
  ""
  nil
  t
  nil
  "Show the output attributes provided by the CWD flake"
  "f s"
  "List available templates"
  "f s templates")

(define-command flake update (u)
  "update flake lock file"
  ""
  nil
  t
  nil
  "Update all inputs"
  "f u")

(define-command flake new (n)
  "create a flake in the specified directory from a template"
  "flake"
  nil
  t
  nil
  "Create a flake in the directory `hello'"
  "f n hello"
  "Create a flake in the directory `hello' using template haskell-hello"
  "f n hello -t templates#haskell-hello")

(define-command flake clone (c)
  "clone flake repository"
  "flake"
  nil
  t
  nil
  "Check out the source code of the dwarffs flake"
  "f c dwarffs -- --dest dwarffs")

(define-command flake check (k)
  "check whether the flake evaluates and run its tests"
  ""
  nil
  t
  nil
  "Evaluate the flake in the current directory, and build its checks"
  "f k")

(define-command flake archive (a)
  "copy a flake and all its inputs to a store"
  ""
  nil
  t
  nil
  "Fetch the dwarffs flake to the local Nix store"
  "f a dwarffs")

(define-command flake prefetch (p)
  "download the flake source tree into the Nix store"
  ""
  nil
  t
  nil
  "Download the dwarffs flake"
  "f p dwarffs")

(define-sub-commands flake
  init metadata show update new clone check archive prefetch)

(define-command nil flake (f)
  "flake commands"
  "command"
  nil
  #'usage
  t)
