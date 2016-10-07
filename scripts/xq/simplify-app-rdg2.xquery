xquery version "3.0";

copy $doc := doc("/home/neven/rad/croalacts/data/bunic02/croala1761880/bunic02.croala1761880.croala-lat1.xml")
modify ( for $d in $doc//*:text/*:back/*:app/*:rdg/*:div/*
let $text := data($d)
return replace node $d/*:app with $text )
return file:write("/home/neven/rad/croalacts/data/bunic02/croala1761880/bunic02.croala1761880.croala-lat1.xml" , $doc)
(: return $doc :)