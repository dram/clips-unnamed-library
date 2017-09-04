(deffunction clear-directory (?name)
  (system "/bin/rm -r " (UNNAMED::escape-shell-string ?name) "/*"))
