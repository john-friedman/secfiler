<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncrfiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">


	<!-- Item 1 templates -->
	<xsl:template name="PartC">

	  <xsl:call-template name="supportC" />
		<h4>Security Supported (if applicable)</h4>
		  <xsl:for-each select="m1:disclosure/m1:partCSecurityInformations/m1:partCSecurityInformation">			
			<table role="presentation">
				<tr>
					<td>
						Security Information Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
			</table>
		 <xsl:call-template name="securityInfoC" />	
			
					
		<xsl:choose>
             <xsl:when test="count(m1:securityIdentifiers) &gt; 0"> 
		      <br />	
			</xsl:when>
		</xsl:choose>
			
			 <!-- my changes info securities-->
			 
			 <table role="presentation">
			 	
				<tr>
				<td class="label">C.7 Value of security supported on date support was initiated (if applicable)</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:securityValue" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		
			 </table>
			<br />	
			<!-- end part B my changes --> 
		 </xsl:for-each>
		
		 	<xsl:call-template name="additionalInfoC" />	
			<br />
	</xsl:template>
		 
	
		<xsl:template name="supportC">

		<table role="presentation">
			<tr>
				<td class="label">C.1 Description of nature of support</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:disclosure/m1:supportDescription" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">C.2 Person providing support</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:disclosure/m1:supportPersonName" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">C.3 Brief description of relationship between the person providing support and the fund</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:disclosure/m1:relationshipDescription" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">C.4 Date support provided</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:disclosure/m1:supportDate" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">C.5 Amount of support</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:disclosure/m1:supportAmtDescription" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>
	</xsl:template>
	

	<xsl:template name="securityInfoC">

		<table role="presentation">
			<tr>
				<td class="label">C.6 Name of the issuer</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:issuerName" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

			<tr>
				<td class="label">Title of the issue</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:issueTitle" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

			<tr>
				<td class="label">Coupon</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:coupon" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

			<tr>
				<td class="label">Yield</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:yield" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			
				<tr>
				<td class="label">Date the fund acquired the security</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:acquiredDate" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		
		<xsl:choose>
             <xsl:when test="count(m1:securityIdentifiers) &gt; 0"> 
		
			  <tr>
			     <td>
				   <h4>Identifiers</h4>
			     </td>
			  </tr>
			</xsl:when>
		</xsl:choose>	
			<xsl:for-each
				select="m1:securityIdentifiers/m1:securityIdentifier">

				<tr>
					<td>
						Security Identifier Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
		
				<tr>
					<td class="label">Identifier Type</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="m1:IdType" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
					<tr>
					<td class="label">Identifier</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="m1:IdValue" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
					<tr>
					<td class="label">Identifier Description</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="m1:IdDescription" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
			</xsl:for-each>
	
		</table>
	</xsl:template>
	
	

	<xsl:template name="additionalInfoC">

		<table role="presentation">
			<tr>
				<td class="label">C.8 Brief description of reason for support</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:disclosure/m1:reasonDescription" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			
			<tr>
				<td class="label">C.9 Term of support</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:disclosure/m1:termOfSupport" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">C.10 Brief description of any contractual restrictions relating to support</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:disclosure/m1:contractRestrictionsDesc" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>
	</xsl:template>


</xsl:stylesheet>
	
