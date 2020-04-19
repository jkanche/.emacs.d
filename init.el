;; (package-initialize) - prevent package.el from adding stuff
;; (require 'cl-lib)
;; (require 'subr-x)
;; (let ((file-name-handler-alist nil)
;;      (package-enable-at-startup nil)
;;      (message-log-max 16384)
;;      (gc-cons-threshold (lsh 1 30))
;;      (gc-cons-percentage 0.6)
;;      (auto-window-vscroll nil))
;;  (garbage-collect))


;; (setq line-number-mode t)

(set-frame-font "Source Code Pro 12" nil t)

;; package repositories
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; user settings - name and email
(setq user-full-name "Jayaram Kancherla")
(setq user-mail-address "jayaram.kancherla@gmail.com")

;; enable clipboard/resize
(setq select-enable-clipboard t)
(setq frame-resize-pixelwise t)
(setq window-combination-resize t)
;;(setq-default fill-column 80)

;; wrap lines
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; Automatically :ensure packages.
(setq use-package-always-ensure t)

;; Default value for :pin in each use-package.
;;(setq use-package-always-pin "melpa-stable")

;; Bootstrap use-package & dependencies
(seq-doseq (package '(use-package bind-key diminish))
	(unless (package-installed-p package)
	  (package-refresh-contents)
	  (package-install package)))

     (eval-when-compile
	(require 'use-package))

(require 'diminish)
(require 'bind-key)

;; enable package for theme
;;(setq package-archives
;;      (append '(("melpa" . "http://melpa.milkbox.net/packages/"))
;;              package-archives))
(use-package leuven-theme)

;; org settings
(require 'org)

;; set org folder by default and enable agenda on all files
(setq inital-buffer-choice "~/Dropbox/org")
(setq org-agenda-files (list "~/Dropbox/org"))

;; org keybindings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(setq org-agenda-todo-list-sublevels t)

(setq org-todo-keywords '((sequence "TODO(t/!)" "IN-PROGRESS(i/!)" "WAITING(w/!)" "DONE(d@/!)")))

;; probably overkill to log everything
(setq org-log-into-drawer t)
(setq org-log-done t)
(setq org-log-reschedule t)
(setq org-log-redeadline t)
(setq org-enable-priority-commands nil)

;; org-journal
;; (require 'org-journal)


;; org-super-agenda
;; (require 'org-super-agenda)

;; org-journal setup
(require 'org-journal)
(use-package org-journal
  :ensure t
  :defer t
  :custom
  (org-journal-dir "~/Dropbox/org/journal/")
  (org-journal-date-format "%A, %d %B %Y"))

;; (setq-default org-download-image-dir "~/Desktop/gdrive/org/images")

;; enables org-download, adds drag & drop
(require 'org-download)
(add-hook 'dired-mode-hook 'org-download-enable)

;; displays images inline in org files
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images "inlineimages")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (toc-org helm org-download use-package orgalist org-super-agenda org-journal leuven-theme diminish deft))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; helm configuration
(require 'helm)
(helm-mode 1)


;; org-toc
(if (require 'toc-org nil t)
    (add-hook 'org-mode-hook 'toc-org-mode)

    ;; enable in markdown, too
    (add-hook 'markdown-mode-hook 'toc-org-mode)
    (define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point)
  (warn "toc-org not found"))

;; deft settings
(require 'deft)
(setq deft-extensions '("org" "tex" "txt", "md", "markdown"))
(setq deft-directory "~/Dropbox/org")
(setq deft-recursive t)
(global-set-key [f8] 'deft)
(setq deft-use-filename-as-title t)
