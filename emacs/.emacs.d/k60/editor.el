;;; misc
(savehist-mode +1)
(setq savehist-save-minibuffer-history t)

(recentf-mode +1)
(setq recentf-max-menu-items 9000)

(global-visual-line-mode 1)

;; tabs no more
(setq-default tab-width 4 indent-tabs-mode nil)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Enable indentation+completion using the TAB key.
;; `completion-at-point' is often bound to M-TAB.
(setq tab-always-indent 'complete)

;; sane electric
(setq-default electric-indent-inhibit t)
(setq backward-delete-char-untabify-method 'hungry)

; selected text will be overwritten when you start typing
(delete-selection-mode 1)

;; saving
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq create-lockfiles nil)
(global-auto-revert-mode t)

;; undo
(use-package undo-tree
  :config (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo-tree/")))
  :init (global-undo-tree-mode)
  :bind (("C-z" . undo-tree-undo)
         ("C-S-z" . undo-tree-redo)))

;; snippets
(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1))

(use-package projectile
  :after ivy
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))

(use-package projectile
  :diminish projectile-mode
  :bind
  (("C-c p f" . projectile-find-file)
   ("C-c p p" . projectile-switch-project)
   ("C-c p s" . projectile-save-project-buffers))
  :config
  (projectile-mode +1))

;; kill-ring / system clipboard interaction

(setq select-enable-clipboard t
      save-interprogram-paste-before-kill t
      yank-pop-change-selection t)

;; (require 'trip-mode)
