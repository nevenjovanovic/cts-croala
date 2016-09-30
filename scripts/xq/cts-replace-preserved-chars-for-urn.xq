let $stops := <list>
  <l>#alienus-macedo</l>
  <l>#anonymus-0976</l>
  <l>#anonymus-0999</l>
  <l>#anonymus-1004</l>
  <l>#anonymus-1015</l>
  <l>#anonymus-1020</l>
  <l>#anonymus-1056</l>
  <l>#anonymus-1066</l>
  <l>#anonymus-1099</l>
  <l>#anonymus-1111</l>
  <l>#anonymus-1112</l>
  <l>#anonymus-1268</l>
  <l>#anonymus-1296</l>
  <l>#anonymus-1346</l>
  <l>#anonymus-1493</l>
  <l>#anonymus-1579</l>
  <l>#anonymus-1600</l>
  <l>#anonymus-1657</l>
  <l>#anonymus-1790</l>
  <l>#anonymus-1800</l>
  <l>#varii-1105</l>
  <l>#varii-1590</l>
  <l>grad-senj</l>
  <l>senj-kaptol</l>
</list>
for $s in $stops//l/string()
for $node in (collection("croalabib"), collection("croala-cts"))//*/@*[.=$s]
let $new := replace($s, '-', '_')
return replace value of node $node with $new