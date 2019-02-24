let $paths :=
for $n in db:open("croala-cts-1","vicic01/croala227390/vicic01.croala227390.croala-lat1.xml")/*:TEI/*:text//*[parent::*:div]
return replace(substring-after(path($n), '/Q{http://www.tei-c.org/ns/1.0}TEI[1]/Q{http://www.tei-c.org/ns/1.0}text[1]/Q{http://www.tei-c.org/ns/1.0}body[1]'), '\[[0-9]+\]', '')
return distinct-values($paths)