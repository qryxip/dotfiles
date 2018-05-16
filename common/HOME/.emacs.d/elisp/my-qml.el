(defun my-qml-init ()
  (interactive)
  (set (make-local-variable 'tab-width) 2))

(add-hook 'qml-mode-hook 'my-qml-init)
