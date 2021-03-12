;; (package-initialize)

(setq inhibit-startup-message t)
(setq make-backup-files nil)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8-unix)
(setq coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8)

(setq-default indent-tabs-mode nil)
(setq-default scroll-conservatively 1)

(setq-default tab-width 4) ;; somehow necessary here and there

(setq default-frame-alist (append (list '(width . 180) '(height . 60)) default-frame-alist))

(setq straight-use-package-by-default t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package evil
  :custom (evil-want-C-i-jump t)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config (evil-collection-init))

(use-package evil-cleverparens)
(use-package evil-commentary)
(use-package evil-matchit)
(use-package evil-snipe)
(use-package evil-surround)

(use-package company)
(use-package company-lsp)
(use-package ggtags)
(use-package helm
  :config (progn
            (define-key helm-map "\C-i" 'helm-execute-persistent-action)
            (define-key helm-map "\C-j" 'helm-confirm-and-exit-minibuffer)
            (define-key helm-map "\C-h" 'delete-backward-char)
            (define-key helm-map "\C-w" 'evil-delete-backward-word)))
(use-package helm-gtags)
(use-package lsp-mode
  :custom (lsp-prefer-flymake :none)
          (lsp-rust-server 'rust-analyzer)
          (lsp-rust-rls-command '("rustup" "run" "stable" "rls"))
          (lsp-rust-clippy-preference "on")
          (lsp-rust-analyzer-cargo-watch-command "clippy")
          (lsp-rust-analyzer-cargo-watch-args ["--profile" "test"])
          (lsp-rust-analyzer-proc-macro-enable t)
          (lsp-rust-analyzer-cargo-load-out-dirs-from-check t)
          ;(lsp-auto-guess-root t)
          )
(use-package lsp-ui
  ;; :config (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :custom (lsp-ui-doc-enable nil)
  )
;;(use-package eglot)
(use-package rainbow-delimiters)
(use-package smartparens
  :config (progn
            (smartparens-global-mode 1)
            (show-smartparens-global-mode)))
(use-package tabbar)
(use-package which-key
  :config (which-key-mode 1))
(use-package yasnippet)

(use-package flycheck
  :config (add-to-list 'display-buffer-alist
                       `(,(rx bos "*Flycheck errors*" eos)
                         (display-buffer-reuse-window display-buffer-in-side-window)
                         (side . bottom)
                         (reusable-frames . visible)
                         (window-height . 0.33))))
(use-package flycheck-status-emoji
  :custom
  (flycheck-status-emoji-indicator-running ?⭯)
  (flycheck-status-emoji-indicator-finished-ok ?✓)
  (flycheck-status-emoji-indicator-finished-error ?✗)
  (flycheck-status-emoji-indicator-finished-warning ?⚠)
  (flycheck-status-emoji-indicator-finished-info ?ℹ)
  (flycheck-status-emoji-indicator-not-checked (string-to-char "?"))
  (flycheck-status-emoji-indicator-no-checker (string-to-char "?"))
  (flycheck-status-emoji-indicator-errored ?E)
  (flycheck-status-emoji-indicator-interrupted ?❗)
  (flycheck-status-emoji-indicator-suspicious ?❗)
  :config (flycheck-status-emoji-mode 1))

(use-package magit)
(use-package smeargle)
(use-package gitattributes-mode)
(use-package gitconfig-mode)
(use-package gitignore-mode)
(use-package git-timemachine)
(use-package diff-hl
  :config
  (set-face-background 'diff-hl-insert nil)
  (set-face-background 'diff-hl-delete nil)
  (set-face-background 'diff-hl-change nil)
  (set-face-foreground 'diff-hl-insert "green")
  (set-face-foreground 'diff-hl-delete "red")
  (set-face-foreground 'diff-hl-change "yellow")
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (diff-hl-margin-mode 1)
  (global-diff-hl-mode 1))

(use-package migemo)
(use-package swiper)
(use-package wgrep)
(use-package avy)

(use-package avy-migemo
  ;; https://github.com/momomo5717/avy-migemo/pull/8
  :straight (:host github :repo "tam17aki/avy-migemo")
  :config (require 'avy-migemo-e.g.swiper))

(use-package monokai-theme
  :config (progn (load-theme 'monokai t)
                 (set-face-attribute 'font-lock-builtin-face nil :weight 'bold)
                 (set-face-attribute 'font-lock-keyword-face nil :weight 'bold)
                 (dolist (face '("default" "fringe"))
                   (set-face-foreground (intern face) "#ebdbb2")
                   (set-face-background (intern face) "#282828"))
                 (face-attribute 'default :foreground)))
(use-package autothemer)

(use-package bind-key)
(use-package dash)
(use-package drag-stuff)
(use-package exec-path-from-shell)
(use-package expand-region)
(use-package f)
(use-package htmlize)
(use-package idle-highlight-mode)
(use-package multiple-cursors)
(use-package nyan-mode)
(use-package pallet)
(use-package popwin)
(use-package prodigy)
(use-package projectile)
(use-package s)
(use-package smex)
(use-package term-run)

(setq-default truncate-lines t)

(global-flycheck-mode 1)
(setq flycheck-pos-tip-timeout 0)

(with-eval-after-load 'flymake
  (custom-set-variables '(flymake-error-bitmap nil)
                        '(flymake-note-bitmap nil)
                        '(flymake-warning-bitmap nil))
  (set-face-underline 'flymake-error nil)
  (set-face-underline 'flymake-note nil)
  (set-face-underline 'flymake-warning nil))

(yas-global-mode 1)
(add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
(add-hook 'yas-before-expand-snippet-hook (lambda () (smartparens-mode -1)))
(add-hook 'yas-after-exit-snippet-hook (lambda () (smartparens-mode 1)))
(setq helm-buffers-fuzzy-matching t
      helm-M-x-fuzzy-match t)

(set-face-attribute 'default nil :family "Cica" :height 85 :weight 'bold)
(set-face-attribute 'link nil :family "Cica" :height 85 :weight 'bold)
(set-face-attribute 'font-lock-type-face nil :family "Cica" :height 85 :weight 'bold)
(set-face-attribute 'fixed-pitch nil :family "Cica" :height 85 :weight 'bold)
(with-eval-after-load 'tex-mode
  (set-face-attribute 'tex-verbatim nil :inherit 'link))
(with-eval-after-load 'markdown-mode
  (set-face-attribute 'markdown-inline-code-face nil :inherit 'link))

(setq whitespace-style '(face trailing tabs tab-mark))
(global-whitespace-mode 1)

(blink-cursor-mode 0)
(setq cursor-type '(box "white")
      evil-normal-state-cursor '(box "#66ff33")
      evil-insert-state-cursor '(box "#4fdeff")
      evil-visual-state-cursor '(box "yellow")
      evil-motion-state-cursor '(box "black")
      evil-replace-state-cursor '(box "black")
      evil-operator-state-cursor '(box "black"))

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)

;;(use-package crosshairs)
(use-package powerline)
(use-package sky-color-clock
  :straight (sky-color-clock :repo "https://github.com/zk-phi/sky-color-clock")
  :custom (sky-color-clock-enable-emoji-icon t)
          (sky-color-clock-enable-temperature-indicator t)
  :config (sky-color-clock-initialize 35)
          (let ((path (expand-file-name "apikeys/sky-color-clock.txt" user-emacs-directory)))
            (when (file-exists-p path)
              (with-temp-buffer
                (insert-file-contents path)
                (sky-color-clock-initialize-openweathermap-client (buffer-string) 1850144)))))

(defun init--create-face (name fg bg weight)
  (make-face name)
  (set-face-attribute name nil :foreground fg :background bg :box nil :weight weight :inherit 'mode-line))

(with-eval-after-load 'powerline
  (set-face-attribute 'mode-line nil :background (face-attribute 'default :background) :height (face-attribute 'default :height) :box "#808080")
  (set-face-attribute 'mode-line-buffer-id nil :foreground "#99ff33")
  (init--create-face 'mode-line-non-utf-8-unix "white" "red" 'bold)
  (init--create-face 'mode-line-evil-normal "black" "#66ff33" 'bold)
  (init--create-face 'mode-line-evil-insert "black" "#4fdeff" 'bold)
  (init--create-face 'mode-line-evil-visual "black" "yellow" 'bold)
  (init--create-face 'mode-line-evil-motion "black" "black" 'bold)
  (init--create-face 'mode-line-evil-replace "black" "black" 'bold)
  (init--create-face 'mode-line-evil-operator "black" "black" 'bold)
  (setq-default mode-line-format
                '("%e" (:eval (let* ((active (powerline-selected-window-active))
                                     (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
                                     (mode-line (if active 'mode-line 'mode-line-inactive))
                                     (lhs (append (list (cond ((and (string-equal evil-state "normal") active)
                                                               (powerline-raw " 🅝 " (if active 'mode-line-evil-normal 'powerline-inactive1)))
                                                              ((string-equal evil-state "normal")
                                                               " Ⓝ ")
                                                              ((and (string-equal evil-state "insert") active)
                                                               (powerline-raw " 🅘 " (if active 'mode-line-evil-insert 'powerline-inactive1)))
                                                              ((string-equal evil-state "insert")
                                                               " Ⓘ ")
                                                              ((and (string-equal evil-state "visual") active)
                                                               (powerline-raw " 🅥 " (if active 'mode-line-evil-visual 'powerline-inactive1)))
                                                              ((string-equal evil-state "visual")
                                                               " Ⓥ ")
                                                              ((and (string-equal evil-state "motion") active)
                                                               (powerline-raw " 🅜 " (if active 'mode-line-evil-motion 'powerline-inactive1)))
                                                              ((string-equal evil-state "motion")
                                                               " Ⓜ ")
                                                              ((and (string-equal evil-state "replace") active)
                                                               (powerline-raw " 🅡 " (if active 'mode-line-evil-replace 'powerline-inactive1)))
                                                              ((string-equal evil-state "replace")
                                                               " Ⓡ ")
                                                              ((and (string-equal evil-state "operator") active)
                                                               (powerline-raw " 🅞 " (if active 'mode-line-evil-operator 'powerline-inactive1)))
                                                              ((string-equal evil-state "operator")
                                                               " Ⓞ ")
                                                              (active
                                                               " 🅔 ")
                                                              (t
                                                               " Ⓔ "))
                                                        (powerline-raw "%* %I" nil 'l)
                                                        (powerline-raw "%b" 'mode-line-buffer-id 'l)
                                                        (powerline-raw " %M %m " nil 'l))
                                                  (flycheck-status-emoji-mode-line-text)))
                                     (rhs (append (if (string= buffer-file-coding-system "utf-8-unix")
                                                      '()
                                                    (list (powerline-raw (format "%s " buffer-file-coding-system) 'mode-line-non-utf-8-unix 'r)))
                                                  (list (powerline-raw "%l:%c  %6p" nil 'r)))))
                                (concat (powerline-render lhs)
                                        (powerline-fill nil (+ (powerline-width rhs) (string-width (sky-color-clock))))
                                        (powerline-render rhs)
                                        (sky-color-clock)))))))


(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(use-package irony)
(use-package company-irony)
(use-package flycheck-irony)
(use-package clang-format
  :straight (:host github
             :repo "emacsmirror/clang-format"))

(use-package web-mode
  :custom (web-mode-markup-indent-offset 2))

(use-package graphql)

(use-package toml-mode)
(use-package yaml-mode)

(use-package dhall-mode
  :custom (dhall-use-header-line nil))

(use-package markdown-mode)
(use-package websocket)
(use-package web-server)
(use-package markdown-preview-mode)

(use-package igarashi-copl-mode
  :straight (igarashi-copl-mode :type git
                                :host github
                                :repo "ashiato45/igarashi-copl-mode"))

(use-package init-loader
  :init (setq-default init-loader-show-log-after-init nil))

(init-loader-load (expand-file-name "el" user-emacs-directory))
