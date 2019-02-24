distinct-values(
let $list := ("p", "l")
for $e in //*:text//*[name()=$list and not(parent::*:div)]
let $p := $e/parent::*/name()
return $p )