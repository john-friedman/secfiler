<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncrfiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 4 templates -->
	<xsl:template name="PartF">	
		
		<table role="presentation">
			<tr>
					<td class="label">F.1 Optional disclosure
					</td>
					<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:optionalDisclosure/m1:optionalDisclosure)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
					</td>
				</tr>
		</table>

	</xsl:template>

</xsl:stylesheet>