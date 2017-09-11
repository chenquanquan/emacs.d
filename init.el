;;; package --- Summary
;;; Commentary:
;;; Code:

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
     ("lwn" "https://lwn.net/headlines/rss" nil nil nil))))
 '(newsticker-url-list-defaults nil)
 '(package-selected-packages
   (quote
    (pyim-greatdict pyim fcitx exec-path-from-shell company eshell-prompt-extras color-theme-solarized color-theme weibo highlight-parentheses company-irony-c-headers company-irony flycheck-irony avy-flycheck flycheck anzu solarized-theme highlight-symbol neotree highlight-escape-sequences column-enforce-mode ace-jump-mode jumplist dsvn esh-help bash-completion irony-eldoc irony find-file-in-repository ac-etags sr-speedbar switch-window qt-pro-mode auto-compile magit ac-clang w3m undo-tree youdao-dictionary sdcv google-translate smex molokai-theme xcscope)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-install-package
;; install my package
;;
(defun my-install-package ( )
  "Install all package of my plugin."
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
  (package-install 'flycheck)
  (package-install 'flycheck-irony)
  (package-install 'avy-flycheck)
  (package-install 'highlight-parentheses)
  (package-install 'find-file-in-repository)
  (package-install 'pyim)
  (package-install 'pyim-greatdict)
  )

;; my-toggle-current-window-dedication
(defun my-toggle-current-window-dedication ()
  "Set the current window to dedication window, can't be replaced by 'display buffer' Reference from https://stackoverflow.com/questions/4244637/dedicated-window-for-dired-mode-in-emacs."
 (interactive)
 (let* ((window    (selected-window))
        (dedicated (window-dedicated-p window)))
   (set-window-dedicated-p window (not dedicated))
   (message "Window %sdedicated to %s"
            (if dedicated "no longer " "")
            (buffer-name))))

;; my-reload-config
;; reload .emacs
(defun my-reload-config ()
  "Reload ~/.emacs file."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; my-open-config
;; open .emacs
(defun my-open-config ()
  "Open ~/.emacs file."
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
(defun wy-go-back-to-char (n char)
  "Refrence wy-go-to-char, (N CHAR)."
  (interactive "p\ncGo back to char: ")
  (search-backward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-backward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c A") 'wy-go-back-to-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "local-lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))
;;
;; vcmd
;; command like vim
(require 'vcmd)
(define-key global-map (kbd "C-o") 'vcmd-open-new-line)
(define-key global-map (kbd "C-S-o") 'vcmd-open-new-before-line)
(define-key global-map (kbd "C-j") 'vcmd-delete-indentation)

;;
;; code-helper
;;
(require 'code-helper)

;;
;; init script
;;
(require 'init-ac)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; font config for org table showing.
;; reference from http://www.cnblogs.com/aqing1987/p/4187101.html
(set-default-font "monospace-11")
(dolist (charset '(kana han symbol cjk-misc bopomofo))
   (set-fontset-font (frame-parameter nil 'font)
                     charset
                     (font-spec :family "WenQuanYi Micro Hei")))
;; tune rescale so that Chinese character width = 2 * English character width
(setq face-font-rescale-alist '(("monospace" . 1.0) ("WenQuanYi" . 1.23)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom package configure
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
;;(require 'zone)
;;(zone-when-idle (* 30 60))

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
;; flycheck
;;
(add-hook 'after-init-hook #'global-flycheck-mode)

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

;;
;; Pyim
;;
(require 'pyim)
(require 'pyim-basedict)
(pyim-basedict-enable)
(setq default-input-method "pyim")

(setq pyim-default-scheme 'quanpin)

(setq-default pyim-punctuation-half-width-functions
	      '(pyim-probe-punctuation-line-beginning
		pyim-probe-punctuation-after-punctuation))

;; 开启拼音搜索功能
(setq pyim-isearch-enable-pinyin-search t)

;; 选词框显示5个候选词
(setq pyim-page-length 5)

(setq default-input-method "pyim")
(global-set-key (kbd "C-\\") 'toggle-input-method)

;;
;; pyim-greatdict
;;
;;(require 'pyim-greatdict)
;;(pyim-greatdict-enable)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; command
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-s . / C-s C-w: like * in vim
;; C-x r d/c/t: like select in vim
;; revert-buffer-with-coding-system: change buffer encode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; init.el ends here
