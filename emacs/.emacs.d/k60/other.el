(setq auth-sources '("~/.authinfo.gpg"))

(use-package telega
  :commands (telega)
  :defer
  :config (setq telega-emoji-use-images t
                telega-symbol-checkmark "•"
                telega-symbol-heavy-checkmark " "
                telega-chat-input-markups '("markdown2" nil))
  :custom (telega-chat-button-brackets '((all " " "")))
  :bind-keymap ("C-c t" . telega-prefix-map)
  :init
  (require 'telega-alert)
  (telega-alert-mode 1))

;; erc

(defun my/erc-start-or-switch ()
  "Connects to ERC, or switch to last active buffer."
  (interactive)
  (if (get-buffer "irc.libera.chat:6667")
      (erc-track-switch-buffer 1)
    (when (y-or-n-p "Start ERC? ")
      (erc :server "irc.libera.chat" :port 6667 :nick "k60"))))

(use-package erc
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
  :after erc)

(use-package erc-image
  :after erc)


;; notifications

(use-package alert
  :custom (alert-default-style 'notifier))

;; gnus

(custom-set-variables '(gnus-select-method (quote (nnhackernews ""))))
