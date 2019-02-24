(: return names of empty elements:)
distinct-values(
let $list := ("emph")
for $e in collection("croala-cts-1")//*:text//*[not(*) and normalize-space(.)='']
(: where $e[name()=$list] :)
(: return db:path($e) :)
return $e/name()
)