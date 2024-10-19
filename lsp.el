;;Setup lsp and then work to the language
(defun enable-flymake-with-eglot ()
  "Enable flymake with eglot for linting"
  (setq eglot-stay-out-of '(flymake))
  )


;; To make your snippets do yas-new-snippet 
;; 0$ last place where your cursor ends up
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook ((org-mode prog-mode ) . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :defer t
  :after yasnippet)

(use-package eglot
  :ensure t
  :defer t
  :hook (python-mode . enable-flymake-with-eglot)
  :config
  (setq read-process-output-max (* 1024 1024))
  (setq eglot-connect-timeout 120) ;; settime to 2 mins
  (push :documentHighlightProvider eglot-ignored-server-capabilities)
  ;;Adding groovy server
  (add-to-list 'eglot-server-programs `(groovy-mode . ( ,local-java8-path "-jar"  ,(expand-file-name (concat local-abs-config-path local-abs-custom-utils "groovy-language-server/groovy-language-server-all.jar")))))
  (add-to-list 'eglot-server-programs '(clojure-ts-mode "clojure-lsp"))
  )

(setq-default eglot-workspace-configuration
                '((:pylsp . (:configurationSources ["flake8"] :plugins (:pycodestyle (:enabled nil) :mccabe (:enabled nil) :flake8 (:enabled t))))))

;; Eglot is started with prog-mode hook, see hooks.el
;; 

;;Python use pylint with pyright for complete experience
