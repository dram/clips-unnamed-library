(deffunction strip-string (?string $?options)
  ;; TODO: Add support for striping custom characters
  (bind ?left-only FALSE)
  (bind ?right-only FALSE)

  (bind ?option-length (length$ ?options))
  (bind ?i 1)
  (while (<= ?i ?option-length)
    (switch (nth$ ?i ?options)
      (case -left-only
       then (bind ?left-only (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (case -right-only
       then (bind ?right-only (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (default
        (UNNAMED::leave-message ERROR strip-string
                                "invalid option `%s'" (nth$ ?i ?options))
        (return))))

  (bind ?i 1)
  (bind ?j (str-length ?string))

  (if (or ?left-only (not ?right-only))
   then (while (and (<= ?i ?j)
                    (UNNAMED::blankp (sub-string ?i ?i ?string)))
          (bind ?i (+ 1 ?i))))

  (if (or ?right-only (not ?left-only))
   then (while (and (>= ?j ?i)
                    (UNNAMED::blankp (sub-string ?j ?j ?string)))
          (bind ?j (- ?j 1))))

  (sub-string ?i ?j ?string))
