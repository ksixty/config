;; lsp
;; (use-package lsp-mode
;;   :commands lsp
;;   :defer t
;;   :hook
;;   ((js-mode
;;     js-jsx-mode
;;     typescript-mode
;;     web-mode
;;     css-mode
;;     python-mode) . lsp-deferred)
;;   :config
;;   (setq gofmt-command "gofmt"))

;; (use-package lsp-ui
;;   :defer t
;;   :commands lsp-ui-mode)

(use-package eglot
  :ensure t
  :hook
  ((js-mode js-jsx-mode typescript-mode web-mode css-mode python-mode
            rustic-mode go-mode haskell-mode) . eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c r" . 'eglot-rename)
              ("C-c o" . 'eglot-code-action-organize-imports)
              ("C-c h" . 'eldoc)))

(use-package typescript-mode
  :defer t
  :config (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode)))

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  ;; OR for flymake support:
  (add-hook 'haskell-mode-hook 'flymake-mode)
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
  (add-hook 'haskell-mode-hook 'dante-mode))

(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

(use-package elpy
  :ensure t
  :init (elpy-enable))

(use-package flycheck-inline
  :hook (flycheck-mode . flycheck-inline-mode))
  ;:config (setq flycheck-inline-display-function
  ;         (lambda (msg pos err)
  ;           (let* ((ov (quick-peek-overlay-ensure-at pos))
  ;                  (contents (quick-peek-overlay-contents ov))
  ;             (setf (quick-peek-overlay-contents ov)
  ;                   (concat contents (when contents "\n") msg)
  ;             (quick-peek-update ov)
  ;         flycheck-inline-clear-function #'quick-peek-hide))

(use-package sly
  :commands sly
  :defer t
  :config (progn (setq inferior-lisp-program "/usr/bin/sbcl")
                 (setq sly-contribs '(sly-scratch sly-mrepl sly-stickers))
                 (sly-setup)
                 (load (expand-file-name "~/.roswell/helper.el")))
  :bind (:map sly-mode-map
              ("C-c b" . sly-eval-buffer)))

(use-package sly-quicklisp)
(use-package sly-macrostep)

(use-package php-mode
  :commands php-mode
  :defer t)

;;(add-to-list 'load-path "~/.emacs.d/site-lisp/pyenv.el")
;;(top-level(require 'pyenv)

(use-package go-mode
  :defer t
  :commands go-mode)

(use-package parinfer-rust-mode
  :init (setq parinfer-rust-dim-parens nil)
  :hook (lisp-mode . parinfer-rust-mode))


;; c-mode
(setq c-default-style "linux")

;; godbolt-like asm explorer
(use-package rmsbolt
  :defer t
  :commands (rmsbolt-mode))

(use-package nix-mode)

(use-package restclient)
(use-package ob-restclient
  :defer t
  :init
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((restclient . t))))

(use-package dockerfile-mode)
(use-package docker-compose-mode)


(add-hook 'lisp-mode-hook
          (lambda ()
            (font-lock-add-keywords nil '(("\\<\\(definstruction\\)" . 'font-lock-keyword-face)
                                          ("\\bdefinstruction\s\\([^\s]*\\)" 1 'font-lock-function-name-face t)))))
