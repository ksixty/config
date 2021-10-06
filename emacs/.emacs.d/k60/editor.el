;;; misc

;; tabs no more
(setq-default tab-width 4 indent-tabs-mode nil)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; saving
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq create-lockfiles nil)
(global-auto-revert-mode t)



(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1))

(use-package projectile
  :after ivy
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package counsel-projectile
  :init (counsel-projectile-mode))

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
