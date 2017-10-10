(deffunction call-with-input-process (?program
                                      ?arguments
                                      ?function
                                      ?rest-arguments)
  (bind ?f (gensym*))
  (UNNAMED-open-piped-process (UNNAMED::make-command ?program ?arguments)
                              ?f
                              "r")
  (bind ?result (funcall ?function ?f (expand$ ?rest-arguments)))
  (UNNAMED-close-piped-process ?f)
  ?result)
