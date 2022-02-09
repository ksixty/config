;;; keyboard bindings and settings

(when (bound-and-true-p mac-option-modifier)
  ;; things specific to mac keyboard
  (setq mac-command-modifier 'ctrl
    mac-right-command-modifier 'ctrl
    mac-option-modifier nil
    mac-right-option-modifier 'meta))

(global-set-key (kbd "<mouse-2>") (lambda () (interactive)
                                    (mouse-set-point last-input-event)
                                    (yank)))

;; bindings list
(mapc (lambda (x) (global-set-key (kbd (car x)) (cdr x)))
      '(("C-z" . undo)
        ("M-z" . zap-up-to-char)
        ("C-j" . join-line)
        ("C-x g" . magit-status)
        ("C-c a" . org-agenda)
        ("C-c RET" . shell)))

;; little helpers
(use-package crux
  :bind
  ("C-c n" . crux-cleanup-buffer-or-region)
  ("C-c f" . crux-recentf-find-file)
  ("C-a" . crux-move-beginning-of-line))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode -1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :init
  (setq general-override-states '(insert
                                  emacs
                                  hybrid
                                  normal
                                  visual
                                  motion
                                  operator
                                  replace))
  :config
  (general-define-key
   :states '(normal visual motion)
   :keymaps 'override
   "SPC" 'hydra-space/body))

(use-package hydra)

;; cyrillic
(use-package reverse-im
  :ensure t
  :config
  (reverse-im-activate "russian-computer"))
