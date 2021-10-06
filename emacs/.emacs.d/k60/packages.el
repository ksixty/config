(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives (list '("melpa" . "http://melpa.org/packages/")
                 '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(eval-when-compile
  (require 'use-package))
