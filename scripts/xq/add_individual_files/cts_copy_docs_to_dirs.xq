let $path := "/home/neven/Repos/ctscroalapriv/vitsplit/"
let $vitlist := (
  "vitezov01_epist01_croala7470223.croala-lat1.xml",
"vitezov01_epist02_croala524281.croala-lat1.xml",
"vitezov01_epist03_croala1446229.croala-lat1.xml",
"vitezov01_epist04_croala3220475.croala-lat1.xml",
"vitezov01_epist05_croala40274.croala-lat1.xml",
"vitezov01_epist06_croala3970306.croala-lat1.xml",
"vitezov01_epist07a_croala26307.croala-lat1.xml",
"vitezov01_epist07_croala1136422.croala-lat1.xml"
)
for $v in $vitlist 
let $dpath := $path || $v
let $dpart := substring-after(
  substring-after($v, '_'),
  '_')
let $newname := 'vitezov01.' || $dpart
let $newpath := $path || substring-before($dpart, '.croala') || '/' || $newname
return file:copy( $dpath , $newpath )