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
for $f in collection("vitsplitrad")//tei:TEI[tei:text[not(@xml:lang)]]
let $t := $f/tei:text
let $urn := attribute xml:base { "urn:cts:croala:" || replace(functx:substring-after-last(db:path($f),'/'), '\.xml', ':') }
let $lang := attribute xml:lang { "lat" }
(: return $urn :)
return insert node ($urn, $lang) into $t