for $i in //*:idno
return rename node $i as QName("http://www.tei-c.org/ns/1.0","note")