(import markable)
(import filesystem)

(defn- read-template
  "reads the contents of a template"
  [filename]
  (filesystem/read-file (string "src/template/" filename ".html")))

(defn- parse-template
  "parse template with frontmatter"
  [template frontmatter]
  (reduce (fn [acc el]
            (string/replace
              (string "{{" (get el 0) "}}")
              (get el 1) acc))
          template
          (pairs frontmatter)))

(defn- parse-note
  "parse note from markdown to html with templates"
  [note source target]
  (let [contents (filesystem/read-file note)
        @[_ data body] (string/split "---" contents 0 3)
        frontmatter (parse data)
        file (->> note
                  (string/replace ".md" ".html")
                  (string/replace source target))
        body (markable/markdown->html body [:full-info-string :github-pre-lang :smart])
        header (-> "header"
                   read-template
                   (parse-template frontmatter))
        footer (-> "footer"
                   read-template
                   (parse-template frontmatter))]
    (filesystem/write-file file (string header body footer))))

(defn- handle-notes
  "handle all the notes in the source directory"
  [source target]
  (let [notes (filesystem/list-all-files source)]
    (map (fn [note] (parse-note note source target)) notes)))

(defn main
  "simple static site generator"
  [& args]
  (let [source (get args 1 "notes") target (get args 2 "dist")]
    (filesystem/remove-directories target)
    (let [notes (handle-notes source target)]
      (print "processed " (length notes) " notes (source: '" source "' target: '" target "')"))))
