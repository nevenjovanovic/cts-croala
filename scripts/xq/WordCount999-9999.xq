for $node in db:open("croala-cts-1")/*:TEI/*:text
let $cts := $node/@xml:base
let $plaintext := tokenize(normalize-space(data($node)), '\s+')
let $wc := count($plaintext)
order by $wc descending
where 9999 > $wc and $wc > 999
return element tr {
  element td { $cts/string() } ,
  element td { $wc }
}