(deffunction join-strings (?strings $?options)
  (bind ?separator " ")

  (bind ?option-length (length$ ?options))
  (bind ?i 1)
  (while (<= ?i ?option-length)
    (switch (nth$ ?i ?options)
      (case -separator
       then (bind ?separator (nth$ (+ ?i 1) ?options))
            (bind ?i (+ ?i 2)))
      (default
        (UNNAMED::leave-message ERROR join-strings
                                "invalid option `%s'" (nth$ ?i ?options))
        (return))))

  (bind ?length (length$ ?strings))
  (switch ?length
    (case 0 then "")
    (case 1 then (nth$ 1 ?strings))
    (default (format nil
                     "%s%s%s"
                     (nth$ 1 ?strings)
                     ?separator
                     (join-strings (rest$ ?strings) -separator ?separator)))))
