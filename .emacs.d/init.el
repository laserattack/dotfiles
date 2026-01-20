;; ===== INITIALIZE PACKAGE SYSTEM =====
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; ===== INTERFACE =====
(add-to-list 'default-frame-alist
             '(font . "Monospace-15"))

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-dream t))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)

;; Relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

;; ===== BETTER MOVES =====

(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "M-l") 'forward-char)

;; 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(ef-themes gruber-darker-theme zenburn-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
