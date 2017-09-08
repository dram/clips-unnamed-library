(deffunction clear-directory (?name)
  (UNNAMED::run-process find (create$ ?name ! -path ?name -exec rm -r {} +)))
