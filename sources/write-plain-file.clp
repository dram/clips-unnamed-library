(deffunction write-plain-file (?path ?content)
  (UNNAMED::call-with-output-file ?path
                                  printout -rest-arguments ?content))
