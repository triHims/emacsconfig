;;Evil keybindings

(evil-set-leader nil (kbd "SPC"))
(evil-global-set-key 'normal (kbd "<leader>bb") 'ibuffer)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(evil-global-set-key 'normal (kbd "<leader>fr") 'ido-recentf-open)


(evil-define-key 'normal flymake-mode-map "[d" 'flymake-goto-prev-error)
(evil-define-key 'normal flymake-mode-map"]d" 'flymake-goto-next-error)
(evil-define-key 'normal eglot-mode-map "<leader>lr" 'elgot-rename)
