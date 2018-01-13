(: count all words under text nodes :)
(: for a large collection, use the trick from https://stackoverflow.com/questions/6188189/count-the-number-of-words-in-a-xml-node-using-xsl :)
let $wordcount :=
for $t in db:open("croala-cts-1")//*:TEI/*:text
let $count := string-length(normalize-space($t))
-
     string-length(translate(normalize-space($t),' ','')) +1
return $count
return sum ($wordcount)