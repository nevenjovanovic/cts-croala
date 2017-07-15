declare function local:path-to-node
  ( $nodes ) {
$nodes/string-join(ancestor-or-self::*[not(name()="TEI" or name()="text")]/@n, ".")
 } ;
 
 declare function local:urn-to-xpath($urn){
   "/*:" || string-join(
   for $node in tokenize($urn, "\.")
   let $name := if (matches($node, "[0-9]$")) then replace($node, "[0-9]+$", "") else $node
   let $position := if (matches($node, "[0-9]$")) then replace($node, "^[a-zA-Z]+", "") else "1"
   return ($name || "[" || $position || "]"),
   "/*:")
 };
let $urns :=
for $t in db:open("croala-cts-1","brlic01/croala835791/brlic01.croala835791.croala-lat1.xml")/*:TEI/*:text//*[not(.=text())]
 return local:path-to-node($t)
for $u in $urns
return local:urn-to-xpath($u)