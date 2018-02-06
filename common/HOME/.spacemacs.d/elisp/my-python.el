(defun my-python/init ()
  (interactive)
  (yapf-mode 1))

(setq python-fill-column 79)
(add-hook 'python-mode-hook 'my-python/init)
