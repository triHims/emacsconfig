;;Prog mode , dabbrev sets everything as lowercase

(defun set-prog-mode-settings ()
  "Sets `dabbrev-case-fold-search' to 'case-fold-search."
  (setq dabbrev-case-replace nil)
  )

;;HideShow settings
(add-hook 'hs-minor-mode-hook (lambda ()
                               (setq hs-allow-nesting t)))

(add-hook 'org-mode-hook (lambda ()
                               (require 'ox-md nil t)))



;;ProgMode hooks
(add-hook 'prog-mode-hook (lambda ()
			    (hs-minor-mode)
			    (eglot-ensure)
			    ))
