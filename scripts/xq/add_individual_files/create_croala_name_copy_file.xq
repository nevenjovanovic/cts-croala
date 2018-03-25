let $ben_numbers := (
  "caboga01.croala2985887.croala-lat1"
)
let $path := "/home/neven/Documents/documents/latinisti/kaboga_e/data/"
for $file in file:list($path, xs:boolean('false'), "*.xml")
count $c
let $croalaid := $ben_numbers[$c]
let $newname := $croalaid || ".xml"
return file:copy($path || $file, $path || 'caboga01/' || $newname)