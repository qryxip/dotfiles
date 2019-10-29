;; https://github.com/raxod502/straight.el/issues/274
(add-to-list 'load-path (expand-file-name "straight/repos/rust-analyzer/editors/emacs" user-emacs-directory))

(use-package racer)
(use-package ra-emacs-lsp
  :straight (:host github
             :repo "rust-analyzer/rust-analyzer"
             :no-build t))
(use-package rustic
  ;; :custom (rustic-lsp-server 'rust-analyzer)
  ;;         (rustic-analyzer-command nil)
  ;; :custom (rustic-lsp-server 'rust-analyzer)
  ;;         (rustic-analyzer-command '("nice" "ra_lsp_server"))
  :custom (rustic-lsp-server 'rust-analyzer)
  )

;;(defun lsp-buffer-language ()
;;  "Return \"rust\"."
;;  "rust")

;; (lsp-register-client
;;  (make-lsp-client
;;   :new-connection (lsp-stdio-connection (lambda () rust-analyzer-command))
;;   :notification-handlers (ht<-alist rust-analyzer--notification-handlers)
;;   :action-handlers (ht<-alist rust-analyzer--action-handlers)
;;   :major-modes '(rustic-mode)
;;   :ignore-messages nil
;;   :server-id 'rust-analyzer))

(sp-with-modes '(rustic-mode)
  (sp-local-pair "'" "'"
                 :unless '(sp-in-comment-p sp-in-string-quotes-p sp-in-rust-lifetime-context)
                 :post-handlers'(:rem sp-escape-quotes-after-insert))
  (sp-local-pair "<" ">"
                 :when '(sp-rust-filter-angle-brackets)
                 :skip-match 'sp-rust-skip-match-angle-bracket))
(add-to-list 'sp-sexp-suffix (list #'rustic-mode 'regexp ""))

(defun my-rust-run ()
  (interactive)
  (let ((file-path (buffer-file-name)))
    (cond ((string-match "/contest/rs/src/bin/\\(.+\\)\\.rs\\'" file-path)
           (let ((buffer (get-buffer "*snowchains*")))
             (when buffer
               (with-current-buffer buffer
                 (read-only-mode 0)
                 (erase-buffer))))
           (let ((problem-name (match-string 1 file-path)))
             (term-run "snowchains" "*snowchains*" "submit" problem-name "-l" "rust")))
          ((string-match "/src/bin/\\(.+\\)\\.rs\\'" file-path)
           (my-rust--cargo-command (list "cargo" "run" "--bin" (match-string 1 file-path))))
          ((string-match "/examples/\\(.+\\)\\.rs\\'" file-path)
           (my-rust--cargo-command (list "cargo" "run" "--example" (match-string 1 file-path))))
          (t
           (rustic-cargo-run)))))

(defun my-rust-test ()
  (interactive)
  (let ((file-path (buffer-file-name)))
    (cond ((string-match "/contest/rs/src/bin/\\(.+\\)\\.rs\\'" file-path)
           (let ((buffer (get-buffer "*snowchains*")))
             (when buffer
               (with-current-buffer buffer
                 (read-only-mode 0)
                 (erase-buffer))))
           (let ((problem-name (match-string 1 file-path)))
             (term-run "snowchains" "*snowchains*" "judge" problem-name "-l" "rust")))
          ((string-match "/src/bin/\\(.+\\)\\.rs\\'" file-path)
           (my-rust--cargo-command (list "cargo" "test" "--bin" (match-string 1 file-path))))
          (t
           (rustic-cargo-test)))))

(defun my-rust--cargo-command (args)
  (rustic-compilation-process-live)
  (rustic-compilation-start args))

(defun my-rust-insert-comma ()
  (interactive)
  (insert ",")
  (when (not (or (eolp)
                 (nth 3 (syntax-ppss))
                 (nth 5 (syntax-ppss))))
    (insert " ")))

(defun my-rust-insert-colon ()
  (interactive)
  (cond ((and (string-equal (buffer-substring (- (point) 2) (point)) ": ")
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (delete-backward-char 1)
         (self-insert-command 1))
        ((and (equal (preceding-char) (string-to-char ">"))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (self-insert-command 2))
        ((not (or (nth 3 (syntax-ppss))
                  (nth 5 (syntax-ppss))))
         (self-insert-command 1)
         (insert " "))
        (t
         (self-insert-command 1))))

(defun my-rust-insert-semicolon ()
  (interactive)
  (self-insert-command 1)
  ;; (when (and (eolp)
  ;;            (not (or (nth 3 (syntax-ppss))
  ;;                     (nth 5 (syntax-ppss)))))
  ;;   (when rustic-format-on-save
  ;;     (rustic-format-buffer)))
  )

(defun my-rust-insert-equal ()
  (interactive)
  (cond ((and (string-equal " <>" (buffer-substring (- (point) 2) (+ (point) 1)))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (delete-char 1)
         (insert "= "))
        ((and (string-equal "<>" (buffer-substring (- (point) 1) (+ (point) 1)))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (delete-char 1)
         (delete-backward-char 1)
         (insert " <= "))
        ((and (string-equal "= " (buffer-substring (- (point) 2) (point)))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (delete-backward-char 1)
         (insert "= "))
        ((and (member (preceding-char) (string-to-list "+-*/&|^%!=<> "))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (insert "= "))
        ((not (or (nth 3 (syntax-ppss))
                  (nth 5 (syntax-ppss))))
         (insert " = "))
        (t
         (self-insert-command 1))))

(defun my-rust-insert-bar ()
  (interactive)
  (cond ((and (equal (preceding-char) (string-to-char "("))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (insert "||")
         (backward-char 1))
        ((and (string-equal "(move" (buffer-substring (- (point) 5) (point)))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (insert " ||")
         (backward-char 1))
        ((and (or (string-equal "= " (buffer-substring (- (point) 2) (point)))
                  (string-equal "=move " (buffer-substring (- (point) 6) (point)))
                  (string-equal "= move " (buffer-substring (- (point) 7) (point))))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (insert "||;")
         (backward-char 2))
        ((and (or (string-equal "=" (buffer-substring (- (point) 1) (point)))
                  (string-equal "=move" (buffer-substring (- (point) 5) (point)))
                  (string-equal "= move" (buffer-substring (- (point) 6) (point))))
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (insert " ||;")
         (backward-char 2))
        ((and (string-equal (buffer-substring (point) (+ (point) 1)) "|")
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (forward-char 1))
        (t
         (self-insert-command 1))))

(defun my-rust-insert-gt ()
  (interactive)
  (cond ((and (string-equal (buffer-substring (- (point) 2) (point)) "= ")
              (not (or (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (delete-backward-char 1)
         (insert "> "))
        (t
         (self-insert-command 1))))

(defun my-rust-insert-single-quote ()
  (interactive)
  (when (not (or (member (preceding-char) (string-to-list "br&([< "))
                 (and (> (point) 2) (= (char-before (- (point) 1)) (string-to-char "'")))
                 (nth 3 (syntax-ppss))
                 (nth 5 (syntax-ppss))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-double-quote ()
  (interactive)
  (when (not (or (member (preceding-char) (string-to-list "br#([ "))
                 (nth 3 (syntax-ppss))
                 (nth 5 (syntax-ppss))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-curly-brace ()
  (interactive)
  (cond ((and (eolp)
              (string-equal "= " (buffer-substring (- (point) 2) (point)))
              (not (or (string-equal "== " (buffer-substring (- (point) 3) (point)))
                       (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (insert ";")
         (backward-char 1)
         (self-insert-command 1))
        ((and (eolp)
              (equal (preceding-char) (string-to-char "="))
              (not (or (string-equal "==" (buffer-substring (- (point) 2) (point)))
                       (nth 3 (syntax-ppss))
                       (nth 5 (syntax-ppss)))))
         (insert " ;")
         (backward-char 1)
         (self-insert-command 1))
        ((not (or (member (preceding-char) (string-to-list "([: "))
                  (nth 3 (syntax-ppss))
                  (nth 5 (syntax-ppss))))
         (insert " ")
         (self-insert-command 1))
        (t
         (self-insert-command 1))))

(defun my-rust-insert-bracket ()
  (interactive)
  (when (and (member (preceding-char) (string-to-list ",+-*/|=>"))
             (not (or (nth 3 (syntax-ppss))
                      (nth 5 (syntax-ppss)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-ret ()
  (interactive)
  (if (company--active-p)
      ;; when using `company-lsp`, `company-active-map` is sometimes ignored.
      (company-complete-selection)
    (let ((p (and (not (nth 3 (syntax-ppss)))
                  (or (and (eq (preceding-char) (string-to-char "("))
                           (eq (char-before (+ 1 (point))) (string-to-char ")")))
                      (and (eq (preceding-char) (string-to-char "["))
                           (eq (char-before (+ 1 (point))) (string-to-char "]")))
                      (and (eq (preceding-char) (string-to-char "{"))
                           (eq (char-before (+ 1 (point))) (string-to-char "}")))))))
      (newline-and-indent)
      (when p
        (evil-open-above 1)))))

(defun my-rust-insert-operator ()
  (interactive)
  (when (not (or (member (preceding-char) (string-to-list "+-*/=<>&| "))
                 (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-alphabet ()
  (interactive)
  (when (and (member (preceding-char) (string-to-list "+/=>:"))
             (not (equal (char-before (- (point) 1)) (string-to-char ":")))
             (not (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(defun my-rust-insert-number ()
  (interactive)
  (when (and (member (preceding-char) (string-to-list "+*/=<>&|:"))
             (not (equal (char-before (- (point) 1)) (string-to-char ":")))
             (not (nth 3 (syntax-ppss (point)))))
    (insert " "))
  (self-insert-command 1))

(with-eval-after-load 'rustic
  (defun rustic-setup-rls ()
    "Start the rls client's process.
If client isn't installed, offer to install it."
    (unless noninteractive ;; TODO: fix tests to work with eglot/lsp-mode activated
      (let ((client-p (lambda (client)
                        (or (package-installed-p client)
                            (featurep client)
                            (require client))))
            (rls-pkg rustic-rls-pkg))
        (cond ((eq rls-pkg nil)
               nil)
              ((funcall client-p rls-pkg)
               (if (eq rls-pkg 'eglot)
                   (eglot-ensure)
                 ;; No!!!!!!!!!!!!!!!!!!!!!
                 ;; (lsp-workspace-folders-add (rustic-buffer-workspace))
                 (when (and (eq rustic-lsp-server 'rust-analyzer)
                            (not (featurep 'rustic-lsp)))
                   (require 'rustic-lsp))
                 (lsp)))
              (t
               (rustic-install-rls-client-p rls-pkg))))))

  (setq-default rustic-format-on-save nil)
  (setq-default lsp-rust-rls-command '("rustup" "run" "stable" "rls"))

  ;; (setq-default rust-rustfmt-bin "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt")
  (define-key company-active-map "\C-q" 'racer-describe)
  (define-key company-search-map "\C-q" 'racer-describe)
  (evil-define-key 'normal rustic-mode-map "\\r" 'lsp-rename)
  (evil-define-key 'insert rustic-mode-map "\C-j" 'my-rust-insert-ret)
  (evil-define-key 'insert rustic-mode-map "\C-m" 'my-rust-insert-ret)
  (evil-define-key 'insert rustic-mode-map "\C-q" 'racer-describe)
  (evil-define-key 'normal rustic-mode-map "\C-q" 'racer-describe)
  (evil-define-key 'normal rustic-mode-map "\C-]" 'racer-find-definition)
  (evil-define-key 'normal rustic-mode-map "\M-r" 'my-rust-run)
  (evil-define-key 'normal rustic-mode-map "\M-t" 'my-rust-test)
  (evil-define-key 'insert rustic-mode-map "," 'my-rust-insert-comma)
  (evil-define-key 'insert rustic-mode-map ":" 'my-rust-insert-colon)
  (evil-define-key 'insert rustic-mode-map ";" 'my-rust-insert-semicolon)
  (evil-define-key 'insert rustic-mode-map "=" 'my-rust-insert-equal)
  (evil-define-key 'insert rustic-mode-map "|" 'my-rust-insert-bar)
  (evil-define-key 'insert rustic-mode-map ">" 'my-rust-insert-gt)
  (evil-define-key 'insert rustic-mode-map "'" 'my-rust-insert-single-quote)
  (evil-define-key 'insert rustic-mode-map "\"" 'my-rust-insert-double-quote)
  (evil-define-key 'insert rustic-mode-map "{" 'my-rust-insert-curly-brace)
  (setq company-begin-commands (append '(my-rust-insert-colon
                                         my-rust-insert-equal
                                         my-rust-insert-bar
                                         my-rust-insert-curly-brace)
                                       company-begin-commands))
  )

;; (with-eval-after-load 'lsp-mode
;;   (setq lsp-rust-rls-command '("rustup" "run" "stable" "rls-preview"))
;;   (require 'lsp-rust))

(with-eval-after-load 'smartparens
  (require 'smartparens-rust))

(defun my-rust-init ()
  (interactive)
  (when (or (string-match ".*/.cargo/.*" (buffer-file-name))
            (string-match ".*.rustup/.*" (buffer-file-name))
            (string-match ".*/\\.ghq/.*" (buffer-file-name)))
    (read-only-mode 1))
  ;; (racer-mode 1)
  (smartparens-mode 1)
  (rainbow-delimiters-mode 1)
  (lsp)
  )

(add-hook 'rust-mode-hook 'rustic-mode)
(add-hook 'rustic-mode-hook 'my-rust-init)
