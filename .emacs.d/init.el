;; ===== CUSTOM FILE =====

(setq custom-file "~/.emacs.custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

;; ===== PACKAGE SYSTEM =====

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; ===== INTERFACE =====

(add-to-list 'default-frame-alist
             '(font . "Monospace-15"))

;; color theme
(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-dream t))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(set-fringe-mode 0)
(setq inhibit-startup-screen t)

;; relative lines numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; ido

(use-package ido-completing-read+
  :ensure t
  :config
  (ido-mode 1)
  (ido-everywhere 1))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))

;; move text

(use-package move-text
  :ensure t
  :bind (("M-<down>" . move-text-down)
         ("M-<up>" . move-text-up)))

;; company

(use-package company
  :ensure t
  :config
  (global-company-mode))

;;

;; ===== LOAD CUSTOM FILE =====

(load-file custom-file)
