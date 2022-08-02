;;; look and feel
(setq ring-bell-function nil)
(global-hl-line-mode 1)
;;(global-font-lock-mode 1)

(setq cursor-type '(bar . 1))

;; scratch
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message "; scratch"
      initial-major-mode 'emacs-lisp-mode)

(set-face-attribute 'default nil :height 92 :family "cascadia mono" :weight 'normal)
(frame-parameter (selected-frame) 'font-backend)

(set-fontset-font t 'symbol (font-spec :family "Symbola") nil 'append)
(set-fontset-font t 'symbol (font-spec :family "Noto Sans Mono") nil 'prepend)

(use-package quick-peek)
;; theme
;; (use-package modus-themes
;;   :bind ("<f12>" . modus-themes-toggle)
;;   :init (setq modus-themes-variable-pitch-headings nil
;;                 modus-themes-mode-line               '(borderless)
;;                 modus-themes-syntax                  '(faint green-strings yellow-comments)
;;                 modus-themes-lang-checkers           '(straight-underline background)
;;                 modus-themes-italic-constructs       t
;;                 modus-themes-bold-constructs         nil
;;                 modus-themes-fringes                 nil
;;                 modus-themes-hl-line                 '()
;;                 modus-themes-org-blocks              'gray-background
;;                 modus-themes-variable-pitch-ui nil
;;                 modus-themes-vivendi-color-overrides '((bg-main . "#000000")
;;                                                        ;(fg-main . "#66eeab")
;;                                                        (fg-main . "#d6d6d6")))
;;   (modus-themes-load-vivendi))

(defmacro k60/set-theme-persistently (theme)
  `(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (select-frame frame)
            (load-theme ,theme t)))
    (load-theme ,theme t)))

(k60/set-theme-persistently 'gruvbox-dark-hard)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position `1)

(show-paren-mode 1)

;; hide useless stuff
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode -1)

;; modeline
(line-number-mode 1)
(column-number-mode 1)
(size-indication-mode 1)
(use-package diminish
  :config
  (mapc #'diminish (list 'eldoc-mode 'visual-line-mode 'wrap 'undo-tree)))

;; title
(setq frame-title-format "%b — Emacs")

;; minibuffers
(fset 'yes-or-no-p 'y-or-n-p)

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode))

(use-package consult)

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-." . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings))) ;; alternative for `describe-bindings'

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package marginalia
  :init
  (marginalia-mode)
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light)))

;; prescient

(use-package prescient
  :config (prescient-persist-mode +1))

;; help
(global-eldoc-mode t)

(use-package which-key
  :diminish which-key-mode
  :config (which-key-mode +1))

(use-package ligature
  :load-path "~/.emacs.d/site-lisp/ligature.el"
  :config
  (ligature-set-ligatures 't '("{-" "::"
                               ":::" ":="
                               "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                               "#_(" ".-" ".=" ".." "..<" "..." "/*" "/**"
                               "//" "///" "&&" "||" "||=" "|=" "^="
                               "++" "+++" "~~" "%%"))

  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode -1)
  (global-prettify-symbols-mode t))

(global-prettify-symbols-mode t)
