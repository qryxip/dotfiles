(defun my-c-c++-init-c++ ()
  (interactive)
  (setq c-c++-enable-clang-support t)
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony))

  (setq irony-additional-clang-options '("-std=c++14" "-Wall"))
  (irony-mode t)
  (flycheck-irony-setup)
  (my-c-c++--setup-keymap))

(defun my-c-c++-run ()
  (interactive)
  (let ((file-path (buffer-file-name)))
    (cond ((string-match (format "^.*/%s/\\(.+\\)\\.cc$" my-c-c++--snowchains-project) file-path)
           (let ((buffer (get-buffer "*snowchains*")))
             (when buffer
               (with-current-buffer buffer
                 (erase-buffer))))
           (let ((problem-name (match-string 1 file-path)))
             (term-run "snowchains" "*snowchains*" "judge" problem-name)))
          (t
           (quickrun)))))

(defun my-c-c++-insert-semicolon ()
  (interactive)
  (self-insert-command 1)
  (when (and (eolp)
             (not (or (nth 3 (syntax-ppss))
                      (nth 5 (syntax-ppss)))))
    (clang-format-buffer)))

(defun my-c-c++--setup-keymap ()
  (interactive)
  (evil-define-key 'normal c++-mode-map "\M-r" 'my-c-c++-run)
  (evil-define-key 'insert c++-mode-map "\M-r" 'my-c-c++-run)
  (evil-define-key 'insert c++-mode-map ";" 'my-c-c++-insert-semicolon))

(defconst my-c-c++--snowchains-project "contest/cc")

(add-hook 'c++-mode-hook 'my-c-c++-init-c++)
