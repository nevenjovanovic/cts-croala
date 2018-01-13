# CroALa, a CTS edition

Current release: [![DOI](https://zenodo.org/badge/69696146.svg)](https://zenodo.org/badge/latestdoi/69696146)

Current build status: [![Build Status](https://travis-ci.org/nevenjovanovic/cts-croala.svg?branch=master)](https://travis-ci.org/nevenjovanovic/cts-croala)

Neo-Latin texts from [CroALa](http://croala.ffzg.unizg.hr) made conformant to the requirements of the [CITE Architecture](http://cite-architecture.github.io/) and the [CapiTainS guidelines](http://capitains.github.io/pages/guidelines).


## The team

[Neven Jovanović](http://orcid.org/0000-0002-9119-399X), Department of Classical Philology, Faculty of Humanities and Social Sciences, University of Zagreb, Croatia

Alex Simrell, College of the Holy Cross, Worcester, Massachusetts and University of Zagreb, Croatia (2016-2017)

## The task

At the moment, [CroALa](https://github.com/nevenjovanovic/croatiae-auctores-latini-textus) contains 483 documents and about 5.66 million words.

Of the 483 documents, [443](docs/notcroalactsmulti.list) were easy to describe semi-automatically -- via [XQuery scripts](scripts/Scripts.md) -- according to CTS metadata requirements.  The rest (see [a list](docs/croalactsmulti.list)) have multiple authors or other issues.

As we are following the [CapiTainS guidelines](http://capitains.github.io/pages/guidelines) on metadata and directory structure, it has been necessary to rename files in the collection. There is a [concordance file](docs/croalactsconcordance.xml) listing old and new file names.

To learn why we chose to depart from the CapiTainS conventions, and to provide a different interpretation of the CITE Architecture, see the [CroALa CTS explained](CroALa-CTS-explained.md). For an exploration of XPaths number of nodes in CroALa, see [CroALa XPaths](CroALa-XPaths.md).

The task of making this version of CroALa compliant to current CapiTainS setup and conventions is described in [CroALa to CapiTainS](CroALa-CapiTainS.md). Some implications of this task are also sketched there.

## Contents

+ The XML files and metadata are in [data](data)
+ The XQuery scripts used to produce this version are in [scripts](scripts), as well as their [description](scripts/Scripts.md)
+ Files with additional information are in [docs](docs)

## License

[CC-BY](LICENSE.md)

