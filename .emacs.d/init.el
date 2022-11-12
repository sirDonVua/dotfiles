;;;; make emacs always follow symbolic links
(setq vc-handled-backends nil)

;;;; load my config from config.org
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
