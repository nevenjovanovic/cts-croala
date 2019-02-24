declare namespace ti="http://chs.harvard.edu/xmlns/cts";

declare function local:titemplate($workid, $name){
  element ti:textgroup {
    attribute urn {
      "urn:cts:croala:caboga01"
    },
    element ti:groupname {
      attribute xml:lang { "hrv"},
      $name
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
let $label := doc($newpath)//*:titleStmt/*:author
let $title := $label/*[1]
let $ctsfile := local:titemplate($workurn, $title)
let $ctspath := $path || '__cts__.xml'
return file:write($ctspath,$ctsfile)