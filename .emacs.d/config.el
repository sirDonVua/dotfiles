(defvar elpaca-installer-version 0.6)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
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

;;When installing a package which modifies a form used at the top-level
;;(e.g. a package which adds a use-package key word),
;;use `elpaca-wait' to block until that package has been installed/configured.
;;For example:
;;(use-package general :demand t)
;;(elpaca-wait)

;;Useful for configuring built-in emacs features.
(use-package emacs :elpaca nil :config (setq ring-bell-function #'ignore))

;; Don't install anything. Defer execution of BODY
(elpaca nil (message "deferred"))

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
  "b b"   '(counsel-switch-buffer :which-key "Switch buffer")
  "b k"   '(kill-current-buffer :which-key "Kill current buffer")
  "b l"   '(bookmark-bmenu-list :which-key "List bookmarks")
  "b n"   '(next-buffer :which-key "Next buffer")
  "b s"   '(bookmark-set :which-key "Set as a bookmark")
  "b d"   '(bookmark-delete :which-key "Delete bookmark")
  "b w"   '(bookmark-save :which-key "Write bookmarks")
  "b p"   '(previous-buffer :which-key "Previous buffer")
  "b i"   '(ibuffer :which-key "Ibuffer")
  "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
  "b K"   '(kill-buffer :which-key "Kill buffer"))

(mainkeys
"w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right"))

(mainkeys
  "d" '(dired-jump :which-key "Launch dired")
"n" '(:ignore t :wk "Neotree")
  "n n" '(neotree-toggle :wk "Open neotree in current directory")
  "n d" '(neotree-dir :wk "Open directory in neotree")
  "." '(find-file :which-key "find file")

  "r" '((lambda() (interactive) (load-file "~/.emacs.d/init.el")) :wk "reload emacs")
  "/" '(comment-line :wk "Comment lines")

"f" '(:ignore t :wk "files")'
"f r" '(counsel-recentf :which-key "find recent file")
"f s" '(counsel-swiper :which-key "Search in a file")
"f c" '((lambda () (interactive) (find-file "~/.emacs.d/config.org")) :wk "Edit emacs config")
"f e" '((lambda () (interactive) (dired "~/.emacs.d/")) :wk "Open user-emacs-directory in dired"))

(mainkeys
  "a" '((lambda () (interactive) (set-input-method 'arabic)) :which-key "Switch to the secound language" )
  "e" '((lambda() (interactive) (set-input-method 'TeX)) :which-key "Switch to english language" ))

(mainkeys
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable"))

(use-package dashboard
  :init
  ;; icons
  (use-package all-the-icons)
  (use-package nerd-icons)
  (setq dashboard-icon-type 'nerd-icons) ;; use `all-the-icons' package

  (setq dashboard-display-icons-p t) ;; icons for the emacs client
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-heading-icons t)
  ;; icons for the emacs client
  (if (display-graphic-p)
      (setq dashboard-set-file-icons t))
  ;; change title
  (setq dashboard-banner-logo-title "Emacs: More Than a Text Editor")
  (setq dashboard-center-content t) ; make the dashboared centered
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)))
  ;; make dasboard work with the emacs client
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  ;; :custom 
  ;; (dashboard-modify-heading-icons '((recents . "file-text")
  ;; (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

;; Set default font
(defun nt/set-font-faces()
  (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font 14" :height 100)
  (set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font 14" :height 100)
  (set-face-attribute 'variable-pitch nil :font "FantasqueSansM Nerd Font 16" :height 100))
;; (set-fontset-font t 'arabic "ElMessiri 25")
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

(set-fontset-font "fontset-default"
                  'arabic
                  (font-spec :family "ElMessiri" :size 24 ))

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
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(use-package beacon
  :config
  (beacon-mode 1))

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(setq comp-async-report-warnings-errors nil)

(setq vc-handled-backends nil)

(setq ring-bell-function 'ignore)

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; prevent auto piar for org-tempo
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

;; ivy
(use-package ivy
  :config 
  (ivy-mode 1)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers nil))

;; swiper
(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)))

;; counsel
(use-package counsel
  :after ivy
  :config (counsel-mode 1)
  (setq counsel-find-file-at-point t))


;; icons :)
(use-package all-the-icons-ivy-rich
  :after all-the-icons
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
      org-edit-src-content-indentation 0
      )

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

;;   (use-package git-timemachine
;;   :hook (evil-normalize-keymaps . git-timemachine-hook)
;;   :config
;;     (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
;;     (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision)
;; )

(use-package magit)
(mainkeys 
"g" '(magit-status :wk "opens magit"))

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

(use-package eglot)

(use-package company
  :defer 2
  :after eglot
  :hook (eglot-managed-mode . company-mode)
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

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)
         (python-mode . rainbow-delimiters-mode)
	 (nix-mode . rainbow-delimiters-mode)
	 (sh-mode . rainbow-delimiters-mode)
	 ))

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 33
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action
        neo-theme (if (display-graphic-p) 'icons 'arrow))
  ;; truncate long file names in neotree
  (add-hook 'neo-after-create-hook
            #'(lambda (_)
                (with-current-buffer (get-buffer neo-buffer-name)
                  (setq truncate-lines t)
                  (setq word-wrap nil)
                  (make-local-variable 'auto-hscroll-mode)
                  (setq auto-hscroll-mode nil)))))

(use-package sudo-edit
  :config
  (mainkeys
    "fu" '(sudo-edit-find-file :wk "Sudo find file")
    "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package rainbow-mode
  :init
  (rainbow-mode 1)
  :hook 
  ((org-mode prog-mode) . rainbow-mode))

(use-package lua-mode)
(use-package nix-mode
  :mode "\\.nix\\'")
