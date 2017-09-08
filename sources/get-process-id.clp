(deffunction get-process-id ()
  (UNNAMED::call-with-input-file "/proc/self/stat" read-number))
