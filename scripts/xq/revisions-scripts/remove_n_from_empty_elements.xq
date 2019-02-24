(: remove n attribute from empty elements:)
(: that way we will count only those with n :)
for $e in collection("croala-cts-1")//*:text//*[not(*) and normalize-space(.)='' and @n]
(: where $e[name()=$list] :)
return db:path($e)
(: return delete node $e/@n :)