# The CroALa CTS XQuery scripts

We are following the model in [capitains.github.io/pages/guidelines](http://capitains.github.io/pages/guidelines). For our database and XQuery processor we use [BaseX](http://basex.org/).

## Making the XML CTS-conformant

+ First, we need to create workgroups, as directories and metadata descriptions; to achieve that in an uniform way, we call the [croalabib](https://bitbucket.org/nevenjovanovic/croalabiblio) XML db (for authors' names)
+ We need to create work directories inside each workgroup
+ The appropriate files have to be moved into the work directories
+ File names have to be changed, but a concordance list (old name - new name) will be kept

The scripts work locally, paths of files have to be changed. They also rely on several XML databases.

  + List files with multiple authors: [cts-list-multiauthor.xq](xq/cts-list-multiauthor.xq)
  + Subtract files with multiple authors from the cts-croala db: [subtract-multiauthors.xq](xq/subtract-multiauthors.xq)
  + Prepare a list of author refs (IDs) for croalabib: [cts-get-refs-from-croalabib.xq](xq/cts-get-refs-from-croalabib.xq)
  + Prepare a list of textgroups: [cts-list-from-croalabib.xq](xq/cts-list-from-croalabib.xq)

All these scripts are combined in [create-single-author-textgroups.bxs](bxs/create-single-author-textgroups.bxs).

In the next phase, we use a helper index file [croalactstextgroups.xml](../docs/croalactstextgroups.xml), created with [croalacts-create-work-metadata.xq](xq/croalacts-create-work-metadata.xq).

+ Create directories for each **textgroup** (in rad/croalacts/data): [croalacts-create-dirs.xq](xq/croalacts-create-dirs.xq)
+ Put a `__cts__.xml` file with **metadata** in each textgroup dir: [croalacts-create-textgroup-metadata.xq](xq/croalacts-create-textgroup-metadata.xq)
+ Create works directories: [croalacts-create-dirs-works.xq](xq/croalacts-create-dirs-works.xq)
+ Put the XML documents into directories, rename the XML files: [croalacts-move-docs-to-works.xq](croalacts-move-docs-to-works.xq)
+ Create `__cts__.xml` metadata for works: [croalacts-works-create-metadata.xq](xq/croalacts-works-create-metadata.xq)

## Create the database

The (development) database which will be created from files in [data](../data) is called `croala-cts-1`. It can be created and replicated with the script [create-croalacts-db.bxs](bxs/create-croalacts-db.bxs), provided you correct the absolute path of the `data` directory.

On our development server, the script is run by:

```bash

./basex/bin/basex /home/croala/cts-croala/scripts/bxs/create-croalacts-db.bxs

```

Then we move the XQuery modules (`croalacts.xqm`, `functx.xqm`) and scripts to required places:

```bash

rsync -avzP scripts/restxq/cts-open-urn.xq ~/basex/webapp/restxq/

rsync -avzP scripts/xqm/*.xqm ~/basex/repo/


```

We test the setup by going to, for example, [croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6](http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6). Or, if we want, we open a CTS URN several levels up: [croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6](http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6).

## Navigating the CTS URN system

CTS URNs present texts at several levels:

+ textgroups (usually sharing the same author, or authors, or identity)
+ works (belonging to textgroups, instantiated in different editions)
+ editions (realizations of works, differing in textual readings, layout, language)
+ segments (all divisions of an edition we find necessary)

There are XQuery functions to display, or access, everything CroALa has at each level.

All functions are part of the [croalacts.xqm](xqm/croalacts.xqm) XQuery [library module](http://docs.basex.org/wiki/Repository#Accessing_Modules).

The functions were developed using unit testing. The tests are in [ctstest.xqm](xq/testing/ctstest.xqm).

Results of XQueries are displayed as web pages using the [BaseX RESTXQ API](http://docs.basex.org/wiki/RESTXQ). The RESTXQ scripts are in [restxq](restxq), as follows:

+ [cts-list-textgroups.xq](restxq/cts-list-textgroups.xq) displays a list of textgroup URNs available in CroALa; see it on the CroALa site: [croala.ffzg.unizg.hr/basex/conglomerationes](http://croala.ffzg.unizg.hr/basex/conglomerationes)
+ [cts-list-works.xq](restxq/cts-list-works.xq) lists all works belonging to a textgroup; on the CroALa site, for example: [croala.ffzg.unizg.hr/basex/ctsconglomeratio/urn:cts:croala:skrl01](http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/urn:cts:croala:skrl01); note that the URL [croala.ffzg.unizg.hr/basex/ctsconglomeratio/index](http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/index) lists all works available in CroALa, in alphabetical order
+ [cts-list-editions.xq](restxq/cts-list-editions.xq) lists all editions of a work available in CroALa -- currently only one per work; on the CroALa site, for example, [croala.ffzg.unizg.hr/basex/ctsopus/urn:cts:croala:anonymus_1066.croala842559](http://croala.ffzg.unizg.hr/basex/ctsopus/urn:cts:croala:anonymus_1066.croala842559); again, [croala.ffzg.unizg.hr/basex/ctsopus/index](http://croala.ffzg.unizg.hr/basex/ctsopus/index) lists all editions available
+ [cts-list-nodes.xq](restxq/cts-list-nodes.xq) lists CTS URNs of all textual nodes in an edition (in its original sequence), for example [croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:selimb01.croala1579857.croala-lat1](http://croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:selimb01.croala1579857.croala-lat1)
+ [cts-open-urn.xq](restxq/cts-open-urn.xq) displays text, or whatever else belongs to a CTS URN node; for example [croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:selimb01.croala1579857.croala-lat1:text.front.div](http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:selimb01.croala1579857.croala-lat1:text.front.div)

