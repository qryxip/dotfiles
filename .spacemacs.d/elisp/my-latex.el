(defun my-latex/build-single-notebook ()
  (interactive)
  (let ((name (buffer-name)))
    (cond ((string-match "\\([0-9]+\\)\\.tex" name)
           (async-shell-command (concat "cd ../" (match-string 1 name) "-single "
                                        "&& latexmk " (match-string 1 name) "-single.tex")))
          (t
           (print "aaa")))))

(defun my-latex/init ()
  (interactive)
  ;; evil-define-key does not work.
  (define-key evil-normal-state-local-map "\M-r" 'my-latex/build-single-notebook))

(add-hook 'latex-mode-hook 'my-latex/init)
