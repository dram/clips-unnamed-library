(deffunction write-formatted-file (?path ?format $?fields)
  (UNNAMED::call-with-output-file ?path
                                  format -rest-arguments ?format ?fields))
