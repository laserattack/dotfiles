;; ===== BASE SETTINGS =====

(setq custom-file "~/.emacs.custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(add-to-list 'load-path "~/.emacs.local/")

(defalias 'yes-or-no-p 'y-or-n-p) ;; also support <space> for y

(setq use-dialog-box nil)
(setq use-file-dialog nil)

(advice-add #'display-startup-echo-area-message :override #'ignore)
(setq initial-scratch-message "!!!!CHECK AGENDA PLSSSS!!!!")

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
(setq dired-kill-when-opening-new-dired-buffer t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)
(setq-default dired-dwim-target t)

;; repos
(require 'package)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; ===== INTERFACE =====

(add-to-list 'default-frame-alist
             '(font . "Liberation Mono-15"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-hl-line-mode t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default compilation-scroll-output t)

(setq inhibit-startup-screen t)

;; relative lines numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; disable inferting funcs

(put 'narrow-to-region 'disabled t)
(put 'narrow-to-page 'disabled t)
(put 'narrow-to-defun 'disabled t)
(put 'widen 'disabled t)

(global-unset-key (kbd "M-<drag-mouse-1>"))
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-unset-key (kbd "M-<mouse-1>"))
(global-unset-key (kbd "M-<mouse-2>"))
(global-unset-key (kbd "M-<mouse-3>"))

(global-unset-key (kbd "C-<down-mouse-1>"))
(global-unset-key (kbd "C-<down-mouse-3>"))

;; ===== SOME USEFUL STUFF =====

;; binds

(global-set-key (kbd "C-x C-d") 'dired) ;; it also C-x d
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x g") 'rgrep)
(global-set-key (kbd "C-c a") 'align-regexp)

;; duplicate current line
(defun duplicate-line (&optional n)
  (interactive "p")
  (let ((n (or n 1))
        (column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (dotimes (i n)
      (move-end-of-line 1)
      (newline)
      (insert line)
      (move-beginning-of-line 1)
      (forward-char column))))
(global-set-key (kbd "C-c d") 'duplicate-line)

(defun insert-timestamp ()
  (interactive)
  (let ((current-time (current-time)))
    (insert (format-time-string "(%Y%m%d-%H%M%S)" current-time))))
(global-set-key (kbd "C-c i d") 'insert-timestamp)

(defun insert-todo-timestamp ()
  (interactive)
  (let ((current-time (current-time)))
    (insert (format-time-string "TODO(%Y%m%d-%H%M%S): " current-time))))
(global-set-key (kbd "C-c i t") 'insert-todo-timestamp)

;; switch between windows using shift+arrows
(windmove-default-keybindings)

;; ===== PLUGINS =====

;; yas

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.emacs.snippets/"))
  (yas-reload-all)

  ;; allow yas in minibuffer
  (add-hook 'minibuffer-setup-hook 'yas-minor-mode)
  (define-key minibuffer-local-map (kbd "TAB")
    (lambda ()
      (interactive)
      (if (yas--maybe-expand-key-filter 'ignore)
          (yas-expand)
        (vertico-next)))))

;; colortheme

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;; vertical completion UI

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1)
  (setq vertico-preselect 'prompt)
  (setq vertico-count 20))

;; hints on the right

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;; smart search

(use-package orderless
  :ensure t
  :init
  (setq completion-styles nil)
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil)
  :config
  (setq completion-styles '(orderless))
  (setq orderless-matching-styles '(orderless-flex))
  (setq orderless-smart-case t)
  (setq orderless-component-separator nil))

;; ido + smex (old style)

;; (use-package ido-completing-read+
;;   :ensure t
;;   :config
;;   (ido-everywhere)
;;   (setq ido-enable-flex-matching t))

;; (use-package smex
;;   :ensure t
;;   :bind (("M-x" . smex)
;;          ("M-X" . smex-major-mode-commands)
;;          ("C-c C-c M-x" . execute-extended-command)))

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

;; avy jump

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'avy-goto-char-2))

;; magit

(use-package magit
  :ensure t
  :config
  (setq magit-auto-revert-mode nil)
  :bind (("C-c m" . magit-status)))

;; multiple cursors

(use-package multiple-cursors
  :ensure t
  :bind (("C-c e" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("C-\""        . mc/skip-to-next-like-this)
         ("C-}"         . mc/skip-to-previous-like-this)))

;; ===== LANGUAGES MODES =====

;; c mode (https://github.com/rexim/simpc-mode)

(require 'simpc-mode)
;; Enabling simpc-mode on .h, .c, .cpp, .hpp files
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; dockerfile

(use-package dockerfile-mode
  :ensure t)

;; go mode

(use-package go-mode
  :ensure t
  :hook (before-save . gofmt-before-save))

(use-package graphviz-dot-mode
  :ensure t)

;; ===== ORG MODE =====

(setq org-capture-bookmark nil)

;; paths
(setq org-directory "~/org")
(setq org-tasks-file (expand-file-name "tasks.org" org-directory))
(setq org-images-directory (expand-file-name "images" org-directory))
(setq org-notes-directory (expand-file-name "notes" org-directory))

;; agenda
(setq org-agenda-files (list org-tasks-file))
(setq org-tags-column 0)
(setq org-agenda-tags-column 0)
(global-set-key (kbd "C-c o a") 'org-agenda)

;; view images on hotkey
(global-set-key (kbd "C-c o v") 'org-toggle-inline-images)

;; paste images
(use-package org-download
  :ensure t
  :config
  (setq org-download-method 'directory))
(setq-default org-download-image-dir org-images-directory)
(global-set-key (kbd "C-c o i") 'org-download-clipboard)

;; templates for create tasks
(setq org-capture-templates
      `(
	("g" "Global task" entry (file+headline org-tasks-file "Global (no deadline)")
         "** TODO %?")
	("e" "Task for today" entry (file+headline org-tasks-file "Daily")
         "** TODO %?\nSCHEDULED: <%<%Y-%m-%d %a>>")
	("t" "Task for tomorrow" entry (file+headline org-tasks-file "Daily")
	 "** TODO %?\nSCHEDULED: <%(org-read-date nil nil "+1d")>")
	("m" "Task with manual date input" entry (file+headline org-tasks-file "Daily")
	 "** TODO %?\nSCHEDULED: <%^{Date in YYYY-MM-DD format}>")
	))
(global-set-key (kbd "C-c o t") 'org-capture)

;; denote system
(use-package denote
  :ensure t
  :hook
  ((dired-mode . denote-dired-mode-in-directories))
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory org-notes-directory)

  (setq denote-dired-directories (list org-notes-directory))
  (setq denote-known-keywords '("emacs" "philosophy" "prog" "study" "ideas" "linux"))

  ;; Automatically rename Denote buffers when opening them so that
  ;; instead of their long file name they have, for example, a literal
  ;; "[D]" followed by the file's title.  Read the doc string of
  ;; `denote-rename-buffer-format' for how to modify this.
  (denote-rename-buffer-mode 1))

;; GCMH - the Garbage Collector Magic Hack

(use-package gcmh
  :ensure t
  :init
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 100 1024 1024)) ;; 100 mb
  :hook (emacs-startup-hook . gcmh-mode))

;; ===== OTHER =====

;; https://emacs.stackexchange.com/questions/82010/why-is-emacs-recompiling-some-packages-on-every-startup
(use-package comp-run
  :ensure nil
  :config
  (push "loaddefs.el.gz" native-comp-jit-compilation-deny-list))

(load-file custom-file)
