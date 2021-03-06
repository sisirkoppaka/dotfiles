(server-start)

;; ----------
;; load-paths
;; ----------
(add-to-list 'load-path "~/.elisp/")
(add-to-list 'load-path "~/.elisp/use-package")
(add-to-list 'load-path "~/.elisp/haskell-mode")
(add-to-list 'load-path "~/.elisp/magit")
(add-to-list 'load-path "~/.elisp/git-modes")
(add-to-list 'load-path "~/.elisp/clojure-mode")
(add-to-list 'load-path "~/.elisp/ace-jump-mode")
(add-to-list 'load-path "~/.elisp/smex")
(add-to-list 'load-path "~/.elisp/scala-mode2")
(add-to-list 'load-path "~/.elisp/rust-mode")
(add-to-list 'load-path "~/.elisp/php-mode")
(add-to-list 'load-path "~/.elisp/llvm-mode")
(add-to-list 'load-path "~/.elisp/epl")
(add-to-list 'load-path "~/.elisp/dash")
(add-to-list 'load-path "~/.elisp/s")
(add-to-list 'load-path "~/.elisp/pkg-info")
(add-to-list 'load-path "~/.elisp/go-mode")
(add-to-list 'load-path "~/.elisp/lua-mode")
(add-to-list 'load-path "~/.elisp/paredit")
(add-to-list 'load-path "~/.elisp/slim-mode")
(add-to-list 'load-path "~/.elisp/yaml-mode")
(add-to-list 'load-path "~/.elisp/feature-mode")
(add-to-list 'load-path "~/.elisp/yasnippet")
(add-to-list 'load-path "~/.elisp/ghc-mod/elisp")

(add-to-list 'custom-theme-load-path "~/.elisp/zenburn-emacs")

;; ---------
;; Autoloads
;; ---------
(require 'use-package)
(use-package whitespace)
(use-package filladapt)
(use-package tramp)

(setq magit-rigid-key-bindings t)
(use-package magit)
(use-package magit-blame)

(use-package git-rebase-mode)
(use-package git-commit-mode)
(use-package gitignore-mode)
(use-package gitconfig-mode)
(use-package paredit)
(use-package clojure-mode)
(use-package windmove)
(use-package framemove)
(use-package winner)
(use-package uniquify)
(use-package cython-mode)
(use-package slim-mode)
(use-package ace-jump-mode)
(use-package smex)
(use-package scala-mode2)
(use-package saveplace)
(use-package php-mode)
(use-package kconfig-mode)
(use-package epl)
(use-package dash)
(use-package s)
(use-package pkg-info)
(use-package lua-mode)
(use-package yaml-mode)
(use-package feature-mode)
(use-package yasnippet)
(use-package semantic/ia)
(use-package semantic/bovine/gcc)
(use-package auto-complete)
(use-package llvm-mode)
(use-package tablegen-mode)
(use-package rust-mode)
(use-package go-mode)
(use-package package)
(use-package helm-config)

;; ----------------
;; auto-mode-alists
;; ----------------
(add-to-list 'auto-mode-alist '("mutt-.*-" . mail-mode))
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("PKGBUILD" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.mak$" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; ----------------------
;; General Customizations
;; ----------------------
(setq-default inhibit-startup-message t
	      font-lock-maximum-decoration t
	      visible-bell t
	      require-final-newline t
	      resize-minibuffer-frame t
	      column-number-mode t
	      display-battery-mode t
	      transient-mark-mode t
	      next-line-add-newlines nil
	      blink-matching-paren t
	      quack-pretty-lambda-p t
	      blink-matching-delay .25
	      vc-follow-symlinks t
	      indent-tabs-mode t
	      tab-width 8
	      c-basic-offset 8
	      edebug-trace t
	      fill-adapt-mode t
	      winner-mode t
	      uniquify-buffer-name-style 'forward
	      save-place t
	      initial-scratch-message ""
	      initial-major-mode 'text-mode)

(global-font-lock-mode 1)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)
(load-theme 'zenburn t)

;; Remove toolbar, menubar, scrollbar and tooltips
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(set-scroll-bar-mode 'nil)

;; Set the default browser to Chrome
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-beta")

;; General mode loading
(show-paren-mode t)
(savehist-mode t)
(electric-indent-mode 1)

;; Unbind C-z. I don't want suspend
(when window-system
  (global-unset-key [(control z)]))

;; y-or-n-p please
(defalias 'yes-or-no-p 'y-or-n-p)

;; only stop-the-world gc every 20M
(setq gc-cons-threshold 20000000)

;; ----------------------
;; Final newline handling
;; ----------------------
(setq require-final-newline t)
(setq next-line-extends-end-of-buffer nil)
(setq next-line-add-newlines nil)

;; -------------------
;; Everything in UTF-8
;; -------------------
(prefer-coding-system                   'utf-8)
(set-language-environment               'utf-8)
(set-default-coding-systems             'utf-8)
(setq file-name-coding-system           'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq coding-system-for-write           'utf-8)
(set-keyboard-coding-system             'utf-8)
(set-terminal-coding-system             'utf-8)
(set-clipboard-coding-system            'utf-8)
(set-selection-coding-system            'utf-8)
(setq default-process-coding-system     '(utf-8 . utf-8))
(add-to-list 'auto-coding-alist         '("." . utf-8))

;; ------------------
;; Custom Keybindings
;; ------------------
(bind-key* "<C-return>" 'other-window)

(global-set-key [(meta \])] 'forward-paragraph)
(global-set-key [(meta \[)] 'backward-paragraph)
(bind-key* "C-c C-r" #'(lambda () (interactive) (revert-buffer nil t)))
(global-set-key [(control shift n)] #'(lambda () (interactive) (ignore-errors (next-line 5))))
(global-set-key [(control shift p)] #'(lambda () (interactive) (ignore-errors (previous-line 5))))
(global-set-key [(meta j)] #'(lambda () (interactive) (join-line -1)))
(global-set-key [(control c) (s)] 'replace-string)
(global-set-key [(control c) (r)] 'replace-regexp)
(global-set-key [(control c) (\;)] 'comment-or-uncomment-region)
(global-set-key [(control c) (x)] 'compile)
(global-set-key [(control c) (m)] 'man)
(global-set-key [(control x) (p)] 'bury-buffer)

;; ------
;; c-mode
;; ------
(add-hook 'c-mode-common-hook 'turn-on-filladapt-mode)
(add-to-list 'completion-ignored-extensions ".o")

(defmacro define-new-c-style (name derived-from style-alist match-path)
  `(progn
     (c-add-style ,name
		  '(,derived-from ,@style-alist))
     (add-hook 'c-mode-hook
	       (lambda ()
		 (let ((filename (buffer-file-name)))
		   (when (and filename
			      (string-match (expand-file-name ,match-path) filename))
		     (c-set-style ,name)))))
     (add-hook 'c++-mode-hook
	       (lambda ()
		 (let ((filename (buffer-file-name)))
		   (when (and filename
			      (string-match (expand-file-name ,match-path) filename))
		     (c-set-style ,name)))))))

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists with tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

;; Syntax for define-new-c-style:
;; <style-name> <derived-from> <style-alist> <match-path>

(define-new-c-style "llvm" "gnu" ((fill-column . 80)
				  (c++-indent-level . 2)
				  (c-offsets-alist . ((innamespace 0))))
  "~/src/llvm")

(define-new-c-style "emacs" "gnu" nil "~/src/emacs")

(define-new-c-style "linux-tabs-only" "linux" ((indent-tabs-mode . t)
					       (c-offsets-alist
						(arglist-cont-nonempty
						 c-lineup-gcc-asm-reg
						 c-lineup-arglist-tabs-only)))
  "~")

(add-hook 'c-mode-hook (lambda ()
			 (define-key c-mode-map
			   [(meta j)] #'(lambda () (interactive) (join-line -1)))))

;; --------
;; semantic
;; --------
(semantic-mode 1)
(global-set-key [(control c) (j)] 'semantic-ia-fast-jump)

;; ---
;; ido
;; ---
(ido-mode 1)
(ido-everywhere 1)
(setq ido-use-faces nil)

(setq
 ido-ignore-buffers '("\\` " "^\*Mess" "^\*Back" "^\*Ido")
 ido-case-fold t
 ido-use-filename-at-point nil
 ido-use-url-at-point nil
 ido-default-file-method 'selected-window
 ido-default-buffer-method 'selected-window
 ido-max-directory-size nil)

;; ----
;; helm
;; ----
(defvar ctl-period-map)
(define-prefix-command 'ctl-period-map)
(bind-key* "C-." 'ctl-period-map)

(bind-key "C-. C-f" 'helm-for-files)
(bind-key "C-. C-g" 'helm-do-grep)
(bind-key "C-. C-o" 'helm-occur)
(bind-key "C-. M-x" 'helm-M-x)

;; -----
;; Dired
;; -----
(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map (kbd "<return>")
	      'dired-find-alternate-file) ; was dired-advertised-find-file
	    (define-key dired-mode-map (kbd "^")
	      (lambda () (interactive) (find-alternate-file "..")))))

(put 'dired-find-alternate-file 'disabled nil)

;; -----
;; magit
;; -----
(setq vc-handled-backends '(Git))
(global-set-key [(control x) (v)] 'magit-status)
(setq magit-commit-all-when-nothing-staged t
      magit-revert-item-confirm t
      magit-process-connection-type nil
      process-connection-type nil)

(add-hook 'magit-log-edit-mode-hook 'flyspell-mode)

(global-set-key [(control x) (h)] #'(lambda () (interactive)
				  (magit-show-commit
				   (magit-rev-parse "HEAD") nil t)))

(set-variable 'magit-emacsclient-executable "~/bin/emacsclient")

;; git-modes
(setq git-commit-confirm-commit nil)

;; -------------
;; flyspell-mode
;; -------------
(setq ispell-list-command "--list") ;; run flyspell with aspell, not ispell
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(global-set-key [(control c) (f)] 'flyspell-check-previous-highlighted-word)

;; ---------
;; text-mode
;; ---------
(add-hook 'text-mode-hook 'turn-on-filladapt-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

;; ---------------
;; emacs-lisp-mode
;; ---------------
(add-hook 'emacs-lisp-mode-hook (lambda () (eldoc-mode t)))

;; ------------
;; haskell-mode
;; ------------
(use-package haskell-mode-autoloads
  :init
  (use-package ghc)
  (add-to-list 'Info-default-directory-list "~/.elisp/haskell-mode")
  (setq haskell-doc-show-global-types t)
  (add-hook 'haskell-mode-hook (lambda ()
				 (turn-on-haskell-indentation)
				 (haskell-doc-mode)
				 (ghc-init)))
  (add-to-list 'completion-ignored-extensions ".hi"))

;; ---------
;; perl-mode
;; ---------
(defalias 'perl-mode 'cperl-mode)

(defmacro define-new-pl-style (offset match-path)
  `(add-hook 'cperl-mode-hook
	     (lambda ()
	       (let ((filename (buffer-file-name)))
		 (when (and filename
			    (string-match (expand-file-name ,match-path) filename))
		   (setq cperl-indent-level ,offset)
		   (setq cperl-brace-offset 0)
		   (setq cperl-continued-brace-offset ,(- offset))
		   (setq cperl-label-offset ,(- offset))
		   (setq cperl-continued-statement-offset ,offset)
		   (setq cperl-merge-trailing-else nil))))))

(define-new-pl-style 4 "~/src/linux")
(define-new-pl-style 8 "~/src/git")

;; -------
;; Paredit
;; -------
(mapc (lambda (mode)
	(let ((hook (intern (concat (symbol-name mode)
				    "-mode-hook"))))
	  (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp scheme inferior-lisp))

;; -----
;; Tramp
;; -----
(setq tramp-default-method "ssh")
(set-default 'tramp-default-proxies-alist
	     (quote (("^(?!.*kytes).*$" "\\`root\\'" "/ssh:%h:"))))

;; ---------
;; diff-mode
;; ---------
(define-key diff-mode-map [(meta q)] 'fill-paragraph)
(define-key diff-mode-map [(meta backspace)] 'backward-kill-word)

;; ---------
;; mail-mode
;; ---------
(setq user-mail-address "artagnon@gmail.com"
      user-full-name "Ramkumar Ramachandra")

(add-hook 'mail-mode-hook
	  (lambda ()
	    (define-key mail-mode-map [(control c) (control c)]
	      (lambda ()
		(interactive)
		(save-buffer)
		(server-edit)))))

(add-hook 'mail-mode-hook
	  (lambda ()
	    (define-key mail-mode-map [(control c) (control k)]
	      (lambda ()
		(interactive)
		(revert-buffer t t nil)
		(server-edit)))))

;; -----------------
;; shell-script-mode
;; -----------------
(defmacro define-new-sh-style (indentation basic-offset match-path)
  `(add-hook 'sh-mode-hook
	     (lambda ()
	       (let ((filename (buffer-file-name)))
		 (when (and filename
			    (string-match (expand-file-name ,match-path) filename))
		   (setq sh-indetnation ,indentation)
		   (setq sh-basic-offset ,basic-offset)
		   (setq sh-indent-for-case-label 0)
		   (setq sh-indent-for-case-alt '+))))))

(define-new-sh-style 8 8 "~")

;; ---------
;; html-mode
;; ---------
(add-hook 'html-mode-hook
	     (lambda ()
	       (setq indent-tabs-mode nil)))

;; -------
;; js-mode
;; -------
(add-hook 'js-mode-hook
	     (lambda ()
	       (setq indent-tabs-mode nil)))

;; --------
;; org-mode
;; --------
;; org-mode and LaTeX Beamer

;; allow for export=>beamer by placing
;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
	     '("beamer"
	       "\\documentclass[8pt]{beamer}
\\beamertemplateballitem
\\usepackage{hyperref}
\\usepackage{color}
\\usepackage{listings}
\\usepackage{natbib}
\\usepackage{upquote}
\\usepackage{alltt}
\\usepackage{amsfonts}
\\lstset{frame=single, basicstyle=\\ttfamily\\small, upquote=false, columns=fixed, breaklines=true, keywordstyle=\\color{blue}\\bfseries, commentstyle=\\color{red}, numbers=left, xleftmargin=2em}"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\begin{frame}[fragile]\\frametitle{%s}"
		"\\end{frame}"
		"\\begin{frame}[fragile]\\frametitle{%s}"
		"\\end{frame}")))

;; ----------
;; LaTeX mode
;; ----------
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; -------------
;; auto-complete
;; -------------
;; ???

;; ---
;; man
;; ---
(setq Man-notify-method 'aggressive)

;; -------------
;; ace-jump-mode
;; -------------
(global-set-key [(meta h)] 'ace-jump-word-mode)

;; ----
;; smex
;; ----
(smex-initialize)
(global-set-key [remap execute-extended-command] 'smex)

;; ---------
;; yasnippet
;; ---------
(setq yas-snippet-dirs
      '("~/.elisp/snippets"
	"~/.elisp/yasnippet/snippets"))
(yas-global-mode 0)

;; ----------
;; package.el
;; ----------
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; -----------
;; tuareg-mode
;; -----------
(delete '("\\.ml[iylp]?\\'" . tuareg-mode) auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.ml[il]?\\'" . tuareg-mode))
(add-hook 'tuareg-mode-hook
	     (lambda ()
	       (setq indent-tabs-mode nil)))

;; --------------------
;; exec-path-from-shell
;; --------------------
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; ------------------------
;; Useful utility functions
;; ------------------------
(defun rename-file-and-buffer ()
  "Renames the current buffer and the file it's visiting"
  (interactive)
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (message "A buffer named '%s' already exists!" new-name)
	  (progn (rename-file name new-name 1)
		 (rename-buffer new-name)
		 (set-visited-file-name new-name)
		 (set-buffer-modified-p nil)))))))

(global-set-key [(control x) (control r)] 'rename-file-and-buffer)

(defun delete-file-and-buffer ()
  "Removes file connected to current buffer and kills buffer"
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(global-set-key [(control x) (control k)] 'delete-file-and-buffer)

(defun smart-kill-whole-line (&optional arg)
  (interactive "P")
  (kill-whole-line arg)
  (back-to-indentation))

;; [(control shift backspace)]
(global-set-key [remap kill-whole-line] 'smart-kill-whole-line)

(defun smart-open-line ()
  "Shortcut for C-e RET"
  (interactive)
  (move-end-of-line nil)
  (newline))

(global-set-key [(shift return)] 'smart-open-line)

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(global-set-key [remap goto-line] 'goto-line-with-feedback)
