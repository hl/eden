(import markable)
(import filesystem)


(defn- parse-note
  "parse note from markdown to html with templates"
  [note source target]
  (let [contents (filesystem/read-file note)
        file (->> note
                  (string/replace ".md" ".html")
                  (string/replace source target))
        body (markable/markdown->html body [:full-info-string :github-pre-lang :smart])
        header (filesystem/read-file "src/template/header.html")
        footer (filesystem/read-file "src/template/footer.html")]
    (filesystem/write-file file (string header body footer))))


(defn- handle-notes
  "handle all the notes in the source directory"
  [source target]
  (let [notes (filesystem/list-all-files source)]
    (map (fn [note] (parse-note note source target)) notes)))


(defn main
  "simple static site generator"
  [& args]
  (let [source (get args 1 "notes") target (get args 2 "docs")]
    (filesystem/remove-directories target)
    (let [notes (handle-notes source target)]
      (print "processed " (length notes) " notes (source: '" source "' target: '" target "')"))))
