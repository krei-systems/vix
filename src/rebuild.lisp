;;;; -*- mode: lisp; syntax: common-lisp; base: 10; -*-
;;;; rebuild.lisp --- rebuild the system configuration from a flake

(uiop:define-package #:vix/src/rebuild
  (:use #:cl
        #:marie
        #:vix/src/core))

(in-package #:vix/src/rebuild)

(def- rebuild/options ()
  "Return the options for the `rebuild' command."
  (list
   (clingon:make-option :string
                        :description "specify flake"
                        :short-name #\f
                        :long-name "flake"
                        :initial-value (uiop:native-namestring (home "etc/dev/"))
                        :required nil
                        :key :opt-flake)
   (clingon:make-option :flag
                        :description "enable switch"
                        :short-name #\s
                        :long-name "switch"
                        :initial-value (if (uiop:os-macosx-p) :true :false)
                        :required nil
                        :key :opt-switch)
   (clingon:make-option :flag
                        :description "enable upgrade"
                        :short-name #\u
                        :long-name "upgrade"
                        :initial-value (if (uiop:os-macosx-p) :false :true)
                        :required nil
                        :key :opt-upgrade)))

(def- rebuild/handler (cmd)
  "Handler for the `rebuild' command."
  (let* ((args (clingon:command-arguments cmd))
         (opt-flake (clingon:getopt cmd :opt-flake))
         (opt-switch (clingon:getopt cmd :opt-switch))
         (opt-upgrade (when opt-switch
                        (clingon:getopt cmd :opt-upgrade)))
         (full-args (append args
                            (when opt-switch '("switch"))
                            (when opt-upgrade '("switch" "--upgrade")))))
    (uiop:os-cond
     ((uiop:os-macosx-p)
      (run! `("darwin-rebuild" "--flake" ,opt-flake ,@full-args)))
     ((uiop:os-unix-p)
      (run! `("sudo" "nixos-rebuild" "--flake" ,opt-flake ,@full-args)))
     (t (clingon:print-usage-and-exit cmd t)))))

(define-command nil rebuild (rb)
  "rebuild the system configuration from a flake"
  "[-s] [-su]"
  (rebuild/options)
  #'rebuild/handler
  nil
  "Rebuild the system from the flake specified in `~/src/system/'"
  "rb -s -f ~/src/system"
  "Rebuild the system from flake and switch to it"
  "rb -s")
