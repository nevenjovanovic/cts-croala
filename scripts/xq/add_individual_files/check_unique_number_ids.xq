(: check if a random number is unique in croala ids :)
let $list :=
for $d in //*:TEI
return xs:integer(substring-after(substring-before(substring-after(db:path($d), '/'), '/'), 'croala'))
for $n in 1 to 5
let $random := random:integer(9999999)
return if ($list=$random) then "Need a new number!"
else "croala" || $random || ".croala-lat1"