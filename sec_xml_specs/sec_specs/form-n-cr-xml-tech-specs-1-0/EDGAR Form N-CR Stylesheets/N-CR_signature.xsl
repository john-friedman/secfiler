<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncrfiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 4 templates -->
	<xsl:template name="Signatures">
		<xsl:call-template name="Signature" />
	</xsl:template>


	<xsl:template name="Signature">

		<table role="presentation">
			<tr>
				<td colspan="3">
					Pursuant to the requirements of the Investment Company Act of 1940, the registrant has duly caused this report to be signed 
					on its behalf by the undersigned hereunto duly authorized.
		</td>
			</tr>
			<tr>

				<td class="label">Registrant</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of select="m1:signatureBlock/m1:name" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
		

			<tr>

				<td class="label">Signature</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of select="m1:signatureBlock/m1:signature" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>

			<tr>
				<td class="label">Title</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of select="m1:signatureBlock/m1:title" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			
				<tr>
				<td class="label">Date</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of select="m1:signatureBlock/m1:signatureDate" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>

		</table>

	</xsl:template>
</xsl:stylesheet>