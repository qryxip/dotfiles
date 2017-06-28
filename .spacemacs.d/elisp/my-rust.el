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
  (evil-define-key 'normal rust-mode-map "\M-t" 'cargo-process-test))

(defun my-rust-run ()
  (interactive)
  (let ((file-path (buffer-file-name)))
    (cond ((string-match ".*/rust-contest/src/bin/\\(.+\\)\\.rs" file-path)
           (let ((buffer (get-buffer "*snowchains*")))
             (when buffer
               (with-current-buffer buffer
                 (erase-buffer))))
           (let ((problem (match-string 1 file-path)))
             (term-run "sh" "*snowchains*" "-c" (format "snowchains cargo judge %s %s.toml" problem problem))))
          ((string-match ".*/src/bin/\\(.+\\)\\.rs" file-path)
           (cargo-process-run-bin (match-string 1 file-path)))
          (t
           (cargo-process-run)))))

(add-hook 'rust-mode-hook 'my-rust-init)
