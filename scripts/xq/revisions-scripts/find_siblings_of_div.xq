distinct-values(
let $list := ("div")
for $l in //*:text//*[name()=$list]
let $ps := $l/preceding-sibling::*[not(name()=$list) and @n]/name()
return $ps )