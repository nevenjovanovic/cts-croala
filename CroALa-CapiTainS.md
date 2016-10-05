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
3. Moreover, the nodes to be cited as CTS URNs have to have their `@n` attributes mentioned as a regular expression in the XPath, in *descending* order: `A/B[@n='$2']/C[@n='$1']`
4. The `cRefPattern` element in which all this information is supplied has to provide a `@matchpattern` attribute with the number of components *equal to the level count*; if the level count is 2 (as in the examples above), we need to have something like `@matchpattern='(\w+).(\w+)'`

All these conditions required some complex hacking of the CroALa XML files, attributes, and paths. The final result is the [add-crefpaths.xq](scripts/xq/add-crefpaths.xq) XQuery. It is organized in a slightly perplexing and extremely unprofessional way -- but it does what it should; it inserts into our documents `refsDecl` nodes with the required children, and with information structured and expressed adequately enough to pass the relevant HookTest tests.

The main hack consists in allowing *any* element with the `@n` attribute to match in the `cRefPattern/@replacementPattern`, so we get expressions like this:

`#xpath(/tei:TEI/tei:text/*[@n='$5']/*[@n='$4']/*[@n='$3']/*[@n='$2']/*[@n='$1'])`

Because our `@n` attribute values still imitate the concrete XPath context -- they supply names such as `l16, div3, p28, q4` -- in this way the semantic information from the TEI encoding will be preserved, and something equal to our prior verbose `@n` value will be reconstructed by path traversals (and a few hundred CPU cycles more).

## Some considerations

The CapiTainS system evolved as a pragmatic solution of a very concrete challenge: how to test that the documents from all collections of the Perseus Library, in its most up-to-date state, can be served by the Nautilus CTS provider and accessed through the Nemo user interface. The CapiTainS had to remain very close to its target sets of documents, which (like CroALa) grew and evolved over time -- in case of the Perseus Library, for [more than thirty years](http://www.perseus.tufts.edu/hopper/about).

The CTS URN specification, as a component of the CITE Architecture, is far-sighted and abstract enough to be applicable to *all* texts, not only to those belonging to the canon of ancient Greek and Latin literature.

The universal applicability of both CTS URNs and CapiTainS (as one of its more precise implementations) has, however, to be tested and demonstrated. This seems to me to be one of the main avenues to wider acceptance of both.

But, once CTS and CapiTainS have to be applied to other texts and other collections - for example, [CAMENA](http://www.uni-mannheim.de/mateo/camenahtdocs/camena.html), CroALa, or the excellent [LombardPress](http://lombardpress.org/) or the [Editiones Electronicae Guelferbytanae](http://diglib.hab.de/wdb.php?dir=edoc/ed000086&distype=start&pvID=start) - the existing system will have to adapt. Clearly, the texts will be different (Early Modern texts [differ in structure](CroALa-CTS-explained.md) from ancient classics); there will be many of such texts; there won't be time or manpower to make them CTS compliant one by one, at least for the first round of processing.

Therefore it is important to have tools and workflows for automated CTS conversions -- and that such conversions are kept as easy, as simple, and as universal as possible.

