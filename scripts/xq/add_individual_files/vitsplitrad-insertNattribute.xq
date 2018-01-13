declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $db := "ben_add";
for $f in db:open($db)//tei:TEI[tei:teiHeader[not(*:encodingDesc)]]/tei:text//*
let $n := $f/@n
let $name := $f/name()
let $name2 := $name||(count($f/preceding-sibling::*[name()=$name])+1)
return 
if ($n) 
then replace value of node $n with $name2 
else insert node attribute n {$name2} into $f

(: return replace value of node $n with $name2 :)
(: return if ($n) then $name2 else attribute n {$name2} :)