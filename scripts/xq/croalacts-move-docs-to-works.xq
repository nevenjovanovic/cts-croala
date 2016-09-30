for $t in doc("/home/neven/rad/croala-r/croalactsconcordance.xml")//*:text
let $filename := $t/@filename
let $work := $t/@workid
let $ctsname := $t/@ctsfile
let $groupdir := "/home/neven/rad/croalacts/data/" || substring-before($ctsname, '.')
let $file := db:open("croala-cts", $filename)
(: return $groupdir || "/" || $work || "/" || $ctsname :)
return file:write($groupdir || "/" || $work || "/" || $ctsname, $file)
