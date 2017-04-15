declare function local:punct ($string) {
  if (ends-with($string, '\p{P}')) then (element w { substring-before($string, '\p{P}') } , element pc { replace($string, '[a-zA-Z]', '')} )
  else if (starts-with($string, '\p{P}')) then $string
  else()
};
let $words := for $t in //*:text//*[text()]
for $tx in $t/text()
return tokenize(normalize-space($tx), '\s')
for $w in $words
return if (matches($w, '\p{P}')) then $w
else element w { $w }