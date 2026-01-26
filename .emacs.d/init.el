;; ===== BASE SETTINGS =====

(setq custom-file "~/.emacs.custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(add-to-list 'load-path "~/.emacs.local/")

(defalias 'yes-or-no-p 'y-or-n-p) ;; also support <space> for y

(setq use-dialog-box nil)
(setq use-file-dialog nil)

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
1
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

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(global-set-key (kbd "C-c w") 'toggle-truncate-lines)

;; ===== INTERFACE =====

(add-to-list 'default-frame-alist
             '(font . "Liberation Mono-15"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(set-fringe-mode 0)
(global-hl-line-mode t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default compilation-scroll-output t)

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

;; ===== SOME USEFUL STUFF =====

(defun kill-other-buffers-safe ()
  "Kill all other buffers except current and essential ones."
  (interactive)
  (let ((essential-buffers '("*scratch*" "*Messages*"))
        (current (current-buffer)))
    (dolist (buffer (buffer-list))
      (unless (or (eq buffer current)
                  (member (buffer-name buffer) essential-buffers))
        (kill-buffer buffer)))))

;; stolen from https://github.com/rexim/dotfiles/blob/master/.emacs.rc/misc-rc.el
;; duplicate current line
(defun duplicate-line ()
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))
(global-set-key (kbd "C-,") 'duplicate-line)

;; stolen from https://github.com/rexim/dotfiles/blob/master/.emacs.rc/misc-rc.el
(defun insert-timestamp ()
  (interactive)
  (insert (format-time-string "(%Y%m%d-%H%M%S)" nil t)))
(global-set-key (kbd "C-c t") 'insert-timestamp)

;; rgrep
(global-set-key (kbd "C-c g d") 'rgrep)

;; stolen from https://github.com/rexim/dotfiles/blob/master/.emacs.rc/misc-rc.el
;; rgrep selected
(defun rgrep-selected (beg end)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (point-min) (point-min))))
  (rgrep (buffer-substring-no-properties beg end) "*" (pwd)))
(global-set-key (kbd "C-c g s") 'rgrep-selected)

;; switch between windows using shift+arrows
(windmove-default-keybindings)

;; ===== PLUGINS =====

;; colortheme

;;(use-package zenburn-theme
;;  :config
;;  (load-theme 'zenburn t))

;;(use-package gruber-darker-theme
;;  :ensure t
;;  :config 
;;  (load-theme 'gruber-darker t)
;;  (set-face-attribute 'line-number-current-line nil 
;;                      :weight 'bold
;;                      :foreground "#ffdd33"))

(use-package ef-themes
  :ensure t
  :config
  ;;(load-theme 'ef-elea-light t) ;; green light theme
  (load-theme 'ef-bio t)
)

;; ido + smex

(use-package ido-completing-read+
  :ensure t
  :config
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
  :bind (("C-c e" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("C-\""        . mc/skip-to-next-like-this)
         ("C-}"         . mc/skip-to-previous-like-this)))

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

(load-file custom-file)
