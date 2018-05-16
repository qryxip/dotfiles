(defun my-tabbar-buffer-groups ()
  (list (cond ((string-match "magit\\(-[a-z]+\\)?: .*" (buffer-name)) "magit")
              ((eq major-mode 'dired-mode) "dired")
	      ((string= major-mode "messages-buffer-mode") "message")
	      ((string= (buffer-name) "*scratch*") "scratch")
	      ((or (string-match "\\*.+" (buffer-name))
		   (string-match "intero:backend:.*" (buffer-name))) "emacs")
	      (t "user"))))

(with-eval-after-load 'tabbar
  (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
  (dolist (btn '(tabbar-buffer-home-button
		 tabbar-scroll-left-button
		 tabbar-scroll-right-button))
    (set btn (cons (cons "" nil)
		   (cons "" nil))))
  (set-face-attribute 'tabbar-default nil
		      :family (face-attribute 'default :family)
		      :foreground (face-attribute 'default :foreground)
		      :background (face-attribute 'default :background)
		      :height (face-attribute 'default :height)
		      :box "#808080")
  (set-face-attribute 'tabbar-unselected nil
		      :family (face-attribute 'default :family)
		      :foreground (face-attribute 'mode-line-inactive :foreground)
		      :background (face-attribute 'mode-line-inactive :background)
		      :box nil)
  (set-face-attribute 'tabbar-selected nil
		      :family (face-attribute 'default :family)
		      :foreground (face-attribute 'mode-line :foreground)
		      :background (face-attribute 'mode-line :background)
		      :box nil))

(tabbar-mode 1)
