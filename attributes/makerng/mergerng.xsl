<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:oasisdita="http://dita.oasis-open.org/architecture/2005/"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:sch="http://purl.oclc.org/dsdl/schematron">
  
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="/">
    <xsl:variable name="combinefiles" as="document-node()">
      <xsl:document>
        <xsl:apply-templates mode="combinefiles"/>
      </xsl:document>
    </xsl:variable>
    <rng:grammar>
      <xsl:apply-templates select="$combinefiles//*[local-name()='element']" mode="copy-element"/>
    </rng:grammar>
  </xsl:template>
  
  <xsl:template match="oasisdita:moduleDesc" mode="combinefiles"/>
  <xsl:template match="a:documentation" mode="combinefiles"/>
  <xsl:template match="rng:include" mode="combinefiles">
    <xsl:apply-templates select="document(@href,/)/*/*" mode="combinefiles"/>
  </xsl:template>
  <xsl:template match="*|@*|text()" mode="combinefiles">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()" mode="combinefiles"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[local-name()='element']" mode="copy-element">
    <xsl:variable name="inmodel" select="@name"/>
    <!--<xsl:message>Gonna work on <xsl:value-of select="$inmodel"/></xsl:message>-->
    <xsl:comment>
      ELEMENT: <xsl:value-of select="$inmodel"/>
    </xsl:comment>
    <element>
      <xsl:apply-templates select="@*|*" mode="resolve-ref">
        <xsl:with-param name="inmodel" select="$inmodel"/>
      </xsl:apply-templates>
    </element>
  </xsl:template>
  <xsl:template match="*[local-name()='element']" mode="resolve-ref">
    <xsl:param name="inmodel"/>
    <element inmode="{$inmodel}">
      <xsl:apply-templates select="@*" mode="resolve-ref"/>
    </element>
  </xsl:template>
  <xsl:template match="*[local-name()='ref']" mode="resolve-ref">
    <xsl:param name="inmodel"/>
    <xsl:variable name="refname" select="@name"/>
    <xsl:apply-templates select="//*[local-name()='define'][@name=$refname]/*" mode="resolve-ref">
      <xsl:with-param name="inmodel" select="$inmodel"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="*[local-name()='empty']" mode="resolve-ref"/>
  <xsl:template match="*" mode="resolve-ref">
    <xsl:param name="inmodel"/>
    <xsl:copy>
      <xsl:attribute name="inmodel" select="$inmodel"/>
      <xsl:apply-templates select="@*|*|text()" mode="resolve-ref">
        <xsl:with-param name="inmodel" select="$inmodel"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="@*|text()" mode="resolve-ref">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()" mode="resolve-ref"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
