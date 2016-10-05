# Revision of CroALa texts

*Objective*: produce a better and more finely-grained descriptions of works in the CroALa collection, using the CITE Architecture.

## The approach

We concentrate on composite works such as collections of poetry, of documents, or of correspondence. Each work that is at the same time a component of a larger work (the latter is a [FRBR aggregate](https://journals.ala.org/lrts/article/view/5753/7201)) will receive its own description according to the CITE Architecture, inside a `ti:work` element. In this implementation, such elements reside in a separate `__cts__.xml` file in a separate directory for each work, for example for [Zamanja's epistles, identified as urn:cts:croala:zama01.croala2075416](zama01/croala2075416/__cts__.xml).

We will proceed from "manual" descriptions to those prepared by a script and reviewed by a human philologist; and from simple cases (miscellanies, collections of poetry and of letters) to more complex ones (scholarly compilations of texts such as the [Illyricum Sacrum](http://enciklopedija.hr/natuknica.aspx?id=27106)).

## Procedure

1. Inside the textgroup directory, a new directory is prepared, named according to the model `croalaNUMBER`. The number can be random, but must be unique in the context of the textgroup.
2. In the new directory, a `__cts__.xml` file is prepared, with the contents following this model:

```xml

<ti:work xmlns:ti="http://chs.harvard.edu/xmlns/cts" groupUrn="urn:cts:croala:zama01" urn="urn:cts:croala:zama01.croala2075416" xml:lang="lat">
  <ti:title xml:lang="lat">Epistolae scriptae an. 1795. et 1796</ti:title>
  <ti:edition workUrn="urn:cts:croala:zama01.croala2075416" urn="urn:cts:croala:zama01.croala2075416.croala-lat1">
    <ti:label xml:lang="lat">Epistolae scriptae an. 1795. et 1796, versio electronica</ti:label>
    <ti:description xml:lang="hrv">Mense Decembri, 2011.</ti:description>
  </ti:edition>
</ti:work>

```

A translation of the title in a modern language should be added. Inside the `ti:description` there should be a brief, but informative text about the edition (more informative than the one shown above) - for example, a description that people would like to find in a bibliography or in a lexicon.

Finally, an XML file with the text of the edition should be added, named according to this model: `TEXTGROUP.WORK.croala-latNUMBER.xml`. As the document contains a single, non-aggregate work, the TEI XML should have the most economic structure: `TEI/text/body/l`, and not `TEI/text/body/div/l`.