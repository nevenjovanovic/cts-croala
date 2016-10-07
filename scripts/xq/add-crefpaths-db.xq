declare default element namespace "http://www.tei-c.org/ns/1.0";
(: add crefpaths to an individual TEI XML file :)
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";

(: name of db here :)
declare variable $doc := "cp-tokenize";

declare function functx:path-to-node
  ( $nodes ) {
$nodes/string-join(ancestor-or-self::*[not(name()="TEI" or name()="text")]/name(.), "/tei:")
 } ;

(: create matchpattern based on number of elements :)
(: below TEI/text (= count) :)
declare function local:matchpattern($count){
let $sequence :=
for $c in 1 to $count
return "(\w+)"
return string-join($sequence, ".")
};

(: return changing part of sequence :)
(: for xpath :)
declare function local:nodecount($path){
let $count := count(tokenize($path, "/"))
let $sequence := 
for $e at $pos in tokenize($path, "/")
return "*[@n='$" || $pos || "']"
return string-join($sequence, "/")
};

(: get distinct paths in the collection :)
(: below TEI/text :)
declare function local:getdistinctpaths($file){
  let $paths :=
  let $cr := $file
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
let $target := collection($doc)
for $f in $target//*:TEI/*:teiHeader
  let $filename := db:path($target)
  let $node := element refsDecl {
    attribute n { "CTS" },
    for $ppaths in distinct-values ( local:getdistinctpaths($target) )
    return local:makecref($ppaths)
  }
return replace node $f//tei:encodingDesc/tei:refsDecl[@n="CTS"] with $node
(: return insert node $node into $f//tei:encodingDesc :)
(: return $node :)
