(setq custom-file "~/.emacs.custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(add-to-list 'load-path "~/.emacs.local/")

;; ===== BASE SETTINGS =====

(defalias 'yes-or-no-p 'y-or-n-p) ;; also support <space> for y

(advice-add #'display-startup-echo-area-message :override #'ignore)

;; disable mouse wheel speed up
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(3))

;; emacs will reload the file if it is modified from the outside
(global-auto-revert-mode t)

;; disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; save positions in buffer on exit
(save-place-mode 1)

;; without asking, follow the symlinks in the version control systems
(setq vc-follow-symlinks t)

;; dired

(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)
(setq-default dired-dwim-target t)

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
;;(global-hl-line-mode t)

(setq-default truncate-lines nil)
(global-visual-line-mode 1)
(defun custom-toggle-word-wrap ()
  (interactive)
  (if visual-line-mode
      (progn
        (visual-line-mode -1)
        (setq truncate-lines t))
    (progn
        (visual-line-mode 1)
        (setq truncate-lines nil))))
(global-set-key (kbd "C-c w") 'custom-toggle-word-wrap)

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
  (ido-everywhere)
  (setq ido-enable-flex-matching t))

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

;; magit

(use-package magit
  :ensure t
  :config
  (setq magit-auto-revert-mode nil)
  :bind (("C-c m s" . magit-status)
         ("C-c m l" . magit-log)))

;; multiple cursors

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("C-\""        . mc/skip-to-next-like-this)
         ("C-}"         . mc/skip-to-previous-like-this)))

;; deadgrep

(use-package deadgrep
  :ensure t
  :bind ("C-c g" . deadgrep))

;; russian keyboard shortcuts support

;;(use-package reverse-im
;;  :ensure t
;;  :custom
;;  (reverse-im-input-methods '("russian-computer"))
;;  :config
;;  (reverse-im-mode t))

;; ===== LANGUAGES MODES =====

;; c mode (https://github.com/rexim/simpc-mode)

(require 'simpc-mode)
;; Enabling simpc-mode on .h, .c, .cpp, .hpp files
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; ===== ORG MODE =====

(setq org-directory "~/org")
(setq org-agenda-files (list (expand-file-name "tasks.org" org-directory)))
(setq org-tags-column 0)
(setq org-agenda-tags-column 0)
(global-set-key (kbd "C-c a") 'org-agenda)

(use-package org-download
  :ensure t
  :config
  (setq org-download-method 'directory))
(setq-default org-download-image-dir (expand-file-name "images" org-directory))
(setq org-startup-with-inline-images t)
(global-set-key (kbd "C-c i") 'org-download-clipboard)

;; ===== LOAD CUSTOM FILE =====

(load-file custom-file)
