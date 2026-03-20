<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/nmfp3"
	xmlns:ns3="http://www.sec.gov/edgar/nmfp3common">
	
	<xsl:template name="item6_signature">
		<h1>N-MFP: SIGNATURES</h1>
		<h4 style="padding:10px;">
			Pursuant to the requirements of the Investment Company Act of 1940, the registrant has 
			duly caused this report to be signed on its behalf by the undersigned hereunto duly authorized
		</h4>
		<table role="presentation">
			<tr>
				<td class="label">(Registrant)</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:signature/m1:registrant)" />
					</div>					
				</td>
			</tr>
			<tr>
				<td class="label">Date</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="string(m1:signature/m1:signatureDate)" />
					</div>					
				</td>
			</tr>
			<tr>
				<td class="label">(Signature)*</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:signature/m1:signature)" />
					</div>					
				</td>
			</tr>
			<tr>
				<td class="label">Name of Signing Officer</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:signature/m1:nameOfSigningOfficer)" />
					</div>					
				</td>
			</tr>
			<tr>
				<td class="label">Title of Signing Officer</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:signature/m1:titleOfSigningOfficer)" />
					</div>					
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>

