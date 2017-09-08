(deffunction call-with-output-file (?path ?function $?options)
  (bind ?rest-arguments (create$))

  (bind ?option-length (length$ ?options))
  (bind ?i 1)
  (while (<= ?i ?option-length)
    (switch (nth$ ?i ?options)
      (case -rest-arguments
       then (bind ?i (+ ?i 1))
            (while (<= ?i ?option-length)
              (bind ?rest-arguments ?rest-arguments (nth$ ?i ?options))
              (bind ?i (+ ?i 1))))
      (default
        (UNNAMED::leave-message ERROR call-with-output-file
                                "invalid option `%s'" (nth$ ?i ?options))
        (return))))

  (bind ?f (gensym*))
  (open ?path ?f "w")
  (bind ?result (funcall ?function ?f (expand$ ?rest-arguments)))
  (close ?f)
  ?result)
