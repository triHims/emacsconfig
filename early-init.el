;; (setenv "LIBRARY_PATH" "/usr/local/include:/usr/local/opt/gcc/lib/gcc/current:/usr/local/opt/libgccjit/lib/gcc/current:/usr/local/opt/gcc/lib/gcc/current/gcc/x86_64-apple-darwin21/12")

(defun my-append-env-var (var-name value)
  "Append VALUE to the beginning of current value of env variable VAR-NAME."
  (setenv var-name (if (getenv var-name)
                       (format "%s:%s" value (getenv var-name))
                     value)))

(let ((gccjitpath "/usr/local/include:/usr/local/opt/gcc/lib/gcc/current:/usr/local/opt/libgccjit/lib/gcc/current:/usr/local/opt/gcc/lib/gcc/current/gcc/x86_64-apple-darwin21/12:/usr/lib:/Library/Developer/CommandLineTools/SDKs/MacOSX12.1.sdk/usr/lib"))
  (mapc (lambda (var-name) (my-append-env-var var-name gccjitpath))
        '("LIBRARY_PATH" "LD_LIBRARY_PATH" "PATH")))
