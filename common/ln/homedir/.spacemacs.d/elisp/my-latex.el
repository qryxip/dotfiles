(with-eval-after-load 'latex
  (evil-define-key 'normal LaTeX-mode-map "\M-r" 'latex/build))

;(defun my-latex-build-single-notebook ()
;  (interactive)
;  (let ((name (buffer-name)))
;    (cond ((string-match "\\(\d+\D*\\)\\.tex" name)
;           (async-shell-command (concat "cd ../" (match-string 1 name) "-single "
;                                        "&& latexmk " (match-string 1 name) "-single.tex")))
;          (t
;           (latex/build)))))
