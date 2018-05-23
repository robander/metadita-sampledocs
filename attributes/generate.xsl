<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dita="http://dita.oasis-open.org/architecture/2005/"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="dita a rng sch xs">
  
  <xsl:output method="xml" encoding="UTF-8" doctype-public="-//OASIS//DTD DITA 2.0 Base Map//EN" doctype-system="basemap.dtd"/>
  
  <xsl:template match="/">
    <map>
      <xsl:for-each select="/*/*">
        <xsl:if test="normalize-space(@name)!=''">
          <xsl:variable name="parent">
            <xsl:choose>
              <xsl:when test="@name='li'">ol</xsl:when>
              <xsl:when test="@name='dlentry'">dl</xsl:when>
              <xsl:when test="@name='sli'">sl</xsl:when>
              <xsl:when test="@name='data-about'">data</xsl:when>
              <xsl:when test="@name='figgroup'">fig</xsl:when>
              <xsl:when test="@name='alt' or @name='longdescref'">image</xsl:when>
              <xsl:when test="@name='longquoteref'">lq</xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="structure" as="element()?">
            <xsl:if test="$parent=''">
              <xsl:choose>
                <xsl:when test="@name='navtitle'">
                  <topic id="navtitle"><title>navtitle</title><titlealts><navtitle conref="#navtest/test"/></titlealts>
                    <topic id="navtest"><title>Nest topic</title><titlealts><placeholder name="navtitle"/></titlealts></topic>
                  </topic>
                </xsl:when>
                <xsl:when test="@name='searchtitle'">
                  <topic id="searchtitle"><title>searchtitle</title><titlealts><searchtitle conref="#searchtitletest/test"/></titlealts>
                    <topic id="searchtitletest"><title>Nest topic</title><titlealts><placeholder name="searchtitle"/></titlealts></topic>
                  </topic>
                </xsl:when>
                <xsl:when test="@name='titlealts'">
                  <topic id="titlealts"><title>titlealts</title><titlealts conref="#titlealtstest/test"/>
                    <topic id="titlealtstest"><title>Nest topic</title><placeholder name="titlealts"/></topic>
                  </topic>
                </xsl:when>
                <xsl:when test="@name='section' or @name='example' or @name='bodydiv'">
                  <topic id="{@name}"><title><xsl:value-of select="@name"/></title><body>
                    <xsl:element name="{@name}"><xsl:attribute name="conref" select="'#./test'"/></xsl:element>
                    <placeholder name="{@name}"/></body></topic>
                </xsl:when>
                <xsl:when test="@name='body'">
                  <topic id="body"><title>body</title>
                    <topic id="body1"><title>nest1</title><body conref="#body2/test"/></topic>
                    <topic id="body2"><title>nest2</title><placeholder name="body"/></topic>
                  </topic>
                </xsl:when>
                <xsl:when test="@name='desc'">
                  <topic id="desc"><title>desc</title><body><fig><desc conref="#./test"/></fig><fig><placeholder name="desc"/></fig></body></topic>
                </xsl:when>
                <xsl:when test="@name='itemgroup'">
                  <topic id="itemgroup"><title>itemgroup</title><body><ol><li><itemgroup conref="#./test"/><placeholder name="itemgroup"/></li></ol></body></topic>
                </xsl:when>
                <xsl:when test="@name='dlhead'">
                  <topic id="dlhead"><title>dlhead</title><body><dl><dlhead conref="#./test"><dthd/><ddhd/></dlhead><dlentry><dt/><dd/></dlentry></dl>
                    <dl><placeholder name="dlhead"/><dlentry><dt/><dd/></dlentry></dl></body></topic>
                </xsl:when>
                <xsl:when test="@name='dt'">
                  <topic id="dt"><title>dt</title><body><dl><dlentry><dt conref="#./test"/><dd/></dlentry><dlentry><placeholder name="dt"/><dd/></dlentry></dl></body></topic>
                </xsl:when>
                <xsl:when test="@name='dd'">
                  <topic id="dd"><title>dd</title><body><dl><dlentry><dt/><dd conref="#./test"/></dlentry><dlentry><dt/><placeholder name="dd"/></dlentry></dl></body></topic>
                </xsl:when>
                <xsl:when test="@name='dthd'">
                  <topic id="dthd"><title>dthd</title><body><dl><dlhead><dthd conref="#./test"/><ddhd/></dlhead><dlentry><dt/><dd/></dlentry></dl>
                    <dl><dlhead><placeholder name="dthd"/><ddhd/></dlhead><dlentry><dt/><dd/></dlentry></dl></body></topic>
                </xsl:when>
                <xsl:when test="@name='ddhd'">
                  <topic id="ddhd"><title>ddhd</title><body><dl><dlhead><dthd/><ddhd conref="#./test"/></dlhead><dlentry><dt/><dd/></dlentry></dl>
                    <dl><dlhead><dthd/><placeholder name="ddhd"/></dlhead><dlentry><dt/><dd/></dlentry></dl></body></topic>
                </xsl:when>
              </xsl:choose>
            </xsl:if>
          </xsl:variable>
          <xsl:message>Should generate <xsl:value-of select="@name"/></xsl:message>
          <topicref href="{@name}.dita"/>
          <xsl:choose>
            <xsl:when test="not(empty($structure))">
              <xsl:result-document href="{@name}.dita" doctype-public="-//OASIS//DTD DITA 2.0 Base Topic//EN" doctype-system="basetopic.dtd">
                <xsl:apply-templates select="$structure" mode="variabletopic">
                  <xsl:with-param name="ctx" select="." as="element()"/>
                </xsl:apply-templates>
              </xsl:result-document>
            </xsl:when>
            <xsl:when test="not(empty($parent))">
              <xsl:apply-templates select="." mode="generate-in-section">
                <xsl:with-param name="parent" select="$parent"/>
              </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="." mode="generate-in-section"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:for-each>
    </map>
  </xsl:template>
  
  <xsl:template match="placeholder" mode="variabletopic">
    <xsl:param name="ctx"/>
    <xsl:element name="{@name}">
      <xsl:apply-templates select="$ctx//rng:attribute" mode="add-attributes"/>
      <xsl:apply-templates select="$ctx" mode="required-children"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="*|@*|text()|processing-instruction()" mode="variabletopic">
    <xsl:param name="ctx"/>
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()" mode="variabletopic">
        <xsl:with-param name="ctx" select="$ctx"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" mode="generate-in-section">
    <xsl:param name="parent" as="xs:string?"/>
    <xsl:variable name="elname" select="@name"/>
      <xsl:result-document href="{$elname}.dita" doctype-public="-//OASIS//DTD DITA 2.0 Base Topic//EN" doctype-system="basetopic.dtd">
        <topic id="{$elname}">
          <title>Test <xsl:value-of select="$elname"/></title>
          <body>
            <section>
              <xsl:choose>
                <xsl:when test="$parent=''">
                  <xsl:element name="{$elname}">
                    <xsl:attribute name="conref">#./test</xsl:attribute>
                    <xsl:apply-templates select="." mode="required-children"/>
                  </xsl:element>
                  <xsl:element name="{$elname}">
                    <xsl:apply-templates select=".//rng:attribute" mode="add-attributes"/>
                    <xsl:apply-templates select="." mode="required-children"/>
                  </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:message>Maybe not working with [<xsl:value-of select="$parent"/>]</xsl:message>
                  <xsl:element name="{$parent}">
                    <xsl:element name="{$elname}">
                      <xsl:attribute name="conref">#./test</xsl:attribute>
                      <xsl:apply-templates select="." mode="required-children"/>
                    </xsl:element>
                  </xsl:element>
                  <xsl:element name="{$parent}">
                    <xsl:element name="{$elname}">
                      <xsl:apply-templates select=".//rng:attribute" mode="add-attributes"/>
                      <xsl:apply-templates select="." mode="required-children"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:otherwise>
              </xsl:choose>
            </section>
          </body>
        </topic>
      </xsl:result-document>
    
  </xsl:template>
  
  <xsl:template match="*" mode="required-children">testcontent</xsl:template>
  <xsl:template match="*[@name='data-about']" mode="required-children"><data>testcontent</data></xsl:template>
  <xsl:template match="*[@name='ul' or @name='ol']" mode="required-children"><li>testcontent</li></xsl:template>
  <xsl:template match="*[@name='sl']" mode="required-children"><sli>testcontent</sli></xsl:template>
  <xsl:template match="*[@name='dl']" mode="required-children"><dlentry><dt>test</dt><dd>test</dd></dlentry></xsl:template>
  <xsl:template match="*[@name='dlentry']" mode="required-children"><dt>test</dt><dd>test</dd></xsl:template>
  <xsl:template match="*[@name='dlhead']" mode="required-children"><dthd>test</dthd><ddhd>test</ddhd></xsl:template>
  <xsl:template match="*[@name='longquoteref' or @name='longdescref']" mode="required-children"></xsl:template>
  <xsl:template match="*[@name='fig' or @name='figgroup']" mode="required-children"><p>test</p></xsl:template>
  <xsl:template match="*[@name='image']" mode="required-children"><alt>test</alt></xsl:template>
  <xsl:template match="*[@name='tm']" mode="required-children"><xsl:attribute name="tmtype">reg</xsl:attribute>trademark</xsl:template>
  <xsl:template match="*[@name='state']" mode="required-children"><xsl:attribute name="name">test</xsl:attribute><xsl:attribute name="value">test</xsl:attribute></xsl:template>
  
  <xsl:template match="*[@name='conref']" mode="add-attributes"/>
  <xsl:template match="*[@name='xml:space']" mode="add-attributes">
    <xsl:attribute name="xml:space">preserve</xsl:attribute>
  </xsl:template>
  <xsl:template match="*[@name='xml:lang']" mode="add-attributes">
    <xsl:attribute name="xml:lang">en</xsl:attribute>
  </xsl:template>
  <xsl:template match="*" mode="add-attributes">
    <xsl:attribute name="{@name}">
      <xsl:choose>
        <xsl:when test="rng:choice"><xsl:value-of select="rng:choice/rng:value[1]"/></xsl:when>
        <xsl:otherwise>test</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>
