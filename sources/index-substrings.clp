(deffunction index-substrings (?string ?separators)
  (bind ?i FALSE)
  (foreach ?s ?separators
    (if (and (bind ?j (str-index ?s ?string))
             (or (not ?i) (< ?j ?i)))
     then (bind ?i ?j)))
  ?i)
