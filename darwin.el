(setq-local JAVA_HOME "/Volumes/WORK/ProgramFiles/jdk-21.0.3+9/Contents/Home")
(setq-local custom-path   `( "/Volumes/WORK/programfiles/bin" "/Users/himanshutripathi/.local/bin" ,(concat JAVA_HOME "/bin") ) )  ;; Add any paths that you want programatically filled

(setq-local pathStr "/Users/himanshutripathi/.pyenv/plugins/pyenv-virtualenv/shims:/Users/himanshutripathi/.pyenv/shims:/Users/himanshutripathi/.pyenv/bin:/Users/himanshutripathi/.local/bin/nvm-installs/versions/node/v18.20.3/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/local/bin:/opt/local/sbin:/Applications/iTerm.app/Contents/Resources/utilities:/Volumes/WORK/programfiles/bin:/Users/himanshutripathi/.local/bin") ;; To make it easy run "echo $PATH" and paste output here


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



(setq org-directory "~/Dropbox/NOTES")
(setq org-default-notes-file (concat org-directory "~/Dropbox/NOTES/captured-notes.org"))
