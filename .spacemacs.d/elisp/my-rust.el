(defun my-rust/init ()
  (interactive)
  (when (or (string-match ".*/.cargo/.*" (pwd))
            (string-match ".*.rustup/.*" (pwd)))
    (read-only-mode 1))
  (define-key company-active-map "\C-q" 'racer-describe)
  (define-key company-search-map "\C-q" 'racer-describe))

(setq rust-format-on-save t)

(evil-define-key 'insert rust-mode-map "\C-q" 'racer-describe)
(evil-define-key 'normal rust-mode-map "\C-q" 'racer-describe)
(evil-define-key 'normal rust-mode-map "\C-]" 'racer-find-definition)
(evil-define-key 'normal rust-mode-map "\M-r" 'cargo-process-run)
(evil-define-key 'normal rust-mode-map "\M-t" 'cargo-process-test)

(add-hook 'rust-mode-hook 'my-rust/init)


