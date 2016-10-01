declare namespace ti = "http://chs.harvard.edu/xmlns/cts";
for $t in doc("/home/neven/rad/croalacts/docs/croalactsconcordance-multi.xml")//*:text
let $croala := "urn:cts:croala:"
let $filename := $t/@filename
let $title := data(db:open("croala-cts", $filename)//*:teiHeader/*:fileDesc/*:titleStmt/*:title)
let $description := normalize-space(data(db:open("croala-cts", $filename)//*:teiHeader/*:fileDesc/*:editionStmt/*:edition))
let $work := $t/@workid
let $ctsname := $t/@ctsfile
let $groupname :=  substring-before($ctsname, '.')
let $groupdir := "/home/neven/rad/croalacts/data/" || $groupname
let $file := db:open("croala-cts", $filename)
(: return $groupdir || "/" || $work || "/" || $ctsname :)
let $metadata := element ti:work {
  attribute groupUrn { $croala || $groupname },
  attribute urn {  $croala || $groupname || "." || $work },
  attribute xml:lang {"lat"},
  element ti:title {
      attribute xml:lang {"lat"},
      for $t in $title return replace(replace($t, ', versio electronica', ''), 'Machine-readable text', ':')
  },
  element ti:edition {
    attribute workUrn {$croala || $groupname || "." || $work},
    attribute urn { $croala || substring-before($ctsname, '.xml')},
    element ti:label {
      attribute xml:lang {"lat"},
      $title
    },
    element ti:description {
      attribute xml:lang {"hrv"},
      $description
    }
  }
}
return file:write($groupdir || "/" || $work || "/__cts__.xml", $metadata)
(: return element ti {
  attribute dir { $groupdir || "/" || $work || "/__cts__.xml"}, $metadata } :)