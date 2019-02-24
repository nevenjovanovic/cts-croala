# Create wordlists with XQuery

Objective: create a wordlist for a set of CroALa CTS documents, for lemmatization, normalization and other linguistic manipulations.

## Phase 1: create a simple wordlist

"Simple" means: do not combine upper- and lowercase words, do not remove accents; remove only strings containing numbers.

Our case study are poetic letters of Pavao Ritter Vitezović. In this case, we need only words under the 'text' element of the TEI document, and in that set we may disregard everything under the 'note' element.

The XQuery script: [corpus_create_wordlist_1.xq]()

## Phase 2: normalize for letter case and accents

