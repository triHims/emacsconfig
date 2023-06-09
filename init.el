;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/")
	     '("elpa" . "https://elpa.gnu.org/packages/")
	     )
(package-initialize)

;; Download Evil
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package evil
	     :ensure t
	     :init
	     (evil-mode 1)
	     (evil-select-search-module 'evil-search-module 'evil-search)
	     (setq evil-undo-system 'undo-redo)
	     )


(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))


(use-package which-key
	     :ensure t
	     :init
	     (which-key-mode))
(use-package monokai-theme
	     :ensure t
	     )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("9abe2b502db3ed511fea7ab84b62096ba15a3a71cdb106fd989afa179ff8ab8d" default))
 '(package-selected-packages
   '(coverlay json-mode typescript-mode typescript tsx-mode tree-sitter-langs tree-sitter treemacs-evil treemacs magit evil-surround monokai-theme eglot yasnippet-snippets yasnippet corfu ido-vertical-mode use-package which-key evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "UKWN" :family "Iosevka")))))


;;Enable recent files
(recentf-mode 1)

;; Save what you enter into minibuffer prompts
(setq history-length 25)
(savehist-mode 1)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)


;; Enable ido configs
(ido-mode 1)
(ido-everywhere 1)
(fido-mode 1)
(fido-vertical-mode 1)

(use-package ido-vertical-mode
	     :ensure t
	     :init
	     (ido-vertical-mode 1))
(setq ido-verticle-define-keys `C-n-and-C-p-only)

;; Disable emacs bell

(setq ring-bell-function 'ignore)

;;Load keys bindings
(load "~/.emacs.d/keybindings.el")

;;Load misc functions 

(load "~/.emacs.d/extra_functions.el")



;;Recentf super charged
(require 'recentf)
;; enable recent files mode.
(recentf-mode t)
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

;;Enable narrow and widen C-x n n and C-x n w
(put 'narrow-to-region 'disabled nil)



(use-package corfu
	     :ensure t
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu global.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :bind
  (:map corfu-map
	("C-n" . corfu-next)
	("C-p" . corfu-previous)
	("<escape>" . corfu-quit)
	("<return>" . corfu-insert)
	("M-d" . corfu-info-documentation)
	("M-l" . corfu-info-location)
	)
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  (setq read-extended-command-predicate
       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  ;;(setq tab-always-indent 'complete)
  )


;;Completion super charged
;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . hippie-expand))
  ;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))

;;This tweak makes corfu plugins have precendence over evil ,
;; Then we simply make triggers to normalize maps
(evil-make-overriding-map corfu-map)
(advice-add 'corfu--setup :after 'evil-normalize-keymaps)
(advice-add 'corfu--teardown :after 'evil-normalize-keymaps)


(load "~/.emacs.d/lsp.el")
(load "~/.emacs.d/flymake_settings.el")
(load "~/.emacs.d/magit.el")


;; Configure saves 
	
(defvar --backup-directory (concat user-emacs-directory ".backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )



(setq config-loaded-himanshu-text "Config has been loaded")







(load "~/.emacs.d/treemacs.el")




;;Typescript




(use-package typescript-mode
  :ensure t
  :init
  (define-derived-mode typescript-tsx-mode typescript-mode "tsx")
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode)
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-tsx-mode)))

;;Treesitter ; Add some typescript things to enable custom tsx mode
(use-package tree-sitter
  :ensure t
  :config
  ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (global-tree-sitter-mode)
  ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
  ;; by switching on and off
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  :hook ((typescript-mode . tree-sitter-hl-mode)
	 (typescript-tsx-mode . tree-sitter-hl-mode)))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter
  :config
  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx)))

(use-package json-mode
  :ensure t)

;;HideShow settings
(add-hook 'hs-minor-mode-hook (lambda ()
                               (setq hs-allow-nesting t)))



;;ProgMode hooks
(add-hook 'prog-mode-hook (lambda ()
			    (hs-minor-mode)
			    (eglot-ensure)))


;;Python use pylint with pyright for complete experience
