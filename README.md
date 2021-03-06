# Sample DITA documents

These documents are not intented as examples of good DITA markup or organization. Instead, they
are intended to test specific aspects of DITA or DITA-OT processing.

Originally stored in the https://github.com/robander/metadita repository; moved here January 2018
as samples expanded to make it easier to use them independently.

I've been asked _why_ I'm creating these. So far, as of June 1 2016, each test serves two purposes:
 1. Demostration set for a particular feature. 
    * The original set (NLS) can be used to demonstrate every language supported in the toolkit.
    * The bookmap set demonstrates how every defined piece of bookmap is formatted in a PDF.
 1. Feature testing with DITA-OT. 
    * The NLS set can be used to test that every language works, and to test that every variable 
defined for English is also defined for every other language. 
If you heavily customize styles or variables, you could use these as a starting point to test
whether those customizations work for any other language you need.
    * The doctype test verifies that every document type supplied by OASIS will properly compile and build in DITA-OT.

## Updates

May 2017: NLS tests moved to a new repository so they can more easily be used independently:
https://github.com/robander/metadita.nlstest
