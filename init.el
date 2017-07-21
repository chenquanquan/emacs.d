;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-etags-requires 1)
 '(inhibit-startup-screen t)
 '(newsticker-url-list
   (quote
    (("debian.org" "https://www.debian.org/News/news" nil nil nil)
     ("kernel.org" "https://www.kernel.org/feeds/all.atom.xml" nil nil nil)
     ("solidot" "http://www.solidot.org/index.rss" nil nil nil)
     ("IThome" "https://www.ithome.com/rss/" nil nil nil)
     ("debiancn" "https://forums.debiancn.org/c/5-category.rss" nil nil nil)
     ("oschina-xb-blog" "https://my.oschina.net/xxiaobian/rss" nil nil nil)
     ("lwn" "https://lwn.net/headlines/rss" nil nil nil)
     )))
 '(newsticker-url-list-defaults nil)
 '(package-selected-packages
   (quote
    (weibo highlight-parentheses company-irony-c-headers company-irony flycheck-irony avy-flycheck flycheck anzu solarized-theme highlight-symbol neotree highlight-escape-sequences column-enforce-mode ace-jump-mode jumplist dsvn esh-help bash-completion irony-eldoc irony find-file-in-repository ac-etags sr-speedbar switch-window qt-pro-mode auto-compile magit ac-clang w3m undo-tree youdao-dictionary sdcv google-translate smex molokai-theme xcscope))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; From http://ergoemacs.org/emacs/emacs_package_system.html
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-install-package
;; install my package
;;
(defun my-install-package ( )
    "install all package of my plugin"
  (interactive)
  (package-install 'color-theme)
  (package-install 'color-theme-solarized)
  (package-install 'smex)
  (package-install 'xcscope)
  ;;(package-install 'winner-mode)
  (package-install 'magit)
  (package-install 'google-translate)
  (package-install 'youdao-dictionary)
  (package-install 'undo-tree)
  (package-install 'switch-window)
  (package-install 'sr-speedbar)
  (package-install 'esh-help)
  (package-install 'eshell-prompt-extras)
  ;;(package-install 'vs-svn)
  (package-install 'jumplist)
  (package-install 'ace-jump-mode)
  (package-install 'column-enforce-mode)
  (package-install 'highlight-escape-sequences)
  (package-install 'neotree)
  (package-install 'anzu)
  (package-install 'irony)
  (package-install 'company)
  (package-install 'company-irony)
  (package-install 'company-irony-c-headers)
  (package-install 'flycheck)
  (package-install 'flycheck-irony)
  (package-install 'avy-flycheck)
  (package-install 'highlight-parentheses)
  )

;; my-reload-config
;; reload .emacs
(defun my-reload-config ()
  "Reload ~/.emacs file"
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; my-open-config
;; open .emacs
(defun my-open-config ()
  "Open ~/.emacs file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; wy-go-to-char
;; Like vim "fx" command
;; Reference frome https://my.oschina.net/alphajay/blog/152599
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c a") 'wy-go-to-char)

;; wy-go-back-to-char
;; Reference wy-go-to-char
;;
(defun wy-go-back-to-char (n char)
  (interactive "p\ncGo back to char: ")
  (search-backward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-backward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c A") 'wy-go-back-to-char)

;; my-flycheck-add-include-path
;;
;; path load method is reference from (find-file)
(defun my-flycheck-add-include-path (filename &optional wildcard)
  "Add header file path to flyckeck"
  (interactive
   (find-file-read-args "Input path:"
			()))
  (setq flycheck-clang-include-path (cons filename flycheck-clang-include-path))
  (message "add %s in %s" filename flycheck-clang-include-path)
  )

;; my-open-new-line
;; new function like "o" in vim
;;
(defun my-open-new-line ( )
  "Add new line after current line, like o in vim"
  (interactive)
  (move-end-of-line nil)
  (newline))
(define-key global-map (kbd "C-o") 'my-open-new-line)

;; my-open-new-before-line
;; new function like "O" in vim
;;
(defun my-open-new-before-line ( )
  "Add new line before curren line, like O in vim"
  (interactive)
  (previous-line)
  (my-open-new-line))
(define-key global-map (kbd "C-S-o") 'my-open-new-before-line)

;; my-delete-indentation
;; new function like "J" in vim
;;
(defun my-delete-indentation ( )
  "merge next line with current line, like J in vim"
  (interactive)
  (push-mark)
  (next-line)
  (delete-indentation)
  (pop-mark))
(define-key global-map (kbd "C-j") 'my-delete-indentation)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; window custom
;;
(menu-bar-showhide-tool-bar-menu-customize-disable)
(global-linum-mode t)
(column-number-mode t)
(global-hl-line-mode t)
(ido-mode t)
(show-paren-mode t)
(global-set-key (kbd "C-c C-v C-b") 'pop-to-buffer)
(blink-cursor-mode -1)
(setq confirm-kill-emacs 'y-or-n-p)
(setq scroll-margin 3
      scroll-conservatively 10000)
;;
;; internal plugin
;;
(require 'zone)
(zone-when-idle (* 5 60))

;; newstricker
;;
(add-hook 'newsticker-mode-hook 'imenu-add-menubar-index)

;;
;; theme
;;
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-kingsajz)
(require 'color-theme-solarized)
(color-theme-solarized)

;;
;; For C source
;;
(add-hook 'c-mode-hook '(lambda () (c-set-style "linux")))
(add-hook 'c++-mode-hook '(lambda () (c-set-style "linux")))
(add-hook 'c-mode-hook '(lambda () (electric-pair-mode t)))
(add-hook 'c++-mode-hook '(lambda () (electric-pair-mode t)))

;;
;; winner-mode
;; "C-c left" to restore window layout
(when (fboundp 'winner-mode) 
 (winner-mode) 
 (windmove-default-keybindings))

;;
;; smex
;;
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;
;; xcscope
;;
(require 'xcscope)
(cscope-setup)

;;
;; magit
;;
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;;;;
;;;; auto-complete
;;;;
;;(ac-config-default)
;;;;
;;;; ac-etags
;;;;
;;(eval-after-load "etags"
;;  '(progn
;;      (ac-etags-setup)))
;;
;;(add-hook 'c-mode-common-hook 'ac-etags-ac-setup)
;;(add-hook 'ruby-mode-common-hook 'ac-etags-ac-setup)

;;
;; google-translate
;;
(require 'google-translate)
(require 'google-translate-smooth-ui)
(global-set-key "\C-ct" 'google-translate-smooth-translate)

;;
;; youdao dictionary
;;
(global-set-key (kbd "C-c C-v C-t") 'youdao-dictionary-search-at-point-tooltip)

;;
;; undo tree
;;
(require 'undo-tree)
(global-undo-tree-mode)

;;
;; switch-window
;;
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
(global-set-key (kbd "C-x 0") 'switch-window-then-delete)

;;
;; sr-speedbar
;;
(require 'sr-speedbar)
(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))

;;
;; esh-help
;;
(require 'esh-help)
(setup-esh-help-eldoc)  ;; To use eldoc in Eshell

;;
;; eshell-prompt-extras
;;
(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

;;
;; dsvn
;;
(require 'vc-svn)

;;
;; jumplist
;;
(require 'jumplist)
(global-set-key (kbd "C-<") 'jumplist-previous)
(global-set-key (kbd "C->") 'jumplist-next)

;;
;; ace-jump-mode
;;
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;
;; column-enforce-mode
;;
(global-column-enforce-mode t)

;;
;; highlight-escape-sequences
;;
(hes-mode)

;;
;; neotree
;;
(require 'neotree)
(define-key global-map [(f8)] 'neotree-toggle)

;;
;; anzu
;;
(global-anzu-mode +1)

;;
;; irony
;;
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;
;; company
;;
(add-hook 'after-init-hook 'global-company-mode)

;;
;; company-irony
;;
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;;
;; compay-irony-c-header
;;When compiler options change, call
;;`company-irony-c-headers-reload-compiler-output` manually to
;;reload.
(require 'company-irony-c-headers)
;; Load with `irony-mode` as a grouped backend
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

;;
;; flycheck
;;
(add-hook 'after-init-hook #'global-flycheck-mode)

;;
;; flycheck-irony
;;
;;(eval-after-load 'flycheck
;;  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; avy-flycheck
;;
(require 'avy-flycheck)
(avy-flycheck-setup)
(global-flycheck-mode)
(global-set-key (kbd "C-c '") #'avy-flycheck-goto-error)

;;
;; highlight-parenthess
;;
(require 'highlight-parentheses)
(global-highlight-parentheses-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; command 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-s . / C-s C-w: like * in vim
;; C-x r d/c/t: like select in vim
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

