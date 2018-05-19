(defun my-elisp-insert-symbol-char ()
  (interactive)
  (when (and (not (= (point) (line-beginning-position)))
	     (member (preceding-char) (string-to-list "#'\")]"))
	     (not (nth 3 (syntax-ppss))))
    (insert " "))
  (self-insert-command 1))

(defun my-elisp-insert-single-quote ()
  (interactive)
  (unless (or (equal (point) (line-beginning-position))
	      (member (preceding-char) (string-to-list " #"))
              (nth 3 (syntax-ppss)))
    (insert " "))
  (insert "'"))

(defun my-elisp-insert-double-quote ()
  (interactive)
  (unless (or (equal (point) (line-beginning-position))
	      (= (preceding-char) (string-to-char " "))
              (nth 3 (syntax-ppss)))
    (insert " "))
  (self-insert-command 1))

(defun my-elisp-insert-bracket ()
  (interactive)
  (unless (or (equal (point) (line-beginning-position))
              (member (preceding-char) (string-to-list "' "))
              (nth 3 (syntax-ppss)))
    (insert " "))
  (self-insert-command 1))

(defun my-elisp-init ()
  (interactive)
  (rainbow-delimiters-mode-enable))

(add-hook 'emacs-lisp-mode-hook 'my-elisp-init)

(mapc (lambda (c) (evil-define-key 'insert emacs-lisp-mode-map (char-to-string c) 'my-elisp-insert-symbol-char))
      (string-to-list "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_+*=$/"))
(evil-define-key 'insert emacs-lisp-mode-map "'" 'my-elisp-insert-single-quote)
(evil-define-key 'insert emacs-lisp-mode-map "\"" 'my-elisp-insert-double-quote)
(evil-define-key 'insert emacs-lisp-mode-map "(" 'my-elisp-insert-bracket)
(setq company-begin-commands (append '(my-elisp-insert-symbol-char
				       my-elisp-insert-single-quote
				       my-elisp-insert-double-quote
				       my-elisp-insert-bracket)
				     company-begin-commands))
