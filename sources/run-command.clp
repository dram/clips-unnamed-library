(deffunction run-command ($?commands)
  (system (UNNAMED::join-strings ?commands -separator " | ")))
