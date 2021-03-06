<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>

  <xsl:template match="/testcase">
    <html>
      <head>
        <script src="jquery-1.5.min.js" />
        <script src="testcase.js" />

        <title><xsl:value-of select="@id" /> Result</title>
        <link rel="stylesheet" href="testCaseStyle.css" type="text/css" />
      </head>

      <body onload="notifyParrent();">

        <div id="info">
          <xsl:call-template name="printTestInfo"/>
        </div>

        <div id="prepare">
			<xsl:for-each select="./prepare/*">
				<xsl:call-template name="printTestStep"/>
			</xsl:for-each>
		</div>

        <div id="execute">
			<xsl:for-each select="./execute/*">
				<xsl:call-template name="printTestStep"/>
			</xsl:for-each>
		</div>

        <div id="restore">
			<xsl:for-each select="./restore/*">
				<xsl:call-template name="printTestStep"/>
			</xsl:for-each>
		</div>
      </body>
    </html>    
  </xsl:template>

	<xsl:template name="printTestInfo">
		<div class="table">
			<table class="testinfo">
				<tr>
					<td class="leftside">Id:</td>
					<td><xsl:value-of select="@id" /></td>
				</tr>
				<tr>
					<td class="leftside">Description:</td>
					<td><xsl:value-of select="description" /></td>
				</tr>
				<tr>
					<td class="leftside">Verdict:</td>
					<td><xsl:value-of select="result" /></td>
				</tr>
				<tr>
					<td class="leftside">Log Files:</td>
					<td>
						<xsl:for-each select="logfile">
							<xsl:call-template name="printLogFileLink"/>
						</xsl:for-each>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="printTestStep">
		<table>
			<tr>
				<td class="step_info">
					<xsl:if test="count( substeps ) > 0">
						<img class="plusmin" src="plus.gif" onclick="showHideTestStep( this );"></img>
					</xsl:if>
				</td>
				<td class="step_id"><xsl:value-of select="displayName" /></td>
<!-- 
				<xsl:if test="command">
					<td class="step_id"><xsl:value-of select="command" /></td>
				</xsl:if>
				<xsl:if test="script">
					<td class="step_id"><xsl:value-of select="script" /></td>
				</xsl:if>
-->
				<td class="result">
					<xsl:attribute name='class'>
						<xsl:choose>
							<xsl:when test="result='PASSED'">
								tc_r_pass
							</xsl:when>
							<xsl:otherwise>
								tc_r_fail
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="result" />
				</td>
			</tr>
			<xsl:if test="description">
				<tr>
					<td class="step_info"></td>
					<td colspan="2"><xsl:value-of select="description" /></td>
				</tr>
			</xsl:if>
			<xsl:if test="count( logfile ) > 0">
				<tr>
					<td class="step_info"></td>
					<td class="leftside">Log Files:</td>
					<td>
						<xsl:for-each select="logfile">
							<xsl:call-template name="printLogFileLink"/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="comment">
				<tr>
					<td class="step_info"></td>
					<td colspan="2">
						<xsl:value-of select="./comment" />
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="count( substeps ) > 0">
				<tr class="substeps" style="display:none;">
					<td class="step_info"></td>
					<td colspan="2">
						<xsl:for-each select="substeps/teststep">
							<xsl:call-template name="printTestStep"/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>

		</table>
	</xsl:template>

	<xsl:template name="printLogFileLink">
		<span class="logfilelink">
			<a target="_blank">
				<xsl:attribute name='href'>
					<xsl:value-of select="."/>
				</xsl:attribute>
				<xsl:value-of select="@type" />
			</a>
		</span>
	</xsl:template>

</xsl:stylesheet>
