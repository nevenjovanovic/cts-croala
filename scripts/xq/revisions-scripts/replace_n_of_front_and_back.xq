let $list := ("front", "back")
for $b in //*:text//*[name()=$list]
let $n := $b/name()
(: return replace value of node $b/@n with $n :)
return $b