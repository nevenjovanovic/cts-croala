(: find divs which don't have p or l children :)
distinct-values(
let $n := collection("croala-cts-1")//*:div[not(*:div) and not(*:p) and not(*:l)]
return $n/*/name()
)