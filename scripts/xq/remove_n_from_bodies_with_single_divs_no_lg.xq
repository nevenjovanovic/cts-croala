(: retrieve simple documents - no front and back - with single divs; remove @n from their body :)
(: distinct-values( :)
for $d in //*:text[not(*:front) and not(*:back) and not(descendant::*:lg) and not(*:body/*:div[2]) and *:body/*:div/@type and *:body/*:div[not(@n) and not(*:div[*:div])]/*:div[not(*:div) and @n]]
(: /*:body/*:div/*[normalize-space()!=''] :)
(: where $d/*:body/*:closer :)
(: 
let $name := $d/name()
where not($d/preceding-sibling::*/name()=$name) and not($d/following-sibling::*/name()=$name)
return replace value of node $d/@n with $name
:)
let $repl := 
<refsDecl n="CTS">
 <cRefPattern n="segment" matchPattern="(\w+)" replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/*[@n='$1'])">
          <p>This pointer pattern extracts @n value of segment.</p>
        </cRefPattern>
        </refsDecl>
(:
let $ed := $d/../*:teiHeader/*:encodingDesc
where $ed[normalize-space()!=""]
return $ed
:)
return db:path($d)