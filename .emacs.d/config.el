(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(package-refresh-contents) ; reload the repo could take some time so i suggest using emacs clinet
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
  (setq use-package-always-ensure t) ; always make sure that the packages are installed

(use-package evil
:init ;; tweak the package before loading
(setq evil-want-keybinding nil)
(setq evil-undo-system 'undo-redo)
(evil-mode 1))

(use-package evil-collection
:after evil
:config
(evil-collection-init))

(use-package general
  :config
  (general-evil-setup t))

(nvmap :prefix "SPC"
       "b b"   '(ibuffer :which-key "Ibuffer")
       "b k"   '(kill-current-buffer :which-key "Kill current buffer")
       "b l"   '(bookmark-bmenu-list :which-key "List bookmarks")
       "b n"   '(next-buffer :which-key "Next buffer")
       "b s"   '(bookmark-set :which-key "Set as a bookmark")
       "b w"   '(bookmark-save :which-key "Write bookmarks")
       "b p"   '(previous-buffer :which-key "Previous buffer")
       "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
       "b K"   '(kill-buffer :which-key "Kill buffer"))

;; launching dired
(nvmap :prefix "SPC"
    "d" '(dired-jump :which-key "Launch dired")
    "." '(find-file :which-key "find file")
    "r" '((lambda() (interactive) (load-file "~/.emacs.d/init.el"))
    :which-key "reload emacs"))

;; makeing h,l do what the supposed to do
(evil-define-key 'normal dired-mode-map
(kbd "h") 'dired-up-directory
(kbd "l") 'dired-find-file
(kbd "SPC") 'nil) ; making keybindings start with SPC work in dired

(nvmap :prefix "SPC"
    "a" '((lambda () (interactive) (set-input-method 'arabic )) :which-key "Switch to arabic language" )
    "e" '((lambda() (interactive) (set-input-method 'Tox)) :which-key "Switch to english language" ))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  ;; icons
  (use-package all-the-icons)
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

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font 16" :weight 'medium)
(set-face-attribute 'variable-pitch nil :font "UbuntuMono Nerd Font 16" :weight 'medium)
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font 16" :weight 'medium)

;; uncomment only if using emacs client
;(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font 14" ))

(set-fontset-font "fontset-default"
		  'arabic
		  (font-spec :family "Amiri" :size 24 ))

;; make RTL work will in org
(defun set-bidi-env ()
  "interactive"
  (setq bidi-paragraph-direction 'nil))
(add-hook 'org-mode-hook 'set-bidi-env)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; line numbers
(global-display-line-numbers-mode 1)

(use-package doom-themes
  :config
  (setq doom-theme-enable-bold t
	doom-theme-enable-italic t)
  (load-theme 'doom-one t)) ; load the doom one theme

(use-package beacon
:config
(beacon-mode 1))

(setq make-backup-files nil)

(setq comp-async-report-warnings-errors nil)

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(use-package all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

(use-package magit
  :config
  (nvmap :prefix "SPC"
    "g" '(magit-status :which-key "Opens magit")))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package lua-mode)
