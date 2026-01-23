(setq custom-file "~/.emacs.custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(add-to-list 'load-path "~/.emacs.local/")

;; ===== BASE SETTINGS =====

(defalias 'yes-or-no-p 'y-or-n-p) ;; also support <space> for y

(advice-add #'display-startup-echo-area-message :override #'ignore)

(setq warning-minimum-level :error)

;; disable mouse wheel speed up
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(3))

;; emacs will reload the file if it is modified from the outside
(global-auto-revert-mode t)

;; disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; close the buffer without question if it holds the process
(remove-hook 'kill-buffer-query-functions 
             'process-kill-buffer-query-function)

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

;; color theme enspired by Casey Muratory `s handmade hero theme

;;(use-package ef-themes
;;  :config
;;  (setq ef-dream-palette-overrides
;;        '((bg-main "#161616")
;;          (fg-main "#CDAA7D")
;;          (cursor "#40FF40")
;;          (comment "#808080")
;;          (keyword "#B8860B")
;;          (type "#CDAA7D")
;;          (string "#6B8E23")
;;          (constant "#6B8E23")
;;          (builtin "#DAB98F")
;;          (bg-hl-line "#191970")
;;          (bg-mode-line "#1A1A1A")
;;          (fg-mode-line "#AAAAAA")
;;          (bg-mode-line-active "#222222")
;;          (fg-mode-line-active "#CDAA7D")))
;;  (load-theme 'ef-dream t))

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-dream t))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(set-fringe-mode 0)
(global-hl-line-mode t)

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

(global-set-key (kbd "C-p") 'previous-logical-line)
(global-set-key (kbd "C-n") 'next-logical-line)
(global-set-key (kbd "C-a") 'beginning-of-line)
(global-set-key (kbd "C-e") 'end-of-line)

(setq inhibit-startup-screen t)

;; relative lines numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; ===== ANOTHER PLUGINS =====

;; ido + smex

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
  :bind (("M-n" . move-text-down)
         ("M-p" . move-text-up)))

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

;; paths
(setq org-directory "~/org")
(setq org-tasks-directory (expand-file-name "tasks.org" org-directory))
(setq org-images-directory (expand-file-name "images" org-directory))

;; agenda
(setq org-agenda-files (list org-tasks-directory))
(setq org-tags-column 0)
(setq org-agenda-tags-column 0)
(global-set-key (kbd "C-c a") 'org-agenda)

;; paste images
(use-package org-download
  :ensure t
  :config
  (setq org-download-method 'directory))
(setq-default org-download-image-dir org-images-directory)
(setq org-startup-with-inline-images t)
(global-set-key (kbd "C-c i") 'org-download-clipboard)

;; templates
(setq org-capture-templates
      `(
	("g" "Global task" entry (file+headline org-tasks-directory "Global (no deadline)")
         "** TODO %?")
	("e" "Task for today" entry (file+headline org-tasks-directory "Daily")
         "** TODO %?\nSCHEDULED: <%<%Y-%m-%d %a>>")
	("t" "Task for tomorrow" entry (file+headline org-tasks-directory "Daily")
	 "** TODO %?\nSCHEDULED: <%(org-read-date nil nil \"+1d\")>")
	("m" "Task with manual date input" entry (file+headline org-tasks-directory "Daily")
	 "** TODO %?\nSCHEDULED: <%^{Date in YYYY-MM-DD format}>")
	))
(global-set-key (kbd "C-c c") 'org-capture)

;; ===== OTHER =====

(use-package comp-run
  :ensure nil
  :config
  ;; Fix for Emacs 29+ bug with .el.gz files infinite compilation
  ;; Bug: native compilation incorrectly processes .el.gz files,
  ;; ignoring their 'no-native-compile: t' directive.
  ;; This prevents JIT compilation of all *loaddefs.el.gz files
  ;; (org-loaddefs.el.gz, cl-loaddefs.el.gz, tramp-loaddefs.el.gz, etc.)
  ;; which are autoload files and should not be compiled.
  ;; See: https://debbugs.gnu.org/cgi/bugreport.cgi?bug=XXXXX
  ;; This is a temporary workaround until the bug is fixed upstream.
  (push "loaddefs.el.gz" native-comp-jit-compilation-deny-list))

;; ===== LOAD CUSTOM FILE =====

(load-file custom-file)
