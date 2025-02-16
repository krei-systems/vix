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
   ;; (make-opt flake :string (uiop:native-namestring (home "etc/dev/")))
   ;; (make-opt switch :flag :true)
   ;; (make-opt upgrade :flag :false)
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
                        :initial-value :true
                        :required nil
                        :key :opt-switch)
   (clingon:make-option :flag
                        :description "enable upgrade"
                        :short-name #\u
                        :long-name "upgrade"
                        :initial-value :false
                        :required nil
                        :key :opt-upgrade)
   ))

(def- rebuild/handler (cmd)
  "Handler for the `rebuild' command."
  (let* ((args (clingon:command-arguments cmd))
         (opt-flake (clingon:getopt cmd :opt-flake))
         (opt-switch (clingon:getopt cmd :opt-switch))
         (opt-upgrade (clingon:getopt cmd :opt-upgrade))
         (full-args (append args
                            (when opt-switch '("switch"))
                            (when opt-upgrade '("--upgrade")))))
    (uiop:os-cond
     ((uiop:os-macosx-p)
      (run! `("darwin-rebuild" "--flake" ,opt-flake ,@full-args)))
     ((uiop:os-unix-p)
      (run! `("sudo" "nixos-rebuild" "--flake" ,opt-flake ,@full-args)))
     (t (clingon:print-usage-and-exit cmd t)))))

(define-command nil rebuild (rb)
  "rebuild the system configuration from a flake"
  "[-f flake] [-s] [-u]"
  (rebuild/options)
  #'rebuild/handler
  nil
  "Rebuild the system from the flake specified in `~/src/system/'"
  "rb -f ~/src/system -s"
  "Rebuild the system from the default flake and switch to it"
  "rb -s")
