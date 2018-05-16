;; (package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer (url-retrieve-synchronously "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

;; (el-get-bundle! init-loader)
(el-get-bundle! use-package)

(el-get-bundle! evil)
(el-get-bundle! evil-cleverparens)
(el-get-bundle! evil-commentary)
(el-get-bundle! evil-snipe)
(el-get-bundle! evil-surround)

(el-get-bundle! avy)
(el-get-bundle! avy-migemo)
(el-get-bundle! company)
(el-get-bundle! company-lsp)
(el-get-bundle! ggtags)
(el-get-bundle! helm)
(el-get-bundle! helm-gtags)
(el-get-bundle! linum-relative)
(el-get-bundle! lsp-mode)
(el-get-bundle! lsp-ui)
(el-get-bundle! magit)
(el-get-bundle! migemo)
(el-get-bundle! powerline)
(el-get-bundle! rainbow-delimiters)
(el-get-bundle! smartparens)
(el-get-bundle! swiper)
(el-get-bundle! tabbar)
(el-get-bundle! which-key)
(el-get-bundle! yasnippet)
(el-get-bundle! flycheck
                :type github
                :pkgname "flycheck/flycheck"
                :checkout "32cb1369e9db63e6b8c2176ea7907d98b66ac3f2")

(el-get-bundle! dracula-theme
                (progn
                  (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/dracula-theme-20180416.652")
                  (load-theme 'dracula t)))

(el-get-bundle! toml-mode)
(el-get-bundle! markdown-mode)

(el-get-bundle! rust-mode)
(el-get-bundle! cargo)
(el-get-bundle! lsp-rust)
(el-get-bundle! racer)
(el-get-bundle! flycheck-rust
                :init (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(el-get-bundle! web-mode)

(el-get-bundle! bind-key)
(el-get-bundle! dash)
(el-get-bundle! drag-stuff)
(el-get-bundle! exec-path-from-shell)
(el-get-bundle! expand-region)
(el-get-bundle! f)
(el-get-bundle! htmlize)
(el-get-bundle! idle-highlight-mode)
(el-get-bundle! multiple-cursors)
(el-get-bundle! nyan-mode)
(el-get-bundle! pallet)
(el-get-bundle! popwin)
(el-get-bundle! prodigy)
(el-get-bundle! projectile)
(el-get-bundle! s)
(el-get-bundle! smex)

(setq inhibit-startup-message t)
(setq make-backup-files nil)

(prefer-coding-system 'utf-8-unix)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

(evil-mode 1)
(setq evil-want-C-i-jump t)

(linum-relative-global-mode t)
(setq linum-relative-current-symbol "")

(which-key-mode 1)

(smartparens-global-mode 1)
(show-smartparens-global-mode)

(global-flycheck-mode 1)
(setq flycheck-pos-tip-timeout 0)

(yas-global-mode 1)
(add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
(add-hook 'yas-before-expand-snippet-hook (lambda () (smartparens-mode -1)))
(add-hook 'yas-after-exit-snippet-hook (lambda () (smartparens-mode 1)))
(setq helm-buffers-fuzzy-matching t
      helm-M-x-fuzzy-match t)

(setq web-mode-markup-indent-offset 2)

(set-face-attribute 'default nil :family "Cica" :height 95 :weight 'bold)

(set-face-background 'default "#1b1d1e")
(set-face-background 'linum "#1b1d1e")
(set-face-background 'fringe "#1b1d1e")

(setq whitespace-style '(face trailing tabs tab-mark))
(global-whitespace-mode 1)

(blink-cursor-mode 0)
(setq cursor-type '(box "white")
      evil-normal-state-cursor '(box "#66ff33")
      evil-insert-state-cursor '(box "#0099ff")
      evil-visual-state-cursor '(box "yellow")
      evil-motion-state-cursor '(box "black")
      evil-replace-state-cursor '(box "black")
      evil-operator-state-cursor '(box "black"))

(require 'avy-migemo-e.g.swiper)
;; (init-loader-load "~/.emacs.d/elisp/")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
(load "my-keymap")
(load "my-company")
(load "my-tabbar")
(load "my-migemo")
(load "my-c-c++")
(load "my-elisp")
(load "my-haskell")
(load "my-js2")
(load "my-latex")
(load "my-org")
(load "my-python")
(load "my-qml")
(load "my-rust")
(load "my-shell")

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)

(defun my-powerline--create-face (name fg bg weight)
  (make-face name)
  (set-face-attribute name nil :foreground fg :background bg :box nil :weight weight :inherit 'mode-line))

(with-eval-after-load 'powerline
  (set-face-attribute 'mode-line nil :background (face-attribute 'default :background) :height (face-attribute 'default :height) :box "#808080")
  (set-face-attribute 'mode-line-buffer-id nil :foreground "#99ff33")
  (my-powerline--create-face 'mode-line-non-utf-8-unix "white" "red" 'bold)
  (my-powerline--create-face 'mode-line-evil-normal "black" "#66ff33" 'bold)
  (my-powerline--create-face 'mode-line-evil-insert "black" "#0099ff" 'bold)
  (my-powerline--create-face 'mode-line-evil-visual "black" "yellow" 'bold)
  (my-powerline--create-face 'mode-line-evil-motion "black" "black" 'bold)
  (my-powerline--create-face 'mode-line-evil-replace "black" "black" 'bold)
  (my-powerline--create-face 'mode-line-evil-operator "black" "black" 'bold)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (lhs (list (cond ((and (string-equal evil-state "normal") active)
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
                                     (powerline-raw " %M %m  [" nil 'l)
                                     (string-join (split-string (format-mode-line minor-mode-alist)) " ")
                                     "]"))
                          (rhs (append (if (string= buffer-file-coding-system "utf-8-unix")
                                           '()
                                         (list (powerline-raw (format "%s " buffer-file-coding-system) 'mode-line-non-utf-8-unix 'r)))
                                       (list (powerline-raw "%l:%c  %6p" nil 'r)))))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs))
                             (powerline-render rhs)))))))

(unless (server-running-p)
  (server-start))
