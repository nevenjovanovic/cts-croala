declare namespace functx = "http://www.functx.com";
declare function functx:substring-before-last
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string {

   if (matches($arg, functx:escape-for-regex($delim)))
   then replace($arg,
            concat('^(.*)', functx:escape-for-regex($delim),'.*'),
            '$1')
   else ''
 } ;
 declare function functx:escape-for-regex
  ( $arg ) {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;
for $s in collection("croala-cts-1")//*:text/@xml:base
let $newurn := functx:substring-before-last($s/string(), ":")
return replace value of node $s with $newurn