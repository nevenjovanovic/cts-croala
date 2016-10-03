module namespace cts = "http://croala.ffzg.unizg.hr/cts";
import module namespace functx = "http://www.functx.com" at "functx.xqm";
declare namespace ti = "http://chs.harvard.edu/xmlns/cts";


(: list all available CTS URNs of text elements :)
declare function cts:getcapabilities(){
  let $tbody := element tbody {
  for $t in collection("croala-cts-1")//*:TEI/*:text
let $urn := $t/@xml:base/string()
for $node in $t//*
let $cts := $urn || $node/@n/string()
let $href := "http://croala.ffzg.unizg.hr/basex/cts/" || $cts
return element tr {
  element td {
    element a { 
    attribute href { $href} , 
    $cts }
  }
}
}
return $tbody
};

(: list available textgroups as rows and cells :)
declare function cts:listtextgroupurns () {
  for $tg in collection("croala-cts-1")//ti:textgroup
  let $groupurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/cts/work/" || $tg/@urn/string() } , 
    $tg/@urn/string() 
  }
  let $grouplabel := string-join(
    for $a in $tg/ti:groupname/* 
    return normalize-space(data($a)), '; '
  )
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/cts/editions/" || $groupurn
  let $groupcount := element a { 
  attribute href { $editionhref } ,
  count(collection("croala-cts-1")//ti:work[@groupUrn=$groupurn]) }
  order by $grouplabel collation "?lang=hr"
  return element tr { 
    element td {$grouplabel},
    element td {$groupurn},
    element td { $groupcount }
     }
};

(: Make a table displaying available textgroups :)
(: Label, CTS URN, count of available editions :)
(: CTS URN of work links to a description of the work :)
(: and to the first edition available? :)
(: count of editions links to edition page :)
declare function cts:gettextgroups(){
  let $table := 
  let $dbname := "croala-cts-1"
  let $dateupdated := db:info($dbname)//databaseproperties/timestamp/string()
  let $head := cts:tablecaption($dbname, $dateupdated)
  let $label := element td { "Label" }
  let $ctsurn := element td { "CTS URN" }
  let $count := element td { "Available works" }
  let $theadrow := cts:returnheadrow($label, $ctsurn, $count)
  let $textgroupurns := cts:listtextgroupurns()
  return cts:returntable($head, $theadrow, $textgroupurns )
  return $table
};

(: from a CTS URN, retrieve a single passage :)
declare function cts:getpassage($ctsurn) {
  let $edition := functx:substring-before-last($ctsurn, ":") || ":"
  let $path := functx:substring-after-last($ctsurn, ":")
  return collection("croala-cts-1")//*:text[@xml:base=$edition]//*[@n=$path]
};

(: list available works :)

declare function cts:getworks($workurn1){
  let $dbname := "croala-cts-1"
  let $dateupdated := db:info($dbname)//databaseproperties/timestamp/string()
  let $head := cts:tablecaption($dbname, $dateupdated)
  let $label := element td { "Label" }
  let $ctsurn := element td { "CTS URN" }
  let $count := element td { "Editions available" }
  let $theadrow := cts:returnheadrow($label, $ctsurn, $count)
  let $urnlist := cts:listworkurns ($workurn1)
  return cts:returntable($head, $theadrow, $urnlist )
};

declare function cts:returntable($head, $theadrow, $urnlist ) {
  let $table :=
  element table {
    attribute class {"table-striped table-hover table-centered"},
    element caption { $head },
    element thead {
   $theadrow
    },
    element tbody {
      $urnlist
    }
  }
  return $table
};

declare function cts:tablecaption($dbname, $date){
  let $head := "Works available in CroALa db " || $dbname || ", updated on " || $date
  return $head
};

declare function cts:returnheadrow($label, $ctsurn, $count){
  element tr { 
    element td { $label }, 
    element td { $ctsurn }, 
    element td { $count }
  }
};

(: list available works as rows and cells :)
declare function cts:listworkurns ($groupurn1) {
  if ($groupurn1="") then 
  for $tg in collection("croala-cts-1")//ti:work
  let $workurnstring := $tg/@urn/string()
  let $workurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/ctswork/" || $workurnstring } , 
    $workurnstring 
  }
  let $worklabel := string-join(
    for $a in $tg/ti:title
    return normalize-space(data($a)), '; '
  )
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctseditions/" || $workurn
  let $editioncount := element a { 
  attribute href { $editionhref } ,
  count(collection("croala-cts-1")//ti:edition[@workUrn=$workurn]) }
  order by $worklabel collation "?lang=hr"
  return element tr { 
    element td {$worklabel},
    element td {$workurn},
    element td { $editioncount }
     }
 else
  for $tg in collection("croala-cts-1")//ti:work[@groupUrn=$groupurn1]
  let $workurnstring := $tg/@urn/string()
  let $workurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/ctswork/" || $workurnstring } , 
    $workurnstring 
  }
  let $worklabel := string-join(
    for $a in $tg/ti:title
    return normalize-space(data($a)), '; '
  )
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctseditions/" || $workurn
  let $editioncount := element a { 
  attribute href { $editionhref } ,
  count(collection("croala-cts-1")//ti:edition[@workUrn=$workurn]) }
  order by $worklabel collation "?lang=hr"
  return element tr { 
    element td {$worklabel},
    element td {$workurn},
    element td { $editioncount }
     }
};