;;Evil keybindings

;; 
(evil-set-leader nil (kbd "SPC"))
(evil-global-set-key 'normal (kbd "<leader>bb") 'ibuffer)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(evil-global-set-key 'normal (kbd "<leader>fr") 'ido-recentf-open)


(evil-define-key 'normal flymake-mode-map (kbd "[d") 'lsp-bridge-diagnostic-jump-prev)
(evil-define-key 'normal flymake-mode-map (kbd "]d") 'lsp-bridge-diagnostic-jump-next)
;; LSP keybindings
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>lr") 'lsp-bridge-rename)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>lF") 'lsp-bridge-code-format)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>la") 'lsp-bridge-code-action)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>ls") 'lsp-bridge-workspace-list-symbol-at-point)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>lS") 'lsp-bridge-workspace-list-symbol-at-point)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "gd") 'lsp-bridge-find-def)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "gD") 'lsp-bridge-find-impl)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "gr") 'lsp-bridge-find-references)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "K") 'lsp-bridge-popup-documentation)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>ld") 'lsp-bridge-diagnostic-list)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>gd") 'lsp-bridge-find-impl-other-window)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>gt") 'lsp-bridge-find-type-def)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "<leader>gT") 'lsp-bridge-find-type-def-other-window)

(evil-define-key 'insert lsp-bridge-mode-map (kbd "C-M-i") 'lsp-bridge-popup-complete-menu)

(evil-define-key 'normal lsp-bridge-mode-map (kbd "[d") 'lsp-bridge-diagnostic-jump-prev)
(evil-define-key 'normal lsp-bridge-mode-map (kbd "]d") 'lsp-bridge-diagnostic-jump-next)
(add-hook 'lsp-bridge-mode-hook #'evil-normalize-keymaps)

;; ACM Bindings
;;(define-key acm-mode-map (kbd "C-p") 'acm-select-prev) ; "K" was bound to magit-file-untrack.
;;(define-key acm-mode-map (kbd "C-n") 'acm-select-next) ; "K" was bound to magit-file-untrack.

(add-hook 'acm-mode-hook
          (lambda ()
	    (evil-define-key 'insert acm-mode-map (kbd "C-p") 'acm-select-prev)
            (evil-define-key 'insert acm-mode-map (kbd "C-n") 'acm-select-next)
     (define-key acm-mode-map (kbd "C-p") 'acm-select-prev)
     (define-key acm-mode-map (kbd "C-n") 'acm-select-next)))
(add-hook 'acm-mode-hook #'evil-normalize-keymaps)
;;If you use evil-define-key to define a key for a mode it is possible that they keymap will not be active
;; Use evil-normalize-keymaps to fix it


(evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-file)



(evil-define-key 'motion Buffer-menu-mode-map (kbd "<return>") 'Buffer-menu-view)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x K") 'kill-buffer-and-window)

;; Minibuffer file dired not work work properly


;;files and dir


(evil-global-set-key 'normal (kbd "<leader>ff") 'find-dired-eager)
(evil-global-set-key 'normal (kbd "<leader>fF") 'find-dired)
(evil-global-set-key 'normal (kbd "<leader>fg") 'grep-eager)
(evil-global-set-key 'normal (kbd "<leader>fG") 'grep-find)
