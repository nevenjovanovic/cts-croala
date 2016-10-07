for $b in collection("croala-cts-1")/*
where matches(db:path($b),"bunic02/croala1761880")
return $b