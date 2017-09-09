(deffunction write-formatted-file (?path ?format $?fields)
  (UNNAMED::call-with-output-file ?path format (create$ ?format ?fields)))
