(deffunction clear-directory (?name)
  (system "/bin/rm -r "
          (format nil "%s/*" (UNNAMED::escape-shell-string ?name))))
