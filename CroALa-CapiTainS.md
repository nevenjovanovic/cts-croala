# CroALa to CapiTainS

**Objective**: make texts from CroALa pass all tests from the [HookTest](https://github.com/Capitains/HookTest), to eventually enable ingesting CroALa in the [CapiTainS Nemo / Nautilus system](http://cts.perseids.org/).

## Barrier 1: URN conventions

Texts in CroALa have their base URN at `TEI/text/@xml:base`, while the HookTest, following the CapiTainS guidelines, currently looks for them in `TEI/text/body/@n`. To overcome this, I have [opened an issue and created a Pull Request](https://github.com/Capitains/Capitains.github.io/issues/14) on the Guidelines. The PR was merged, so we expect that a next version of the HookTest will tolerate our URNs.

## Barrier 2: value of the @n attribute

The CapiTainS Guidelines require a relevant node to be identified by a `@n` attribute. The attribute, however, may contain *only alphanumeric characters*.

To satisfy this, we had to eliminate most of our verbose, XPath-imitating `@n` values. This was achieved with the [pare-down-multidot-n-attrs.xq](scripts/xq/pare-down-multidot-n-attrs.xq) XQuery. For 40 documents with some 100,000 nodes to be changed, on my (rather modest) system the script took about three minutes to finish.

## Barrier 3: XPath levels

1. The CapiTainS Guidelines (and the HookTest, which follows them) rely on *levels* - the count of [ancestors](http://zvon.org/xxl/XPathTutorial/Output/example14.html) of a node
2. The Guidelines also require the XPaths to nodes in a document to be sorted by the *descending* level count, to be distinguished *only* by level count; from that perspective, the path `A/B/C` is regarded to be equal to the path `A/C/D`
3. The nodes to be cited as CTS URNs have to have their `@n` attributes mentioned as a regular expression in the XPath: `A/B[@n='$1']/C[@n='$2']`
4. The `cRefPattern` element in which all this information is supplied has to provide a `@matchpattern` attribute with the number of components *equal to the level count*; if the level count is 2 (as in the examples above), we need to have something like `@matchpattern='(\w+).(\w+)'`

All these conditions required some complex hacking of the CroALa XML files, attributes, and paths. The final result is the [add-crefpaths.xq](scripts/xq/add-crefpaths.xq) XQuery. It is organized in a slightly perplexing and extremely unprofessional way -- but it does what it should; it inserts into our documents `refsDecl` nodes with the required children, and with information structured and expressed adequately enough to pass the relevant HookTest tests.

The main hack consists in allowing *any* element with the `@n` attribute to match in the `cRefPattern/@replacementPattern`, so we get expressions like this:

`#xpath(/tei:TEI/tei:text/*[@n='$5']/*[@n='$4']/*[@n='$3']/*[@n='$2']/*[@n='$1'])`

Because our `@n` attribute values still imitate the concrete XPath context -- they supply names such as `l16, div3, p28, q4` -- in this way the semantic information from the TEI encoding will be preserved, and something equal to our prior verbose `@n` value will be reconstructed by path traversals (and a few hundred CPU cycles more).

## Some considerations

The CapiTainS system evolved as a pragmatic solution for a very concrete challenge: how to test that the documents from all collections of the [Perseus Digital Library](http://www.perseus.tufts.edu/hopper/), in their most up-to-date state, can be served by the Nautilus CTS provider and accessed through the Nemo user interface. The CapiTainS had to remain very close to its target sets of documents, which are in themselves complicated enough; not only because of their contents, but also because (like CroALa) grew and evolved over time; the Perseus Library exists for [more than thirty years](http://www.perseus.tufts.edu/hopper/about) (congratulations!). Both the Perseus Library and CapitainS want to grow further - to embrace more texts, of more different kinds.

On the other hand, the CTS URN specification, as one of the components of the [CITE Architecture](http://cite-architecture.github.io/), offers a citation framework far-sighted and abstract enough to be applicable to *all* texts, not only to those belonging to the canon of ancient Greek and Latin literature.

The universal applicability of both CTS URNs and CapiTainS (as one of real-world implementations and applications of the CTS specifications) has, however, to be tested and demonstrated. This seems to me to be one of the main avenues to the wider acceptance of both.

But, when CTS and CapiTainS have to be applied to other texts and other collections - for example, [CAMENA](http://www.uni-mannheim.de/mateo/camenahtdocs/camena.html), CroALa, or the excellent [LombardPress](http://lombardpress.org/) or the [Editiones Electronicae Guelferbytanae](http://diglib.hab.de/wdb.php?dir=edoc/ed000086&distype=start&pvID=start) - the existing system will have to adapt. There will be different texts (Early Modern texts [differ in structure](CroALa-CTS-explained.md) from ancient classics); there will be *many* such texts; and, as usual, there won't be time or manpower to make them CTS compliant one by one, at least for the first round of processing.

Therefore it is important to have tools and workflows for automated CTS conversions -- and that such conversions are kept as easy, as simple, and as universal as possible.

Moreover, it is clear from our experiment that we can reshape and reformat XML documents. But, as regards reformatting, there is a line which I would hesitate to cross. XML is not a set of random numeric identifiers whose main purpose is to be unique (as in the case of VIAF identifiers, for example).  The TEI XML elements were designed to have semantic value, their very names hold specific information; as a matter of fact, this was extremely attractive to me the first time I encountered the TEI scheme. In a particular TEI XML edition, sometime much thought has gone into deciding which element will we choose for our content. So, instead of swiftly discarding the information preserved in the XML elements -- and with it discarding some knowledge as well -- would not it be better for us to develop ways to *use* this information, to harness it in such a way that our presentations and interpretations of the text are enriched?

