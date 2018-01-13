declare namespace ti="http://chs.harvard.edu/xmlns/cts";

declare function local:titemplate($workid, $label, $title){
  element ti:work {
    attribute groupUrn {
      "urn:cts:croala:vitezov01"
    },
    attribute urn {
      "urn:cts:croala:vitezov01." || $workid
    },
    attribute xml:lang { "lat"},
    element ti:title {
      attribute xml:lang { "lat"},
      $title
    },
    element ti:edition {
      attribute workUrn {
        "urn:cts:croala:vitezov01." || $workid
      },
      attribute urn {
        "urn:cts:croala:vitezov01." || $workid || ".croala-lat1:"
      },
    element ti:label {
      attribute xml:lang { 'lat' },
      $label
    },
    element ti:description {
      attribute xml:lang { 'hrv' },
      "Moderno znanstveno izdanje (2018)."
    }
  }
  }
};


let $path := "/home/neven/Repos/ctscroalapriv/vitsplit2/data/vitezov01/"
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
let $workurn := substring-before($dpart, '.croala')
let $newpath := $path || $workurn || '/' || $newname
let $label := data(doc($newpath)//*:titleStmt/*:title)
let $title := substring-before($label, ', versio')
let $ctsfile := local:titemplate($workurn, $label, $title)
let $ctspath := $path || $workurn || '/__cts__.xml'
return file:write($ctspath,$ctsfile)