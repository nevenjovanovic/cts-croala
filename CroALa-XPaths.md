# An analysis of XPaths in CroALa

To start thinking about the possible diversity of XPaths with philologically interesting content, we have analyzed the 2,390,070 nodes in the `croala-cts-1` XML database and extracted all XPaths descending from the `TEI/text` nodes. It turns out that there are **2563** distinct paths; the deepest two have 13 levels each (of type `text/body/div1/div2/div3/div4/p/table/row/cell/foreign/choice/expan`), while the shortest seven consist of (unsurprisingly) just two nodes.

The paths were analyzed by the XQuery [map-all-paths-from-text.xq](scripts/xq/map-all-paths-from-text.xq). The results are in [croala-cts-1-reflevels.xml](docs/croala-cts-1-reflevels.xml).

It is my opinion that in a scholarly edition *everything* should be citable; in a scholarly edition, everything is of some importance (if it is not, it should be left out). This means that even the longest XPath should be described, and made reachable, by CTS URNs.
