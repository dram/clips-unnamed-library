(deffunction read-binary-file (?path)
  (bind ?result "")
  (bind ?id (gensym*))
  (open ?path ?id)
  (while (neq (bind ?c (get-char ?id)) -1)
    (bind ?result (format nil "%s%c" ?result ?c)))
  (close ?id)
  ?result)
