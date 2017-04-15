declare function local:punct($string) {
  if (matches($string, '\p{P}$')) then $string
  else if (matches($string, '^\p{P}')) then $string
  else()
};
let $a := <a>
<w>formas</w>
<w>corpora;</w>
<w>di,</w>
<w>coeptis</w>
<w>(nam</w>
<w>vos</w>
</a>
for $w in $a//w
return if (matches($w, '\p{P}')) then local:punct($w) else()