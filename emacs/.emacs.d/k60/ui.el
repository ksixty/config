;;; look and feel

;; scratch
(setq inhibit-startup-screen t
      inhibit-startup-message t
      initial-scratch-message "#+title: scratch\n\n"
      initial-major-mode 'org-mode)

;; colors and fonts
(set-frame-font (font-spec :family "Iosevka" :size 14) nil t t)

(use-package modus-themes
  :config (setq modus-themes-mode-line '(3d accented)
                modus-themes-syntax    '(yellow-comments green-strings)
                modus-themes-completions 'moderate
                modus-themes-intense-markup t
                modus-themes-italic-constructs t
                modus-themes-bold-constructs t
                modus-themes-org-blocks 'tinted-background)
  :init (modus-themes-load-operandi))

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(show-paren-mode 1)

;; hide useless stuff
(if (bound-and-true-p mac-option-modifier) (menu-bar-mode 1)
  (menu-bar-mode -1))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode -1)

;; modeline
(line-number-mode 1)
(column-number-mode 1)
(size-indication-mode 1)
(use-package diminish
  :config
  (mapc #'diminish (list eldoc-mode)))

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