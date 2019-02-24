(: delete n attribute from empty nodes :)
let $empty := ("milestone", "pb", "gap")
for $e in //*:text//*[name()=$empty and @n]
return delete node $e/@n