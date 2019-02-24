distinct-values(
let $list := ("emph")
for $l in //*:text//*[name()=$list]
let $ps := $l/preceding-sibling::*[not(name()=$list) and @n]/name()
return $ps )