# CroALa to CapiTainS

**Objective**: make texts from CroALa pass all tests in [HookTest](https://github.com/Capitains/HookTest), with the view to eventually ingest CroALa in the CapiTainS Nemo system.

## Barrier 1: URN conventions

Texts in CroALa have their base URN at `TEI/text/@xml:base`, while HookTest, following the CapiTainS guidelines, currently looks for them in 
