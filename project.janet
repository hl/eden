(declare-project
  :name "eden"
  :description "Digital garden for random notes."
  :dependencies ["https://github.com/pyrmont/markable"
                 "https://github.com/jeannekamikaze/janet-filesystem.git"]
  :author "Henricus Louwhoff"
  :license ""
  :url "https://henricuslouwhoff.com"
  :repo "https://sr.ht/~hlo/eden")

(declare-executable
  :name "eden"
  :entry "main.janet")
