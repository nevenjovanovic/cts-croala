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
  order by $grouplabel
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
  let $date := db:info("croala-cts-1")//databaseproperties/timestamp/string()
  let $head := "CroALa textgroups in " || $dbname || ", " || $date
  let $label := element td { "Label" }
  let $ctsurnlabel := element td { "CTS URN" }
  let $count := element td { "Available works" }
  let $theadrow := element tr { $label, $ctsurnlabel, $count }
  let $textgroupurns := cts:listtextgroupurns()
  return element table {
    attribute class {"table"},
    element caption { $head },
    element thead {
   $theadrow
    },
    element tbody {
      $textgroupurns
    }
  }
  return $table
};

(: from a CTS URN, retrieve a single passage :)
declare function cts:getpassage($ctsurn) {
  let $cts := substring-after($ctsurn, "http://croala.ffzg.unizg.hr/basex/cts/")
  let $edition := functx:substring-before-last($cts, ":") || ":"
  let $path := functx:substring-after-last($cts, ":")
  return collection("croala-cts-1")//*:text[@xml:base=$edition]//*[@n=$path]
};