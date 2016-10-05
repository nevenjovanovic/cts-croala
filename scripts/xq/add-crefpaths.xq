declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare function functx:path-to-node
  ( $nodes ) {
$nodes/string-join(ancestor-or-self::*[not(name()="TEI" or name()="text")]/name(.), "/tei:")
 } ;

(: create matchpattern based on number of elements :)
(: below TEI/text (= count) :)
declare function local:matchpattern($count){
let $sequence :=
for $c in 1 to $count
return "(.+)"
return string-join($sequence, ".")
};

(: return changing part of sequence :)
(: for xpath :)
declare function local:nodecount($path){
let $count := count(tokenize($path, "/"))
let $sequence := element c {
for $e at $pos in tokenize($path, "/")
let $pp := element n { element node { $e } , element pos { $pos } }
return $pp
}
let $sequence2 :=
for $s in $sequence//n
let $c2 := $count - xs:integer($s/pos/string()) + 1
return "*[@n='$" || $c2 || "']"
return string-join($sequence2, "/")
};

(: get distinct paths in the collection :)
(: below TEI/text :)
declare function local:getdistinctpaths($file){
  let $paths :=
  let $cr := db:open("croala-cts-1", $file)
    let $els := for $e in $cr/*:TEI/*:text//*
    return functx:path-to-node($e)
    return distinct-values($els)
    for $p in $paths
    let $length := count(tokenize($p, "/"))
    let $newpath := local:nodecount($p)
    order by $length descending
    return $newpath
  
};

(: create cRefPattern element and its children :)
(: commonpath = common denominator of paths by levels :)

declare function local:makecref ($commonpath){
  let $matchpattern := local:matchpattern(count(tokenize($commonpath,"/")))
  return
   element cRefPattern {
    attribute n { "segment" },
    attribute matchPattern { $matchpattern },
    attribute replacementPattern { "#xpath(/tei:TEI/tei:text/" || $commonpath || ")" },
    element p { "This pointer pattern extracts @n value of segment."}
  }
};

(: testing collection is refsDeclproba :)
(: change as necessary :)
(: insert the actual refsDecl node into encodingDesc :)
(: make sure that the collection has no refsDecl/@n="CTS" already :)
for $f in collection("refsDeclproba")//*:TEI/*:teiHeader
  let $filename := db:path($f)
  let $node := element refsDecl {
    attribute n { "CTS" },
    for $ppaths in distinct-values ( local:getdistinctpaths($filename) )
    return local:makecref($ppaths)
  }
return insert node $node into $f//tei:encodingDesc
(:return $node:)