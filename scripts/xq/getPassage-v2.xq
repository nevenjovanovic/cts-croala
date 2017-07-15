(: a rewrite of the getpassage function, using tokenizing of cts and edition :)

declare function local:tokenize-cts($cts) {
  tokenize(substring-after($cts, "http://croala.ffzg.unizg.hr/basex/cts/"), ":")
};

declare function local:tokenize-edition($edition){
  tokenize($edition, "\.")
};

declare function local:urn-to-xpath($urn){
   "*:" || string-join(
   for $node in tokenize($urn, "\.")
   let $name := if (matches($node, "[0-9]$")) then replace($node, "[0-9]+$", "") else $node
   let $position := if (matches($node, "[0-9]$")) then replace($node, "^[a-zA-Z]+", "") else "1"
   return ($name || "[" || $position || "]"),
   "/*:")
 };

declare function local:getpassage($ctsurn) {
  let $edition := local:tokenize-edition(
    local:tokenize-cts($ctsurn)[4])[1] || "/" ||
    local:tokenize-edition(
    local:tokenize-cts($ctsurn)[4])[2] || "/" ||
    local:tokenize-cts($ctsurn)[4] || ".xml"
  let $path := "/*:TEI/*:text/" || local:urn-to-xpath(local:tokenize-cts($ctsurn)[5])
  return xquery:eval($path , map { "" : db:open("croala-cts-1", $edition) } )
};

let $cts := "http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:crije02.croala292491.croala-lat1:body1.div1.div1.l7"
let $edition := "crije02.croala292491.croala-lat1"
return local:getpassage($cts)