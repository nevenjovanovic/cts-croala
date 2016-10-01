let $doc := doc("/home/neven/rad/croalacts/docs/croalactstextgroups-multi.xml")
for $tg in $doc//*:textgroup
let $dirname := "/home/neven/rad/croalacts/data/" || substring-after($tg/@urn,'urn:cts:croala:')
return try { file:create-dir($dirname) } catch * {
  'Error [' || $err:code || ']: ' || $err:description
}