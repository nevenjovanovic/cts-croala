let $path := "/home/neven/Repos/ctscroalapriv/ben_add/benes01"
let $vitlist := file:list($path, xs:boolean('false'), '*.xml')
for $v in $vitlist
let $newname := 'benes01.' || substring-after(substring-after($v, '_'), '_')
let $dname := substring-before(substring-after(substring-after($v, '_'), '_'), '.croala-')
return file:create-dir($path || '/' || $dname )