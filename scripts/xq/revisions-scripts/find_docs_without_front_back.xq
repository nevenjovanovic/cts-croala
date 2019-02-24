for $t in /*:TEI/*:text[not(*:front) and not(*:back)]
return db:path($t)