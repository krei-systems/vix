;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; specials.lisp --- special variables

(uiop:define-package #:vix/src/specials
  (:use #:cl
        #:marie))

(in-package #:vix/src/specials)


;;; main variables

(defk +project-name+
  "vix"
  "The name of the project.")

(defk +project-version+
  "0.0.1"
  "The version number of the project.")

(defk +project-description+
  "0.0.1"
  "A program for interacting with the Nix ecosystem.")

(defk +exe+
  '("nix")
  "The name of the main command line program.")


;;; nix

(defv- *nix-skeleton-directory*
  (uiop:subpathname (asdf:system-source-directory (asdf:find-system :vix))
                    #P"nix/")
  "The location of the nix skeleton files.")

(def nix-skel-path (path)
  "Return a path from PATH relevant to the project directory."
  (uiop:subpathname *nix-skeleton-directory* path))
