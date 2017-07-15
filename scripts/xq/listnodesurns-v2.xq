(: produce a list of available CTS URNs :)
(: create them just-in-time :)

declare function local:path-to-node
  ( $nodes ) {
$nodes/string-join(ancestor-or-self::*[not(name()="TEI" or name()="text")]/@n, ".")
 } ;

declare function local:listnodesurns($editionurn){
  for $node in collection("croala-cts-1")//*:text[matches(@xml:base, $editionurn)]//*
  let $ctsurn := local:path-to-node($node)
  return element tr {
    element td {
      element a {
        attribute href {"http://croala.ffzg.unizg.hr/basex/cts/" || $editionurn || $ctsurn },
        $editionurn || $ctsurn
      }
    }
  }
};
let $urn := "urn:cts:croala:crije02.croala292491.croala-lat1:"
return local:listnodesurns($urn)