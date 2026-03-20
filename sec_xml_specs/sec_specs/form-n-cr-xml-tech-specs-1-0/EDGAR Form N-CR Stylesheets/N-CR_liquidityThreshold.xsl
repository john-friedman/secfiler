<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncrfiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 5 templates -->
	<xsl:template name="PartE">
	

		 <xsl:call-template name="liquidityThresholdEventCover" />
   
	</xsl:template>
	
	<xsl:template name="liquidityThresholdEventCover">

		<table role="presentation">
			<tr>
				<td class="label">E.1 Initial date on which the fund invested less than 25% of its total assets in weekly liquid assets, if applicable
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:liquidityThresholdEvent/m1:dateOfWeeklyAssets" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			<tr>
				<td class="label">E.2 Initial date on which the fund invested less than 12.5% of its total assets in daily liquid assets, if applicable
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:liquidityThresholdEvent/m1:dateOfDailyAssets" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			<tr>
				<td class="label">E.3 Percentage of the fund's total assets invested in weekly liquid assets as of any dates reported in Items E.1 or E.2
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:liquidityThresholdEvent/m1:percentageOfWeeklyAssets" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			<tr>
				<td class="label">Percentage of the fund's total assets invested in daily liquid assets as of any dates reported in Items E.1 or E.2	 
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:liquidityThresholdEvent/m1:percentageOfDailyAssets" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
			<tr>
				<td class="label">E.4 Brief description of the facts and circumstances leading to the fund investing less than 25% of its total assets in weekly liquid assets or less than 12.5% of its total assets in daily liquid assets, as applicable	
				</td>
				<td>
					
						<div class="fakeBox3">
							<xsl:value-of
								select="m1:liquidityThresholdEvent/m1:factsDescription" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>

		</table>
	</xsl:template>


</xsl:stylesheet>