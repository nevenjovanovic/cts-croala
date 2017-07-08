for $t in //*:work/*:edition
let $urn := $t/@urn || ":"
return replace value of node $t/@urn with $urn