for $f in db:open("caboga-cts")//*:TEI/*:text//*:div
let $n := $f/@n
let $name2 := count($f/preceding-sibling::*)+1
return 
if ($n) 
then replace value of node $n with $name2 
else insert node attribute n {$name2} into $f
(: return replace value of node $n with $name2 :)
(: return $name2 :)