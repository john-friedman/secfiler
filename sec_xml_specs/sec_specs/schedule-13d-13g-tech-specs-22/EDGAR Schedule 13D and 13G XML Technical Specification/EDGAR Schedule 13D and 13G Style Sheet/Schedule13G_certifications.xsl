<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="http://www.sec.gov/edgar/schedule13g" 
	xmlns:p1="http://www.sec.gov/edgar/common">

	<xsl:template name="certification">
		<table role="presentation" id="certifications">
		    <tr>
				<td width="8%" class="tableClassValignNoBorder">Item 10.</td>
				<td width="92%" class="tableClassNoBorder">Certifications:</td>
			</tr>
			<tr class="tableClass">
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item10/p:notApplicableFlag = 'Y'">
							<div class="text">
									Not Applicable
							</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="largetext">
									<xsl:value-of select="string(p:items/p:item10/p:certifications)" disable-output-escaping="yes"/>
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>
		<br/>
	</xsl:template>
</xsl:stylesheet>