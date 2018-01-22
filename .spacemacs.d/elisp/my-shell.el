(evil-define-key 'normal shell-mode-map "q" 'evil-window-delete)
(setq sh-basic-offset 2
      sh-indentation 2)
(evil-set-initial-state 'shell-mode 'normal)
