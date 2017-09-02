(deffunction create-directory (?name)
  (UNNAMED::run-process "/bin/mkdir" (create$ -p ?name)))
