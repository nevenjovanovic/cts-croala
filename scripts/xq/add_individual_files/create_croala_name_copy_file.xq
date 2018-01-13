let $ben_numbers := (
  "croala8033200.croala-lat1",
"croala8750797.croala-lat1",
"croala8775069.croala-lat1",
"croala6739337.croala-lat1",
"croala5095251.croala-lat1",
"croala7115623.croala-lat1",
"croala8221897.croala-lat1",
"croala6197596.croala-lat1"
)
let $path := "/home/neven/Documents/documents/latinisti/benesa/gotovo/"
for $file in file:list($path, xs:boolean('false'), "*.xml")
count $c
let $croalaid := $ben_numbers[$c]
let $newname := replace($file, '_croala', "_" || $croalaid)
return file:copy($path || $file, $path || 'benes01/' || $newname)