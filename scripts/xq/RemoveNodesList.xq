let $names := ("lb",
"note",
"add", "q", "quote",
"emph", "expan", "abbr")
for $n in //*:text/*:body/*/*
let $t := normalize-space(upper-case($n/text()))
return replace value of node $n with $t