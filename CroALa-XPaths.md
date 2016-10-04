# An analysis of XPaths in CroALa

To start thinking about the possible diversity of XPaths with philologically interesting content, we have analyzed the 2,390,070 nodes in the `croala-cts-1` XML database and extracted all XPaths descending from the `TEI/text` nodes. It turns out that there are **2563** distinct paths; the deepest two have 13 levels each, while the shortest seven consist of (unsurprisingly) just two nodes.

The paths were analyzed by the XQuery [map-index-paths-from-text.xq](scripts/xq/map-index-paths-from-text.xq). The results are in [](docs/)
