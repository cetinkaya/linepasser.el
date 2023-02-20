;; Ahmet Cetinkaya, 2023

(defun get-command ()
  (save-restriction
    (widen)
    (save-excursion
      (goto-line 0)
      (buffer-substring-no-properties (line-beginning-position) (line-end-position)))))

(defun pass-line ()
  (interactive)
  (let ((current-line (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        (normal-state-p (evil-normal-state-p)))
    (evil-open-below 1)
    (insert "  ")
    (insert (string-trim (shell-command-to-string (concat (get-command) " '" current-line "'"))))
    (if normal-state-p (evil-normal-state))))

(define-minor-mode line-passer-mode
  "Pass lines as arguments to a command written on the first line."
  :lighter " lp"
  :keymap (let ((map (make-sparse-keymap))) (define-key map (kbd "C-x j") 'pass-line) map))

(provide 'line-passer-mode)
