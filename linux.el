(setq-local JAVA_HOME "")
(setq-local custom-path   `( "/Volumes/WORK/programfiles/bin" "/Users/himanshutripathi/.local/bin" ,(concat JAVA_HOME "/bin") ) )  ;; Add any paths that you want programatically filled

(setq-local pathStr "/home/himanshu/.npm-packages/bin:/home/himanshu/.cargo/bin:/home/himanshu/.npm-packages/bin:/home/himanshu/.cargo/bin:/home/himanshu/.local/bin:/home/himanshu/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/home/himanshu/.composer/vendor/bin:/home/himanshu/.local/go/bin") ;; To make it easy run "echo $PATH" and paste output here


;; join and dedup various paths
;; Add them to emacs path
(setq-local final-emacs-path (delete-dups
 (append 
  exec-path
  (split-string (getenv "PATH") ":")
  (split-string pathStr ":")
  custom-path)
 ))
(setenv "PATH" (string-join final-emacs-path ":" ))
(setq exec-path final-emacs-path)

(setenv "JAVA_HOME" JAVA_HOME)



(setq org-directory "~/NOTES")
(setq org-default-notes-file (concat org-directory "/captured-notes.org"))
