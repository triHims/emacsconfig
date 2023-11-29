;;Evil keybindings

;; 
(evil-set-leader nil (kbd "SPC"))
(evil-global-set-key 'normal (kbd "<leader>bb") 'ibuffer)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(evil-global-set-key 'normal (kbd "<leader>fr") 'ido-recentf-open)


(evil-define-key 'normal flymake-mode-map (kbd "[d") 'flymake-goto-prev-error)
(evil-define-key 'normal flymake-mode-map (kbd "]d") 'flymake-goto-next-error)
;; Eglot keybindings
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lr") 'eglot-rename)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>lF") 'eglot-format)


(evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-file)

(evil-define-key 'motion Buffer-menu-mode-map (kbd "<return>") 'Buffer-menu-view)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x K") 'kill-buffer-and-window)

;; Minibuffer file dired not work work properly
