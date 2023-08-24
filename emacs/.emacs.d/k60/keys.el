;;; keyboard bindings and settings

(when (bound-and-true-p mac-option-modifier)
  ;; things specific to mac keyboard
  (setq mac-command-modifier 'ctrl
    mac-right-command-modifier 'ctrl
    mac-option-modifier nil
    mac-right-option-modifier 'meta))

;; enable windmove
(windmove-default-keybindings)

(global-set-key (kbd "<mouse-2>") (lambda () (interactive)
                                    (mouse-set-point last-input-event)
                                    (yank)))

;; bindings list
(mapc (lambda (x) (global-set-key (kbd (car x)) (cdr x)))
      '(("C-z"     . undo)
        ("M-z"     . zap-up-to-char)
        ("C-j"     . join-line)
        ("C-x g"   . magit-status)
        ("C-c a"   . org-agenda)
        ("C-c e"   . eshell-here)
        ("<f6>"    . compile)
        ("C-x m"   . mu4e-compose-new)
        ("<f5>"    . recompile)
        ("C->"     . indent-rigidly-right-to-tab-stop)
        ("C-<"     . indent-rigidly-left-to-tab-stop)
        ("M-["     . backward-paragraph)
        ("M-]"     . forward-paragraph)
        ("M-x"     . execute-extended-command)
        ("C-<tab>" . previous-buffer)
        ("C-]"     . next-buffer)
        ("C-x C-f" . find-file)
        ("C-x r b" . consult-bookmark)
        ("C-x b"   . consult-buffer)
        ("C-c C-r" . consult-ripgrep)
        ("C-x C-r" . consult-recent-file)))

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
