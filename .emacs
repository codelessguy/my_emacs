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

; refresh buffer automatically when using git for example
(global-auto-revert-mode t)

; disable copy when highlight something
(setq mouse-drag-copy-region nil)

; ==================== Indentation =======================
;(setq rest-basic-offset 4)

(setq c-default-style "linux" c-basic-offset 4)

;(setq default-indent-tabs-mode t)
(setq default-tab-width 4)
(setq indent-line-function 'insert-tab)

;(setq truncate-lines t)
;(set-language-environment "UTF-8")

;; load smart tabs
;(load "~/.emacs.d/smart-tabs-mode")

;; use smart tabs for all the predefined languages
;(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'ruby 'nxml)

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
(load-file "~/.emacs.d/plugins/qml-mode.el")
(require 'qml-mode)
(setq auto-mode-alist (cons '("\\.qml$" . qml-mode) auto-mode-alist))

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

; ===================== File Finder =======================
(defun geosoft-parse-minibuffer ()
  ;; Extension to the complete word facility of the minibuffer
  (interactive)
  (backward-char 4)
  (setq found t)
  (cond
     ; local directories
     ((looking-at ".c") (setq directory "~"))
     ((looking-at ".rst") (setq directory "~"))
     (t (setq found nil)))
  (cond (found (beginning-of-line)
                (kill-line)
                (insert directory))
         (t     (forward-char 4)
                (minibuffer-complete)))) 

(define-key minibuffer-local-completion-map " " 'geosoft-parse-minibuffer) 

; ====================== Buffer Switcher ==========================
(defvar LIMIT 1)
(defvar time 0)
(defvar mylist nil)

(defun time-now ()
   (car (cdr (current-time))))

(defun bubble-buffer ()
   (interactive)
   (if (or (> (- (time-now) time) LIMIT) (null mylist))
       (progn (setq mylist (copy-alist (buffer-list)))
          (delq (get-buffer " *Minibuf-0*") mylist)
          (delq (get-buffer " *Minibuf-1*") mylist)))
   (bury-buffer (car mylist))
   (setq mylist (cdr mylist))
   (setq newtop (car mylist))
   (switch-to-buffer (car mylist))
   (setq rest (cdr (copy-alist mylist)))
   (while rest
     (bury-buffer (car rest))
     (setq rest (cdr rest)))
   (setq time (time-now))) 

(defun geosoft-kill-buffer ()
   ;; Kill default buffer without the extra emacs questions
   (interactive)
   (kill-buffer (buffer-name))
   (set-name)) 

; ===================== Buffer Navigator ===================
(defun geosoft-forward-word ()
   ;; Move one word forward. Leave the pointer at start of word
   ;; instead of emacs default end of word. Treat _ as part of word
   (interactive)
   (forward-char 1)
   (backward-word 1)
   (forward-word 2)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
         (t (forward-char 1))))

(defun geosoft-backward-word ()
   ;; Move one word backward. Leave the pointer at start of word
   ;; Treat _ as part of word
   (interactive)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (geosoft-backward-word))
         (t (forward-char 1)))) 

;================== Auto Complete ======================
(add-to-list 'load-path "~/.emacs.d")    ; This may not be appeared if you have already added.
(load-file "~/.emacs.d/auto-complete.el")
(load-file "~/.emacs.d/auto-complete-config.el")
(load-file "~/.emacs.d/fuzzy.el")
(load-file "~/.emacs.d/popup.el")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)

; ===================== blank-mode ==========================
; see http://www.emacswiki.org/BlankMode
(require 'blank-mode)

; ===================== auto-complete-clang ==========================
; install: sudo apt-get install clang
(load-file "~/.emacs.d/plugins/auto-complete-clang.el")
(require 'auto-complete-clang)
 
(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(ac-set-trigger-key "TAB")
;(define-key ac-mode-map  [(control tab)] 'auto-complete)
(global-set-key (kbd "C-`") 'ac-complete-clang)
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

; =======================================================
(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))
(global-set-key (kbd "<f7>") 'switch-to-minibuffer-window)

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

(global-set-key [f4] 'blank-mode)

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
(global-set-key [M-kp-subtract] 'kill-whole-line)
;; M-d : delete a word

;; Reload current buffer
;; C-x C-v

;; reload emacs config
;; M-x eval-buffer

;; *** CTAGS ***
;; search for files (generate TAGS file): find . -type f -iname "*.[chS]" | xargs etags -a
;; M-. <RET> : Jump to the tag underneath the cursor
;; M-. <tag> <RET> : Search for a particular tag
;; C-u M-. : Find the next definition for the last tag
;; M-* : Pop back to where you previously invoked "M-."
