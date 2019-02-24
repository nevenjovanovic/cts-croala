let $vitlist := (
  "caboga01.croala2985887.croala-lat1.xml"
)
for $v in $vitlist 
let $dname := tokenize($v, "\.")
return file:create-dir('/home/neven/Documents/documents/latinisti/kaboga_e/data/' || $dname[1] || "/" || $dname[2])