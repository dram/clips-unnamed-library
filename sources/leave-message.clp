(deffunction leave-message (?level ?object ?format $?fields)
  (format stderr
          (str-cat "%s %s: " ?format "%n") ?level ?object (expand$ ?fields)))
