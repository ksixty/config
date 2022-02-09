;;; look and feel
(setq ring-bell-function nil)
(global-hl-line-mode 1)

;; scratch
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message "#+title: scratch\n\n"
      initial-major-mode 'org-mode)

;; colors and fonts
(set-frame-font (font-spec :family "Iosevka SS11"
                           :size 13)
                t t nil)

;; theme
(defvar k60/modus-p nil)

(use-package modus-themes
  :init (setq modus-themes-variable-pitch-headings nil
              modus-themes-mode-line               '(3d)
              modus-themes-syntax                  '(yellow-comments)
              modus-themes-completions             'moderate
              modus-themes-intense-markup          t
              modus-themes-italic-constructs       t
              modus-themes-bold-constructs         t
              modus-themes-org-blocks              'gray-background
              modus-themes-vivendi-color-overrides '((bg-main . "#1a1a1a")
                                                     (fg-main . "#cccccc")))
  :config (when k60/modus-p (modus-themes-load-operandi)))

(unless k60/modus-p
  (load-theme 'shades-of-purple)
  (set-face-foreground 'vertical-border "#223"))

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(show-paren-mode 1)

;; hide useless stuff
(scroll-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode -1)

;; modeline
(line-number-mode 1)
(column-number-mode 1)
(size-indication-mode 1)
(use-package diminish
  :config
  (mapc #'diminish (list 'eldoc-mode)))

;; title
(setq frame-title-format "%b")

;; minibuffers
(fset 'yes-or-no-p 'y-or-n-p)

;; company
(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode))

(use-package company-box
  :diminish
  :hook (company-mode . company-box-mode)
  :config (setq company-box-enable-icon nil
                company-box-scrollbar 'inherit))

;; completion etc.
(use-package ivy
    :diminish
    :config (setq ivy-use-virtual-buffers t)
            (ivy-mode 1))

(use-package counsel
  :after ivy :diminish
  :config (counsel-mode)
  :bind ("C-/" . counsel-rg))

(use-package marginalia
  :init
  (marginalia-mode)
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light)))

(use-package selectrum
  :config (selectrum-mode +1))

;; prescient

(use-package prescient
  :config (prescient-persist-mode +1))

(use-package selectrum-prescient
  :config (selectrum-prescient-mode +1))

(use-package company-prescient
  :config (company-prescient-mode +1))

;; help
(global-eldoc-mode t)

(use-package which-key
  :diminish which-key-mode
  :config (which-key-mode +1))
