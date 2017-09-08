(deffunction load-clips-file (?path)
  (bind ?result (create$))
  (bind ?f (gensym*))
  (open ?path ?f)
  (while (neq (bind ?expression (read ?f)) EOF)
    (bind ?result ?result ?expression))
  (close ?f)
  ?result)
