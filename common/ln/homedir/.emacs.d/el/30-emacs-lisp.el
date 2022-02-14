(defun my-emacs-lisp-init ()
  (interactive)
  (when (string-prefix-p (expand-file-name (concat user-emacs-directory "straight/repos")) (buffer-file-name))
    (read-only-mode 1))
  (rainbow-delimiters-mode 1))

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-init)
