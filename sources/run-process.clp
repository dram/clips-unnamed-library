(deffunction run-process (?program ?arguments $?options)
  (bind ?in-file nil)
  (bind ?out-file nil)

  (bind ?option-length (length$ ?options))
  (bind ?i 1)
  (while (<= ?i ?option-length)
    (switch (nth$ ?i ?options)
      (case -input-from-file
       then (bind ?in-file (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (case -output-to-file
       then (bind ?out-file (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (default
        (UNNAMED::leave-message ERROR run-process
                                "invalid option `%s'" (nth$ ?i ?options))
        (return))))

  (bind ?command (create$ ?program))
  (foreach ?argument ?arguments
    (bind ?command
      ?command " " (UNNAMED::escape-shell-string ?argument)))

  (if (neq nil ?in-file)
   then (bind ?command ?command " <" (UNNAMED::escape-shell-string ?in-file)))
  (if (neq nil ?out-file)
   then (bind ?command ?command " >" (UNNAMED::escape-shell-string ?out-file)))

  (system (expand$ ?command)))
