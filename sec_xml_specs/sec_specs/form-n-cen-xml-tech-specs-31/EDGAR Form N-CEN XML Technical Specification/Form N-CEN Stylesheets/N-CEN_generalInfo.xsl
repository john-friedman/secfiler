<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/ncen"
	xmlns:ns1="http://www.sec.gov/edgar/common"
	xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes"
	xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 1 templates -->
	<xsl:template name="PartA">

		<h4>Item A.1. Reporting period covered.</h4>
		<xsl:call-template name="reportingPeriodCover" />
	</xsl:template>

	<xsl:template name="reportingPeriodCover">

		<table role="presentation">
			<tr>
				<td class="label">a. Report for period ending:
				</td>
				<td>
					
						<div class="fakeBox2">
							<xsl:value-of
								select="m1:generalInfo/@reportEndingPeriod" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>

			<tr>
				<td class="label">b. Does this report cover a period of less than 12 months?</td>
				<td>
				<xsl:call-template name="yesNoRadio">
		<xsl:with-param name="yesNoElement" select="m1:generalInfo/@isReportPeriodLt12" />
				</xsl:call-template>
				</td>
			</tr>

		</table>
	</xsl:template>

</xsl:stylesheet>