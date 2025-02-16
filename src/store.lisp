;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; store.lisp --- manipulate the Nix store

(uiop:define-package #:vix/src/store
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/store)

(define-command store add (a)
  "add a file or directory to the Nix store"
  "<location>"
  nil
  t
  nil
  "Add a directory to the store"
  "s a ./dir")

(define-command store cat (c)
  "print the contents of a file in the Nix store on stdout"
  "<location>"
  nil
  t
  nil
  "Show the contents of a file in a binary cache"
  "s c --store https://cache.nixos.org/ /nix/store/0i2jd68mp5g6h2sa5k9c85rb80sn8hi9-hello-2.10/bin/hello")

(define-command store copy-log (y)
  "copy build logs between Nix stores"
  "<location>"
  nil
  t
  nil
  "Copy build logs between Nix stores"
  "s y --from https://cache.nixos.org --eval-store auto nixpkgs#hello")

;; TODO add example(s)
(define-command store copy-sigs (i)
  "copy store path signatures from substituters"
  ""
  nil
  t
  nil
  "Copy sigs"
  "s i")

(define-command store delete (d)
  "delete paths from the Nix store"
  "<path>..."
  nil
  t
  nil
  "Delete a specific store path"
  "s d /nix/store/yb5q57zxv6hgqql42d5r8b5k5mcq6kay-hello-2.10")

(define-command store diff-closures (u)
  "show what packages and versions were added and removed"
  "<path>..."
  nil
  t
  nil
  "Show what got added and removed between two versions of the NixOS system profile"
  "s u /nix/var/nix/profiles/system-655-link /nix/var/nix/profiles/system-658-link")

(define-command store dump-path (p)
  "serialise a store path to stdout in NAR format"
  "<path>"
  nil
  t
  nil
  "To get a NAR from the binary cache https://cache.nixos.org/"
  "s p -- --store https://cache.nixos.org/ /nix/store/7crrmih8c52r8fbnqb933dxrsp44md93-glibc-2.25 > glibc.nar")

(define-command store gc (g)
  "perform garbage collection on a Nix store"
  ""
  nil
  t
  nil
  "Delete unreachable paths in the Nix store"
  "s g")

(define-command store info (o)
  "test whether a store can be accessed"
  "<path>"
  nil
  t
  nil
  "Test whether connecting to a remote Nix store via SSH works"
  "s o -- --store ssh://mac1")

(define-command store ls (l)
  "show information about a path in the Nix store"
  "<path>"
  nil
  t
  nil
  "To list the contents of a store path in a binary cache"
  "s l -- --store https://cache.nixos.org/ --long --recursive /nix/store/0i2jd68mp5g6h2sa5k9c85rb80sn8hi9-hello-2.10")

(define-command store make-content-addressed (m)
  "rewrite a path or closure to content-addressed form"
  "<path>"
  t
  t
  nil
  "Create a content-addressed representation of the closure of `hello'"
  "s m nixpkgs#hello")

(define-command store optimise (t)
  "replace identical files in the store by hard links"
  ""
  nil
  t
  nil
  "Optimise the Nix store"
  "s t")

(define-command store path-from-hash-part (h)
  "get a store path from its hash part"
  "<path>"
  nil
  t
  nil
  "Return the full store path with the given hash part"
  "s h --store https://cache.nixos.org/ 0i2jd68mp5g6h2sa5k9c85rb80sn8hi9")

(define-command store prefetch-file (f)
  "download a file into the Nix store"
  "<loca>tion"
  nil
  t
  nil
  "Download a file to the Nix store"
  "s f https://releases.nixos.org/nix/nix-2.3.10/nix-2.3.10.tar.xz")

(define-command store repair (r)
  "repair store paths"
  "<path>"
  nil
  t
  nil
  "Repair a store path, after determining that it is corrupt"
  "s r /nix/store/yb5q57zxv6hgqql42d5r8b5k5mcq6kay-hello-2.10")

;; TODO add example(s)
(define-command store sign (n)
  "sign store paths with a local key"
  ""
  nil
  t
  nil
  "Sign store"
  "s n")

(define-command store verify (v)
  "verify the integrity of store paths"
  ""
  nil
  t
  nil
  "Verify the entire Nix store"
  "store-verify -- --all")

(define-command nil store (o)
  "manipulate the Nix store"
  "<command>"
  nil
  #'print-usage
  (add cat copy-log copy-sigs delete diff-closures
       dump-path gc info ls
       make-content-addressed optimise path-from-hash-part prefetch-file repair sign
       verify) )
