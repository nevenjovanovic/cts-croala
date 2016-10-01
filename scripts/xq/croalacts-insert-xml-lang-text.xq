for $f in collection("croala-cts-1")//*:TEI
let $t := $f/*:text
let $lang := attribute xml:lang { "lat" }
return if ($t[not(@xml:lang)]) then insert node $lang into $t else()