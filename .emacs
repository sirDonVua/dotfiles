;;;; package mangement ;;;;

;; melpa

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
; (package-refresh-contents) ; reload the repo could take some time so i suggest using emacs clinet
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
(package-install 'use-package))

;; EVIL MODE

;; setup evil for text editing
(use-package evil
:ensure t ;; make sure it's installed
:init ;; tweak the package before loading
(setq evil-want-keybinding nil)
(setq evil-undo-system 'undo-redo)
(evil-mode 1))


;; setup evil-collection which is evil in all emacs
(use-package evil-collection
:after evil
:ensure t
:config
(evil-collection-init))

;;;; Customization ;;;;

;; dasboard ;;
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  ;; icons
  (use-package all-the-icons :ensure t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;; change title
  (setq dashboard-banner-logo-title "I Love Emacs Games :)")
  (setq dashboard-center-content t) ; make the dashboared centered
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (agenda . 5)))
; make dasboard work with the emacs client
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

;;;;


;; fonts
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font 16" :weight 'medium)
(set-face-attribute 'variable-pitch nil :font "UbuntuMono Nerd Font 16" :weight 'medium)
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font 16" :weight 'medium)

;;making fonts work right in emacs clinet
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font 14" ))

;; arabic font
(set-fontset-font "fontset-default"
		  'arabic
		  (font-spec :family "NotoSans Nerd Font 24" ))

;; make RTL work will in org
(defun set-bidi-env ()
  "interactive"
  (setq bidi-paragraph-direction 'nil))
(add-hook 'org-mode-hook 'set-bidi-env)

;; remove usless nobie bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; line numbers
(global-display-line-numbers-mode 1)
;; stop creating ~ files
(setq make-backup-files nil)

;; dark theme setup :)
;; doom emacs themes
(use-package doom-themes
  :ensure t
  :config
  (setq doom-theme-enable-bold t
	doom-theme-enable-italic t)
  (load-theme 'doom-one t)) ; load the doom one theme

;; Which key ;;
(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

;; lua support ;;
(use-package lua-mode :ensure t)
