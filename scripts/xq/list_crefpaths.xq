declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare function functx:escape-for-regex
  ( $arg as xs:string? )  as xs:string {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;
declare function functx:substring-after-last
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string {

   replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
 } ;

declare function functx:path-to-node
  ( $nodes ) { 
  let $path :=
  for $n in $nodes/ancestor-or-self::*
  return if ($n/@n) then $n/name() || "@@"
  else $n/name()
  return "tei:" || string-join($path , "/tei:")
 } ;
 
declare function local:orderbycount($refsdecl){
  for $r in $refsdecl//*:cRefPattern
let $count := count(tokenize($r/@matchPattern, "."))
order by $count descending
return $r
};
 
 declare function local:getallpaths(){
   distinct-values(
for $node in collection("caboga-cts")//*:text//*[@n and not(preceding-sibling::text()[normalize-space()!=''] or following-sibling::text()[normalize-space()!='']) and normalize-space()!='' and name()!="body"]
let $path := functx:path-to-node($node)
return $path )
 };
 
 declare function local:makepattern($n){
   string-join(
   for $w in 1 to $n - 1
   return "(\w+)", ".")
 };
 
 declare function local:levelnames($tokenized){
   for $t in $tokenized
   return 
     functx:substring-after-last($t, "tei:")[not(matches(.,"[0-9]"))]
 };
 
 declare function local:makecref ($commonpath){
   let $steps := tokenize($commonpath, "\[@n='\$")
   let $names := local:levelnames($steps)
   let $pattern := count($steps)
   let $level := substring-before(
      substring-after(functx:substring-after-last($commonpath, "/"), "tei:"), "[")
   return
   element cRefPattern {
    attribute n { $level },
    attribute matchPattern { local:makepattern($pattern) },
    attribute replacementPattern { "#xpath(" || $commonpath || ")" },
    element p { "This pointer pattern extracts " || string-join($names, " and ") || "."}
  }
};
let $rd :=
element encodingDesc {
element refsDecl {
  attribute n {"CTS"} ,
let $refsdecl := element r {
let $sequence :=  local:getallpaths() 
for $s in $sequence
let $t :=
for $p at $pos in tokenize($s, "@@/")
let $pp := "[@n='$" || $pos || "']"
return $p || $pp
return local:makecref(replace(string-join($t, '/'), "@@", ""))
}
return local:orderbycount($refsdecl)
} }
return insert node $rd after collection("caboga-cts")//tei:TEI/tei:teiHeader/tei:fileDesc