;;Emacs config path
(setq local-abs-config-path "~/.config/emacs/")
(setq local-abs-custom-utils "custom-utils/")
(setq local-abs-custom-packages "custom-packages/")
(setq local-java11-path "/Volumes/WORK/ProgramFiles/jdk-11.0.22+7/Contents/Home/bin/java")
(setq local-jdk11-path "/Volumes/WORK/ProgramFiles/jdk-11.0.22+7/Contents/Home/bin/")
(setq local-java8-path "/Volumes/WORK/ProgramFiles/amazon-corretto-8.jdk/Contents/Home/bin/java")
(setq local-jdk8-path "/Volumes/WORK/ProgramFiles/amazon-corretto-8.jdk/Contents/Home/bin/")

;;Internal configs
;; Custom file for transient system settings
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)


;;Load os vars
(cond
 ((string-prefix-p "darwin" (symbol-name system-type)) (load (concat user-emacs-directory "darwin.el")))
 ((string-prefix-p "gnu" (symbol-name system-type)) (load (concat user-emacs-directory "linux.el")))
 )

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


;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
       ("elpa" . "https://elpa.gnu.org/packages/")
       ("melpa"        . "https://melpa.org/packages/")))

(setq package-archive-priorities
      '(("melpa-stable" . 10)
       ("elpa" . 5)
       ("melpa"        . 2))
      )
(package-initialize)

;; Download Evil
(unless (package-installed-p 'use-package)
  (package-refresh-contents t)
  (package-install 'use-package))

(use-package evil
  :ensure t
  :pin melpa
  )

(evil-select-search-module 'evil-search-module 'evil-search)
(setq evil-undo-system 'undo-redo)

(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.

(use-package goto-chg
  :ensure t)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))


(use-package evil-numbers
  :ensure t
  :bind
  (:map evil-normal-state-map
        ("C-c +" . evil-numbers/inc-at-pt)
        ("C-c -" . evil-numbers/dec-at-pt)))


(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode))


(use-package which-key
	     :ensure t
	     :init
	     (which-key-mode))
(use-package monokai-theme
	     :ensure t
	     :pin melpa
	     )




;;Enable recent files
(recentf-mode 1)

;; Save what you enter into minibuffer prompts
(setq history-length 25)
(savehist-mode 1)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Vertico: Minibuffer completion UI (replaces ido/fido)
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; Orderless: Powerful fuzzy matching
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil))

;; Optional: Annotate minibuffer choices
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))


;; Add consult
(use-package consult
  :ensure t
  :bind (("C-s"     . consult-line)           ;; Fuzzy buffer search
         ("M-y"     . consult-yank-pop)       ;; Kill ring with preview
         ("C-c r"   . consult-recent-file)    ;; Recent files
         ("C-c i"   . consult-imenu)          ;; Jump to symbol in buffer
         ("C-c g"   . consult-ripgrep)          ;; Project grep (requires ripgrep)
         ("C-x b"   . consult-buffer)        ;; Replaces switch-to-buffer
         ("C-c r"   . consult-recent-file)   ;; Recent files
	 )
  :config (setq consult-preview-key "M-.")
  )      



;; Disable emacs bell
(setq ring-bell-function 'ignore)

;;Load misc functions 

(load (concat local-abs-config-path "extra_functions.el"))

;;Load keys bindings (load functions first to set with keybindings)
(load (concat local-abs-config-path "keybindings.el"))




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
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))


;;Completion super charged
;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . hippie-expand))
  ;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol
        try-complete-lisp-symbol-partially))


;; yasnippets Config in lsp.el
;; eglot config , yasnippet config
(load (concat local-abs-config-path "lsp.el"))
(load (concat local-abs-config-path "flymake_settings.el") )
(load (concat local-abs-config-path "magit.el"))



(load (concat local-abs-config-path "hooks.el"))
(load (concat local-abs-config-path "flymake_settings.el"))

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
;; (use-package tree-sitter
;;   :ensure t
;;   :config
;;   ;; activate tree-sitter on any buffer containing code for which it has a parser available
;;   (global-tree-sitter-mode)
;;   ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
;;   ;; by switching on and off
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
;;   :hook ((typescript-mode . tree-sitter-hl-mode)
;; 	 (typescript-tsx-mode . tree-sitter-hl-mode)))

;; (use-package tree-sitter-langs
;;   :ensure t
;;   :after tree-sitter
;;   :config
;;   (tree-sitter-require 'tsx)
;;   (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx)))

(use-package json-mode
  :ensure t)







;;Dired settings

(setq dired-kill-when-opening-new-dired-buffer t)
(put 'dired-find-alternate-file 'disabled nil)
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



;; Org mode more settings

