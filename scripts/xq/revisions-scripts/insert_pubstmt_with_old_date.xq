let $av := <publicationStmt>
            
               <publisher>
                  <orgName>
                     <ref type="viaf" target="124389134">Filozofski fakultet Sveučilišta u
                        Zagrebu</ref>
                  </orgName>
               </publisher>
               <pubPlace>
                  <placeName ref="3186886">Zagreb</placeName>
               </pubPlace>
               
               <availability>
                  <licence target="http://creativecommons.org/licenses/by/3.0/" notBefore="2017-12-25">
                     <p>The Creative Commons Attribution 3.0 Unported (CC BY 3.0) Licence applies to
                        this document.</p>
                     <p>The licence was added on March 19, 2018.</p>
                  </licence>
               </availability>
	        </publicationStmt>
for $p in //*:publicationStmt[not(*:availability)]
let $date := $p/*:p/*:date
let $newp := element publicationStmt { 
$av/*:publisher,
$av/*:pubPlace ,
$date ,
$av/*:availability }
return replace node $p with $newp