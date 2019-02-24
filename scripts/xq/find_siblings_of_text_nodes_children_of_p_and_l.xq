(: return names of all siblings of text nodes which are children of p or l -- i.e. unreachable by CTS :)
for $e in
distinct-values(
  let $list := ("p", "l")
for $t in collection("croala-cts-1")//*:text//*[name()=$list]/text()[normalize-space()!='']
let $n := $t/preceding-sibling::*[text()]|following-sibling::*[text()]
return $n/name())
order by $e
return $e