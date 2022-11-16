(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
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

(nvmap :prefix "SPC"
    "d" '(dired-jump :which-key "Launch dired")
    "." '(find-file :which-key "find file")
    "f r" '(counsel-recentf :which-key "find recent file")
    "f s" '(counsel-swiper :which-key "Search in a file")
    "r" '((lambda() (interactive) (load-file "~/.emacs.d/init.el"))
    :which-key "reload emacs"))

(nvmap :prefix "SPC"
    "a" '((lambda () (interactive) (set-input-method 'arabic)) :which-key "Switch to the secound language" )
    "e" '((lambda() (interactive) (set-input-method 'TeX)) :which-key "Switch to english language" ))

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
  (setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)))
  ; make dasboard work with the emacs client
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font 14" :weight 'medium)
(set-face-attribute 'variable-pitch nil :font "UbuntuMono Nerd Font 16" :weight 'medium)
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font 14" :weight 'medium)

;; if the buffer is a daemon it will fix the daemon fonts.
(if (daemonp)
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font 14" )))

(set-fontset-font "fontset-default"
		  'arabic
		  (font-spec :family "Amiri" :size 24 ))

;; make RTL work will in org mode
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

(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

(use-package beacon
:config
(beacon-mode 1))

(setq make-backup-files nil)

(setq comp-async-report-warnings-errors nil)

(setq vc-handled-backends nil)

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; counsel
(use-package counsel
:after ivy
:config (counsel-mode))

;; ivy
(use-package ivy
:config (ivy-mode)
(setq ivy-initial-inputs-alist nil))

;; ivy-rich
(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer)
  (ivy-rich-mode 1)) ;; this gets us descriptions in M-x.

;; swiper
(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)))

(use-package all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

;; makeing h,l do what the supposed to do
(evil-define-key 'normal dired-mode-map
(kbd "h") 'dired-up-directory
(kbd "l") 'dired-find-file
(kbd "SPC") 'nil) ; making keybindings start with SPC work in dired

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

(set-face-attribute 'org-level-1 nil :height 1.8)
(set-face-attribute 'org-level-2 nil :height 1.6)
(set-face-attribute 'org-level-3 nil :height 1.4)
(set-face-attribute 'org-level-4 nil :height 1.3)
(set-face-attribute 'org-level-5 nil :height 1.2)
(set-face-attribute 'org-level-6 nil :height 1.1)

(use-package org-modern
  :config (global-org-modern-mode 1))
(setq org-hide-emphasis-markers t) ; hide markup signs like ~ ~ * * / / _ _

(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

(use-package org-tempo
  :ensure nil) ; iguess it's installed but need to be activated

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package org-auto-tangle
 :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package org-journal
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir "~/org/journal/"
        org-journal-date-format "%A, %d %B %Y"
        org-journal-file-format "%Y-%m-%d.org"))

(nvmap :prefix "SPC"
   "o a" '(org-agenda :which-key "opens org agenda")
   "o w" '(org-agenda-list :which-key "agenda week view")
   "o j" '(org-journal-new-entry :which-key "a new journal file")
   "o c" '(org-journal-open-current-journal-file :which-key "open Current journal file"))

(use-package magit
  :config
  (nvmap :prefix "SPC"
    "g" '(magit-status :which-key "Opens magit")))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package lua-mode)
