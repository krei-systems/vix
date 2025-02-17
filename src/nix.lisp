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

(def nix-skel-path (path)
  "Return a path from PATH relevant to the project directory."
  (uiop:subpathname *nix-skel-directory* path))

(defk +main-program+
  '("nix")
  "The name of the main command line program.")
