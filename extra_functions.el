
(defun custom-apply-to-pairs (fn common lst)
  "Apply function FN to pairs of elements in LST."
  (if (null lst)
      nil
    (cons (funcall fn common (car lst) (cadr lst))
          (custom-apply-to-pairs fn common (cddr lst)))))

;;Deprecated
(defun pyrightconfig-write (virtualenv)
  "For python project use this function with pyright to detect virtualenv my making pyrightconfig.json"
  (interactive "DEnv: ")

  (let* (;; file-truename and tramp-file-local-name ensure that neither `~' nor
         ;; the Tramp prefix (e.g. "/ssh:my-host:") wind up in the final
         ;; absolute directory path.
         (venv-dir (tramp-file-local-name (file-truename virtualenv)))

         ;; Given something like /path/to/.venv/, this strips off the trailing `/'.
         (venv-file-name (directory-file-name venv-dir))

         ;; Naming convention for venvPath matches the field for
         ;; pyrightconfig.json.  `file-name-directory' gets us the parent path
         ;; (one above .venv).
         (venvPath (file-name-directory venv-file-name))

         ;; Grabs just the `.venv' off the end of the venv-file-name.
         (venv (file-name-base venv-file-name))

         ;; Eglot demands that `pyrightconfig.json' is in the project root
         ;; folder.
         (base-dir (vc-git-root default-directory))
         (out-file (expand-file-name "pyrightconfig.json" base-dir))

         ;; Finally, get a string with the JSON payload.
         (out-contents (json-encode (list :venvPath venvPath :venv venv))))

    ;; Emacs uses buffers for everything.  This creates a temp buffer, inserts
    ;; the JSON payload, then flushes that content to final `pyrightconfig.json'
    ;; location
    (with-temp-file out-file (insert out-contents))))









(global-set-key
 (kbd "C-<f6>")
 (lambda (arg) (interactive "P")
   (let ((separator (pcase arg
                      ('(4) "-")
                      (0 "/")
                      (_ ""))))
     (insert
      (format-time-string (concat "%Y" separator "%m" separator "%d"))))))

(global-set-key
 (kbd "C-S-<f6>")
 (lambda (arg) (interactive "P")
   (let ((separator (pcase arg
                      ('(4) "-")
                      (0 "/")
                      (_ ""))))
     (insert
      (format-time-string (concat "%Y" separator "%m" separator "%d" separator "%I" separator "%M" separator "%S" "%p"))))))



(defun zen-mode-toggle ()
  "Zen Mode Toggle"
  (interactive)
  (tool-bar-mode 'toggle)
  (menu-bar-mode 'toggle)
  (scroll-bar-mode 'toggle))

(defun find-dired-eager (filename)
  "Does find-dired recursive using current dir with fuzzy search of keyword"
  (interactive "MFuzzy file name - ")
  (let
      ((currentdir (file-name-directory buffer-file-name))
       (args (concat "-iname \"*" filename "*\"" )))
    (find-dired currentdir args)))



(defun grep-eager (keyword)
  "Does recursive grep with current dir"
  (interactive "Msearch word - ")
  (let*
      ((currentdir (file-name-directory buffer-file-name))
       (args (concat "find " currentdir " -type f -exec grep --color=auto -nH --null -e " keyword " \{\} +")))
    (grep-find args)))



(defun hims-read-file-as-string (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (buffer-string))
  )



(defun hims-read-short-keys (filename)
  (string-trim (hims-read-file-as-string filename))
  )

(defun sp-wrap-round ()
  "Wrap following sexp in round parentheses."
  (interactive)
  (sp-wrap-with-pair "("))

(defun sp-wrap-square ()
  "Wrap following sexp in square brackets."
  (interactive)
  (sp-wrap-with-pair "["))

(defun sp-wrap-curly ()
  "Wrap following sexp in curly braces."
  (interactive)
  (sp-wrap-with-pair "{"))
