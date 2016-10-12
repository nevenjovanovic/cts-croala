(: exercise XQuery script to manipulate XML :)
for $text in //*:text[contains(@xml:base,"urn:cts:croala:zama01.croala10")]//*:l
return $text