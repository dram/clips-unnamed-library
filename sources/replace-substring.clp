(deffunction replace-substring (?string ?pattern ?replacement)
  (bind ?i (str-index ?pattern ?string))
  (if (or (not ?i)
          (eq ?pattern ""))
   then ?string
   else (str-cat (sub-string 1 (- ?i 1) ?string)
                 ?replacement
                 (replace-substring (sub-string (+ ?i (str-length ?pattern))
                                                (str-length ?string)
                                                ?string)
                                    ?pattern
                                    ?replacement))))
