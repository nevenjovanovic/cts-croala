for $h in //*[matches(@n,"[a-z]1$")]
let $name := $h/name()
where not($h/following-sibling::*[name()=$name and @n=$name || "2"])
(: return replace value of node $h/@n with "head" :)
(: return replace value of node $h/@n with "p" :)
return replace value of node $h/@n with $name