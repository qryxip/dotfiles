(use-package tuareg
  :config (add-hook 'tuareg-mode-hook #'merlin-mode))
(use-package utop)
(use-package ocp-indent)
(use-package flycheck-ocaml)
(use-package merlin
  :init (setq-default merlin-error-after-save nil)
  :config (flycheck-ocaml-setup))

;; (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
;;   (when (and opam-share (file-directory-p opam-share))
;;     ;; Register Merlin
;;     (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
;;     (autoload 'merlin-mode "merlin" nil t nil)
;;     ;; Automatically start it in OCaml buffers
;;     (add-hook 'tuareg-mode-hook 'merlin-mode t)
;;     (add-hook 'caml-mode-hook 'merlin-mode t)
;;     ;; Use opam switch to lookup ocamlmerlin binary
;;     (setq merlin-command 'opam)))
