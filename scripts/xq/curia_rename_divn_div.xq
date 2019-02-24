for $d in //*[matches(name(),"div[1-5]")]
(: return rename node $d as  QName("http://www.tei-c.org/ns/1.0","div") :)
(: let $name := $d/name()
let $new := substring-after($d/@n, $name) :)
(: return replace value of node $d/@n with $new :)
return rename node $d as  QName("http://www.tei-c.org/ns/1.0","div")