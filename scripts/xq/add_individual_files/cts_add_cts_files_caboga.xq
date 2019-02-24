declare namespace ti="http://chs.harvard.edu/xmlns/cts";

declare function local:titemplate($workid, $label, $title){
  element ti:work {
    attribute groupUrn {
      "urn:cts:croala:caboga01"
    },
    attribute urn {
      "urn:cts:croala:caboga01." || $workid
    },
    attribute xml:lang { "lat"},
    element ti:title {
      attribute xml:lang { "lat"},
      $title
    },
    element ti:edition {
      attribute workUrn {
        "urn:cts:croala:caboga01." || $workid
      },
      attribute urn {
        "urn:cts:croala:caboga01." || $workid || ".croala-lat1:"
      },
    element ti:label {
      attribute xml:lang { 'lat' },
      $label
    },
    element ti:description {
      attribute xml:lang { 'hrv' },
      "Moderno znanstveno izdanje (2016)."
    }
  }
  }
};


let $path := "/home/neven/Documents/documents/latinisti/kaboga_e/data/caboga01/"
let $vitlist := (
  "caboga01.croala2985887.croala-lat1.xml"
)
for $v in $vitlist 
let $dpath := $path || $v
let $dpart := 
  substring-after($v, 'caboga01.')
let $newname := $v
let $workurn := substring-before($dpart, '.croala-')
let $newpath := $path || $workurn || '/' || $newname
let $label := data(doc($newpath)//*:titleStmt/*:title)
let $title := substring-before($label, ', versio')
let $ctsfile := local:titemplate($workurn, $label, $title)
let $ctspath := $path || $workurn || '/__cts__.xml'
return file:write($ctspath,$ctsfile)