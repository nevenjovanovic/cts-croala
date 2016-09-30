let $notlist :=
for $nothc in
let $f := tokenize(file:read-text("/home/neven/rad/croala-r/croalactsmulti.list"), ' ')
let $n := for $ff in collection("croala-cts")//*:TEI
let $path := db:path($ff)
return $path
return distinct-values($n[not(.=$f)])
order by $nothc
return $nothc
return file:write("/home/neven/rad/croala-r/notcroalactsmulti.list", $notlist)