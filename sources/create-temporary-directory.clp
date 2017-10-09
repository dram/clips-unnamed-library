(deffunction create-temporary-directory (?template)
  (UNNAMED::call-with-input-process
      mktemp (create$ -d ?template)
    readline (create$)))
