;; ===== CUSTOM FILE =====

(setq custom-file "~/.emacs.custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(add-to-list 'load-path "~/.emacs.local/")

;; ===== PACKAGE SYSTEM =====

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; ===== BINDINGS =====

(global-set-key (kbd "C-c w") 'toggle-truncate-lines)

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

(setq-default truncate-lines nil)
(global-visual-line-mode 1)
(defun my-toggle-word-wrap ()
  (interactive)
  (if visual-line-mode
      (progn
        (visual-line-mode -1)
        (setq truncate-lines t))
    (progn
        (visual-line-mode 1)
        (setq truncate-lines nil))))
(global-set-key (kbd "C-c w") 'my-toggle-word-wrap)

(setq inhibit-startup-screen t)

;; relative lines numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; ===== ANOTHER PLUGINS =====

;; ido

(use-package ido-completing-read+
  :ensure t
  :config
  (ido-mode 1)
  (ido-everywhere))

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

;; ave jump

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-c SPC") 'avy-goto-char-2))

;; ===== MODES =====

;; c mode (https://github.com/rexim/simpc-mode)

(require 'simpc-mode)
;; Enabling simpc-mode on .h, .c, .cpp, .hpp files
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;

;; ===== LOAD CUSTOM FILE =====

(load-file custom-file)
