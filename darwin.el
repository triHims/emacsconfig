(setq-local custom-path   '( "/Volumes/WORK/programfiles/bin" ) )

(type-of custom-path)
(setenv "PATH" (concat (getenv "PATH") ":" (string-join custom-path ":")))
(setq exec-path (append exec-path custom-path))




(setq org-directory "/Volumes/WORK/NOTES")
(setq org-default-notes-file (concat org-directory "/captured-notes.org"))
