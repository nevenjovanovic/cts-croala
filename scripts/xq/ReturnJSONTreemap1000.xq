declare option output:method 'text';
let $json := element json {
  attribute type {"object"},
  element name { "croala"} ,
  element children {
    attribute type {"array"},
let $count := element idx {
  for $c in db:open("croala-cts-1")/*:TEI/*:text
let $text := data($c)
return element doc { 
element id { db:path($c) } , 
element count { count(tokenize($text, '\s+')) }
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
  where xs:int($s/count/string()) <= 1000
  return 
  element _ {
  attribute type {"object"},
   element name { $auth_id } , element size { 
  attribute type {"number" } , $s/count/string() } } }
}
} } 
return json:serialize($json)