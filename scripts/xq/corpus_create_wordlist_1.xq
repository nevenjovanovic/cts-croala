(: create a wordlist :)
(: process only the "Epistolarum" files :)
(: remove text from notes :)
(: remove numbers :)
(: treat capitals and accented letters as such :)
let $tokens :=
for $w in collection("vitsplitrad")//*:TEI[descendant::*:titleStmt/*:title[matches(., "Epistolarum")]]/*:text//text()[not(ancestor::*:note)]
let $text := normalize-space(string-join($w , " "))
return tokenize($text, '\W+')
let $list := 
for $t in distinct-values($tokens)
where not(matches($t, '[0-9 ]'))
order by $t
return $t
return $list