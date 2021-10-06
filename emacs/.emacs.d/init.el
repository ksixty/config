;;; emacsd --- k60's emacs configuration
;;; Code
;; -*- lexical-binding: t; -*-

(setq user-full-name "Vanya Klimenko"
      user-mail-address "k60@fmap.me")

(defmacro mb (n) (* n 1000000))

(setq gc-cons-threshold (mb 50))
(setq large-file-warning-threshold (mb 100))

(setq custom-file "custom.el")
(mapc 'load (file-expand-wildcards "~/.emacs.d/k60/*.el"))
