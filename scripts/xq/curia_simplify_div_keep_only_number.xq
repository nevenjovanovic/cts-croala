for $d in //*[matches(@n, "div[0-9]+")]
let $new := substring-after($d/@n, "div")
(: return replace value of node $d/@n with $new :)
where $d[@n="div31"]
return $d/@n