let $doc := doc("/home/neven/rad/croalacts/docs/croalactstextgroups-multi.xml")
for $tg in $doc//*:textgroup
let $dirname := "/home/neven/rad/croalacts/data/" || substring-after($tg/@urn,'urn:cts:croala:')
return file:write($dirname || "/__cts__.xml", $tg)