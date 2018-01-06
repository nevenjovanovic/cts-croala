<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="tei">
    <xsl:output method = "xml" indent="yes" omit-xml-declaration="no" /> 
    <!-- 17cts_croala_add_n: add @n to all elements under text; the value is count of preceding siblings of the same name -->
    <!-- note -->
    <xsl:include href="copy.xsl"/>
    <xsl:template match="//tei:text//*">
        <xsl:variable name="name1" select="local-name()"/>
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n" xmlns:tei="http://www.tei-c.org/ns/1.0"><xsl:value-of select="concat(local-name() , count(preceding-sibling::*[name()=$name1]) + 1)"/></xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
