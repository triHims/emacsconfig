;; Use pyvenv package for managing Python virtual environments
(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "~/.pyenv/versions")
  :hook (python-mode . my-python-mode-hook)
  :config

  ;; Custom Python mode hook
  (defun my-python-mode-hook ()
    ;; Locating the virtual environment file (.python-version) in the directory tree
    ;; and extracting its contents to use for setting up the virtual environment
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  ".python-version"))
           (venv (and root
                      (with-temp-buffer
                        (insert-file-contents
                         (expand-file-name ".python-version" root))
                        (string-trim (buffer-string))))))
      ;; If a virtual environment is found, enable pyvenv mode,
      ;; activate the virtual environment and restart lsp workspace
      (when venv
        (pyvenv-mode 1)
        (pyvenv-workon venv)
        (lsp-restart-workspace)))))
