(tabbar-mode 1)

(defun my-tabbar/buffer-groups ()
  (list (cond ((or (string-match "\\*.+" (buffer-name))
                   (string-match "intero:backend:.*" (buffer-name))) "Emacs Buffer")
              ((eq major-mode 'dired-mode) "Dired Buffer")
              (t "User Buffer"))))

(setq tabbar-buffer-groups-function 'my-tabbar/buffer-groups)

(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

(set-face-attribute 'tabbar-default nil
                    :family (face-attribute 'default :family)
                    :background (face-attribute 'mode-line-inactive :background)
                    :height 1.0)

(set-face-attribute 'tabbar-unselected nil
                    :background (face-attribute 'mode-line-inactive :background)
                    :foreground (face-attribute 'mode-line-inactive :foreground)
                    :box nil)

(set-face-attribute 'tabbar-selected nil
                    :background (face-attribute 'mode-line :background)
                    :foreground (face-attribute 'mode-line :foreground)
                    :box nil)

