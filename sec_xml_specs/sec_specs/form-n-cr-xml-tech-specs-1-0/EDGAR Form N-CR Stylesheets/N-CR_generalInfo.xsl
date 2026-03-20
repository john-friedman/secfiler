<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/ncrfiler"
	xmlns:ns1="http://www.sec.gov/edgar/common"
	xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes"
	xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 1 templates -->
	<xsl:template name="PartA">

		<h4>General Information</h4>
		 <xsl:call-template name="reportingPeriodCover" />
		 <h4>Registrant</h4>
		 <xsl:call-template name="registrantInfoCover" />
		 <h4>Series</h4>
		 <xsl:call-template name="seriesInfoCover" />
		 <h4>Authorized Contact Information</h4>
		 <xsl:call-template name="authorizedContactInfoCover" />
	</xsl:template>

	<xsl:template name="reportingPeriodCover">

		<table role="presentation">
			<tr>
				<td class="label">A.1 Date of report
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:reportDate" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>

		</table>
	</xsl:template>
	
	
		<xsl:template name="registrantInfoCover">

		<table role="presentation">
			<tr>
				<td class="label">A.2 Name of registrant
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:registrantName" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			
				<tr>
				<td class="label">A.3 CIK Number of registrant 
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:registrantCik" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			
				<tr>
				<td class="label">A.4 LEI of registrant
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:registrantLei" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>

		</table>
	</xsl:template>
	
		<xsl:template name="seriesInfoCover">

		<table role="presentation">
			<tr>
				<td class="label">A.5 Name of series
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:seriesName" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			
			<tr>
				<td class="label">A.6 EDGAR Series Identifier
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:seriesId" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			
			<tr>
				<td class="label">A.7 LEI of series
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:seriesLei" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			
			<tr>
				<td class="label">A.8 Securities Act File Number
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:fileNumber" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>

		</table>
	</xsl:template>
	
		<xsl:template name="authorizedContactInfoCover">

		<table role="presentation">
			<tr>
				<td class="label">A.9 Name
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:contact/m1:name" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
				<tr>
				<td class="label">E-mail Address
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo//m1:contact/m1:emailAddress" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			
			<tr>
				<td class="label">Phone Number 
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/m1:contact/m1:phoneNumber" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
					

		</table>
	</xsl:template>


</xsl:stylesheet>