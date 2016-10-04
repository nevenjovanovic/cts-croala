declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare function functx:path-to-node
  ( $nodes ) {
$nodes/string-join(ancestor-or-self::*/name(.), '/tei:')
 } ;


declare function local:getdistinctpaths($file){
  let $paths :=
  let $cr := db:open("croala-cts-1", $file)
    let $els := for $e in $cr/*:TEI/*:text//*
    return functx:path-to-node($e)
    return distinct-values($els)
    for $p in $paths
    let $length := count(tokenize($p, "/"))
    order by $length descending
    return element cRefPattern {
    attribute n { "segment" },
    attribute matchPattern {"([a-z0-9.]+)"},
    attribute replacementPattern { "#xpath(/tei:" || $p || "[@n='$1'])" },
    element p { "This pointer pattern extracts @n value of segment."}
  }
};


for $f in collection("refsDeclproba")//*:TEI/*:teiHeader
  let $filename := db:path($f)
  let $node := element refsDecl {
    attribute n { "CTS" },
    local:getdistinctpaths($filename)
  }
  return insert node $node into $f//tei:encodingDesc
