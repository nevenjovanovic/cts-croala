# CroALa to CapiTainS

**Objective**: make texts from CroALa pass all tests in [HookTest](https://github.com/Capitains/HookTest), with the view to eventually ingest CroALa in the CapiTainS Nemo system.

## Barrier 1: URN conventions

Texts in CroALa have their base URN at `TEI/text/@xml:base`, while HookTest, following the CapiTainS guidelines, currently looks for them in `TEI/text/body/@n`. To overcome this, I have [opened an issue and created a Pull Request](https://github.com/Capitains/Capitains.github.io/issues/14) on the Guidelines. The PR was merged, so we can hope that a next version of the HookTest will tolerate our URNs.

## Barrier 2: value of the @n attribute

The CapiTainS Guidelines expect that a relevant node will be identified by a `@n` attribute. The attribute, however, may contain *only alphanumeric characters*.

To satisfy this, we had to eliminate most of our verbose, XPath-imitating `@n` values. This is done with the [pare-down-multidot-n-attrs.xq](scripts/xq/pare-down-multidot-n-attrs.xq) XQuery. For 40 documents with some 100,000 nodes to be changed, on my system the script takes about three minutes to finish.

## Barrier 3: XPath levels

The CapiTainS Guidelines (and the HookTest, which follows them) lean heavily on *levels* - the number of [ancestors](http://zvon.org/xxl/XPathTutorial/Output/example14.html) of a node. The Guidelines require XPaths to nodes in a document to be sorted by the descending level count, and the XPaths to be distinguished *only* by level count (from that perspective, the path `A/B/C` is regarded same as the path `A/C/D`).

Moreover, the nodes to be cited as CTS URNs have to have their `@n` attributes mentioned as a regular expression in the XPath, in *descending* order: `A/B[@n='$2']/C[@n='$1']`.

And the `cRefPattern` element in which all this information is supplied has to have a `@matchpattern` attribute with the number of components equal to the level count; if the level count is 2 (as in the example above), we need to have something like `@matchpattern='(\w+).(\w+)'`.

All these conditions required some complex hacking of the CroALa XML files, attributes, and paths. The final result is the [add-crefpaths.xq](scripts/xq/add-crefpaths.xq) XQuery, organized in a slightly perplexing and extremely unprofessional way -- but it inserts into our documents `refsDecl` nodes with the required children, and with information structured and expressed adequately enough to pass the relevant tests in the HookTest.

The main hack consists in allowing *any* element with the `@n` attribute to match in the `cRefPattern/@replacementPattern`, so we get expressions like this:

`TBA`

This may be tolerated for our purposes because our `@n` attribute values still imitate the concrete XPath context -- they supply names such as `l16, div3, p28, q4` -- and in this way the semantic information from the TEI encoding is preserved.

## Some considerations


