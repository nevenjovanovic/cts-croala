declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function local:getdistinctpaths(){
  "PLH"
};

declare function local:crefpat(){
  let $f := local:getdistinctpaths()
  return element tei:cRefPattern {
    attribute n { "segment" },
    attribute matchPattern {"(\w+)"},
    attribute replacementPattern { "#xpath(" || $f || "[@n='$1'])" },
    element p { "This pointer pattern extracts @n value of segment."}
  }
};

for $f in collection("refsDeclproba")/*:TEI/*:teiHeader
  let $node := element tei:refsDecl {
    attribute n { "CTS" },
    local:crefpat()
  }
  return $node
