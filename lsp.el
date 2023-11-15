;;Setup lsp and then work to the language


;; To make your snippets do yas-new-snippet 
;; 0$ last place where your cursor ends up
(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :defer t
  :after yasnippet)


(add-to-list 'load-path (concat local-abs-config-path local-abs-custom-packages "lsp-bridge"))

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)
(setq lsp-bridge-user-multiserver-dir (concat local-abs-config-path "lsp-multiserver"))
(setq lsp-bridge-user-langserver-dir (concat local-abs-config-path "lsp-langserver"))
(global-lsp-bridge-mode)
(setq lsp-bridge-complete-manually t)
(setq acm-enable-tabnine nil)


;;(use-package eglot
  ;;:ensure t
  ;;:defer t
  ;;:hook (python-mode . enable-flymake-with-eglot)
  ;;:config
  ;;(setq read-process-output-max (* 1024 1024))
  ;;(push :documentHighlightProvider eglot-ignored-server-capabilities)
  ;;;;Adding groovy server
  ;;(add-to-list 'eglot-server-programs `(groovy-mode . ( ,local-java8-path "-jar"  ,(expand-file-name (concat local-abs-config-path local-abs-custom-utils "groovy-language-server/groovy-language-server-all.jar")))))
  ;;)
;;
;;(setq-default eglot-workspace-configuration
                ;;'((:pylsp . (:configurationSources ["flake8"] :plugins (:pycodestyle (:enabled nil) :mccabe (:enabled nil) :flake8 (:enabled t))))))
;;
;; Eglot is started with prog-mode hook, see hooks.el
;; 

;;Python use pylint with pyright for complete experience
