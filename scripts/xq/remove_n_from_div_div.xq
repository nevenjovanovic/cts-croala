(: distinct-values( :)
for $paths in (
  "crije02/croala1844580/crije02.croala1844580.croala-lat1.xml",
"milecij01/croala1676024/milecij01.croala1676024.croala-lat1.xml",
"and02/croala507426/and02.croala507426.croala-lat1.xml",
"croala498219/croala498219/croala498219.croala498219.croala-lat1.xml",
"madij01/croala1919303/madij01.croala1919303.croala-lat1.xml",
"galopa01/croala1586332/galopa01.croala1586332.croala-lat1.xml",
"benes01/croala512580/benes01.croala512580.croala-lat1.xml"
)
let $doc := db:open("croala-cts-1", $paths)
(:
let $repl := 
<refsDecl n="CTS">
 <cRefPattern n="segment" matchPattern="(\w+)" replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/*[@n='$1'])">
          <p>This pointer pattern extracts @n value of segment.</p>
        </cRefPattern>
        </refsDecl>
:)
(: return delete node $doc//*:text/*:body/*:div/*:div/*[normalize-space()=""]/@n :)
(: return $doc//*:text/*:body/*:div[not(*:div[2])]/*[normalize-space()=""]/@n :)
(: return $doc//*:teiHeader/*:encodingDesc/* :)
(: 
for $div1 in $doc//*:text/*:body/*:div[not(*:div[2])]/*:div/@n
return $div1
:)
for $div1 in $doc//*:text/*:body/*:div/*:div/*[@n]
let $name := $div1/name()
(: where not($div1/../*[name()=$name and position()>=2])
(: return replace value of node $div1/@n with $name :) :)
(: let $one := ("opener1", "closer1") :)
let $new := substring-before($div1/@n, "1")
(: where $div1[not(following-sibling::*:p)] :)
(: return replace value of node $div1/@n with $new :)
(: return replace value of node $div1/@n with "p" :)
return $div1/@n