(defun my-latex-run ()
  (interactive)
  ;; (let ((TeX-save-query nil))
  ;;   (TeX-save-document (TeX-master-file)))
  ;; (TeX-command latex-build-command 'TeX-master-file -1)
  (async-shell-command "latexmk")
  )

(with-eval-after-load 'latex
  (setq auctex-latexmk-inherit-TeX-PDF-mode nil)
  (evil-define-key 'normal LaTeX-mode-map "\M-r" 'my-latex-run))
