(: covers 443 files :)
let $doc := doc("/home/neven/rad/croala-r/croalactstextgroups.xml")
for $tg in $doc//*:textgroup
let $authid := substring-after($tg/@urn,'urn:cts:croala:')
let $authid2 := "#" || $authid
let $dirname := "/home/neven/rad/croalacts/data/" || $authid
for $file in collection("croala-cts")//*:TEI[*:teiHeader/*:fileDesc/*:titleStmt/*:author[1][@ref=$authid or @ref=$authid2]]
let $workid := "croala" || db:node-id($file)
let $ctsfileid := $authid || "." || $workid || ".croala-lat1.xml"
return element text { attribute filename { db:path($file) }, attribute workid {$workid}, attribute ctsfile {$ctsfileid} }