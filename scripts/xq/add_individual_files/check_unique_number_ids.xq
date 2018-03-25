(: check if a random number is unique in croala ids :)
declare variable $textgroup := "caboga01";
let $list :=
for $d in db:open("croala-cts-1")//*:TEI
return xs:integer(
  substring-after(
    substring-before(
      substring-after(
        db:path($d),
         '/'),
        '/'), 
        'croala')
        )
for $n in 1 to 2
let $random := random:integer(9999999)
return if ($list=$random) then "Need a new number!"
else $textgroup || ".croala" || $random || ".croala-lat1"