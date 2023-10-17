;;Prog mode , dabbrev sets everything as lowercase

(defun set-prog-mode-settings ()
  "Sets `dabbrev-case-fold-search' to 'case-fold-search."
  (setq dabbrev-case-replace nil)
  )

;;(defun enable-flymake-with-eglot ()
  ;;"Enable flymake with eglot for linting"
  ;;(setq eglot-stay-out-of '(flymake))
  ;;(add-hook 'eglot--managed-mode-hook (lambda () (add-hook 'flymake-diagnostic-functions 'eglot-flymake-backend)))
  ;;)
(add-hook 'python-mode-hook 'set-prog-mode-settings)




;;HideShow settings
(add-hook 'hs-minor-mode-hook (lambda ()
                               (setq hs-allow-nesting t)))




;;ProgMode hooks
(add-hook 'prog-mode-hook (lambda ()
			    (hs-minor-mode)
			    ))
