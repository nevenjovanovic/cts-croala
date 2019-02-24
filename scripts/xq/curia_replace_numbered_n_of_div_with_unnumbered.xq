for $d in //*:div[matches(@n, "^[1-9]+")]
let $new := "div" || $d/@n
return replace value of node $d/@n with $new