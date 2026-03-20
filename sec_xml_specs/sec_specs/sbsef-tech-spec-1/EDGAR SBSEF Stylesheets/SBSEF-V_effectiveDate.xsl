<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="http://www.sec.gov/edgar/sbsefwvfiler"
    xmlns:p1="http://www.sec.gov/edgar/common">

	<xsl:template name="effectiveDate">		
	  	<h1><xsl:value-of select="$subType"/>: Effective Date</h1>
		<h4 class="warning" style="font-weight:normal">
			Under 242.803(f), a security-based swap execution facility may request that its registration be vacated by filing a vacation request electronically with the Commission at least 90 days prior to the date that the vacation is requested to take effect.
		</h4>
		<table role="presentation">
			<tr>
				<td class="label">Effective Date</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="/p:edgarSubmission/p:formData/p:effectiveDateInfo/p:effectiveDate"/>
					</div>
				</td>
			</tr>													
		</table>		
	</xsl:template>
</xsl:stylesheet>