;; Ahmet Cetinkaya, 2023

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
         (piped-comand-p (string-equal "|" (substring command 0 1)))
         (normal-state-p (evil-normal-state-p)))
    (evil-open-below 1)
    (insert "  ")
    (let ((command-result
           (string-trim
            (if piped-comand-p
                (shell-command-to-string
                 (concat "echo '" current-line-or-region "'" command))
              (shell-command-to-string
               (concat command " '" current-line-or-region "'"))))))
      (insert command-result))
    (if normal-state-p (evil-normal-state))))

(define-minor-mode line-passer-mode
  "Pass lines as arguments to a command written on the first line."
  :lighter " lp"
  :keymap (let ((map (make-sparse-keymap))) (define-key map (kbd "C-x j") 'pass-line) map))

(provide 'line-passer-mode)
