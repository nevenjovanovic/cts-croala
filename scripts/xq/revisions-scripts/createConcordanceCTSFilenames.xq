(: create a concordance of file names and CTS codes :)
(: produce a CSV file :)
let $csv := element csv {
for $d in db:open("croala-cts-1")//*:TEI
let $cts := $d//*:text[@xml:base]/@xml:base/string()
let $filename := $d/*:teiHeader/*:fileDesc/@xml:id/string()
order by $filename
return element row {
  element cts { $cts },
  element file { $filename }
}
}
return csv:serialize($csv, map { 'header': true() })