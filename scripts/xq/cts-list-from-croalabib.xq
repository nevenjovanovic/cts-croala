declare namespace ti = "http://chs.harvard.edu/xmlns/cts";
(: 190 unique :)
for $authlist in
for $a in tokenize(file:read-text("/home/neven/rad/croala-r/ctsauthid.list"), ' ')
return $a
let $name := collection("croalabib")//*[name()=("person","org") and @xml:id=$authlist]
return if ($name) then
element ti:textgroup {
  attribute urn {"urn:cts:croala:" || $authlist },
  element ti:groupname {
    let $lang := $name/*[name()=("persName", "orgName")][1]/@xml:lang
    return if ($lang) then $lang else attribute xml:lang {"lat"} ,
$name/*[name()=("persName", "orgName")][1]
}
}
(: special cases, not listed in croalabib, starting in # :)
else element ti:textgroup {
  attribute urn {"urn:cts:croala:" || replace($authlist, '#', '') },
  element ti:groupname {
    attribute xml:lang {"lat"} ,
    collection("croala-cts")//*:TEI/*:teiHeader/*:fileDesc/*:titleStmt/*:author[@ref=$authlist]/*
}
}
