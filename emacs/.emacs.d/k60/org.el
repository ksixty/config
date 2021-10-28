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
  (setq org-directory "~/org"
        org-agenda-files (list "~/org")
        org-image-actual-width nil
        org-image-actual-width 700
        org-src-preserve-indentation t
        org-src-tab-acts-natively t
        org-src-strip-leading-and-trailing-blank-lines t))

;; (use-package org-tree-slide
;;   :bind (:map org-mode-map
;;               ("<f8>" . org-tree-slide-mode))
;;   :config
;;   (setq org-tree-slide-skip-outline-level 4
;;         org-tree-slide-fold-subtrees-skipped t
;;         org-tree-slide-skip-done t))

(setq epresent-face-attributes '((default :height 300)))
