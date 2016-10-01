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
for $f in collection("croala-cts-1")//*:TEI
let $t := $f/*:text
let $urn := attribute xml:base { "urn:cts:croala:" || replace(functx:substring-after-last(db:path($f),'/'), '\.xml', ':') }
return insert node $urn into $t