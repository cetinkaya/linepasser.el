;; Ahmet Cetinkaya, 2023

(defun escape-letters (str escape-list)
  (with-output-to-string
    (dolist (c (string-to-list str))
      (if (member (string c) escape-list)
          (princ (concat "\\" (string c)))
        (princ (string c))))))

(defun get-command ()
  (save-restriction
    (widen)
    (save-excursion
      (goto-line 0)
      (string-trim (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))))))

(defun pass-line ()
  (interactive)
  (let* ((command (get-command))
         (current-line-or-region
          (if (region-active-p)
              (buffer-substring-no-properties
               (region-beginning) (region-end))
            (buffer-substring-no-properties
             (line-beginning-position)
             (line-end-position))))
         (escaped-current-line-or-region
          (escape-letters current-line-or-region '("'")))
         (piped-comand-p (string-equal "|" (substring command 0 1)))
         (normal-state-p (evil-normal-state-p)))
    (evil-open-below 1)
    (insert "  ")
    (let ((command-result
           (string-trim
            (if piped-comand-p
                (shell-command-to-string
                 (concat "echo '" escaped-current-line-or-region "'" command))
              (shell-command-to-string
               (concat command " '" escaped-current-line-or-region "'"))))))
      (insert command-result))
    (if normal-state-p (evil-normal-state))))

(define-minor-mode line-passer-mode
  "Pass lines as arguments to a command written on the first line."
  :lighter " lp"
  :keymap (let ((map (make-sparse-keymap))) (define-key map (kbd "C-x j") 'pass-line) map)

  (setq keywords '(("^  [^\n]+$" . font-lock-doc-face)))
  (font-lock-add-keywords nil keywords)
  (if (fboundp 'font-lock-flush)
      (font-lock-flush)
    (when font-lock-mode (with-no-warnings (font-lock-fontify-buffer)))))

(provide 'line-passer-mode)
