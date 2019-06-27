(defun my-company-select-next-previous ()
  (interactive)
  ;; when using `company-lsp`, `company-active-map` is sometimes ignored.
  (let ((active-p (company--active-p)))
    (company-select-next)
    (unless active-p
      (company-select-previous))))

(defun my-company-select-previous-next ()
  (interactive)
  ;; when using `company-lsp`, `company-active-map` is sometimes ignored.
  (let ((active-p (company--active-p)))
    (company-select-previous)
    (unless active-p
      (company-select-next))))

(with-eval-after-load 'company
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  (push 'company-lsp company-backends)

  (dolist (m (list company-active-map company-filter-map company-search-map))
    (define-key m (kbd "<tab>") 'hippie-expand)
    (define-key m (kbd "C-h") 'delete-backward-char)
    (define-key m (kbd "C-i") 'hippie-expand)
    (define-key m (kbd "C-j") 'company-complete-selection)
    (define-key m (kbd "C-m") 'company-complete-selection)
    (define-key m (kbd "C-n") 'company-select-next)
    (define-key m (kbd "C-p") 'company-select-previous)
    (define-key m (kbd "C-q") 'company-show-doc-buffer)
    (define-key m (kbd "C-w") 'evil-delete-backward-word))

  (define-key evil-insert-state-map "\C-n" ' my-company-select-next-previous)
  (define-key evil-insert-state-map "\C-p" ' my-company-select-previous-next))

(global-company-mode 1)
