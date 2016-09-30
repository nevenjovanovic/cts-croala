let $doc := doc("/home/neven/rad/croala-r/croalactstextgroups.xml")
for $tg in $doc//*:textgroup
let $dirname := "/home/neven/rad/croalacts/data/" || substring-after($tg/@urn,'urn:cts:croala:')
return file:create-dir($dirname)