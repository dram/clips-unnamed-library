(defmodule UNNAMED
  (export deffunction ?ALL))

(load* sources/delete-duplicates$.clp)
(load* sources/empty$.clp)
(load* sources/index-substrings.clp)
(load* sources/replace-substring.clp)

(defmodule MAIN)

(if (load* tools/compile.clp)
 then
   (watch facts)
   (reset)
   (run))

(exit)
