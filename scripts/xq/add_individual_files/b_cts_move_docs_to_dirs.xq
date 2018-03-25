let $path := "/home/neven/Documents/documents/latinisti/kaboga_e/data/caboga01"
let $vitlist := file:list($path, xs:boolean('false'), '*.xml')
for $v in $vitlist
where $v[starts-with(., "c")]
let $file := $v
let $address := tokenize($file, "\.")
return file:copy($path || '/' || $v , $path || '/' || $address[2] )