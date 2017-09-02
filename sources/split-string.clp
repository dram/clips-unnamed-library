(deffunction split-string (?string $?options)
  (bind ?max-split -1)
  (bind ?max-substring -1)
  ;; FIXME: treat "" as separator to split on all kind of whitespaces
  (bind ?separator " ")

  (bind ?option-length (length$ ?options))
  (bind ?i 1)
  (while (<= ?i ?option-length)
    (switch (nth$ ?i ?options)
      (case -max-split
       then (bind ?max-split (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (case -max-substring
       then (bind ?max-substring (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (case -separator
       then (bind ?separator (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (default error)))

  (if (= ?max-substring 0)
   then (return (create$)))

  (if (= ?max-split 0)
   then (return (create$ ?string)))

  (bind ?i (str-index ?separator ?string))
  (if (not ?i)
   then (create$ ?string)
   else (create$ (sub-string 1 (- ?i 1) ?string)
                 (split-string (sub-string (+ ?i (str-length ?separator))
                                           (str-length ?string)
                                           ?string)
                                -max-split (- ?max-split 1)
                                -max-substring (- ?max-substring 1)
                                -separator ?separator))))