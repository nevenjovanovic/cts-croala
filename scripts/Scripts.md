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



```

