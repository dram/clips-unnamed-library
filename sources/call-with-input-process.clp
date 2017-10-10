(deffunction call-with-input-process (?program
                                      ?arguments
                                      ?function
                                      ?rest-arguments)
  (UNNAMED::call-with-input-command (UNNAMED::make-command ?program ?arguments)
                                    ?function
                                    ?rest-arguments))
