(org-babel-do-load-languages 'org-babel-load-languages '((dot . t)))
(org-babel-do-load-languages 'org-babel-load-languages '((python . t)))
(setq org-confirm-babel-evaluate t)

(evil-define-key 'normal org-mode-map "\M-r" 'org-export-dispatch)
(sp-local-pair 'org-mode "(" ")")
(sp-local-pair 'org-mode "{" "}")
(sp-local-pair 'org-mode "$" "$")
