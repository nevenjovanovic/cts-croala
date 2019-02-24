(: find all files with lg :)
distinct-values(
for $f in //*:text//*[*:lg and *:p]
return db:path($f)
)