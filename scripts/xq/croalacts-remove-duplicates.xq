for $dupli in ("andreis-f-polonos","aa-vv-praef-epist-rebus-dalm", "baricev-aa-epist", "baricev-aa-epist-penzel", "bunic-j-vgc", "dragisic-j-oratio", "hektor-p-nn-inscr", "kruzic-orlovic-epist-1525-04-19", "kunic-r-hymnus-cererem", "marul-mar-dante", "mazuranic-bakovic-mors", "michet-a-cassand", "sisgor-g-epigr-m", "skerle-n-epist-salag", "step-n-obsid", "vrancic-a-m-epigrammata-duo", "zamagna-b-navis", "zigerius-e-epist")
for $x in //*:TEI/*:teiHeader/*:fileDesc/@xml:id
where $x[contains(., $dupli)] and starts-with(db:path($x), 'croala')
order by $x
return db:path($x)