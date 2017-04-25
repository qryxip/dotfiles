(defun my-python/init ()
  (interactive)
  (yapf-mode 1))

(setq python-enable-yapf-format-on-save t)

(add-hook 'python-mode-hook 'my-python/init)
