(: for each document in collection :)
(: find nodes with @n having text() siblings :)
(: report maximal depth of @n paths before such nodes :)
for $d in collection("croala-cts-1")//*:TEI
let $ancs :=
for $tn in $d/*:text//*[@n]
let $tsib := $tn[preceding-sibling::text()[normalize-space()!=""] or following-sibling::text()[normalize-space()!=""]]
let $anc := count($tn/ancestor::*[@n])
where $tsib
return $anc
let $refs := count($d//*:refsDecl[@n="CTS"]/*:cRefPattern)
return element doc {
  element n { db:path($d) } , 
  element textsib { min($ancs) }, 
  element ctslev {$refs }
}