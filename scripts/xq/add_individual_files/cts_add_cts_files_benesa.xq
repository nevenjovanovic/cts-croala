declare namespace ti="http://chs.harvard.edu/xmlns/cts";

declare variable $groupname := "benes01";

declare function local:titemplate($workid, $label, $title){
  let $groupurn := "urn:cts:croala:" || $groupname
  return
  element ti:work {
    attribute groupUrn {
      $groupurn
    },
    attribute urn {
      $groupurn || "." || $workid
    },
    attribute xml:lang { "lat"},
    element ti:title {
      attribute xml:lang { "lat"},
      $title
    },
    element ti:edition {
      attribute workUrn {
       $groupurn || "." || $workid
      },
      attribute urn {
        $groupurn || "." || $workid || ".croala-lat1:"
      },
    element ti:label {
      attribute xml:lang { 'lat' },
      $label
    },
    element ti:description {
      attribute xml:lang { 'hrv' },
      "Moderno znanstveno izdanje (2017)."
    }
  }
  }
};


let $path := "/home/neven/Repos/ctscroalapriv/ben_add/benes01/"
let $vitlist := file:list($path, xs:boolean('true'), '*-lat1.xml')

for $v in $vitlist 
let $dpath := $path || $v
let $dpart := substring-after($v, '/')
let $workurn := substring-before($v, '/')
let $cref := doc($dpath)//*:encodingDesc/*:refsDecl[@n="CTS"]
let $label := data(doc($dpath)//*:titleStmt/*:title)
let $title := substring-before($label, ', versio')
let $ctsfile := local:titemplate($workurn, $label, $title)
let $ctspath := $path || $workurn || '/__cts__.xml'
(: return file:write($ctspath,$ctsfile) :)
return if (not($cref)) then file:write($ctspath, $ctsfile)
else ()