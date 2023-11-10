;;;; make emacs always follow symbolic links
(setq vc-handled-backends nil)

;;;; load my config from config.org
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" default))
 '(org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)"))
 '(package-selected-packages
   '(nix-mode company-box company lsp-mode visual-fill-column mixed-pitch lsp-pyright pyvenv python-mode lsp-ui company-jedi lua-mode which-key magit org-journal org-auto-tangle toc-org org-modern all-the-icons-dired ivy-rich counsel beacon doom-modeline doom-themes all-the-icons dashboard general evil-collection evil use-package))
 '(warning-suppress-log-types '((emacs)))
 '(warning-suppress-types '((emacs) (emacs) (comp) (comp) (comp))))
