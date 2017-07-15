for $f in db:open("croala-cts-1")//*:TEI/*:text//*
let $n := $f/@n
let $name := $f/name()
let $name2 := $name||(count($f/preceding-sibling::*[name()=$name])+1)
(: return if ($n) then replace value of node $n with $name2 else insert node attribute n {$name2} into $f :)
return replace value of node $n with $name2