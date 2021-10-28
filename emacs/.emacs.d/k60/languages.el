;; lsp
(use-package lsp-mode
  :commands lsp
  :hook
  ((js-mode
    js-jsx-mode
    typescript-mode
    python-mode) . lsp-deferred)
  :config
  (setq gofmt-command "gofmt"))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package typescript-mode
  :config (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode)))

(use-package sly
  :config (setq inferior-lisp-program
                (shell-command-to-string "printf %s \"$(which sbcl)\""))
  :bind (:map sly-mode-map
              ("C-c b" . sly-eval-buffer)))

(use-package php-mode)

(add-to-list 'load-path "~/.emacs.d/site-lisp/pyenv.el")
(require 'pyenv)
(global-pyenv-mode)

(use-package go-mode)

(use-package parinfer-rust-mode
  :hook (lisp-mode . parinfer-rust-mode))

;; c-mode
(setq c-default-style "linux")

;; godbolt-like asm explorer
(use-package rmsbolt)

(use-package nix-mode)

(use-package restclient)
(use-package ob-restclient
  :init
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((restclient . t))))

(use-package dockerfile-mode)
(use-package docker-compose-mode)
