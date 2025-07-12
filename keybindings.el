;;Evil keybindings

;; 
(evil-set-leader nil (kbd "SPC"))
(evil-global-set-key 'normal (kbd "<leader>bb") 'ibuffer)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(evil-global-set-key 'normal (kbd "<leader>oa") 'org-agenda)


(evil-define-key 'normal flymake-mode-map (kbd "[d") 'flymake-goto-prev-error)
(evil-define-key 'normal flymake-mode-map (kbd "]d") 'flymake-goto-next-error)

;; Eglot keybindings
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lr") 'eglot-rename)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lF") 'eglot-format)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>la") 'eglot-code-actions)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lh") 'eldoc)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lf") 'eglot-format-buffer)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lg") 'eglot-find-implementation)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>ld") 'xref-find-definitions)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lD") 'eglot-find-declaration)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lt") 'eglot-find-typeDefinition)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>li") 'eglot-find-implementation)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>ls") 'eglot-shutdown)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>ll") 'eglot-reconnect)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lR") 'eglot-reconnect)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lw") 'eglot-show-workspace-configuration)

;; Additional Eglot actions
(defun eglot-organize-imports ()
  "Organize imports using Eglot."
  (interactive)
  (eglot-code-actions nil nil "source.organizeImports" t))

(evil-define-key 'normal eglot-mode-map (kbd "<leader>lo") 'eglot-organize-imports)

(evil-define-key 'normal eglot-mode-map (kbd "<leader>le") 'flymake-show-buffer-diagnostics)



(evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-file)

(evil-define-key 'motion Buffer-menu-mode-map (kbd "<return>") 'Buffer-menu-view)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x K") 'kill-buffer-and-window)

;; Minibuffer file dired not work work properly


;;files and dir


(evil-global-set-key 'normal (kbd "<leader>fr") 'consult-recent-file)
(evil-global-set-key 'normal (kbd "<leader>ff") 'consult-find)
(evil-global-set-key 'normal (kbd "<leader>fp") 'consult-fd)
(evil-global-set-key 'normal (kbd "<leader>fF") 'find-dired)
(evil-global-set-key 'normal (kbd "<leader>fl") 'consult-locate)
(evil-global-set-key 'normal (kbd "<leader>fg") 'consult-ripgrep)
(evil-global-set-key 'normal (kbd "<leader>fG") 'consult-grep)




;; Eglot-java keybindings

(add-hook 'java-mode-hook 'eglot-java-mode)
(with-eval-after-load 'eglot-java
  (define-key eglot-java-mode-map (kbd "C-c l n") #'eglot-java-file-new)
  (define-key eglot-java-mode-map (kbd "C-c l x") #'eglot-java-run-main)
  (define-key eglot-java-mode-map (kbd "C-c l t") #'eglot-java-run-test)
  (define-key eglot-java-mode-map (kbd "C-c l N") #'eglot-java-project-new)
  (define-key eglot-java-mode-map (kbd "C-c l T") #'eglot-java-project-build-task)
  (define-key eglot-java-mode-map (kbd "C-c l R") #'eglot-java-project-build-refresh))



;; Lisp keybindings
(evil-define-key 'insert smartparens-mode-map
    (kbd "C-}") #'sp-forward-slurp-sexp
    (kbd "C-{") #'sp-forward-barf-sexp
    (kbd "C-)") #'sp-wrap-round
    (kbd "C-]") #'sp-wrap-square
    (kbd "C-\"") #'sp-wrap-doublequote
    (kbd "C-k") #'sp-kill-sexp
    (kbd "C-M-k") #'sp-backward-kill-sexp)
