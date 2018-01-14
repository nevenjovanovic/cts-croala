declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare variable $dbname := "bart_add";
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
for $f in collection($dbname)//tei:TEI/tei:text[not(@xml:lang)]
let $urn := attribute xml:base { "urn:cts:croala:" || replace(functx:substring-after-last(db:path($f),'/'), '\.xml', ':') }
let $lang := attribute xml:lang { "lat" }
(: return $urn :)
return insert node ($urn, $lang) into $f
(: return ($urn, $lang) :)