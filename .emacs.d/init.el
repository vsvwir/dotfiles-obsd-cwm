;; TODO:
;; Migrate all straight-use-package to use-package
;; Migrate to either vertico & friends OR Get used to ido+smex (currently trying vertico)
;; Nicer language completion would be nice as well.
;; MAYBE:
;; multiple-cursors, SLY instead of SLIME, Org, modular config

;;;; basics
;; backup fix
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
;; straight.el bootstrap
(defvar bootstrap-version) 
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default 1)
;; line numbers/column numbers
(setq display-line-numbers 'relative)
(line-number-mode 1)
(column-number-mode 1)
;; general coding style
(setq-default show-trailing-whitespace t)
(setq whitespace-style '(trailing lines)
      whitespace-line-column 80)

(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(scroll-bar-mode -1)
(menu-bar-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t)
;;;; vertico and friends
(use-package vertico
  :init
  (vertico-mode))
(use-package consult
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("M-s r" . consult-ripgrep)))
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
;; font
(set-frame-font "Go Mono 12" t t) ; Requires Go Mono to be installed
;; theme
(use-package parchment-theme
  :config (load-theme 'parchment t))
;;;; programming
;; lsp support
(use-package lsp-mode)
(add-hook 'c-mode-hook 'lsp-deferred)
(add-hook 'c++-mode-hook 'lsp-deferred)
(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'rust-mode-hook 'lsp-deferred)
(use-package lsp-ui
  :config
  (setq lsp-ui-peek-enable t))
(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
;; comment-uncomment
(global-set-key (kbd "C-c C-o") 'comment-or-uncomment-region)
;; magit
(use-package magit)
(setq magit-define-global-key-bindings 'recommended)
;; flycheck
(use-package flycheck
  :hook (c-mode . flycheck-mode)
        (go-mode . flycheck-mode))
;; company
(use-package company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode))
;; lisp
(use-package paredit
  :hook ((emacs-lisp-mode . paredit-mode)
         (lisp-mode . paredit-mode)))
;; c
(setq c-default-style "bsd")
(setq c-basic-offset 8)
;; rust
(use-package rust-mode)
;; go
(use-package go-mode
  :mode (("\\.go\\'" . go-mode)))
(add-hook 'go-mode-hook (lambda () (setq tab-width 4)))
;; tree-sitter
(use-package tree-sitter
  :config
  (use-package tree-sitter-langs)
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
