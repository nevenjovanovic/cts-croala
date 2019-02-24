(: exclude siblings of text nodes, empty nodes, and body :)
for $t in collection("caboga-cts")//*:text//*[not(preceding-sibling::text()[normalize-space()!=''] or following-sibling::text()[normalize-space()!='']) and normalize-space()!='' and name()!="body"]
(: prepare the sequence number of node - preceding nodes with the same name :)
let $name2 := $t/name() || count($t/preceding-sibling::*[name()=$t/name()])+1
(: get count of following siblings with the same name :)
let $name3 := count($t/following-sibling::*[name()=$t/name()])
(: get count of previous siblings with the same name :)
let $name4 := count($t/preceding-sibling::*[name()=$t/name()])
return if ($t[not(@n)]) then 
(: if there are no previous or following siblings with the same name :)
  if ($name3=0 and $name4=0) then insert node attribute n { $t/name() } into $t
  (: else, add count of previous siblings :)
  else insert node attribute n {$name2} into $t 
else ()
(: insert node attribute n {$name2} into $t :)