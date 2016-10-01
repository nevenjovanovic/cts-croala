(: covers remaining 41 multi-author files :)
let $doc := doc("/home/neven/rad/croalacts/docs/croalactstextgroups-multi.xml")
let $list := element list {
for $tg in $doc//*:textgroup
let $authid := substring-after($tg/@urn,'urn:cts:croala:')
let $node := substring-after($authid, "croala")
let $workid := $authid
let $ctsfileid := $authid || "." || $workid || ".croala-lat1.xml"
return element text { attribute filename { db:path(db:open-id("croala-cts", xs:integer($node))) }, attribute workid {$workid}, attribute ctsfile {$ctsfileid} }
}
return file:write("/home/neven/rad/croalacts/docs/croalactsconcordance-multi.xml", $list)