(use-package satysfi
  :straight (:host github
             :repo "gfngfn/satysfi.el"))

(defun my-satysfi-init ()
  (interactive)
  (when (string-match ".*/\\.?satysfi/dist/packages/.*" (buffer-file-name))
    (read-only-mode 1))
  (rainbow-delimiters-mode 1))

(defun my-satysfi-run ()
  (interactive)
  (async-shell-command (concat "satysfi " (buffer-file-name)) "*satysfi command*"))

(add-to-list 'auto-mode-alist '("\\.satyh?\\'" . satysfi-mode))

(add-hook 'satysfi-mode-hook 'my-satysfi-init)

(with-eval-after-load 'satysfi
  (evil-define-key 'normal satysfi-mode-map "\M-r" 'my-satysfi-run))
