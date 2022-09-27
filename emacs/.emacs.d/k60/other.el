(setq auth-sources '("~/.authinfo.gpg"))
(setq epg-gpg-program "/usr/bin/gpg")
(setf epa-pinentry-mode 'loopback)

(add-to-list 'package-archives
           '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-pinned-packages
             '(telega . "melpa-stable")
             '(python-mode . "melpa-stable"))

(use-package telega
  :commands (telega)
  :defer t
  :config (setq telega-emoji-use-images nil ;; pre-rendered emoji
                telega-use-images t
                telega-chat-show-avatars t
                telega-chat-fill-column 60
                telega-symbol-checkmark "•"
                telega-symbol-heavy-checkmark " "
                telega-chat-input-markups '("markdown2" nil)
                telega-server-libs-prefix "/usr/")
  :custom (telega-chat-button-brackets '((all " " "")))
  :bind-keymap ("C-c t" . telega-prefix-map)
  :init (progn (telega-notifications-mode 1)))
                                        ;'(require 'ol-telega)


(defun unload-feature-recursive (feature)
  (let* ((file (feature-file feature))
         (dependents (delete file (copy-sequence (file-dependents file)))))
    (when dependents
      (mapc #'unload-feature-recursive (mapcan #'file-provides dependents)))))

;; erc

(defun my/erc-start-or-switch ()
  "Connects to ERC, or switch to last active buffer."
  (interactive)
  (if (get-buffer "irc.libera.chat:6667")
      (erc-track-switch-buffer 1)
    (when (y-or-n-p "Start ERC? ")
      (erc :server "irc.libera.chat" :port 6667 :nick "k60"))))

(use-package erc
  :defer t
  :custom
  (erc-autojoin-channels-alist '(("libera.chat"
                                  "#emacs"
                                  "#org-mode"
                                  "#math"
                                  "##music"
                                  "##audio"
                                  "#music-theory"
                                  "#linuxmusicians"
                                  "#music-playlist"
                                  "#chat"
                                  "#haskell")))
  (erc-autojoin-timing 'ident)
  (erc-fill-function 'erc-fill-static)
  (erc-fill-static-center 22)
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-threshold-time 43200)
  (erc-prompt-for-nickserv-password nil)
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                             "324" "329" "332" "333" "353" "477"))
  :config
  (add-to-list 'erc-modules 'spelling)
  (erc-services-mode 1)
  (erc-update-modules)

  :bind ("C-c i" . my/erc-start-or-switch))

(use-package erc-hl-nicks
  :defer t
  :after erc)

(use-package erc-image
  :defer t
  :after erc)


;; notifications

(use-package alert
  :custom (alert-default-style 'libnotify))

(use-package password-store)

;; email

(require 'mu4e)

(setq mu4e-sent-folder "/fmap/Sent"
      ;; mu4e-sent-messages-behavior 'delete ;; Unsure how this should be configured
      mu4e-drafts-folder "/fmap/Drafts"
      smtpmail-default-smtp-server "fmap.me"
      smtpmail-smtp-server "fmap.me"
      smtpmail-smtp-service 587
      smtpmail-auth-credentials "~/.authinfo.gpg"
      send-mail-function 'smtpmail-send-it)

(setq mu4e-contexts
 `( ,(make-mu4e-context
      :name "fmap"
      :match-func (lambda (msg) (when msg
                                 (string-prefix-p "/fmap" (mu4e-message-field msg :maildir))))
      :vars '((mu4e-trash-folder . "/fmap/Trash")
              (mu4e-refile-folder . "/fmap/Archive")))))

;; (use-package mu4e-alert
;;   :ensure t
;;   :after mu4e
;;   :init
;;   (setq mu4e-alert-interesting-mail-query "flag:unread")
;;   (mu4e-alert-enable-mode-line-display)
;;   (mu4e-alert-enable-notifications))

;; aviod trashing when deleting
(defun remove-nth-element (nth list)
  (if (zerop nth) (cdr list)
    (let ((last (nthcdr (1- nth) list)))
      (setcdr last (cddr last))
      list)))

(setq mu4e-marks (remove-nth-element 5 mu4e-marks))

(add-to-list 'mu4e-marks
     '(trash
       :char ("d" . "▼")
       :prompt "dtrash"
       :dyn-target (lambda (target msg) (mu4e-get-trash-folder msg))
       :action (lambda (docid msg target)
                 (mu4e~proc-move docid
                                 (mu4e~mark-check-target target) "-N"))))

(setq mu4e-completing-read-function 'completing-read
      mu4e-context-policy 'pick-first
      mu4e-compose-context-policy 'pick-first
      mu4e-compose-format-flowed t
      mu4e-confirm-quit nil
      mu4e-view-prefer-html nil
      mu4e-html2text-command "html2text -utf8 -width 80"
      mu4e-headers-date-format "%Y-%m-%d %H:%M"
      mu4e-view-show-addresses t
      mu4e-show-images t
      mu4e-view-show-images t
      mu4e-view-image-max-width 500
      mu4e-headers-fields '((:date . 18)
                            (:flags . 6)
                            (:from . 22)
                            (:subject)))

(defun browse-files-by-wildcard (wildcard &optional prompt)
  (interactive)
  (let ((prompt (or prompt "Select file: "))
        ;; TODO: pretty-print task names, authors and descritions
        (candidates (mapcar (lambda (f) (cons f (file-name-base f)))
                            (file-expand-wildcards wildcard))))
    (prin1 candidates)
    (find-file (selectrum-completing-read prompt candidates))))

; (mapcar (lambda (f) (cons (file-name-base f) f)) (file-expand-wildcards "~/*"))

(defun ugractf-find-task ()
  (interactive)
  (browse-files-by-wildcard "~/code/tt/ugractf-20*/tasks/*"
                            "Find Ugra CTF task: "))

(defun k60-find-emacsd ()
  (interactive)
  (browse-files-by-wildcard "~/.emacs.d/k60/*.el"))

;; (use-package nnreddit
;;   :defer t
;;   :config (custom-set-variables '(gnus-select-method (quote (nnreddit "")))))

(use-package system-packages
  :config (setq system-packages-package-manager 'pacman
                system-packages-use-sudo t))
