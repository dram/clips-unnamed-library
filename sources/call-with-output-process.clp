(deffunction call-with-output-process (?program
                                       ?arguments
                                       ?function
                                       ?rest-arguments)
  (bind ?command ?program)
  (foreach ?argument ?arguments
    (bind ?command
      (str-cat ?command " " (UNNAMED::escape-shell-string ?argument))))

  (bind ?f (gensym*))
  (UNNAMED-open-piped-process ?command ?f "w")
  (bind ?result (funcall ?function ?f (expand$ ?rest-arguments)))
  (UNNAMED-close-piped-process ?f)
  ?result)
