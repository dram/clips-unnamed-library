(deffunction call-with-output-command (?command
                                       ?function
                                       ?rest-arguments)
  (bind ?f (gensym*))
  (UNNAMED-open-piped-command ?command ?f "w")
  (bind ?result (funcall ?function ?f (expand$ ?rest-arguments)))
  (UNNAMED-close-piped-command ?f)
  ?result)
