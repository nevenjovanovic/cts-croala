let $path := "/home/neven/Repos/ctscroalapriv/bart_add"
let $vitlist := file:list($path, xs:boolean('false'), '*.xml')
for $v in $vitlist
let $dname := tokenize(substring-before($v, '.croala-'), '\.')
return file:create-dir($path || '/' || $dname[1] || '/' || $dname[2] )