<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:wix="http://schemas.microsoft.com/wix/2006/wi">
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:key name="exe-search" match="wix:Component[contains(wix:File/@Source, '.exe')]" use="@Id" />
  <xsl:key name="pdb-search" match="wix:Component[contains(wix:File/@Source, '.pdb')]" use="@Id" />
  <xsl:key name="config-search" match="wix:Component[contains(wix:File/@Source, '.config')]" use="@Id" />

  <xsl:template match="wix:Component[key('pdb-search', @Id)]" />
  <xsl:template match="wix:Component[key('config-search', @Id)]" />

  <xsl:template match="wix:ComponentRef[key('pdb-search', @Id)]" />
  <xsl:template match="wix:ComponentRef[key('config-search', @Id)]" />

  <xsl:template match="wix:Component[key('exe-search', @Id)]">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:attribute name="Id">
        <xsl:value-of select="@Id" />
      </xsl:attribute>
      <xsl:attribute name="Guid">
        <xsl:value-of select="@Guid" />
      </xsl:attribute>
      <xsl:apply-templates select="node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

