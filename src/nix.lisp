;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; nix.lisp --- Nix-specific stuff

(uiop:define-package #:vix/src/nix
  (:use #:cl
        #:marie))

(in-package #:vix/src/nix)


;;; variables

(defv- *nix-skel-directory*
  (uiop:subpathname (asdf:system-source-directory (asdf:find-system :vix))
                    #P"nix/")
  "The location of the nix skeleton files.")

(defv- *vix-config*
  (uiop:merge-pathnames* "vix.lisp" (home ".config/vix/"))
  "The default location of vix config.")


;;; fns

(def nix-skel-path (path)
  "Return a path from PATH relevant to the project directory."
  (uiop:subpathname *nix-skel-directory* path))

(def- read-config (&optional key)
  "Read the contents of the vix config."
  (let ((expr (uiop:read-file-form *vix-config*)))
    (if key
        (getf expr key)
        expr)))

(def- default-flake ()
  "Return the default flake."
  (read-config :flake))


;;; interface

(defk +main-program+
  '("nix")
  "The name of the main command line program.")

(defk +main-option+
  "nixpkgs"
  "The common option name across commands.")

(def fence-args (args)
  (let* ((flake (default-flake))
         (fmt-args (if (empty-string-p flake)
                       `("~{~A~^ ~}" ,args)
                       `(,(cat "~{" flake "#~A~^ ~}") ,args))))
    (apply #'format nil fmt-args)))
