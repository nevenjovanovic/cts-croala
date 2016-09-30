let $multi :=
for $ff in collection("croala-cts")//*:TEI
where $ff/*:teiHeader/*:fileDesc/*:titleStmt/*:author[2]
return db:path($ff)
return file:write("/home/neven/rad/croala-r/croalactsmulti.list", $multi)