(use-package org-bullets
  :ensure t
  :after
  org
  :hook
  (org-mode . org-bullets-mode))
  

(setq org-adapt-indentation t)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "IN-PROGRESS(p@/!)" "|" "DONE(d!)" "CANCELED(c@)")))


;; For js install Prettier

(use-package prettier
  :ensure t
  )



(zen-mode-toggle)

;;line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)


;;Cider for clojure
(use-package cider
  :ensure t
  :pin melpa-stable
  )


;;Make native compilation silent and prune its cache

(when (native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent)
  (setq native-compile-prune-cache t))

(use-package clojure-snippets
  :ensure t
  :pin melpa-stable
  )

(use-package rainbow-delimiters
  :ensure t
  :hook prog-mode
  )

(use-package smartparens
  :ensure t
  :hook ((emacs-lisp-mode
        clojure-mode
        clojure-ts-mode
        lisp-mode
        scheme-mode
        fennel-mode
        racket-mode) . smartparens-mode)
  :config
  (require 'smartparens-config))

;; Use vterm
(use-package vterm
    :ensure t)

;; Treesitter
(use-package treesit-auto
  :ensure t
  :pin melpa
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Clojure TreeSitter
(use-package clojure-ts-mode
    :ensure t)


;; Pyenv python
(use-package pyenv-mode
  :ensure t
  :init
  (setq pyenv-mode-map
	(let ((map (make-sparse-keymap)))
	  map))
  :hook python-ts-mode python-mode
  :bind
  (:map python-ts-mode-map
	("C-c C-s" . pyenv-mode-set)
	("C-c C-u" . pyenv-mode-unset)))

;; Activate pyenv mode
(org-babel-do-load-languages
 'org-babel-load-languages '((python . t)))

;; GoLang
(use-package go-mode
    :ensure t)



;;ELLAMA

(use-package ellama
  :ensure t
  :bind ("C-c e" . ellama)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init
  ;; setup key bindings
  ;;(setopt ellama-keymap-prefix "SPC a")
  ;; language you want ellama to translate to
  (setopt ellama-language "English")
  ;; could be llm-openai for example
  (require 'llm-gemini)
  (setopt ellama-provider
  	  (make-llm-gemini
  	   ;; this model should be pulled to use it
  	   ;; value should be the same as you print in terminal during pull
	   :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
  	   :chat-model "gemini-2.5-pro"))
  (setopt ellama-summarization-provider
  	  (make-llm-gemini
	   :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
  	   :chat-model "gemini-2.0-flash"))
  (setopt ellama-coding-provider
  	  (make-llm-gemini
	   :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
  	   :chat-model "gemini-2.0-flash"))
  ;; Predefined llm providers for interactive switching.
  ;; You shouldn't add ollama providers here - it can be selected interactively
  ;; without it. It is just example.
  (setopt ellama-providers
	  '(("Gemini 2.5" . (make-llm-gemini
			     ;; this model should be pulled to use it
			     ;; value should be the same as you print in terminal during pull
			     :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
			     :chat-model "gemini-2.5-pro"))
	    ("Gemini Flash Lite" . (make-llm-gemini
				    :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
				    :chat-model "gemini-2.0-flash-lite"))
	    ("Gemini Flash" . (make-llm-gemini
			       :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
			       :chat-model "gemini-2.0-flash"))))
  ;; Naming new sessions with llm
  (setopt ellama-naming-provider
  	  (make-llm-gemini
			     ;; this model should be pulled to use it
			     ;; value should be the same as you print in terminal during pull
			     :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
			     :chat-model "gemini-2.5-pro-exp-03-25"))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  ;; Translation llm provider
  (setopt ellama-translation-provider
  	  (make-llm-gemini
				    :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
				    :chat-model "gemini-2.0-flash-lite"))
  (setopt ellama-extraction-provider (make-llm-gemini
				    :key (hims-read-short-keys "~/.local/tripathikeys/.geminikey")
				    :chat-model "gemini-2.0-flash-lite"))
  ;; customize display buffer behaviour
  ;; see ~(info "(elisp) Buffer Display Action Functions")~
  (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
  (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode +1)
  ;; show ellama session id in header line in all buffers
  (ellama-session-header-line-global-mode +1)
  ;; handle scrolling events
  (advice-add 'pixel-scroll-precision :before #'ellama-disable-scroll)
  (advice-add 'end-of-buffer :after #'ellama-enable-scroll))

;; Java - eglot

(use-package eglot-java
  :requires eglot
  :ensure t
  :hook (java-mode java-ts-mode)
  )



;; Disable pinch gestrue 
(global-set-key (kbd "<pinch>") 'ignore)


;;Tab bar mode
(add-to-list 'tab-bar-format #'tab-bar-format-menu-bar)
(tab-bar-mode t)

