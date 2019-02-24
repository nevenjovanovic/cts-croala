let $f :=
for $d in collection("croala-cts-1")/*:TEI/*:text[not(*:front) and not(*:back) and not(*:text)]//*:p
return path($d)
return distinct-values($f)