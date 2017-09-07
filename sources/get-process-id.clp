(deffunction get-process-id ()
  (bind ?id (gensym*))
  (open "/proc/self/stat" ?id)
  (bind ?result (read-number ?id))
  (close ?id)
  ?result)
