declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare function functx:path-to-node
  ( $nodes ) {
$nodes/string-join(ancestor-or-self::*[@n]/name(.), "/tei:")
 } ;

(: create matchpattern based on number of elements below TEI/text (this number of nodes is passed as $count) :)
(: called by local:makecref :)
declare function local:matchpattern($count){
let $sequence :=
for $c in 1 to $count
return "(\w+)"
return string-join($sequence, ".")
};

(: for all existing xpath combinations in document, add an index number based on XML level count, in descending order -- each descendant is represented by a smaller number   :)
(: called by local:getdistinctpaths :)
declare function local:nodecount($path){
(: $count is the maximum number of levels :)
let $count := count(tokenize($path, "/"))
let $sequence := 
  for $e at $pos in tokenize($path, "/")
  let $pp := "*[@n='$" || $pos || "']"
  return $pp
return string-join($sequence, "/")
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
(: commonpath = regex as common denominator of paths by levels :)
(: called by the main XQuery :)
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
(: change db name as necessary :)
(: insert the actual refsDecl node into encodingDesc :)
(: make sure that the collection has no refsDecl/@n="CTS" already :)
for $f in collection("croala-cts-1")//*:TEI/*:teiHeader
let $filename := db:path($f)
let $node := element refsDecl {
    attribute n { "CTS" },
    for $ppaths in distinct-values ( local:getdistinctpaths($filename) )
    return local:makecref($ppaths)
  }
return replace node $f//tei:encodingDesc/*:refsDecl[@n="CTS"] with $node
(: expression for testing :)
(: return $node :)