let $list := ("front", "back")
for $f in db:open("caboga-cts")//*:TEI/*:text/*[name()=$list]
let $n := $f/@n
let $name2 := $f/name()
return if ($n) 
then replace value of node $n with $name2 
else insert node attribute n {$name2} into $f