declare option output:method 'text';
let $json := element json {
  attribute type {"object"},
  element name { "croala"} ,
  element children {
    attribute type {"array"},
let $count := element idx {
  for $c in db:open("croala-cts-1")/*:TEI/*:text
  let $text := data($c)
  let $count := count(tokenize($text, '\s+'))
  where 100 >= $count
    return element doc { 
    element id { db:path($c) } , 
    element count { $count }
} }
for $cc in $count//doc
let $auth_id := substring-before($cc/id, '/')
group by $auth_id
return element _ {
  attribute type {"object" } , 
  element name { $auth_id },
  element children {
  attribute type {"array"},
  
  for $s in $cc 
  let $cts := replace(
    substring-after(
     substring-after($s/id, '/'),
     '/'), '.xml', '')
  return 
  element _ {
  attribute type {"object"},
   element name { $cts } , 
   element size { 
  attribute type {"number" } , $s/count/string() },
  element url {
    attribute type {"string"},
    "http://croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:" || $cts
  } } }
}
} } 
return json:serialize($json)