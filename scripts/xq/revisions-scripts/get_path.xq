let $nodnames :=
let $files :=
let $c :=
for $d in collection("croala-cts-1")/*:TEI/*:text[not(*:front) and not(*:back)]/*:body[not(*:div[*:div])]
return db:path($d)
return distinct-values($c)
for $f in $files
return db:open("croala-cts-1", $f)//*:body//*[parent::*:div or parent::*:body]/*/*/*/*/name()
return distinct-values($nodnames)