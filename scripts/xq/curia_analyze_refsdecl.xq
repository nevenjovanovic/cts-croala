for $p in //*:refsDecl[@n="CTS"]
let $c := count($p/*:cRefPattern)
where $c = 6
return db:path($p)