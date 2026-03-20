<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncrfiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 1 templates -->
	<xsl:template name="PartB">
		<h4>Security or Securities Affected</h4>
		  <xsl:for-each select="m1:eventOfInsolvency/m1:partBSecurityInformations/m1:partBSecurityInformation">			
			<table role="presentation">
				<tr>
					<td>
						Security Information Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
			</table>
			 <xsl:call-template name="securityInformationCover" />		
			<xsl:choose>
			
             <xsl:when test="count(m1:securityIdentifiers) &gt; 0"> 
		      <br />	
			</xsl:when>
		   </xsl:choose>	
			
			 <!-- my changes info securities-->
			 
				 <table role="presentation">

			 	
				<tr>
				<td class="label">B.2 Date(s) on which the default(s) or Event(s) of Insolvency occurred</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:eventDate" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			
				<tr>
				<td class="label">B.3 Value of affected security or securities on the date(s) on which the default(s) or event(s) of insolvency occurred</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:securityValue" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			
			<tr>
				<td class="label">B.4 Percentage of the fund's total assets represented by the affected security or securities</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:percentageOfFundsTotalAssets" />
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
		
			<xsl:call-template name="additionalInformationCover" />			
			<br />
			 	
	</xsl:template>

	<xsl:template name="securityInformationCover">

		<table role="presentation">
			<tr>
				<td class="label">B.1 Name of the issuer</td>
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
	
	

	<xsl:template name="additionalInformationCover">

		<table role="presentation">
			<tr>
				<td class="label">B.5 Brief description of actions fund plans to take, or has taken, in response to the default(s) or event(s) of insolvency</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:eventOfInsolvency/m1:actionDescription" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>
	</xsl:template>


</xsl:stylesheet>