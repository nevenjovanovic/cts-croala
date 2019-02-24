for $d in collection("croala-cts-1")/*:TEI/*:text/*
return count($d/preceding-sibling::*) + 1