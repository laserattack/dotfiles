;;; move-text.el --- Move current line or region with M-up or M-down. -*- lexical-binding: t; -*-

;;; Code:
(require 'cl-lib)

(defun move-text-get-region-and-prefix ()
    "Get the region and prefix for the `interactive' macro, without aborting.

Note: `region-beginning' and `region-end' are the reason why an
`interactive' macro with \"r\" will blow up with the error:

\"The mark is not set now, so there is no region\"

We check with `use-region-p' to avoid calling
them when there's no region or it is not appropriate
to act on it.

We use `prefix-numeric-value' to return a number.
"
    (list
     (when (use-region-p) (region-beginning)) ;; otherwise nil
     (when (use-region-p) (region-end))
     (prefix-numeric-value current-prefix-arg)))

;;;###autoload
(defun move-text--total-lines ()
  "Convenience function to get the total lines in the buffer / or narrowed buffer."
  (line-number-at-pos (point-max)))

;;;###autoload
(defun move-text--at-first-line-p ()
  "Predicate, is the point at the first line?"
  (= (line-number-at-pos) 1))

;;;###autoload
(defun move-text--at-penultimate-line-p ()
  "Predicate, is the point at the penultimate line?"
  (= (line-number-at-pos) (1- (move-text--total-lines))))

;; save-mark-and-excursion in Emacs 25 works like save-excursion did before
(eval-when-compile
  (when (< emacs-major-version 25)
    (defmacro save-mark-and-excursion (&rest body)
      `(save-excursion ,@body))))

;;;###autoload
(defun move-text--last-line-is-just-newline ()
  "Predicate, is last line just a newline?"
  (save-mark-and-excursion
   (goto-char (point-max))
   (beginning-of-line)
   (= (point-max) (point))))

;;;###autoload
(defun move-text--at-last-line-p ()
  "Predicate, is the point at the last line?"
  (= (line-number-at-pos) (move-text--total-lines)))

;;;###autoload
(defun move-text-line-up ()
  "Move the current line up."
  (interactive)
    (if (move-text--at-last-line-p)
        (let ((target-point))
          (kill-whole-line)
          (forward-line -1)
          (beginning-of-line)
          (setq target-point (point))
          (yank)
          (unless (looking-at "\n")
            (newline))
          (goto-char target-point))
      (let ((col (current-column)))
        (progn (transpose-lines 1)
               (forward-line -2)
               (move-to-column col)))))

;;;###autoload
(defun move-text-line-down ()
  "Move the current line down."
  (interactive)
  (unless (or
           (move-text--at-last-line-p)
           (and
            (move-text--last-line-is-just-newline)
            (move-text--at-penultimate-line-p)))
    (let ((col (current-column)))
      (forward-line 1)
      (transpose-lines 1)
      (forward-line -1)
      (move-to-column col))))

;;;###autoload
(defun move-text-region (start end n)
  "Move the current region (START END) up or down by N lines."
  (interactive (move-text-get-region-and-prefix))
  (save-excursion
    (goto-char end)
    (unless (bolp)
      (setq end (1+ end))))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

;;;###autoload
(defun move-text-region-up (start end n)
  "Move the current region (START END) up by N lines."
  (interactive (move-text-get-region-and-prefix))
  (move-text-region start end (- n)))

;;;###autoload
(defun move-text-region-down (start end n)
  "Move the current region (START END) down by N lines."
  (interactive (move-text-get-region-and-prefix))
  (move-text-region start end n))

;;;###autoload
(defun move-text-up (start end n)
  "Move the line or region (START END) up by N lines."
  (interactive (move-text-get-region-and-prefix))
  (if (not (move-text--at-first-line-p))
    (if (region-active-p)
        (move-text-region-up start end n)
      (cl-loop repeat n do (move-text-line-up)))))

;;;###autoload
(defun move-text-down (start end n)
  "Move the line or region (START END) down by N lines."
  (interactive (move-text-get-region-and-prefix))
  (if (region-active-p)
      (move-text-region-down start end n)
    (cl-loop repeat n do (move-text-line-down))))

;;;###autoload
(defun move-text-default-bindings ()
  "Bind `move-text-up' and `move-text-down' to M-up & M-down."
  (interactive)
  (global-set-key [M-down] 'move-text-down)
  (global-set-key [M-up]   'move-text-up))

(provide 'move-text)

;;; move-text.el ends here
