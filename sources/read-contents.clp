(deffunction read-contents (?f)
  (bind ?result "")
  (while (neq (bind ?line (readline ?f)) EOF)
    (bind ?result (format nil "%s%s%n" ?result ?line)))
  ?result)
