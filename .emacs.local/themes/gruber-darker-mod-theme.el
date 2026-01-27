;;; gruber-darker-mod.el --- Modified Gruber Darker color theme for Emacs

;; Original Copyright (C) 2026 laserattack
;; Original Copyright (C) 2013-2016 Alexey Kutepov a.k.a rexim
;; Original Copyright (C) 2009-2010 Jason R. Blevins

;; Author: laserattack <sc7227484@gmail.com>
;; Based on: Original by Alexey Kutepov <reximkut@gmail.com>
;; Original URL: http://github.com/rexim/gruber-darker-theme
;; Version: 0.7-mod

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:
;;
;; Modified Gruber Darker color theme for Emacs.
;; Based on original by Jason Blevins, adapted by Alexey Kutepov.
;; This version changes yellow to green+1 color, and some small changes

(deftheme gruber-darker-mod
  "Gruber Darker color theme for Emacs 24")

;; Please, install rainbow-mode.
;; Colors with +x are lighter. Colors with -x are darker.
(let ((gruber-darker-mod-fg        "#e4e4ef")
      (gruber-darker-mod-fg+1      "#f4f4ff")
      (gruber-darker-mod-fg+2      "#f5f5f5")
      (gruber-darker-mod-white     "#ffffff")
      (gruber-darker-mod-black     "#000000")
      (gruber-darker-mod-bg-1      "#101010")
      (gruber-darker-mod-bg        "#181818")
      (gruber-darker-mod-bg+1      "#282828")
      (gruber-darker-mod-bg+2      "#453d41")
      (gruber-darker-mod-bg+3      "#484848")
      (gruber-darker-mod-bg+4      "#52494e")
      (gruber-darker-mod-red-1     "#c73c3f")
      (gruber-darker-mod-red       "#f43841")
      (gruber-darker-mod-red+1     "#ff4f58")
      (gruber-darker-mod-green     "#73c936")
      (gruber-darker-mod-green+1   "#35f038")
      (gruber-darker-mod-brown     "#cc8c3c")
      (gruber-darker-mod-quartz    "#95a99f")
      (gruber-darker-mod-niagara-2 "#303540")
      (gruber-darker-mod-niagara-1 "#565f73")
      (gruber-darker-mod-niagara   "#96a6c8")
      (gruber-darker-mod-wisteria  "#9e95c7")
      )
  (custom-theme-set-variables
   'gruber-darker-mod
   '(frame-brackground-mode (quote dark)))

  (custom-theme-set-faces
   'gruber-darker-mod

   ;; Agda2
   `(agda2-highlight-datatype-face ((t (:foreground ,gruber-darker-mod-quartz))))
   `(agda2-highlight-primitive-type-face ((t (:foreground ,gruber-darker-mod-quartz))))
   `(agda2-highlight-function-face ((t (:foreground ,gruber-darker-mod-niagara))))
   `(agda2-highlight-keyword-face ((t ,(list :foreground gruber-darker-mod-green+1
                                             :bold t))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,gruber-darker-mod-green))))
   `(agda2-highlight-number-face ((t (:foreground ,gruber-darker-mod-wisteria))))

   ;; AUCTeX
   `(font-latex-bold-face ((t (:foreground ,gruber-darker-mod-quartz :bold t))))
   `(font-latex-italic-face ((t (:foreground ,gruber-darker-mod-quartz :italic t))))
   `(font-latex-math-face ((t (:foreground ,gruber-darker-mod-green))))
   `(font-latex-sectioning-5-face ((t ,(list :foreground gruber-darker-mod-niagara
                                             :bold t))))
   `(font-latex-slide-title-face ((t (:foreground ,gruber-darker-mod-niagara))))
   `(font-latex-string-face ((t (:foreground ,gruber-darker-mod-green))))
   `(font-latex-warning-face ((t (:foreground ,gruber-darker-mod-red))))

   ;; Basic Coloring (or Uncategorized)
   `(border ((t ,(list :background gruber-darker-mod-bg-1
                       :foreground gruber-darker-mod-bg+2))))
   `(cursor ((t (:background ,gruber-darker-mod-green+1))))
   `(default ((t ,(list :foreground gruber-darker-mod-fg
                        :background gruber-darker-mod-bg))))
   `(fringe ((t ,(list :background nil
                       :foreground gruber-darker-mod-bg+2))))
   `(vertical-border ((t ,(list :foreground gruber-darker-mod-bg+2))))
   `(link ((t (:foreground ,gruber-darker-mod-niagara :underline t))))
   `(link-visited ((t (:foreground ,gruber-darker-mod-wisteria :underline t))))
   `(match ((t (:background ,gruber-darker-mod-bg+4))))
   `(shadow ((t (:foreground ,gruber-darker-mod-bg+4))))
   `(minibuffer-prompt ((t (:foreground ,gruber-darker-mod-niagara))))
   `(region ((t (:background ,gruber-darker-mod-bg+3 :foreground nil))))
   `(secondary-selection ((t ,(list :background gruber-darker-mod-bg+3
                                    :foreground nil))))
   `(trailing-whitespace ((t ,(list :foreground gruber-darker-mod-black
                                    :background gruber-darker-mod-red))))
   `(tooltip ((t ,(list :background gruber-darker-mod-bg+4
                        :foreground gruber-darker-mod-white))))

   ;; Calendar
   `(holiday-face ((t (:foreground ,gruber-darker-mod-red))))

   ;; Compilation
   `(compilation-info ((t ,(list :foreground gruber-darker-mod-green
                                 :inherit 'unspecified))))
   `(compilation-warning ((t ,(list :foreground gruber-darker-mod-brown
                                    :bold t
                                    :inherit 'unspecified))))
   `(compilation-error ((t (:foreground ,gruber-darker-mod-red+1))))
   `(compilation-mode-line-fail ((t ,(list :foreground gruber-darker-mod-red
                                           :weight 'bold
                                           :inherit 'unspecified))))
   `(compilation-mode-line-exit ((t ,(list :foreground gruber-darker-mod-green
                                           :weight 'bold
                                           :inherit 'unspecified))))

   ;; Completion
   `(completions-annotations ((t (:inherit 'shadow))))

   ;; Custom
   `(custom-state ((t (:foreground ,gruber-darker-mod-green))))

   ;; Diff
   `(diff-removed ((t ,(list :foreground gruber-darker-mod-red+1
                             :background nil))))
   `(diff-added ((t ,(list :foreground gruber-darker-mod-green
                           :background nil))))

   ;; Dired
   `(dired-directory ((t (:foreground ,gruber-darker-mod-niagara :weight bold))))
   `(dired-ignored ((t ,(list :foreground gruber-darker-mod-quartz
                              :inherit 'unspecified))))

   ;; Ebrowse
   `(ebrowse-root-class ((t (:foreground ,gruber-darker-mod-niagara :weight bold))))
   `(ebrowse-progress ((t (:background ,gruber-darker-mod-niagara))))

   ;; Egg
   `(egg-branch ((t (:foreground ,gruber-darker-mod-green+1))))
   `(egg-branch-mono ((t (:foreground ,gruber-darker-mod-green+1))))
   `(egg-diff-add ((t (:foreground ,gruber-darker-mod-green))))
   `(egg-diff-del ((t (:foreground ,gruber-darker-mod-red))))
   `(egg-diff-file-header ((t (:foreground ,gruber-darker-mod-wisteria))))
   `(egg-help-header-1 ((t (:foreground ,gruber-darker-mod-green+1))))
   `(egg-help-header-2 ((t (:foreground ,gruber-darker-mod-niagara))))
   `(egg-log-HEAD-name ((t (:box (:color ,gruber-darker-mod-fg)))))
   `(egg-reflog-mono ((t (:foreground ,gruber-darker-mod-niagara-1))))
   `(egg-section-title ((t (:foreground ,gruber-darker-mod-green+1))))
   `(egg-text-base ((t (:foreground ,gruber-darker-mod-fg))))
   `(egg-term ((t (:foreground ,gruber-darker-mod-green+1))))

   ;; ERC
   `(erc-notice-face ((t (:foreground ,gruber-darker-mod-wisteria))))
   `(erc-timestamp-face ((t (:foreground ,gruber-darker-mod-green))))
   `(erc-input-face ((t (:foreground ,gruber-darker-mod-red+1))))
   `(erc-my-nick-face ((t (:foreground ,gruber-darker-mod-red+1))))

   ;; EShell
   `(eshell-ls-backup ((t (:foreground ,gruber-darker-mod-quartz))))
   `(eshell-ls-directory ((t (:foreground ,gruber-darker-mod-niagara))))
   `(eshell-ls-executable ((t (:foreground ,gruber-darker-mod-green))))
   `(eshell-ls-symlink ((t (:foreground ,gruber-darker-mod-green+1))))

   ;; Font Lock
   `(font-lock-builtin-face ((t (:foreground ,gruber-darker-mod-green+1))))
   `(font-lock-comment-face ((t (:foreground ,gruber-darker-mod-brown))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,gruber-darker-mod-brown))))
   `(font-lock-constant-face ((t (:foreground ,gruber-darker-mod-quartz))))
   `(font-lock-doc-face ((t (:foreground ,gruber-darker-mod-green))))
   `(font-lock-doc-string-face ((t (:foreground ,gruber-darker-mod-green))))
   `(font-lock-function-name-face ((t (:foreground ,gruber-darker-mod-niagara))))
   `(font-lock-keyword-face ((t (:foreground ,gruber-darker-mod-green+1 :bold t))))
   `(font-lock-preprocessor-face ((t (:foreground ,gruber-darker-mod-quartz))))
   `(font-lock-reference-face ((t (:foreground ,gruber-darker-mod-quartz))))
   `(font-lock-string-face ((t (:foreground ,gruber-darker-mod-green))))
   `(font-lock-type-face ((t (:foreground ,gruber-darker-mod-quartz))))
   `(font-lock-variable-name-face ((t (:foreground ,gruber-darker-mod-fg+1))))
   `(font-lock-warning-face ((t (:foreground ,gruber-darker-mod-red))))

   ;; Flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-mod-red)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,gruber-darker-mod-red :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-mod-green+1)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:forground ,gruber-darker-mod-green+1 :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-mod-green)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:forground ,gruber-darker-mod-green :weight bold :underline t))))

   ;; Flyspell
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-mod-red) :inherit unspecified))
      (t (:foreground ,gruber-darker-mod-red :weight bold :underline t))))
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-mod-green+1) :inherit unspecified))
      (t (:foreground ,gruber-darker-mod-green+1 :weight bold :underline t))))

   ;; Helm
   `(helm-candidate-number ((t ,(list :background gruber-darker-mod-bg+2
                                      :foreground gruber-darker-mod-green+1
                                      :bold t))))
   `(helm-ff-directory ((t ,(list :foreground gruber-darker-mod-niagara
                                  :background gruber-darker-mod-bg
                                  :bold t))))
   `(helm-ff-executable ((t (:foreground ,gruber-darker-mod-green))))
   `(helm-ff-file ((t (:foreground ,gruber-darker-mod-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t ,(list :foreground gruber-darker-mod-bg
                                        :background gruber-darker-mod-red))))
   `(helm-ff-symlink ((t (:foreground ,gruber-darker-mod-green+1 :bold t))))
   `(helm-selection-line ((t (:background ,gruber-darker-mod-bg+1))))
   `(helm-selection ((t (:background ,gruber-darker-mod-bg+1 :underline nil))))
   `(helm-source-header ((t ,(list :foreground gruber-darker-mod-green+1
                                   :background gruber-darker-mod-bg
                                   :box (list :line-width -1
                                              :style 'released-button)))))

   ;; Ido
   `(ido-first-match ((t (:foreground ,gruber-darker-mod-green+1 :bold nil))))
   `(ido-only-match ((t (:foreground ,gruber-darker-mod-brown :weight bold))))
   `(ido-subdir ((t (:foreground ,gruber-darker-mod-niagara :weight bold))))

   ;; Info
   `(info-xref ((t (:foreground ,gruber-darker-mod-niagara))))
   `(info-visited ((t (:foreground ,gruber-darker-mod-wisteria))))

   ;; Jabber
   `(jabber-chat-prompt-foreign ((t ,(list :foreground gruber-darker-mod-quartz
                                           :bold nil))))
   `(jabber-chat-prompt-local ((t (:foreground ,gruber-darker-mod-green+1))))
   `(jabber-chat-prompt-system ((t (:foreground ,gruber-darker-mod-green))))
   `(jabber-rare-time-face ((t (:foreground ,gruber-darker-mod-green))))
   `(jabber-roster-user-online ((t (:foreground ,gruber-darker-mod-green))))
   `(jabber-activity-face ((t (:foreground ,gruber-darker-mod-red))))
   `(jabber-activity-personal-face ((t (:foreground ,gruber-darker-mod-green+1 :bold t))))

   ;; Line Highlighting
   `(highlight ((t (:background ,gruber-darker-mod-bg+1 :foreground nil))))
   `(highlight-current-line-face ((t ,(list :background gruber-darker-mod-bg+1
                                            :foreground nil))))

   ;; line numbers
   `(line-number ((t (:inherit default :foreground ,gruber-darker-mod-bg+4))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,gruber-darker-mod-green+1 :weight bold))))

   ;; Linum
   `(linum ((t `(list :foreground gruber-darker-mod-quartz
                      :background gruber-darker-mod-bg))))

   ;; Magit
   `(magit-branch ((t (:foreground ,gruber-darker-mod-niagara))))
   `(magit-diff-hunk-header ((t (:background ,gruber-darker-mod-bg+2))))
   `(magit-diff-file-header ((t (:background ,gruber-darker-mod-bg+4))))
   `(magit-log-sha1 ((t (:foreground ,gruber-darker-mod-red+1))))
   `(magit-log-author ((t (:foreground ,gruber-darker-mod-brown))))
   `(magit-log-head-label-remote ((t ,(list :foreground gruber-darker-mod-green
                                            :background gruber-darker-mod-bg+1))))
   `(magit-log-head-label-local ((t ,(list :foreground gruber-darker-mod-niagara
                                           :background gruber-darker-mod-bg+1))))
   `(magit-log-head-label-tags ((t ,(list :foreground gruber-darker-mod-green+1
                                          :background gruber-darker-mod-bg+1))))
   `(magit-log-head-label-head ((t ,(list :foreground gruber-darker-mod-fg
                                          :background gruber-darker-mod-bg+1))))
   `(magit-item-highlight ((t (:background ,gruber-darker-mod-bg+1))))
   `(magit-tag ((t ,(list :foreground gruber-darker-mod-green+1
                          :background gruber-darker-mod-bg))))
   `(magit-blame-heading ((t ,(list :background gruber-darker-mod-bg+1
                                    :foreground gruber-darker-mod-fg))))

   ;; Message
   `(message-header-name ((t (:foreground ,gruber-darker-mod-green))))

   ;; Mode Line
   `(mode-line ((t ,(list :background gruber-darker-mod-bg+1
                          :foreground gruber-darker-mod-white))))
   `(mode-line-buffer-id ((t ,(list :background gruber-darker-mod-bg+1
                                    :foreground gruber-darker-mod-white))))
   `(mode-line-inactive ((t ,(list :background gruber-darker-mod-bg+1
                                   :foreground gruber-darker-mod-quartz))))

   ;; Neo Dir
   `(neo-dir-link-face ((t (:foreground ,gruber-darker-mod-niagara))))

   ;; Org Mode
   `(org-agenda-structure ((t (:foreground ,gruber-darker-mod-niagara))))
   `(org-column ((t (:background ,gruber-darker-mod-bg-1))))
   `(org-column-title ((t (:background ,gruber-darker-mod-bg-1 :underline t :weight bold))))
   `(org-done ((t (:foreground ,gruber-darker-mod-green))))
   `(org-todo ((t (:foreground ,gruber-darker-mod-red-1))))
   `(org-upcoming-deadline ((t (:foreground ,gruber-darker-mod-green+1))))

   `(org-level-1 ((t (:foreground ,gruber-darker-mod-niagara :weight bold))))
   `(org-level-2 ((t (:inherit org-level-1))))
   `(org-level-3 ((t (:inherit org-level-1))))
   `(org-level-4 ((t (:inherit org-level-1))))
   `(org-level-5 ((t (:inherit org-level-1))))
   `(org-level-6 ((t (:inherit org-level-1))))
   `(org-level-7 ((t (:inherit org-level-1))))
   `(org-level-8 ((t (:inherit org-level-1))))

   `(org-meta-line ((t (:foreground ,gruber-darker-mod-green))))
   `(org-document-info-keyword ((t (:foreground ,gruber-darker-mod-green))))
   `(org-document-title ((t (:foreground ,gruber-darker-mod-green))))

   `(org-special-keyword ((t (:foreground ,gruber-darker-mod-green+1))))
   `(org-property-value ((t (:foreground ,gruber-darker-mod-green+1))))
   `(org-tag ((t (:foreground ,gruber-darker-mod-green+1))))

   ;; Search
   `(isearch ((t ,(list :foreground gruber-darker-mod-black
                        :background gruber-darker-mod-fg+2))))
   `(isearch-fail ((t ,(list :foreground gruber-darker-mod-black
                             :background gruber-darker-mod-red))))
   `(isearch-lazy-highlight-face ((t ,(list
                                       :foreground gruber-darker-mod-fg+1
                                       :background gruber-darker-mod-niagara-1))))

   ;; Sh
   `(sh-quoted-exec ((t (:foreground ,gruber-darker-mod-red+1))))

   ;; Show Paren
   `(show-paren-match-face ((t (:background ,gruber-darker-mod-bg+4))))
   `(show-paren-mismatch-face ((t (:background ,gruber-darker-mod-red-1))))

   ;; Slime
   `(slime-repl-inputed-output-face ((t (:foreground ,gruber-darker-mod-red))))

   ;; Tuareg
   `(tuareg-font-lock-governing-face ((t (:foreground ,gruber-darker-mod-green+1))))

   ;; Speedbar
   `(speedbar-directory-face ((t ,(list :foreground gruber-darker-mod-niagara
                                        :weight 'bold))))
   `(speedbar-file-face ((t (:foreground ,gruber-darker-mod-fg))))
   `(speedbar-highlight-face ((t (:background ,gruber-darker-mod-bg+1))))
   `(speedbar-selected-face ((t (:foreground ,gruber-darker-mod-red))))
   `(speedbar-tag-face ((t (:foreground ,gruber-darker-mod-green+1))))

   ;; Which Function
   `(which-func ((t (:foreground ,gruber-darker-mod-wisteria))))

   ;; Whitespace
   `(whitespace-space ((t ,(list :background gruber-darker-mod-bg
                                 :foreground gruber-darker-mod-bg+1))))
   `(whitespace-tab ((t ,(list :background gruber-darker-mod-bg
                               :foreground gruber-darker-mod-bg+1))))
   `(whitespace-hspace ((t ,(list :background gruber-darker-mod-bg
                                  :foreground gruber-darker-mod-bg+2))))
   `(whitespace-line ((t ,(list :background gruber-darker-mod-bg+2
                                :foreground gruber-darker-mod-red+1))))
   `(whitespace-newline ((t ,(list :background gruber-darker-mod-bg
                                   :foreground gruber-darker-mod-bg+2))))
   `(whitespace-trailing ((t ,(list :background gruber-darker-mod-red
                                    :foreground gruber-darker-mod-red))))
   `(whitespace-empty ((t ,(list :background gruber-darker-mod-green+1
                                 :foreground gruber-darker-mod-green+1))))
   `(whitespace-indentation ((t ,(list :background gruber-darker-mod-green+1
                                       :foreground gruber-darker-mod-red))))
   `(whitespace-space-after-tab ((t ,(list :background gruber-darker-mod-green+1
                                           :foreground gruber-darker-mod-green+1))))
   `(whitespace-space-before-tab ((t ,(list :background gruber-darker-mod-brown
                                            :foreground gruber-darker-mod-brown))))

   ;; tab-bar
   `(tab-bar ((t (:background ,gruber-darker-mod-bg+1 :foreground ,gruber-darker-mod-bg+4))))
   `(tab-bar-tab ((t (:background nil :foreground ,gruber-darker-mod-green+1 :weight bold))))
   `(tab-bar-tab-inactive ((t (:background nil))))

   ;; vterm / ansi-term
   `(term-color-black ((t (:foreground ,gruber-darker-mod-bg+3 :background ,gruber-darker-mod-bg+4))))
   `(term-color-red ((t (:foreground ,gruber-darker-mod-red-1 :background ,gruber-darker-mod-red-1))))
   `(term-color-green ((t (:foreground ,gruber-darker-mod-green :background ,gruber-darker-mod-green))))
   `(term-color-blue ((t (:foreground ,gruber-darker-mod-niagara :background ,gruber-darker-mod-niagara))))
   `(term-color-yellow ((t (:foreground ,gruber-darker-mod-green+1 :background ,gruber-darker-mod-green+1))))
   `(term-color-magenta ((t (:foreground ,gruber-darker-mod-wisteria :background ,gruber-darker-mod-wisteria))))
   `(term-color-cyan ((t (:foreground ,gruber-darker-mod-quartz :background ,gruber-darker-mod-quartz))))
   `(term-color-white ((t (:foreground ,gruber-darker-mod-fg :background ,gruber-darker-mod-white))))

   ;; company-mode
   `(company-tooltip ((t (:foreground ,gruber-darker-mod-fg :background ,gruber-darker-mod-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,gruber-darker-mod-brown :background ,gruber-darker-mod-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,gruber-darker-mod-brown :background ,gruber-darker-mod-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,gruber-darker-mod-fg :background ,gruber-darker-mod-bg-1))))
   `(company-tooltip-mouse ((t (:background ,gruber-darker-mod-bg-1))))
   `(company-tooltip-common ((t (:foreground ,gruber-darker-mod-green))))
   `(company-tooltip-common-selection ((t (:foreground ,gruber-darker-mod-green))))
   `(company-scrollbar-fg ((t (:background ,gruber-darker-mod-bg-1))))
   `(company-scrollbar-bg ((t (:background ,gruber-darker-mod-bg+2))))
   `(company-preview ((t (:background ,gruber-darker-mod-green))))
   `(company-preview-common ((t (:foreground ,gruber-darker-mod-green :background ,gruber-darker-mod-bg-1))))

   ;; Proof General
   `(proof-locked-face ((t (:background ,gruber-darker-mod-niagara-2))))

   ;; Orderless
   `(orderless-match-face-0 ((t (:foreground ,gruber-darker-mod-green+1))))
   `(orderless-match-face-1 ((t (:foreground ,gruber-darker-mod-green))))
   `(orderless-match-face-2 ((t (:foreground ,gruber-darker-mod-brown))))
   `(orderless-match-face-3 ((t (:foreground ,gruber-darker-mod-quartz))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'gruber-darker-mod)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:

;;; gruber-darker-mod-theme.el ends here.
