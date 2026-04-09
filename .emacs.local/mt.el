;; -*- lexical-binding: t; -*-

(require 'cl-lib)

(defun mt-get-region-and-prefix ()
    (list
     (when (use-region-p) (region-beginning)) ;; otherwise nil
     (when (use-region-p) (region-end))
     (prefix-numeric-value current-prefix-arg)))

;;;###autoload
(defun mt--total-lines ()
  "Convenience function to get the total lines in the buffer / or narrowed buffer."
  (line-number-at-pos (point-max)))

;;;###autoload
(defun mt--at-first-line-p ()
  "Predicate, is the point at the first line?"
  (= (line-number-at-pos) 1))

;;;###autoload
(defun mt--at-penultimate-line-p ()
  "Predicate, is the point at the penultimate line?"
  (= (line-number-at-pos) (1- (mt--total-lines))))

;; save-mark-and-excursion in Emacs 25 works like save-excursion did before
(eval-when-compile
  (when (< emacs-major-version 25)
    (defmacro save-mark-and-excursion (&rest body)
      `(save-excursion ,@body))))

;;;###autoload
(defun mt--last-line-is-just-newline ()
  "Predicate, is last line just a newline?"
  (save-mark-and-excursion
   (goto-char (point-max))
   (beginning-of-line)
   (= (point-max) (point))))

;;;###autoload
(defun mt--at-last-line-p ()
  "Predicate, is the point at the last line?"
  (= (line-number-at-pos) (mt--total-lines)))

;;;###autoload
(defun mt-line-up ()
  "Move the current line up."
  (interactive)
    (if (mt--at-last-line-p)
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
(defun mt-line-down ()
  "Move the current line down."
  (interactive)
  (unless (or
           (mt--at-last-line-p)
           (and
            (mt--last-line-is-just-newline)
            (mt--at-penultimate-line-p)))
    (let ((col (current-column)))
      (forward-line 1)
      (transpose-lines 1)
      (forward-line -1)
      (move-to-column col))))

;;;###autoload
(defun mt-region (start end n)
  "Move the current region (START END) up or down by N lines."
  (interactive (mt-get-region-and-prefix))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

;;;###autoload
(defun mt-region-up (start end n)
  "Move the current region (START END) up by N lines."
  (interactive (mt-get-region-and-prefix))
  (mt-region start end (- n)))

;;;###autoload
(defun mt-region-down (start end n)
  "Move the current region (START END) down by N lines."
  (interactive (mt-get-region-and-prefix))
  (mt-region start end n))

;;;###autoload
(defun mt-up (start end n)
  "Move the line or region (START END) up by N lines."
  (interactive (mt-get-region-and-prefix))
  (if (not (mt--at-first-line-p))
    (if (region-active-p)
        (mt-region-up start end n)
      (cl-loop repeat n do (mt-line-up)))))

;;;###autoload
(defun mt-down (start end n)
  "Move the line or region (START END) down by N lines."
  (interactive (mt-get-region-and-prefix))
  (if (region-active-p)
      (mt-region-down start end n)
    (cl-loop repeat n do (mt-line-down))))

(provide 'mt)
