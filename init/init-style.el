;;; package --- Summary
;;; Code:
;;; Commentary:

;;
;; For C source
;;
(add-hook 'c-mode-hook '(lambda () (c-set-style "linux")))
(add-hook 'c++-mode-hook '(lambda () (c-set-style "cc-mode")))
(add-hook 'c-mode-hook '(lambda () (electric-pair-mode t)))
(add-hook 'c++-mode-hook '(lambda () (electric-pair-mode t)))

;; Remove trailing whitespace between start and end
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'init-style)
;;; init-style.el ends here
