<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncrfiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">


	<xsl:template name="PartD">
		
	  <xsl:call-template name="deviationInformationCover" />
	  
		<h4>Security Information</h4>
		  <xsl:for-each select="m1:deviationAsset/m1:partDSecurityInformations/m1:partDSecurityInformation">			
			<table role="presentation">
				<tr>
					<td>
						Security Information Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
			</table>
		 <xsl:call-template name="securityInformationD" />	
			<br />	
		 </xsl:for-each>
		
	</xsl:template>
	
	
	<xsl:template name="deviationInformationCover">

		<table role="presentation">
			<tr>
				<td class="label">D.1 Date(s) on which such downward deviation exceeded 1/4 of 1 percent</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:deviationAsset/m1:exceededOnePercentDate" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">D.2 Extent of deviation between the fund's current net asset value per share and its intended stable price per share</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:deviationAsset/m1:extentOfDeviation" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">D.3 Principal reason or reasons for the deviation. If any security whose value calculated using available market quotations (or an appropriate substitute that reflects current market conditions) or sale price, or whose issuer's downgrade, default, or event of insolvency has contributed to the deviation, provide information about each security below.</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:deviationAsset/m1:reasonForDeviation" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		
		</table>
	</xsl:template>
	
	<xsl:template name="securityInformationD">

		<table role="presentation">
			<tr>
				<td class="label">Name of the issuer</td>
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
	
	

</xsl:stylesheet>
	