for $b in //*:text/*[not(@xml:lang)]
let $l := attribute xml:lang { "lat" }
return insert node $l into $b