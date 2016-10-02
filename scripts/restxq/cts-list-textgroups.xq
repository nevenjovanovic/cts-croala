(: CroALa CTS :)
(: list textgroups available in the croala-cts-1 db :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cts = "http://croala.ffzg.unizg.hr/cts" at "../../repo/croalacts.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace vit = "http://croala.ffzg.unizg.hr/vit" at "../../repo/vitezovic.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Conglomerationes textuum in CroALa';
declare variable $content := "Display textgroups available in the CroALa collection identified by a CTS URN.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Croatiae auctores Latini, CroALa, gazetteer, literary analysis, scholarly edition, analytical exemplar, citation, quotation, machine-actionable edition";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("conglomerationes")
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
  function page:croalactstextgroups()
{
  (: HTML template starts here :)

<html>
{ vit:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Locus in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://cite-architecture.github.io/">architecturae CITE</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a></p>
<p>Functio nominatur: {rest:uri()}.</p>
<p>Redi ad <a href="http://croala.ffzg.unizg.hr/basex/cp/list">CTS URN indiculum</a>.</p>
</div>
<div class="col-md-6">
{croala:infodb('croala-cts-1')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	<div class="table-responsive">
  { cts:gettextgroups() }
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
