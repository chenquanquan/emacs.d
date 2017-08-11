;;; package --- Summary
;;; Commentary:
;;; Code:

;; my-flycheck-add-include-path
;;
;; path load method is reference from (find-file)
(defun ch-flycheck-add-include-path (filename &optional wildcard)
  "Add header file path to flyckeck, (FILENAME WILDCARD)."
  (interactive
   (find-file-read-args "Input path:"
			()))
  (setq flycheck-clang-include-path (cons filename flycheck-clang-include-path))
  (message "add %s in %s" filename flycheck-clang-include-path)
  )

(provide 'code-helper)
;;; code-helper ends here
