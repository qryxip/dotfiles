(setq c-c++-enable-clang-support t)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(setq irony-additional-clang-options '("-std=c++14" "-Wall"))

(irony-mode t)
(flycheck-irony-setup)
