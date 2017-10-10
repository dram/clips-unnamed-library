(deffunction call-with-output-process (?program
                                       ?arguments
                                       ?function
                                       ?rest-arguments)
  (UNNAMED::call-with-output-command (UNNAMED::make-command ?program
                                                            ?arguments)
                                     ?function
                                     ?rest-arguments))
