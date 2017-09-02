(deffunction escape-shell-string (?string)
  (str-cat "'" (UNNAMED::replace-substring ?string "'" "'\"'\"'") "'"))
