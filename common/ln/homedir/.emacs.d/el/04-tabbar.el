(global-tab-line-mode)
(tab-bar-mode 1)

(define-key evil-normal-state-map "\C-n" 'tab-line-switch-to-next-tab)
(define-key evil-normal-state-map "\C-p" 'tab-line-switch-to-prev-tab)
(define-key evil-insert-state-map "\M-z" 'tab-bar-close-tab)
(define-key evil-normal-state-map "\M-z" 'tab-bar-close-tab)

(set-face-attribute 'tab-bar-tab-inactive nil
                    :family (face-attribute 'default :family)
                    ;;:foreground (face-attribute 'mode-line-inactive :foreground)
                    ;;:background (face-attribute 'mode-line-inactive :background)
                    ;;:box nil
                    )
(set-face-attribute 'tab-bar-tab nil
                    :family (face-attribute 'default :family)
                    ;;:foreground (face-attribute 'mode-line :foreground)
                    ;;:background "#505050"
                    ;;:box nil
                    )
(set-face-attribute 'tab-line-tab-inactive nil
                    :family (face-attribute 'default :family)
                    ;;:foreground (face-attribute 'mode-line-inactive :foreground)
                    ;;:background (face-attribute 'mode-line-inactive :background)
                    ;;:box nil
                    )
(set-face-attribute 'tab-line-tab nil
                    :family (face-attribute 'default :family)
                    ;;:foreground (face-attribute 'mode-line :foreground)
                    ;;:background "#505050"
                    ;;:box nil
                    )

;;(defun my-tabbar-buffer-groups ()
;;  (list (cond ((string-match "magit\\(-[a-z]+\\)?: .*" (buffer-name)) "magit")
;;              ((eq major-mode 'dired-mode) "dired")
;;              ((member (buffer-name) '("*Messages*" "*Warnings*")) "message")
;;              ((string= (buffer-name) "*scratch*") "scratch")
;;              ((or (string-match "\\*.+" (buffer-name))
;;                   (string-match "intero:backend:.*" (buffer-name))) "emacs")
;;              (t "user"))))
;;
;;(with-eval-after-load 'tabbar
;;  (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
;;  (dolist (btn '(tabbar-buffer-home-button
;;                 tabbar-scroll-left-button
;;                 tabbar-scroll-right-button))
;;    (set btn (cons (cons "" nil)
;;                   (cons "" nil))))
;;  (set-face-attribute 'tabbar-default nil
;;                      :family (face-attribute 'default :family)
;;                      :foreground (face-attribute 'default :foreground)
;;                      :background (face-attribute 'default :background)
;;                      :height (face-attribute 'default :height)
;;                      :box "#808080")
;;  (set-face-attribute 'tabbar-unselected nil
;;                      :family (face-attribute 'default :family)
;;                      :foreground (face-attribute 'mode-line-inactive :foreground)
;;                      :background (face-attribute 'mode-line-inactive :background)
;;                      :box nil)
;;  (set-face-attribute 'tabbar-selected nil
;;                      :family (face-attribute 'default :family)
;;                      :foreground (face-attribute 'mode-line :foreground)
;;                      :background "#505050"
;;                      :box nil))
;;
;;(tabbar-mode 1)
