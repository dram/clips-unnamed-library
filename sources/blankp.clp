(deffunction blankp (?string)
  (loop-for-count (?i (str-length ?string))
    (bind ?c (sub-string ?i ?i ?string))
    (if (not (or (eq ?c " ")
                 (eq ?c "	")
                 (eq ?c "")
                 (eq ?c "
")))
     then (return FALSE)))
  (return TRUE))
