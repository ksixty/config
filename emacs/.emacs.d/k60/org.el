(defun browse-notes ()
  (interactive)
  (find-file
   (selectrum-read-file-name "Org files: " "~/org/" nil t nil
                             (lambda (x) (equal "org" (file-name-extension x))))))

(use-package org
  :init
  (require 'org-tempo)
  (add-hook 'org-mode-hook 'org-indent-mode)
  :bind ("C-c o" . browse-notes)
  :config
  (require 'ox-latex)
  (setq org-latex-packages-alist nil)
  (setq org-directory "~/org"
        org-agenda-files (list "~/org")
        org-image-actual-width nil
        org-image-actual-width 700
        org-src-preserve-indentation t
        org-src-tab-acts-natively t
        org-hierarchical-todo-statistics t
        org-src-strip-leading-and-trailing-blank-lines t
        org-latex-inputenc-alist '(("utf8" . "utf8"))
        org-latex-listings 'minted
        org-latex-packages-alist
          '(("cache=false" "minted") ("" "cmap" t) ("T2A,T1" "fontenc" t))
        org-latex-pdf-process
          '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")))

;; (use-package org-tree-slide
;;   :bind (:map org-mode-map
;;               ("<f8>" . org-tree-slide-mode))
;;   :config
;;   (setq org-tree-slide-skip-outline-level 4
;;         org-tree-slide-fold-subtrees-skipped t
;;         org-tree-slide-skip-done t))

(setq epresent-face-attributes '((default :height 300)))

(add-to-list 'org-src-lang-modes '("latex-macros" . latex))

(defvar org-babel-default-header-args:latex-macros
  '((:results . "raw")
    (:exports . "results")))

(defun prefix-all-lines (pre body)
  (with-temp-buffer
    (insert body)
    (string-insert-rectangle (point-min) (point-max) pre)
    (buffer-string)))

(defun org-babel-execute:latex-macros (body _params)
  (concat
   (prefix-all-lines "#+LATEX_HEADER: " body)
   "\n#+HTML_HEAD_EXTRA: <div style=\"display: none\"> \\(\n"
   (prefix-all-lines "#+HTML_HEAD_EXTRA: " body)
   "\n#+HTML_HEAD_EXTRA: \\)</div>\n"))

(setq org-confirm-babel-evaluate nil)
