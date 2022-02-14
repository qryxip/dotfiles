(setq my-rust-packages '(cargo
                         racer
                         company
                         lsp-mode
                         flycheck
                         (flycheck-rust :toggle (configuration-layer/package-usedp 'flycheck))
                         ggtags
                         helm-gtags
                         rust-mode
                         toml-mode))

(defun my-rust/init-lsp-mode ()
  (use-package lsp-mode
    :defer t
    :config (require 'lsp-flycheck)))

(defun my-rust/init-cargo ()
  (use-package cargo :defer t))

(defun my-rust/post-init-flycheck ()
  (spacemacs/add-flycheck-hook 'rust-mode))

(defun my-rust/init-flycheck-rust ()
  (use-package flycheck-rust
    :defer t
    :init (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(defun my-rust/post-init-ggtags ()
  (add-hook 'rust-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

(defun my-rust/post-init-helm-gtags ()
  (spacemacs/helm-gtags-define-keys-for-mode 'rust-mode))

(defun my-rust/init-rust-mode ()
  (use-package rust-mode
    :defer t
    :config (progn
              (setq-default rust-enable-racer t)
              (setq-default rust-format-on-save t))))

(defun my-rust/init-toml-mode ()
  (use-package toml-mode
    :mode "/\\(Cargo.lock\\|\\.cargo/config\\)\\'")
    :init #'smartparens-mode-set-explicitly)

(defun my-rust/post-init-company ()
  (push 'company-capf company-backends-rust-mode)
  (spacemacs|add-company-hook rust-mode)
  (add-hook 'rust-mode-hook
            (lambda ()
              (setq-local company-tooltip-align-annotations t))))

(defun my-rust/post-init-smartparens ()
  (with-eval-after-load 'smartparens
    ;; Don't pair lifetime specifiers
    (sp-local-pair 'rust-mode "'" nil :actions nil)))

(defun my-rust/init-racer ()
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-copy-env "RUST_SRC_PATH"))

  (use-package racer
    :defer t
    :init (progn
            (spacemacs/add-to-hook 'rust-mode-hook '(racer-mode eldoc-mode))
            (spacemacs/declare-prefix-for-mode 'rust-mode "mg" "goto")
            (add-to-list 'spacemacs-jump-handlers-rust-mode 'racer-find-definition)
            (spacemacs/declare-prefix-for-mode 'rust-mode "mh" "help")
            (spacemacs/set-leader-keys-for-major-mode 'rust-mode
              "hh" 'spacemacs/racer-describe))
    :config (progn
              (spacemacs|hide-lighter racer-mode)
              (evilified-state-evilify-map racer-help-mode-map
                :mode racer-help-mode))))
