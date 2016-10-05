declare namespace functx = "http://www.functx.com";
declare function functx:substring-after-last
  ( $arg ,
    $delim ) {
   replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
 } ;
 declare function functx:escape-for-regex
  ( $arg ) {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;
(: for a @n value of type text.body.div1.p2.name3, return only the last component (name3) :)
(: change collection/db name as necessary :)
(: update all *[@n] nodes in the db :)
for $n in collection("refsDeclproba")//*:text//*/@n
let $newn := functx:substring-after-last($n, ".")
return replace value of node $n with $newn