(: list all distinct xpaths in collection croala-cts-1 :)
(: exclude the root TEI node :)
(: report number of nodes in each xpath :)
(: report total number of distinct nodes :)
(: order by descending number of nodes :)
declare namespace functx = "http://www.functx.com";
declare function functx:path-to-node
  ( $nodes ) {
$nodes/string-join(ancestor-or-self::*[not(name()="TEI")]/name(.), '/')
 } ;
 
let $allpaths :=
  for $path in
    let $cr := collection("croala-cts-1")
    let $els := for $e in $cr/*:TEI/*:text//*
    order by $e
    return functx:path-to-node($e)
    return distinct-values($els)
  let $length := count(tokenize($path, "/"))
  order by $length descending
  return element xpath { 
          attribute pathlength {$length} , $path }
let $countpaths := count($allpaths)
return element rep {
        element count {$countpaths},
        element paths {$allpaths}
}