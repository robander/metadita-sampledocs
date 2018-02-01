# OASIS Document Types

Test to ensure that every document type provided by OASIS compiles,
in the various supported formats.

For now `allgrammars.ditamap` refers to all doctypes using all DITA 1.3
versions of the OASIS DITA DTDs and XSDs. It also refers to all (working)
DITA 1.1 and 1.2 document types (exception is Classification Map in XSD,
which complains about a missing element when it should not).

Because RNG still requires a bit of extra setup with DITA-OT, I've kept RNG
a separate map, `rnggrammars.ditamap`, which refers to all RNG doctypes
using all variants of DITA 1.3 IDs. RNG doctypes are not available with 1.1 or 1.2.