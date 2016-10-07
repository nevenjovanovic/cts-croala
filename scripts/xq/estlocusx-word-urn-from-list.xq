let $csv2 := element csv {
for $entry in
for $e in
let $list := "/home/neven/rad/croala-pelagios/csv/c-nomina.csv"
let $w := file:read-text($list)
return csv:parse($w)
return $e//entry/string()
for $word in db:open("cp-tokenize")//*:w[.=$entry]
let $context := string-join(for $wpc in $word/../* return data($wpc), ' ')
let $n := $word/@n/string()
let $urn := replace(db:path($word), '.xml', '')
let $exclude := ("TEI", "text")
let $path := string-join(
  for $a in $word/ancestor::*[not(name()=$exclude)]/@n/string()
  return concat($a , "."))
return element entry { 
element loc { "estlocusX" },
$word ,
element con { $context } ,
element id { $urn || ":" || $path || $n }
 }
}
return file:write("/home/neven/rad/croala-pelagios/csv/bunic02.croala1761880-estlocusx.csv" , csv:serialize($csv2))