<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/nmfp3"
	xmlns:ns3="http://www.sec.gov/edgar/nmfp3common">

	<xsl:import href="util.xsl" />

	<xsl:output 
		method="html" 
		indent="no" 
		encoding="iso-8859-1"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="css/SDR_print.css" />
				<style type="text/css">
					img {
						vertical-align:text-top;
					}
				</style>
			</head>

			<body lang="en-US" text="#000000" bgcolor="#ffffff">
				<div style="display:none">
					schemaVersion: 
					<xsl:value-of select="string(m1:edgarSubmission/m1:schemaVersion)" />
				</div>
				
				<xsl:call-template name="header" />
			</body>
		</html>
		
		<xsl:apply-templates select="m1:edgarSubmission/m1:headerData"/>
		<xsl:apply-templates select="m1:edgarSubmission/m1:formData"/>
		<xsl:apply-templates select="m1:edgarSubmission/m1:documents"/>
	</xsl:template>

	<!-- Header Template START -->
	<xsl:template name="header">
		<div class="contentwrapper">
			<table role="presentation" id="header">
				<tr>
					<td rowspan="2" class="center">
						UNITED STATES
						<br />
						SECURITIES AND EXCHANGE COMMISSION
						<br />
						WASHINGTON, D.C. 20549
						<br />
						<br />
						FORM N-MFP
						<br />
						MONTHLY SCHEDULE OF PORTFOLIO HOLDINGS
						<br/>
						OF MONEY MARKET FUNDS
					</td>
				</tr>		
			</table>
		</div>
	</xsl:template>
	<!-- Header Template END -->

	<!-- N-MFP: Filer Information Template START -->
	<xsl:template name="headerData" match="m1:edgarSubmission/m1:headerData">
		<div id="info">
			<div class="contentwrapper">
				<div class="content">
					<h1>N-MFP: Filer Information</h1>
					<table role="presentation">
						<tr>
							<td class="label">
								Submission Type
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string(m1:submissionType) = 'N-MFP3'">
										<img src="Images/radio-checked.jpg" alt="Radio button checked" /> 
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
									</xsl:otherwise>
								</xsl:choose>&#160;N-MFP3&#160;&#160;
								<xsl:choose>
									<xsl:when test="string(m1:submissionType) = 'N-MFP3/A'">
										<img src="Images/radio-checked.jpg" alt="Radio button checked" /> 
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
									</xsl:otherwise>
								</xsl:choose>&#160;N-MFP3/A
							</td>
						</tr>					
						<tr>
							<td class="label">
								CIK
							</td>
							<td>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:filerInfo/m1:filer/m1:filerCredentials/m1:cik)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">
								CCC
							</td>
							<td>
								<div class="fakeBox2">
									xxxxxxxx
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">
								Test or Live
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string(m1:filerInfo/m1:liveTestFlag) = 'LIVE'">
										<img src="Images/radio-checked.jpg" alt="Radio button checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
									</xsl:otherwise>
								</xsl:choose>&#160;LIVE&#160;&#160;
								<xsl:choose>
									<xsl:when test="string(m1:filerInfo/m1:liveTestFlag) = 'TEST'">
										<img src="Images/radio-checked.jpg" alt="Radio button checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
									</xsl:otherwise>
								</xsl:choose>&#160;TEST
							</td>
						</tr>	
						<tr>
							<td class="label">
								Is this an electronic copy of an official filing submitted in paper format?
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string(m1:filerInfo/m1:confirmingCopyFlag) = 'Y'">
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> 
									</xsl:otherwise>
								</xsl:choose>&#160;Yes&#160;&#160;
								<xsl:choose>
									<xsl:when test="string(m1:filerInfo/m1:confirmingCopyFlag) = 'N'">
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
									</xsl:otherwise>
								</xsl:choose>&#160;No								
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:decimal-format name="percentage" digit="d"/>
	
	<xsl:variable name="submissionType" select="m1:edgarSubmission/m1:headerData/m1:submissionType" />
	<xsl:variable name="masterFundFlagYesNo" select="m1:edgarSubmission/m1:formData/m1:seriesLevelInfo/m1:masterFundFlag" />
	
	<xsl:template name="formData" match="m1:edgarSubmission/m1:formData">
		<h1>N-MFP: Filing Information</h1>
		<xsl:call-template name="item1_generalInformation"/>
		<xsl:call-template name="item2_partA"/>
		<xsl:call-template name="item3_partB"/>
		<xsl:call-template name="item4_partC"/>
		<xsl:call-template name="item5_partD"/>
		<xsl:call-template name="item6_signature"/>
	</xsl:template>

	<xsl:include href="N-MFP3_item1.xsl" />
	<xsl:include href="N-MFP3_item2.xsl" />
	<xsl:include href="N-MFP3_item3.xsl" />
	<xsl:include href="N-MFP3_item4.xsl" />
	<xsl:include href="N-MFP3_item5.xsl" />
	<xsl:include href="N-MFP3_item6.xsl" />
	<xsl:include href="SDR_State_Codes.xsl" />
</xsl:stylesheet>