(defun browse-notes ()
  (interactive)
  (find-file
   (selectrum-read-file-name "Org files: " "~/org/" nil t nil
                             (lambda (x) (equal "org" (file-name-extension x))))))

(use-package org
  :init
  (add-hook 'org-mode-hook 'org-indent-mode)
  :bind ("C-c o" . browse-notes)
  :config
  (setq org-directory "~/org"
        org-agenda-files (list "~/org")))
