<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="http://www.sec.gov/edgar/sbsefwvfiler"
    xmlns:p1="http://www.sec.gov/edgar/common">
	
	<xsl:template name="formdata" match="p:edgarSubmission/p:formData">
	<xsl:if test="(p:signatureInfo)">				
		<h1><xsl:value-of select="$subType"/>: Signature</h1>
		<h4 class="warning" style="font-weight:normal">
			The Applicant and the undersigned represent hereby that all information contained herein is true, current, and complete.
		</h4>
		<table role="presentation">
			<tr>
				<td class="label" style="font-size: 15px;">
					Applicant has duly caused this application, amendment, or withdrawal to be signed on its behalf by the undersigned, hereunto duly authorized, on this date 
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="p:signatureInfo/p:signatureDate"/>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">
					Name of Applicant
				</td>
				<td>
					<div class="fakeBox">
						<xsl:value-of select="p:signatureInfo/p:signatureApplicantName"/>
					</div>
				</td>
			</tr>	
			<tr>
				<td class="label">
					Signature of Duly Authorized Person
				</td>
				<td>
					<div class="fakeBox">
						<xsl:value-of select="p:signatureInfo/p:signatureAuthorizedPerson"/>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">
					Title of Signatory 
				</td>
				<td>
					<div class="fakeBox">
						<xsl:value-of select="p:signatureInfo/p:signatureTitle"/>
					</div>
				</td>
			</tr>										
		</table>
	</xsl:if>
	</xsl:template>
</xsl:stylesheet>