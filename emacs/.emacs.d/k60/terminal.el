(setq eshell-banner-message "")

(defun with-face (str &rest face-plist)
    (propertize str 'face face-plist))

(defun custom-eshell-prompt ()
  (concat
   (with-face (format-time-string "%Y-%m-%d %H:%M " (current-time))
              :foreground "#888")
   (concat (eshell/pwd) " ")
   (with-face "\n")
   "§ "))


(setq eshell-prompt-function 'custom-eshell-prompt)
(setq eshell-highlight-prompt nil)
