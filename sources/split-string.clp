(deffunction split-string (?string $?options)
  (bind ?max-split -1)
  (bind ?max-substring -1)
  (bind ?omit-empty TRUE)
  (bind ?separator nil)
  (bind ?separators nil)

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
      (case -omit-empty
       then (bind ?omit-empty (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (case -separator
       then (bind ?separator (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (case -separators
       then (bind ?separators (create$))
            (while (eq STRING
                       (type (bind ?s (nth$ (bind ?i (+ ?i 1)) ?options))))
              (bind ?separators ?separators ?s)))
      (default error)))

  (if (= ?max-substring 0)
   then (return (create$)))

  (if (= ?max-split 0)
   then (return (create$ ?string)))

  (if (and (eq nil ?separator)
           (eq nil ?separators))
   then (bind ?separators
          (create$ " " (format nil "%c" 9) (format nil "%c" 10))))

  (if (neq nil ?separator)
   then (bind ?i (str-index ?separator ?string))
   else (bind ?i (UNNAMED::index-substrings ?string ?separators)))

  (if (not ?i)
   then (create$ ?string)
   else (bind ?rest
          (split-string (sub-string (+ ?i (str-length ?separator))
                                    (str-length ?string)
                                    ?string)
                        -max-split (- ?max-split 1)
                        -max-substring (- ?max-substring 1)
                        -omit-empty ?omit-empty
                        -separator ?separator
                        -separators ?separators))
        (if (and ?omit-empty
                 (= ?i 1))
         then ?rest
         else (create$ (sub-string 1 (- ?i 1) ?string) ?rest))))
