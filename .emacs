;; ===== PATHS =====

(setq custom-file "~/.emacs.custom.el"
      local-dir "~/.emacs.local"
      org-directory "~/org"
      org-tasks-file (expand-file-name "tasks.org" org-directory)
      org-images-directory (expand-file-name "images" org-directory)
      org-notes-directory (expand-file-name "notes" org-directory))

;; ===== PATHS =====




;; ===== CHANGE SETTINGS =====

(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

(add-to-list 'load-path local-dir)

(defalias 'yes-or-no-p 'y-or-n-p) ;; also support <space> for y

(advice-add #'display-startup-echo-area-message :override #'ignore)
(setq initial-scratch-message ";; !!!!CHECK AGENDA PLSSSS!!!!")

(setq warning-minimum-level :error)

;; close the buffer without question if it holds the process
(remove-hook 'kill-buffer-query-functions
             'process-kill-buffer-query-function)

;; without asking, follow the symlinks in the version control systems
(setq vc-follow-symlinks t)

;; dired
(setq dired-kill-when-opening-new-dired-buffer t
      dired-listing-switches "-alh"
      dired-mouse-drag-files t)
(setq-default dired-dwim-target t)

;; default mode in M-x re-builder
(setq reb-re-syntax 'string)

;; repos
(require 'package)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(add-to-list 'default-frame-alist
             '(font . "Liberation Mono-15"))

(global-hl-line-mode t)

(setq-default tab-width 4
              compilation-scroll-output t)

;; ===== CHANGE SETTINGS =====




;; ===== ENABLE COOL STUFF =====

(column-number-mode 1)

;; save positions in buffer on exit (limit: 400 by default)
(save-place-mode 1)
;; save minibuffer history on exit (limit: 100 by default)
(savehist-mode 1)

;; emacs will reload the file if it is modified from the outside
(global-auto-revert-mode t)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; relative lines numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; ===== ENABLE COOL STUFF =====




;; ===== DISABLE ANNOYING STUFF =====

;; never insert tabs. only spaces. hate tabs.
(setq-default indent-tabs-mode nil) 

;; disable menu etc.
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; disable backup files
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; disable emacs hello-screen on startup
(setq inhibit-startup-screen t)

(setq mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(3))

(setq use-dialog-box nil
      use-file-dialog nil)

(global-eldoc-mode -1)

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

;; ===== DISABLE ANNOYING STUFF =====




;; ===== SOME USEFUL BINDS =====

;; binds

(global-set-key (kbd "C-x C-d") 'dired) ;; it also C-x d
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x g") 'rgrep)
(global-set-key (kbd "C-c a") 'align-regexp)
(global-set-key (kbd "C-c f") 'occur)


(defun my/duplicate-line (&optional n)
  "Duplicate current line."
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
(global-set-key (kbd "C-c d") 'my/duplicate-line)

(defun my/insert-timestamp ()
  "Insert current timestamp in format (%Y%m%dT%H%M%S)."
  (interactive)
  (let ((current-time (current-time)))
    (insert (format-time-string "(%Y%m%dT%H%M%S)" current-time))))
(global-set-key (kbd "C-c i d") 'my/insert-timestamp)

(defun my/insert-todo-timestamp ()
   "Insert todo in format TODO(%Y%m%dT%H%M%S) using current timestamp."
  (interactive)
  (let ((current-time (current-time)))
    (insert (format-time-string "TODO(%Y%m%dT%H%M%S): " current-time))))
(global-set-key (kbd "C-c i t") 'my/insert-todo-timestamp)

;; switch between windows using shift+arrows
(windmove-default-keybindings)

;; ===== SOME USEFUL BINDS =====




;; ===== ORG MODE =====

(setq org-capture-bookmark nil)

;; agenda
(setq org-agenda-files (list org-tasks-file)
      org-tags-column 0
      org-agenda-tags-column 0)
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

;; ===== ORG MODE =====




;; ===== PLUGINS =====

;; snippets

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
  (setq vertico-preselect 'prompt
        vertico-count 20))

;; hints on the right

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;; smart search

(use-package orderless
  :ensure t
  :config
  ;; use orderless unless otherwise specified
  (setq completion-styles '(orderless)
        ;; disable default completion rules
        completion-category-defaults nil
        ;; so, only orderless will be used

        ;; fzf-like search
        orderless-matching-styles '(orderless-flex)
        ;; smart case-insensitive search
        orderless-smart-case t
        ;; no use separators (search the entire row)
        orderless-component-separator nil))

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

;; denote system

(defun my/denote-dired-all ()
  "Open denote directory in dired without filters."
  (interactive)
  (dired org-notes-directory))

(use-package denote
  :ensure t
  :hook
  ((dired-mode . denote-dired-mode-in-directories))
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . my/denote-dired-all)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory org-notes-directory
        denote-dired-directories (list org-notes-directory)
        denote-known-keywords '("emacs" "philosophy" "prog" "it"
                                "study" "ideas" "linux" "list" "personal" "guide"))
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

;; ===== PLUGINS =====




;; ===== LANGUAGES MODES =====

;; c mode (https://github.com/rexim/simpc-mode)

(require 'simpc-mode)
;; Enabling simpc-mode on .h, .c, .cpp, .hpp files
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; dockerfile

(use-package dockerfile-mode
  :ensure t)

;; go

(use-package go-mode
  :ensure t
  :hook (before-save . gofmt-before-save))

;; graphviz

(use-package graphviz-dot-mode
  :ensure t)

;; ===== LANGUAGES MODES =====




;; ===== OTHER =====

;; https://emacs.stackexchange.com/questions/82010/why-is-emacs-recompiling-some-packages-on-every-startup
(use-package comp-run
  :ensure nil
  :config
  (push "loaddefs.el.gz" native-comp-jit-compilation-deny-list))

(load-file custom-file)

;; ===== OTHER =====
