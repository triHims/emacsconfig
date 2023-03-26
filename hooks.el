;;Prog mode , dabbrev sets everything as lowercase

(defun set-prog-mode-settings ()
  "Sets `dabbrev-case-fold-search' to 'case-fold-search."
  (setq dabbrev-case-replace nil)
  )

(add-hook 'python-mode-hook 'set-prog-mode-settings)
