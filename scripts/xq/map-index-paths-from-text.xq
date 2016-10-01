declare namespace functx = "http://www.functx.com";
declare function functx:index-of-node
  ( $nodes ,
    $nodeToFind ) {

  for $seq in (1 to count($nodes))
  return $seq[$nodes[$seq] is $nodeToFind]
 } ;
declare function functx:path-to-node-with-pos
  ( $node ) {

string-join(
  for $ancestor in $node/ancestor-or-self::*[not(name()="TEI")]
  let $sibsOfSameName := $ancestor/../*[name() = name($ancestor)]
  return concat(name($ancestor),
   if (count($sibsOfSameName) <= 1)
   then ''
   else functx:index-of-node($sibsOfSameName,$ancestor))
 , '.')
 } ;
let $cr := collection("croala-cts-1")
for $e in $cr//*:TEI/*:text//*
let $n := functx:path-to-node-with-pos($e)
return if ($e/@n) then replace value of node $e/@n with $n
else insert node attribute n { $n } into $e