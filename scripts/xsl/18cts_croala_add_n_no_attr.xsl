<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="tei">
    <xsl:output method = "xml" indent="yes" omit-xml-declaration="no" /> 
    <!-- 17cts_croala_add_n_no_attr: remove @n from all elements under text -->
    <!-- note -->
    <xsl:include href="copy.xsl"/>
    <xsl:template match="//tei:text//*/@n"/>
    
</xsl:stylesheet>
