(setq-local JAVA_HOME "/Volumes/WORK/ProgramFiles/jdk-17.0.7+7/Contents/Home")
(setq-local custom-path   `( "/Volumes/WORK/programfiles/bin" "/Users/himanshutripathi/.local/bin" ,(concat JAVA_HOME "/bin") ) )

(setenv "PATH" (concat (getenv "PATH") ":" (string-join custom-path ":")))
(setq exec-path (append exec-path custom-path))

(setenv "JAVA_HOME" JAVA_HOME)



(setq org-directory "/Volumes/WORK/NOTES")
(setq org-default-notes-file (concat org-directory "/captured-notes.org"))



(setq-default lsp-bridge-python-command "/Users/himanshutripathi/.pyenv/versions/lsp-bridge/bin/python")
