(deffunction delete-duplicates$ (?values)
  (bind ?result (create$))
  (foreach ?value ?values
    (if (not (member$ ?value ?result))
     then (bind ?result ?result ?value)))
  ?result)
