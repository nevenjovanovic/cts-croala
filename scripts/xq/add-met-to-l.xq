(: for an individual TEI XML file :)
(: for each div/l in document :)
(: add @met to all l elements :)
(: get @met value from parent div :)
(: keep existing @met :)
(: omit elegiacum, has to be solved as hex / pent :)
declare variable $teixml := "/home/neven/rad/croalacts/data/bunic02/croala1761880/bunic02.croala1761880.croala-lat1.xml";
copy $doc := doc($teixml)
modify ( for $d in $doc//*:text//*:div[@met[not(.="elegiacum")]]/*:l[not(@met)]
let $met := attribute met { $d/../@met/string() }
return insert node $met into $d )
return file:write($teixml , $doc)
(: return $doc :)