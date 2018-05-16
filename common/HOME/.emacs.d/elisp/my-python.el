(with-eval-after-load 'python-mode
  (setq python-fill-column 79))

(defun my-python-init ()
  (interactive)
  (yapf-mode 1))

(add-hook 'python-mode-hook 'my-python/init)
