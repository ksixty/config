;;; emacsd --- k60's emacs configuration
;;; Code:
;; -*- lexical-binding: t; -*-

(setq user-full-name "Vanya Klimenko"
      user-mail-address "k60@fmap.me")

(setq warning-minimum-level :emergency)

(defmacro mb (n) (* n 1000000))

(setq gc-cons-threshold (mb 50))
(setq large-file-warning-threshold (mb 100))

(setq custom-file "~/.emacs.d/custom.el")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

(setq package-enable-at-startup nil)
(require 'package)
(setq package-archives (list '("melpa" . "http://melpa.org/packages/")
                        '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(savehist-mode +1)

(setq load-prefer-newer t)
(mapc 'load (file-expand-wildcards "~/.emacs.d/k60/*.el"))
