let $file := "/home/neven/Repos/cts-croala/docs/croala_levels_textnodes.xml"
let $f := doc($file)
for $doc in $f//doc
(: where $doc/textsib != $doc/ctslev :)
where $doc/textsib < $doc/ctslev and $doc/textsib[not(normalize-space()="")]
order by $doc/ctslev descending
return $doc