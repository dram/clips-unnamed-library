;;;
;;; BEGIN OF DATA TEMPLATE DEFINIATIONS
;;;

(deftemplate function
  (slot name (type SYMBOL))
  (multislot depends-on (type SYMBOL)))

(deftemplate has-dependent
  (slot name (type SYMBOL))
  (slot dependent (type SYMBOL)))

(deftemplate source
  (slot name (type SYMBOL))
  (slot content (type STRING)))

;;; END OF DATA TEMPLATES

;;;
;;; BEGIN OF DATA DEFINIATIONS
;;;

(defglobal ?*function-list* = (create$))

;;; END OF DATA

;;;
;;; BEGIN OF RULE DEFINIATIONS
;;;

(defrule start
 =>
  (foreach
      ?name ?*requested-functions*
    (assert (requested-function ?name))))

(defrule process-requested-functions
  (requested-function ?name)
 =>
  (bind ?filename (format nil "sources/%s.clp" ?name))
  (bind ?source "")
  (bind ?dependences (create$))

  (open ?filename file)
  (while (neq (bind ?line (readline file)) EOF)
    (bind ?source
      (format nil
              "%s%s%n"
              ?source
              (UNNAMED::replace-substring ?line "UNNAMED::" "")))

    (bind ?substring ?line)
    (while (neq "" ?substring)
      (if (bind ?i (str-index "UNNAMED::" ?substring))
       then (bind ?substring (sub-string (+ ?i (str-length "UNNAMED::"))
                                         (str-length ?substring)
                                         ?substring))
            (bind ?j (UNNAMED::index-substrings ?substring (create$ " " ")")))
            (if ?j
             then (bind ?j (- ?j 1))
             else (bind ?j (str-length ?substring)))
            (bind ?dependences
              ?dependences (string-to-field (sub-string 1 ?j ?substring)))
       else (bind ?substring ""))))
  (close file)
  (bind ?dependences (UNNAMED::delete-duplicates$ ?dependences))

  (assert (source (name ?name) (content ?source)))
  (assert (function (name ?name) (depends-on ?dependences)))

  (if (UNNAMED::emptyp ?dependences)
   then (assert (dependence-satisfied ?name))
   else (foreach
            ?dependence ?dependences
          (assert
            (requested-function ?dependence)
            (has-dependent (name ?dependence) (dependent ?name))))))

;;; Kahn's algorithm for topological sorting
;;; See: https://en.wikipedia.org/wiki/Topological_sorting
(defrule sort-functions
  (declare (salience -5010)) ; run after requested-function processing
  (dependence-satisfied ?name)
 =>
  (bind ?*function-list* ?*function-list* ?name))

(defrule sort-function-dependents
  (declare (salience -5020))
  (dependence-satisfied ?name)
  (has-dependent (name ?name) (dependent ?dependent))
  (function (name ?dependent) (depends-on $?dependent-dependences))
 =>
  (if (subsetp ?dependent-dependences ?*function-list*)
   then (assert (dependence-satisfied ?dependent))))

(defrule output-source-code
  (declare (salience -10000)) ; run after function list sorting
 =>
  (open ?*output-file-path* output "w")

  (printout output
            ";;; Generated by clips-unnamed-library:" crlf
            ";;;     compile-library " ?*output-file-path*)
  (foreach ?argument ?*requested-functions* (printout output " " ?argument))
  (printout output crlf)

  (foreach
      ?name (UNNAMED::delete-duplicates$ ?*function-list*)
    (format output "%n;;; BEGIN DEFINITION of %s%n%n" ?name)
    (do-for-fact ((?f source)) (eq ?f:name ?name)
      (printout output ?f:content))
    (format output "%n;;; END of %s%n%n" ?name))
  (close output))

;;; END OF RULES
