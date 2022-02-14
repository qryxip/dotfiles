(with-eval-after-load 'company
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  ;(push 'company-lsp company-backends)

  (dolist (m (list company-mode-map company-search-map))
    (define-key m (kbd "<tab>") 'hippie-expand)
    (define-key m (kbd "C-h") 'delete-backward-char)
    (define-key m (kbd "C-i") 'hippie-expand)
    (define-key m (kbd "C-j") 'company-complete-selection)
    (define-key m (kbd "C-m") 'company-complete-selection)
    (define-key m (kbd "C-n") 'company-select-next)
    (define-key m (kbd "C-p") 'company-select-previous)
    (define-key m (kbd "C-q") 'company-show-doc-buffer)
    (define-key m (kbd "C-w") 'evil-delete-backward-word))

  (define-key evil-insert-state-map "\C-n" 'company-select-next)
  (define-key evil-insert-state-map "\C-p" 'company-select-previous))

(global-company-mode 1)
