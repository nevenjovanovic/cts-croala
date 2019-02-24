let $files :=
(
  "/and02/croala702300/and02.croala702300.croala-lat1.xml",
  "/anonymus_1790/croala582425/anonymus_1790.croala582425.croala-lat1.xml",
  "/baric01/croala1506566/baric01.croala1506566.croala-lat1.xml",
  "/bart01/croala3870928/bart01.croala3870928.croala-lat1.xml",
  "/bart01/croala7302927/bart01.croala7302927.croala-lat1.xml",
  (: "/and02/croala507426/and02.croala507426.croala-lat1.xml",
  "/benes01/croala512580/benes01.croala512580.croala-lat1.xml",
  "/crije02/croala1844580/crije02.croala1844580.croala-lat1.xml"
  "/croala498219/croala498219/croala498219.croala498219.croala-lat1.xml",
  "/galopa01/croala1586332/galopa01.croala1586332.croala-lat1.xml",
  "/madij01/croala1919303/madij01.croala1919303.croala-lat1.xml",
  "/milecij01/croala1676024/milecij01.croala1676024.croala-lat1.xml",
  "/kozic01/croala290205/kozic01.croala290205.croala-lat1.xml",  :)
  "/kravar01/croala1105401/kravar01.croala1105401.croala-lat1.xml",
  "/krsav01/croala57086/krsav01.croala57086.croala-lat1.xml",
  "/lipav01/croala23168/lipav01.croala23168.croala-lat1.xml",
  "/mikac01/croala1/mikac01.croala1.croala-lat1.xml",
  "/naljesk01/croala897902/naljesk01.croala897902.croala-lat1.xml",
  "/paul01/croala1444429/paul01.croala1444429.croala-lat1.xml",
  "/perceval01/croala848800/perceval01.croala848800.croala-lat1.xml",
  "/rest02/croala806749/rest02.croala806749.croala-lat1.xml",
  "/skrl01/croala735015/skrl01.croala735015.croala-lat1.xml",
  "/smerdel01/croala896972/smerdel01.croala896972.croala-lat1.xml",
  "/statilic_ivan01/croala1804512/statilic_ivan01.croala1804512.croala-lat1.xml"
)
for $f in $files
let $doc := db:open("croala-cts-1", $f)
let $pattern := $doc//*:encodingDesc/*:refsDecl[@n="CTS"]/*:cRefPattern/@replacementPattern
let $b := $doc//*:text[not(*:front or *:group or *:back)]/*:body[not(*:div)]
let $names := ("head", "opener", "closer", "postscript")
for $v in $b/*[name()=$names]
return $v/@n