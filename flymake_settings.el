;; code checking via flymake
;; set code checker here from "epylint", "pyflakes"
(setq python-flymake-command '("pylint"))

;;Packages

(use-package flymake-eslint
  :ensure t
  :config
  (setq flymake-eslint-defer-binary-check t)
  (setq flymake-eslint-prefer-json-diagnostics t)
  )
