; show line number the cursor is on, in status bar (the mode line)
(line-number-mode 1)

; Mettre un titre aux fenêtres
;(setq frame-title-format '(buffer-file-name "%b (%f)" ))

(add-to-list 'default-frame-alist '(width . 120))
(add-to-list 'default-frame-alist '(height . 180))

;set font size
(set-face-attribute 'default nil :height 105)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

; display line numbers in margin (fringe). Emacs 23 only.
(global-linum-mode 1) ; always show line numbers

(setq inhibit-startup-message   t)   ; Don't want any startup message

;(load-library "iso-transl")

;(add-to-list
;    'default-frame-alist
;    '(font . "-*-Monospace-r-*-*-11-*-*-*-c-*-iso8859-1" )
;    ) 

;tabs
;(require 'tabbar)
;(tabbar-mode)

;AUTOSAVE dans un répertoire commun
(setq backup-directory-alist
	  `((".*" . ,"~/.emacs.d/auto-save-tmp")))
    (setq auto-save-file-name-transforms
		  `((".*" ,"~/.emacs.d/auto-save-tmp" t)))

;(global-set-key [S-Tab] 'backtab)

;(setq-default indent-tabs-mode nil)

; enable copy/paste between X
(setq x-select-enable-clipboard t)

; ==================== Indentation =======================
(setq tab-width 4
      c-default-style "k&r"
      c-block-comment-prefix ""
      c-basic-offset 4)
(setq truncate-lines t)
(set-language-environment "UTF-8")

(setq rest-basic-offset 4)

;(setq default-indent-tabs-mode nil)
;(setq default-tab-width 4)
;(setq tab-width 4)

;(setq truncate-lines t)
;(set-language-environment "UTF-8")

; ======================= Item displayed  ========================
;(menu-bar-mode -1)
;(tool-bar-mode -1)
(scroll-bar-mode -1)

(column-number-mode t)

(setq truncate-partial-width-windows nil)
(setq ring-bell-function 'ignore)

;(display-time-mode t)

;(define-key map (kbd "<backtab>") 'notmuch-show-previous-button)

; ====================== Snippet plugin ==========================
(add-to-list 'load-path "~/.emacs.d/plugins")
(require 'yasnippet-bundle)
;(eval-buffer)

; ===================== Folding ==================================
(require 'hideshow)
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
;(load-file "/home/xyz/.emacs.d/plugins/hideshowvis.el")
;(require 'hideshowvis)

;========================= QML ==================================
;(load-file "~/.emacs.d/plugins/qml-mode.el")
;(require 'qml-mode)
;(setq auto-mode-alist (cons '("\\.qml$" . qml-mode) auto-mode-alist))

; ====================== Themes ==================================
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(load-theme 'zenburn t)
;(load-theme 'tango-2 t)

;theme from: https://github.com/juba/color-theme-tangotango
;(load-theme 'tangotango t)

;(server-start)

; ======================== Cscope ================================
;(setq cscope-do-not-update-database t)
;(load-file "~/.emacs.d/plugins/xcscope.el")
;(require 'xcscope)

;(setq cscope-database-regexps
;      '(
;        ( ".*"
;          ( t )
;          ("/home/xyz/dev/qemu/arm-oe/linux-2.6.38.8")
;        )
;       )
;      )

;(setq cscope-database-regexps
;      '(
;          ("~/dev/qemu/arm-oe/linux-2.6.38.8")
;       )
;      )

;================== Auto Complete ======================
(add-to-list 'load-path "~/.emacs.d")    ; This may not be appeared if you have already added.
(load-file "~/.emacs.d/auto-complete.el")
(load-file "~/.emacs.d/auto-complete-config.el")
(load-file "~/.emacs.d/fuzzy.el")
(load-file "~/.emacs.d/popup.el")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)

; ===================== auto-complete-clang ==========================
(load-file "~/.emacs.d/plugins/auto-complete-clang.el")
(require 'auto-complete-clang)
 
(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(ac-set-trigger-key "TAB")
;(define-key ac-mode-map  [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (setq ac-clang-flags (split-string "-I/usr/include/c++/4.5 -I/usr/include -I/usr/local/include"))
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)

; =================== Bind =======================================
(global-set-key [kp-home]  'beginning-of-buffer) ; [Home]
(global-set-key [home]     'beginning-of-buffer) ; [Home]
(global-set-key [kp-end]   'end-of-buffer)       ; [End]
(global-set-key [end]      'end-of-buffer)       ; [End]
(global-set-key [kp-prior] 'scroll-down)      ; [PgUp]
(global-set-key [prior]    'scroll-down)      ; [PgUp]
(global-set-key [kp-next]  'scroll-up)        ; [PgDn]
(global-set-key [next]     'scroll-up)        ; [PgDn] 

(global-set-key "\C-l" 'goto-line) ; [Ctrl]-[L] 

(global-set-key [f1] 'other-window)
(global-set-key [f3] 'split-window-horizontally)
(global-set-key [f2] 'split-window-vertically)
;(global-set-key [f4] 'delete-window)
; delete-window : C-x 0

; Buffer Switcher
;(global-set-key [f4] 'bubble-buffer)
(global-set-key [M-delete] 'geosoft-kill-buffer) ; Alt-Suppr
;(global-set-key [C-kp-delete] 'geosoft-kill-buffer)

;; C-w : cut/delete selection
;; C-y : paste last cut
;; M-y : paste history
;; M-w : copy selection

;(global-set-key [f5] 'kill-region)         ; Cut
;(global-set-key [f6] 'copy-region-as-kill) ; Copy
;(global-set-key [f6] 'clipboard-kill-ring-save)
;(global-set-key [f7] 'yank)                ; Paste

;(global-set-key (kbd "s-x") 'kill-region)         ; Cut
;(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
;(global-set-key (kbd "s-v") 'yank)                ; Paste

;Buffer Navigator
;(global-set-key [C-right] 'geosoft-forward-word) 
;(global-set-key [C-left] 'geosoft-backward-word)

;Folding
;(hs-minor-mode)
(global-set-key [f9] 'hs-show-block)
(global-set-key [f10] 'hs-hide-block)
(global-set-key [f11] 'hs-show-all)
(global-set-key [f12] 'hs-hide-all)

(global-set-key [M-up] 'buffer-menu)
;; C-x C-b : switch to buffer name

;; C-x s : save the current file
;; C-x S : save all files in buffer
;; M-x rename-buffer <RET> name <RET>

;; C-x f : open a file

;; M-x gdb : open gdb
;; M-x term (or shell) : open en terminal

;;Undo 	C-_    
;;Redo 	(C-)Space C-_

;; C-x h : Select all

;;Search forward 	        C-s 	
;;Repeat last search forward 	C-s C-s 	
;;Search backward 	        C-r 	
;;Repeat last search backward 	C-r C-r

;;help on shortcut : C-h k <shortcut>

;; C-k : delete a line from the cursor to \n
(global-set-key "\C-x\C-k" 'kill-whole-line)
;; M-d : delete a word
