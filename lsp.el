;;Setup lsp and then work to the language


(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :defer t
  :after yasnippet)

(use-package eglot
  :ensure t
  :defer t
  :config
  (setq read-process-output-max (* 1024 1024))
  (push :documentHighlightProvider eglot-ignored-server-capabilities)
  ;;Adding groovy server
  (add-to-list 'eglot-server-programs `(groovy-mode . ( ,local-java8-path "-jar"  ,(expand-file-name (concat local-abs-config-path local-abs-custom-utils "groovy-language-server/groovy-language-server-all.jar")))))
  )

;; 
