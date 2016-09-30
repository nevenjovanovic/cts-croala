(: 468 in croala-txts :)
(: 41 in croala multi :)
let $authidlist :=
for $f in tokenize(file:read-text("/home/neven/rad/croala-r/notcroalactsmulti.list"), ' ')
(: returns 425 docs :)
let $doc := db:open("croala-cts", $f)//*:teiHeader/*:fileDesc[1]/*:titleStmt[1]/*:author/@ref
group by $doc
order by $doc
return $doc
return file:write("/home/neven/rad/croala-r/ctsauthid.list", $authidlist)