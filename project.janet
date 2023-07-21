(declare-project
  :name "eden"
  :description "Digital garden for random notes."
  :dependencies ["https://github.com/pyrmont/markable"
                 "https://github.com/jeannekamikaze/janet-filesystem.git"]
  :author "Henricus Louwhoff"
  :license "MIT"
  :url "https://henricus.dev"
  :repo "https://github.com/hl/eden")

(declare-executable
  :name "eden"
  :entry "main.janet")
