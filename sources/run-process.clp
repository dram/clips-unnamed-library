(deffunction run-process (?program ?arguments $?options)
  (system (UNNAMED::make-command ?program ?arguments (expand$ ?options))))
