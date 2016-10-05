for $refsd in collection("refsDeclproba")//*:refsDecl[@n="CTS"]
return delete node $refsd
(: return $refsd :)