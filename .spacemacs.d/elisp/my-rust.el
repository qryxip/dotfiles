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
  (evil-define-key 'normal rust-mode-map "\M-t" 'cargo-process-test)
  (setq company-begin-commands (append '(my-rust-insert-comma
                                         my-rust-insert-single-quote
                                         my-rust-insert-double-quote
                                         my-rust-insert-curly-brace
                                         my-rust-insert-bracket
                                         my-rust-insert-operator
                                         )
                                       company-begin-commands))
  (evil-define-key 'insert rust-mode-map "," 'my-rust-insert-comma)
  (evil-define-key 'insert rust-mode-map "'" 'my-rust-insert-single-quote)
  (evil-define-key 'insert rust-mode-map "\"" 'my-rust-insert-double-quote)
  (evil-define-key 'insert rust-mode-map "{" 'my-rust-insert-curly-brace)
  (dolist (c (string-to-list "(["))
    (evil-define-key 'insert rust-mode-map (char-to-string c) 'my-rust-insert-bracket))
  (dolist (c (string-to-list "+-*/=<>&|"))
    (evil-define-key 'insert rust-mode-map (char-to-string c) 'my-rust-insert-operator))
  (dolist (c (string-to-list "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))
    (evil-define-key 'insert rust-mode-map (char-to-string c) 'my-rust-insert-alphabet-or-number)))

(defun my-rust-run ()
  (interactive)
  (let ((file-path (buffer-file-name)))
    (cond ((string-match (format "^.*/%s/src/bin/\\(.+\\)\\.rs$" my-rust--snowchains-crate) file-path)
           (let ((buffer (get-buffer "*snowchains*")))
             (when buffer
               (with-current-buffer buffer
                 (erase-buffer))))
           (let ((problem-name (match-string 1 file-path)))
             (term-run "snowchains" "*snowchains*" "judge" "cargo"
                       (format "%s/%s.%s" my-rust--snowchains-dir problem-name my-rust--snowchains-ext)
                       problem-name)))
          ((string-match "^.*/src/bin/\\(.+\\)\\.rs$" file-path)
           (cargo-process-run-bin (match-string 1 file-path)))
          (t
           (cargo-process-run)))))

(defun my-rust-insert-comma ()
  (interactive)
  (insert ",")
  (when (not (nth 3 (syntax-ppss (point))))
    (insert " ")))

(defun my-rust-insert-single-quote ()
  (interactive)
  (when (not (or (member (preceding-char) (string-to-list "& "))
                 (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-double-quote ()
  (interactive)
  (when (not (or (member (preceding-char) (string-to-list "([ "))
                 (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-curly-brace ()
  (interactive)
  (when (not (or (member (preceding-char) (string-to-list "([: "))
                 (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-bracket ()
  (interactive)
  (when (and (member (preceding-char) (string-to-list "+-*/=<>&|"))
             (not (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-operator ()
  (interactive)
  (when (not (or (member (preceding-char) (string-to-list "+-*/=<>&| "))
                 (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-alphabet-or-number ()
  (interactive)
  (when (and (member (preceding-char) (string-to-list "+-*/=<>&|:"))
             (not (equal (char-before (- (point) 1)) (string-to-char ":")))
             (not (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defconst my-rust--snowchains-crate "rust-contest")
(defconst my-rust--snowchains-dir "snowchains")
(defconst my-rust--snowchains-ext "toml")

(add-hook 'rust-mode-hook 'my-rust-init)
