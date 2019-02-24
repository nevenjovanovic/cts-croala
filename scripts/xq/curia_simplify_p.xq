for $h in //*:p[@n="p1"]
where not($h/following-sibling::*:p[@n="p2"])
(: return replace value of node $h/@n with "head" :)
return replace value of node $h/@n with "p"