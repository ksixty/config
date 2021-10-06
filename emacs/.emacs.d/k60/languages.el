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

(use-package go-mode)
