(defvar elpaca-installer-version 0.5)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))

;; Block until current queue processed.
(elpaca-wait)

(require 'use-package-ensure)
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

(use-package evil-tutor)

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer mainkeys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC")) ;; access leader in insert mode

(elpaca-wait)

(mainkeys
       "b b"   '(switch-to-buffer :which-key "Switch buffer")
       "b k"   '(kill-current-buffer :which-key "Kill current buffer")
       "b l"   '(bookmark-bmenu-list :which-key "List bookmarks")
       "b n"   '(next-buffer :which-key "Next buffer")
       "b s"   '(bookmark-set :which-key "Set as a bookmark")
       "b w"   '(bookmark-save :which-key "Write bookmarks")
       "b p"   '(previous-buffer :which-key "Previous buffer")
       "b i"   '(ibuffer :which-key "Ibuffer")
       "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
       "b K"   '(kill-buffer :which-key "Kill buffer"))

(mainkeys
    "d" '(dired-jump :which-key "Launch dired")
    "." '(find-file :which-key "find file")
    "f r" '(counsel-recentf :which-key "find recent file")
    "f s" '(counsel-swiper :which-key "Search in a file")
    "r" '((lambda() (interactive) (load-file "~/.emacs.d/init.el")) :wk "reload emacs")
    "/" '(comment-line :wk "Comment lines"))

(mainkeys
    "a" '((lambda () (interactive) (set-input-method 'arabic)) :which-key "Switch to the secound language" )
    "e" '((lambda() (interactive) (set-input-method 'TeX)) :which-key "Switch to english language" ))

(mainkeys
"h" '(:ignore t :wk "Help")
   "h f" '(describe-function :wk "Describe function")
   "h v" '(describe-variable :wk "Describe variable"))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  ;; icons
  (use-package all-the-icons)
  (use-package nerd-icons)
  (setq dashboard-icon-type 'nerd-icons) ;; use `all-the-icons' package
  (setq dashboard-display-icons-p t) ;; icons for the emacs client
  (setq dashboard-set-file-icons t)
  ;; icons for the emacs client
(if (display-graphic-p)
  (setq dashboard-set-file-icons t))
  ;; change title
  (setq dashboard-banner-logo-title "I Love Emacs Games :)")
  (setq dashboard-center-content t) ; make the dashboared centered
  (setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)))
  ; make dasboard work with the emacs client
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

;; Set default font
(defun nt/set-font-faces()
  (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font 14" :height 100)
  (set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font 14" :height 100)
  (set-face-attribute 'variable-pitch nil :font "UbuntuMono Nerd Font 16" :height 100))
  (set-fontset-font t 'arabic "Omar 12")
;; if the buffer is a daemon it will fix the daemon fonts.
(if (daemonp)
    (add-hook 'after-make-frame-functions
		(lambda (frame)
		  (with-selected-frame frame
		    (nt/set-font-faces))))
  (nt/set-font-faces))

;; Set the default spacing between lines to not make them stuck to each other
(setq-default line-spacing 8)

;; comments in italic
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; (set-fontset-font "fontset-default"
		  ;; 'arabic
		  ;; (font-spec :family "Omar" :size 16 ))

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
(global-visual-line-mode t)

(use-package doom-themes
  :config
  (setq doom-theme-enable-bold t
	doom-theme-enable-italic t)
  (load-theme 'doom-dracula t) ;; loads the theme
  (doom-themes-org-config))

(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

(use-package beacon
:config
(beacon-mode 1))

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(setq comp-async-report-warnings-errors nil)

(setq vc-handled-backends nil)

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; counsel
(use-package counsel
:after ivy
:config (counsel-mode))
(elpaca-wait)

;; ivy
(use-package ivy
:config (ivy-mode)
(setq ivy-initial-inputs-alist nil))

;; icons :)
(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

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

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook))

;; ls command for dired
(setq dired-listing-switches "-alhv --group-directories-first")
;; keybindings
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory) ; using h to go up a directory
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; using l to open/enter a/an file/directory 
    (evil-define-key 'normal dired-mode-map (kbd "SPC") 'nil) ; making keybindings start with SPC work in dired
    (evil-define-key 'normal dired-mode-map (kbd "p") 'peep-dired) ; launching peep dired

;; peep-dired keybindings
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(use-package org-modern
  :config (global-org-modern-mode 1))
(setq org-hide-emphasis-markers t) ; hide markup signs like ~ ~ * * / / _ _
(setq org-startup-indented t)

(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

(require 'org-tempo)

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
  (setq org-journal-dir "~/Documents/journal/"
        org-journal-date-format "%A, %d %B %Y"
        org-journal-file-format "%Y-%m-%d.org"))

(mainkeys
   "o a" '(org-agenda :which-key "opens org agenda")
   "o w" '(org-agenda-list :which-key "agenda week view")
   "o j" '(org-journal-new-entry :which-key "a new journal file")
   "o c" '(org-journal-open-current-journal-file :which-key "open Current journal file"))

(use-package magit
  :config
  (mainkeys :prefix "SPC"
    "g" '(magit-status :which-key "Opens magit")))
(elpaca-wait)

(use-package which-key
  :config
  (which-key-mode 1)
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit t
	  which-key-separator " → " ))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))

;;  lsp-ui UI enhancements for lsp-mode

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

;; Performance tweaks, see
  ;; https://github.com/emacs-lsp/lsp-mode#performance
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
;; pyvenv
(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode t))

(use-package company
  :defer 2
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))

(use-package vterm)
(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  (reusable-frames . visible)
                  (window-height . 0.3)))
(mainkeys
  "v" '(vterm-toggle :wk "toggle vterm")))

(use-package smartparens
  :config (smartparens-global-mode 1))

(use-package sudo-edit
  :config
    (mainkeys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package rainbow-mode
  :config
  (rainbow-mode 1)
  :hook 
  ((org-mode prog-mode) . rainbow-mode))

(use-package lua-mode)
(use-package nix-mode
  :mode "\\.nix\\'")
