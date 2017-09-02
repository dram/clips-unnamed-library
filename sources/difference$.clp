(deffunction difference$ (?set-1 ?set-2)
  (bind ?result (create$))
  (foreach ?value ?set-1
    (if (not (member$ ?value ?set-2))
     then (bind ?result ?result ?value)))
  ?result)
