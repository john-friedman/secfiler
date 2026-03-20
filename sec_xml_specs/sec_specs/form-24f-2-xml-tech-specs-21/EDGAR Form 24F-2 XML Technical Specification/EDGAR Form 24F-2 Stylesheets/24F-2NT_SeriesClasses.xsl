<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/twentyfourf2filer"
	xmlns:ns1="http://www.sec.gov/edgar/common" 
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:feecom="http://www.sec.gov/edgar/feecommon">

	<!-- Item 1 templates -->
	<xsl:template name="seriesclasses">
      <xsl:call-template name="seriesclass" />
      <xsl:call-template name="class" />
 
	</xsl:template>

<xsl:template name="seriesclass">
<xsl:choose>
<xsl:when test="string(m1:seriesClass/m1:reportSeriesClass/m1:rptIncludeAllSeriesFlag) = 'true'">	

		<table role="presentation">
			<tr>
				<td class="label">All?</td>
				<td>
						<img
								src="Images/box-checked.jpg"
								alt="Checkbox checked" />

				</td>
			</tr>
		</table>
</xsl:when>
</xsl:choose>

 <xsl:for-each select="m1:seriesClass/m1:reportSeriesClass/m1:rptSeriesClassInfo">
<table role="presentation"><tr>Series ID Record:<xsl:value-of select="position()"></xsl:value-of></tr></table>
<br/>  
<table role="presentation">
       	<tr>
				<td class="label">Series ID</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:seriesId" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
</table>

<xsl:choose>
<xsl:when test="string(m1:includeAllClassesFlag) = 'true'">		
		<table role="presentation">
			<tr>
				<td class="label">All?</td>
				<td>

						<img
								src="Images/box-checked.jpg"
								alt="Checkbox checked" />
				</td>
			</tr>
		</table>
</xsl:when></xsl:choose>			
<xsl:for-each select="m1:classInfo">
<table role="presentation">
<tr>Class ID Record:<xsl:value-of select="position()"></xsl:value-of></tr></table>
<br/>  
<table role="presentation">
			<tr>
				<td class="label">Class ID</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:classId" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
</table>			
</xsl:for-each>
</xsl:for-each>
	</xsl:template>

<xsl:template name="class">
<xsl:choose>
<xsl:when test="string(m1:seriesClass/m1:reportClass/m1:rptIncludeAllClassesFlag) = 'true'">		
		<table role="presentation">
			<tr>
				<td class="label">All?</td>
				<td>

						<img
								src="Images/box-checked.jpg"
								alt="Checkbox checked" />
				</td>
			</tr>
		</table>
</xsl:when></xsl:choose>

 <xsl:for-each select="m1:seriesClass/m1:reportClass/m1:classInfo">
 <table role="presentation"><tr>Class ID Record:<xsl:value-of select="position()"></xsl:value-of></tr></table>
		
		<table role="presentation">
			<tr>
				<td class="label">Class ID</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:classId" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>
</xsl:for-each>
		
</xsl:template>

</xsl:stylesheet>