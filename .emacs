(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages '(lua-mode which-key magit evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; evil mode
(require 'evil)
(evil-mode 1)
(evil-set-undo-system 'undo-redo)

;; which key
(require 'which-key)
(which-key-mode 1)

;; fonts
;; (font-family-list) ; gives available fonts
(set-frame-font "JetBrainsMono Nerd Font-12" nil t)

;; removeing menu,tool and scrool bars
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; stop creating ~ files
(setq make-backup-files nil) 
