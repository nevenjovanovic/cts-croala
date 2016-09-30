for $t in doc("/home/neven/rad/croala-r/croalactsconcordance.xml")//*:text
let $filename := $t/@filename
let $work := $t/@workid
let $ctsname := $t/@ctsfile
let $groupdir := "/home/neven/rad/croalacts/data/" || substring-before($ctsname, '.')
return file:create-dir($groupdir || "/" || $work)
