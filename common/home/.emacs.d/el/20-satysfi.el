(use-package satysfi
  :straight (:host github
             :repo "gfngfn/satysfi.el"))

(defun my-satysfi-run ()
  (interactive)
  (async-shell-command (concat "satysfi " (buffer-file-name)) "*satysfi command*"))

(add-to-list 'auto-mode-alist '("\\.saty\\'" . satysfi-mode))

(with-eval-after-load 'satysfi
  (evil-define-key 'normal satysfi-mode-map "\M-r" 'my-satysfi-run))
