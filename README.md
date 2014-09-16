wadl-doc
========

XSL files to produce documentation on WADL and XSD files. We use these in our [Developer Network](https://developers.exlibrisgroup.com).

It contains the following files and features:
* wadl2doc.xsl - Converts WADL files to HTML documentation. Specifically, we use the WADL files produced by [Apache CXF](http://cxf.apache.org/)
** Documents URL parameters, querystring parameters, error codes, links to XSD-based payload document
* xsd2doc.xsl - Converts XSD schema files to HTML documentation. 
* sample.xsd - a sample of the kind of XSD file we convert
* script.js - a script which shows or hides XSD fields based on tags, allowing us to show fields only relevent in `GET` requests, for example.

