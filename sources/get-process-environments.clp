(deffunction get-process-environments ()
  (bind ?result (create$))
  (bind ?f (gensym*))
  (open "/proc/self/environ" ?f)
  (bind ?environment "")
  (while (<> (bind ?c (get-char ?f)) -1)
    (if (= ?c 0)
     then (bind ?result ?result ?environment)
          (bind ?environment "")
     else (bind ?environment (format nil "%s%c" ?environment ?c))))
  (close ?f)
  ?result)
