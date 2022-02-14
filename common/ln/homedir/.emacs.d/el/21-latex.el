(use-package reftex)
;; (straight-use-package 'auctex)
;; (use-package auctex-latexmk)
;; (use-package company-auctex)

(defun my-latex-run ()
  (interactive)
  ;; (let ((TeX-save-query nil))
  ;;   (TeX-save-document (TeX-master-file)))
  ;; (TeX-command latex-build-command 'TeX-master-file -1)
  (async-shell-command "latexmk")
  )

(with-eval-after-load 'reftex
  (setq auctex-latexmk-inherit-TeX-PDF-mode nil)
  (evil-define-key 'normal latex-mode-map "\M-r" 'my-latex-run)
  (evil-define-key 'normal LaTeX-mode-map "\M-r" 'my-latex-run))
