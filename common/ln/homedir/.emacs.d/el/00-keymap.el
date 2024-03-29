(defun my-keymap-evil-normal-c$ ()
  (interactive)
  (let ((begin (progn (current-column) (point)))
        (end (progn (end-of-line) (point))))
    (evil-change begin end)))

(defun my-keymap-evil-insert-C-u ()
  (interactive)
  (let ((begin (progn (current-column) (point)))
        (end (progn (evil-first-non-blank) (point))))
    (evil-change begin end)))

(defun my-keymap-delete-backward-word-10-times ()
  (interactive)
  (loop for i from 0 to 9 do
        (evil-delete-backward-word)))

(defun my-keymap-save-if-file-buffer ()
  (interactive)
  (when (not (or (string-match "\\*.+\\*" (buffer-name))
                 (string-match "intero:backend:.*" (buffer-name))
                 (eq major-mode 'dired-mode)))
    ;; (when (string-equal major-mode "c++-mode")
    ;;   (clang-format-buffer))
    (when (and lsp-mode my-keymap-format-on-save)
      (lsp-format-buffer))
    (when (string-equal major-mode "rustic-mode")
      (set-buffer-modified-p t))
    (save-buffer)))

(defun my-keymap-toggle-format-on-save ()
  (interactive)
  (setq my-keymap-format-on-save (not my-keymap-format-on-save))
  (message "Set my-keymap-format-on-save %s" my-keymap-format-on-save))

(setq my-keymap-format-on-save t)

(defun my-keymap-toggle-flycheck-error-buffer ()
  (interactive)
  (if (string-match-p "Flycheck errors" (format "%s" (window-list)))
      (dolist (w (window-list))
        (when (string-match-p "*Flycheck errors*" (buffer-name (window-buffer w)))
          (delete-window w)))
    (flycheck-list-errors)))

(define-key evil-normal-state-map [escape] 'my-keymap-save-if-file-buffer)

(define-key evil-motion-state-map "\\" nil)

(define-key evil-insert-state-map "\M-r" 'quickrun)
(define-key evil-normal-state-map "\M-r" 'quickrun)
(define-key evil-insert-state-map "\M-v" 'helm-imenu)
(define-key evil-normal-state-map "\M-v" 'helm-imenu)
(define-key evil-insert-state-map "\M-l" 'my-keymap-toggle-flycheck-error-buffer)
(define-key evil-normal-state-map "\M-l" 'my-keymap-toggle-flycheck-error-buffer)
(define-key evil-insert-state-map "\M-g" 'magit-status)
(define-key evil-normal-state-map "\M-g" 'magit-status)
(define-key evil-insert-state-map "\M-c" 'delete-other-windows)
(define-key evil-normal-state-map "\M-c" 'delete-other-windows)
(define-key evil-insert-state-map "\M-x" 'helm-M-x)
(define-key evil-normal-state-map "\M-x" 'helm-M-x)

(define-key evil-normal-state-map "\M-q" 'lsp-ui-sideline-apply-code-actions)

(define-key evil-visual-state-map "s" 'evil-surround-region)

(define-key evil-normal-state-map "\M-f" 'avy-migemo-goto-char-2)
(define-key evil-normal-state-map "\M-s" 'swiper)
(define-key evil-normal-state-map "\M-w" 'helm-find-files)
(define-key evil-normal-state-map "\C-h" 'evil-backward-char)
(define-key evil-normal-state-map "\C-k" 'my-keymap-evil-normal-c$)
;;(define-key evil-normal-state-map "\C-n" 'tabbar-forward-tab)
;;(define-key evil-normal-state-map "\C-p" 'tabbar-backward-tab)
;; evil-leader
;; (define-key evil-normal-state-map "\\c" 'toggle-truncate-lines)

(define-key evil-normal-state-map "\C-q" 'lsp-ui-doc-glance)
(define-key company-mode-map "\C-q" 'lsp-ui-doc-glance)
(define-key company-mode-map "\C-q" 'lsp-ui-doc-glance)
(define-key company-active-map "\C-j" 'company-complete-selection)
(define-key company-active-map "\C-i" 'company-complete-selection)

(define-key evil-insert-state-map "\C-a" 'evil-insert-line)
(define-key evil-insert-state-map "\C-e" 'move-end-of-line)
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)
(define-key evil-insert-state-map "\C-h" 'delete-backward-char)
(define-key evil-insert-state-map "\C-i" 'hippie-expand)
(define-key evil-insert-state-map "\C-j" 'newline-and-indent)
(define-key evil-insert-state-map "\C-u" 'my-keymap-evil-insert-C-u)

(define-key evil-ex-completion-map "\C-j" 'exit-minibuffer)

(define-key minibuffer-local-map "\C-j" 'minibuffer-complete-and-exit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(with-eval-after-load 'helm
  (define-key helm-map "\C-h" 'delete-backward-char)
  (define-key helm-map "\C-w" 'evil-delete-backward-word)
  (define-key helm-find-files-map "\C-h" 'delete-backward-char)
  (define-key helm-find-files-map "\C-w" 'evil-delete-backward-word))

(define-key swiper-map "\C-j" 'ivy-done)
(define-key swiper-map "\C-u" 'my-keymap-delete-backward-word-10-times)
(define-key swiper-map [escape] 'minibuffer-keyboard-quit)

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-w") 'evil-delete-backward-word)
(global-set-key [M-kanji] 'ignore)

(evil-define-key 'normal dired-mode-map "\C-j" 'dired-find-file)
(evil-define-key 'normal quickrun--mode-map "q" 'evil-window-delete)

;; (keyboard-translate ?\C-j ?\C-m)
