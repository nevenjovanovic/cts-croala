declare namespace ti = "http://chs.harvard.edu/xmlns/cts";
let $list := element list {
for $f in tokenize(file:read-text("/home/neven/rad/croalacts/docs/croalactsmulti.list"), ' ')
let $file := db:open("croala-cts", $f)//*:TEI
let $author := $file/*:teiHeader/*:fileDesc/*:titleStmt/*:author
let $token := "croala" || db:node-id($file)
return element ti:textgroup {
  attribute urn {"urn:cts:croala:" || $token },
  element ti:groupname {
    let $lang := $author[1]/*[name()=("persName", "orgName")][1]/@xml:lang
    return if ($lang) then $lang else attribute xml:lang {"lat"} ,
$author
}
}
}
return file:write("/home/neven/rad/croalacts/docs/croalactstextgroups-multi.xml",$list)