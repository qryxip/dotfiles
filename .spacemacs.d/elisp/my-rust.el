(setq rust-format-on-save t)
(setq company-idle-delay nil)

(evil-define-key 'normal rust-mode-map "\C-]" 'racer-find-definition)
(evil-define-key 'normal rust-mode-map "\M-r" 'cargo-process-run)
(evil-define-key 'normal rust-mode-map "\M-t" 'cargo-process-test)

(define-key company-active-map "\C-q" 'racer-describe)
(define-key company-search-map "\C-q" 'racer-describe)
