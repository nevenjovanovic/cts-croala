distinct-values(
for $f in //*:TEI/*:text[*:front or *:back]/*
return $f/*[@n]/name()
)