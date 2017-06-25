(require 'cargo)
(require 'term-run)

(defun my-rust-init ()
  (interactive)
  (when (or (string-match ".*/.cargo/.*" (pwd))
            (string-match ".*.rustup/.*" (pwd)))
    (read-only-mode 1))
  (setq rust-format-on-save t)
  (define-key company-active-map "\C-q" 'racer-describe)
  (define-key company-search-map "\C-q" 'racer-describe)
  (evil-define-key 'insert rust-mode-map "\C-q" 'racer-describe)
  (evil-define-key 'normal rust-mode-map "\C-q" 'racer-describe)
  (evil-define-key 'normal rust-mode-map "\C-]" 'racer-find-definition)
  (evil-define-key 'normal rust-mode-map "\M-r" 'my-rust-run)
  (evil-define-key 'normal rust-mode-map "\M-t" 'my-rust-test-all-or-bin))

(defun my-rust-run ()
  (interactive)
  (let ((file-path (buffer-file-name)))
    (cond ((string-match ".*/rust-contest/src/bin/\\(.+\\)\\.rs" file-path)
           (let ((buffer (get-buffer "*cargo-judge*")))
             (when buffer
               (with-current-buffer buffer
                 (erase-buffer))))
           (term-run "sh" "*cargo-judge*" "-c" (concat "cargo judge " (match-string 1 file-path))))
          ((string-match ".*/src/bin/\\(.+\\)\\.rs" file-path)
           (cargo-process-run-bin (match-string 1 file-path)))
          (t
           (cargo-process-run)))))

(defun my-rust-test-all-or-bin ()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (cond ((string-match ".*/src/bin/\\(.+\\)\\.rs" file-name)
           (cargo-process--start "Test" (format "cargo test --release --bin %s" (match-string 1 file-name))))
          (t
           (cargo-process-test)))))

(add-hook 'rust-mode-hook 'my-rust-init)
