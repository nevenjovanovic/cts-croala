distinct-values(
let $list := ("p", "l")
for $l in //*:text//*:div/*[name()=$list]
let $ps := $l/preceding-sibling::*[not(name()=$list) and @n]/name()
return $ps )