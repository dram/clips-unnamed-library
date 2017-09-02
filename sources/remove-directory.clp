(deffunction remove-directory (?name)
  (UNNAMED::run-process "/bin/rm" (create$ -r ?name)))
