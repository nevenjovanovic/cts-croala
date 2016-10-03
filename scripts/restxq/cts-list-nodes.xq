(: CroALa CTS :)
(: list CTS URNs of text nodes available in a document belonging to the the croala-cts-1 db :)
(: for the supplied edition CTS URN :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cts = "http://croala.ffzg.unizg.hr/cts" at "../../repo/croalacts.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace vit = "http://croala.ffzg.unizg.hr/vit" at "../../repo/vitezovic.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Nodi editionis in CroALa';
declare variable $content := "Display text nodes of an edition available in the CroALa collection, identified by a CTS URN.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Croatiae auctores Latini, CroALa, gazetteer, literary analysis, scholarly edition, analytical exemplar, citation, quotation, machine-actionable edition";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("ctseditio/{$urn}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)
  function page:croalactsnodes($urn)
{
  (: HTML template starts here :)

<html>
{ vit:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Nodi editionis { $urn } in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://cite-architecture.github.io/">architecturae CITE</a>, { current-date() }.</p>
<p>Elige numerum ut accedas ad textum nodi.</p>
<p>Functio nominatur: {rest:uri()}.</p>
<p>Abi ad <a href="https://github.com/nevenjovanovic/cts-croala">Github apothecam</a>.</p>
</div>
<div class="col-md-6">
{croala:infodb('croala-cts-1')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	<div class="table-responsive">
  { cts:getnodes($urn) }
  </div>
</blockquote>
     <p/>
     </div>
<hr/>
{ croala:footerserver() }

</body>
</html>
};

return
