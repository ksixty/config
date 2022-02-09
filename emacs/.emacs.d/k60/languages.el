;; lsp
(use-package lsp-mode
  :commands lsp
  :defer t
  :hook
  ((js-mode
    js-jsx-mode
    typescript-mode
    python-mode) . lsp-deferred)
  :config
  (setq gofmt-command "gofmt"))

(use-package lsp-ui
  :defer t
  :commands lsp-ui-mode)

(use-package typescript-mode
  :defer t
  :config (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode)))

(use-package sly
  :commands sly
  :defer t
  :config (setq inferior-lisp-program
                (shell-command-to-string "printf %s \"$(which sbcl)\""))
  :bind (:map sly-mode-map
              ("C-c b" . sly-eval-buffer)))

(use-package php-mode
  :commands php-mode
  :defer t)

(add-to-list 'load-path "~/.emacs.d/site-lisp/pyenv.el")
(require 'pyenv)

(use-package go-mode
  :defer t
  :commands go-mode)

(use-package parinfer-rust-mode
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
