(defun my-c-c++-insert-semicolon ()
  (interactive)
  (self-insert-command 1)
  (when (and (eolp)
             (not (or (nth 3 (syntax-ppss))
                      (nth 5 (syntax-ppss)))))
    (clang-format-buffer)))

(with-eval-after-load 'c++-mode
  (setq irony-additional-clang-options '("-std=c++17" "-Wall"))
  (evil-define-key 'normal c++-mode-map "\M-r" 'quickrun)
  (evil-define-key 'insert c++-mode-map "\M-r" 'quickrun)
  (evil-define-key 'insert c++-mode-map ";" 'my-c-c++-insert-semicolon))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-irony))

(defun my-c-c++-init-c++ ()
  (interactive)
  (irony-mode t)
  (flycheck-irony-setup))

(add-hook 'c++-mode-hook 'my-c-c++-init-c++)
