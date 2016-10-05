for $refsd in collection("croala-cts-1")//*:refsDecl[@n="CTS"]
return delete node $refsd
(: return $refsd :)