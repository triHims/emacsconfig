;;Emacs config path
(setq local-abs-config-path "~/.config/emacs/")
(setq local-abs-custom-utils "custom-utils/")
(setq local-abs-custom-packages "custom-packages/")
(setq local-java11-path "/Volumes/WORK/ProgramFiles/jdk-11.0.19+7/Contents/Home/bin/java")
(setq local-jdk11-path "/Volumes/WORK/ProgramFiles/jdk-11.0.19+7/Contents/Home/bin/")
(setq local-java8-path "/Volumes/WORK/ProgramFiles/amazon-corretto-8.jdk/Contents/Home/bin/java")
(setq local-jdk8-path "/Volumes/WORK/ProgramFiles/amazon-corretto-8.jdk/Contents/Home/bin/")


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

;;Load evil custom
(add-to-list 'load-path (concat local-abs-config-path local-abs-custom-packages "evil"))
(require 'evil)
(evil-select-search-module 'evil-search-module 'evil-search)
(setq evil-undo-system 'undo-redo)



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
 '(org-export-backends '(ascii html icalendar latex odt md))
 '(package-selected-packages
   '(pyvenv yasnippets to coverlay json-mode typescript-mode typescript tsx-mode tree-sitter-langs tree-sitter treemacs-evil treemacs magit evil-surround monokai-theme eglot yasnippet-snippets yasnippet corfu ido-vertical-mode use-package which-key evil))
 '(safe-local-variable-values
   '((eval setq-local exec-path
	   (cons _tempvenvPath exec-path))
     (eval setq-local process-environment
	   (cons
	    (concat "PATH=" _tempvenvPath ":"
		    (getenv "PATH"))
	    (copy-sequence process-environment)))
     (eval setq-local _tempvenvPath "/run/media/himanshu/New_Volume/Projects/Python/gig-enrich-data-apollo-storeleads/app/venv/bin"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Andale Mono")))))


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
(load (concat local-abs-config-path "keybindings.el"))

;;Load misc functions 

(load (concat local-abs-config-path "extra_functions.el"))



;;Recentf super charged
(require 'recentf)
;; enable recent files mode.
(recentf-mode t)
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

;;Enable narrow and widen C-x n n and C-x n w
(put 'narrow-to-region 'disabled nil)



;;Yes no everywhere
(defalias 'yes-or-no-p 'y-or-n-p)


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


;; yasnippets Config in lsp.el
;; eglot config , yasnippet config
(load (concat local-abs-config-path "lsp.el"))
(load (concat local-abs-config-path "flymake_settings.el") )
(load (concat local-abs-config-path "magit.el"))



(load (concat local-abs-config-path "hooks.el"))
(load (concat local-abs-config-path "flymake_settings.el"))
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
(defvar user-temporary-file-directory
  (concat --backup-directory "/" "temporary/"))
(if (not (file-exists-p user-temporary-file-directory))
        (make-directory user-temporary-file-directory t))

(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))     



(setq config-loaded-himanshu-text "Config has been loaded")







(load (concat local-abs-config-path "treemacs.el"))




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



;;Python use pylint with pyright for complete experience




;;Dired settings

(setq dired-kill-when-opening-new-dired-buffer t)
;;Groovy modes

(use-package groovy-mode
  :ensure t
)
;; set evil mode at last
(evil-mode 1)

;;Setup extra project markers
(use-package project
 :init
 (setq project-vc-extra-root-markers '(".dir-locals.el")))
