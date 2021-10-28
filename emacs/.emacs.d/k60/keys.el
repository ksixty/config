;;; keyboard bindings and settings

(when (bound-and-true-p mac-option-modifier)
  ;; things specific to mac keyboard
  (setq mac-command-modifier 'ctrl
    mac-right-command-modifier 'ctrl
    mac-option-modifier 'meta
    mac-right-option-modifier 'meta))

;; bindings list
(mapc (lambda (x) (global-set-key (kbd (car x)) (cdr x)))
      '(("C-z" . undo)
        ("C-j" . join-line)
        ("C-x g" . magit-status)
        ("C-c a" . org-agenda)))

;; little helpers
(use-package crux
  :bind
  ("C-c n" . crux-cleanup-buffer-or-region)
  ("C-c f" . crux-recentf-find-file)
  ("C-a" . crux-move-beginning-of-line))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; cyrillic
(use-package reverse-im
  :ensure t
  :config
  (reverse-im-activate "russian-computer"))
