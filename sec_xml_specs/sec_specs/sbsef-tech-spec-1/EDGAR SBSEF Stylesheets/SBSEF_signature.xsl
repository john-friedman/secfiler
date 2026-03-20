<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/sbseffiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/sbsefcommon"
	xmlns:exa="http://www.sec.gov/edgar/document/sbsef/exhibita"
	xmlns:exb="http://www.sec.gov/edgar/document/sbsef/exhibitb"
	xmlns:exgmn="http://www.sec.gov/edgar/document/sbsef/exhibitgmn"
	xmlns:ext="http://www.sec.gov/edgar/document/sbsef/exhibitt">

	<!-- Item 6 templates -->
	<xsl:template name="Signature">
	
	
 <xsl:if test="count(m1:signatureInfo) &gt; 0">	
	<h1><xsl:value-of select="$subType"/>: Signature</h1>
			<h3>
			<em>Signature
			</em>
		</h3>
		<table role="presentation" >
			<tr>
				<h4>
					<em>
						The Applicant and the undersigned represent hereby that all information contained herein is true, current, and complete. It is understood that all required items and Exhibits are considered integral parts of this Form SBSEF and that the submission of any amendment represents that all unamended items and Exhibits remain true, current, and complete as previously filed.

					</em>
				</h4>
			</tr>
			
	</table>
	 	<xsl:call-template name="sign" />
	</xsl:if>
</xsl:template>
   <xsl:template name="sign">
   
    <xsl:if test="count(m1:signatureInfo/m1:signatureConfFlag) &gt; 0
		   or count(m1:signatureInfo/m1:signatureDate) &gt; 0
		    or count(m1:signatureInfo/m1:signatureApplicantName) &gt; 0
		    or count(m1:signatureInfo/m1:signatureAuthorizedPerson) &gt; 0
		     or count(m1:signatureInfo/m1:signatureTitle) &gt; 0">	
		<table role="presentation" style="border:groove">
		
		 <xsl:if test="count(m1:signatureInfo/m1:signatureConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:signatureInfo/m1:signatureConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(m1:signatureInfo/m1:signatureDate) &gt; 0 ">
			<tr>
				<td class="label">Applicant has duly caused this application, amendment,
				 or withdrawal to be signed on its behalf by the undersigned,
				  hereunto duly authorized, on this date
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:signatureInfo/m1:signatureDate)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
	    </xsl:if>
	     <xsl:if test="count(m1:signatureInfo/m1:signatureApplicantName) &gt; 0 ">
			<tr>
				<td class="label">Name of Applicant  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of
									select="string(m1:signatureInfo/m1:signatureApplicantName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(m1:signatureInfo/m1:signatureAuthorizedPerson) &gt; 0 ">
			<tr>
				<td class="label">Signature of Duly Authorized Person
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:signatureInfo/m1:signatureAuthorizedPerson)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(m1:signatureInfo/m1:signatureTitle) &gt; 0 ">
			<tr>
				<td class="label">Title of Signatory  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:signatureInfo/m1:signatureTitle)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
		
		</table>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>