;; evelyn's emacs config


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
;; semi-basics
(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t)
;; font
(when (member "Terminus" (font-family-list))
  (set-frame-font "Terminus:style=regular" t t))
;; theme
(straight-use-package 'nord-theme)
(load-theme 'nord t)

;;;; packages
;; selectrum
(straight-use-package 'selectrum)
(selectrum-mode +1)
