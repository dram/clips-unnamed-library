(deffunction call-with-output-process (?program
                                       ?arguments
                                       ?function
                                       ?rest-arguments)
  (bind ?f (gensym*))
  (UNNAMED-open-piped-process (UNNAMED::make-command ?program ?arguments)
                              ?f
                              "w")
  (bind ?result (funcall ?function ?f (expand$ ?rest-arguments)))
  (UNNAMED-close-piped-process ?f)
  ?result)
