;;; package --- Summary
;;; Commentary:
;;; Code:

;; vcmd-open-new-line
(defun vcmd-open-new-line ( )
  "Add new line after current line, like o in vim."
  (interactive)
  (move-end-of-line nil)
  (newline))

;; vcmd-open-new-before-line
(defun vcmd-open-new-before-line ( )
  "Add new line before curren line, like O in vim."
  (interactive)
  (previous-line)
  (my-open-new-line))

;; vcmd-delete-indentation
(defun vcmd-delete-indentation ( )
  "Merge next line with current line, like J in vim."
  (interactive)
  (push-mark)
  (next-line)
  (delete-indentation)
  (pop-mark))

(provide 'vcmd)
;;; vcmd.el ends here
