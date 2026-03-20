<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:p="http://www.sec.gov/edgar/schedule13g"
				xmlns:p1="http://www.sec.gov/edgar/common">


	<xsl:output
			method="html"
			indent="no"
			encoding="iso-8859-1"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
	<xsl:variable name = "submissionType" select = "p:edgarSubmission/p:headerData/p:submissionType" />
	<xsl:variable name="cusipNo" select="p:edgarSubmission/p:formData/p:coverPageHeader/p:issuerInfo/p:issuerCusip" />
	<xsl:variable name="amendmentOrNot" select="p:edgarSubmission/p:headerData/p:submissionType" />

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="css/SDR_print.css" />
				<style type="text/css">
					.fakeTextBox {
					border-top: 2px solid #999;
					border-right: 1px solid #ccc;
					border-bottom: 1px solid #ccc;
					border-left: 2px solid #999;
					padding: 2px;
					_width: 800px;
					height: auto;
					min-width: 200px;
					min-height: 50px;
					word-wrap: break-word;
					font-size: 0.9em;
					color: blue;
					}
				</style>
				<style type="text/css">
					table.tableClass { border: solid black;
					border-top-width: 1;
					border-right-width: 1;
					border-bottom-width: 1;
					border-left-width: 1;
					table-layout:fixed;
					}
					table.innerTableClass { border: solid black;
					border-top-width: 0;
					border-right-width: 0;
					border-bottom-width: 0;
					border-left-width: 0;
					table-layout:fixed;
					}
					table.collapsabletableClass {
					border-collapse:collapse;
					border-top-width: 0;
					border-right-width: 0;
					border-bottom-width: 0;
					border-left-width: 0;
					table-layout:fixed;
					}
					th.tableClassLeft { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					padding: 2px;
					}
					th.tableClassRight { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 0;
					padding: 2px;
					}
					th.tableClass { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					padding: 2px;
					}
					td.tableClassLeft { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					font-size: 0.9em;
					color: blue;
					word-wrap: break-word;
					}
					td.tableClassRight { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 0;
					font-size: 0.9em;
					color: blue;
					word-wrap: break-word;
					}
					td.tableClass { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					font-size: 0.9em;
					font-weight:bold;
					color: black;
					word-wrap: break-word;
					}
					td.tableClassNoBorder { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 0px;
					border-left-width: 0px;
					font-size: 0.9em;
					font-weight:bold;
					color: black;
					word-wrap: break-word;
					}

					td.tableClassNoBorderBlue { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 0px;
					border-left-width: 0px;
					font-size: 0.9em;
					font-weight:bold;
					color: blue;
					word-wrap: break-word;
					}

					td.tableClassInnerNoBorderBlue { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 0px;
					border-left-width: 0px;
					font-size: 1.4em;
					font-weight:bold;
					color: blue;
					word-wrap: break-word;
					}

					td.tableClassNoBorderAlignLeft { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 0px;
					border-left-width: 0px;
					font-size: 0.9em;
					font-weight:bold;
					text-align: left;
					color: black;
					word-wrap: break-word;
					}

					td.signature {
					padding: 4px 8px;
					}

					td.tableClassInner { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					font-size: 1em;
					font-weight:bold;
					color: black;
					word-wrap: break-word;
					}

					td.tableClassValign { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					font-size: 0.9em;
					font-weight:bold;
					color: black;
					vertical-align: middle;
					text-align: center;
					word-wrap: break-word;
					}

					td.tableClassValignNoBorder { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 0px;
					border-left-width: 0px;
					font-size: 0.9em;
					font-weight:bold;
					color: black;
					vertical-align: middle;
					text-align: center;
					word-wrap: break-word;
					}

					td.tableClassValignInner { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					font-size: 1em;
					font-weight:bold;
					color: black;
					vertical-align: middle;
					text-align: center;
					word-wrap: break-word;
					}

					td.innerTableClassRightValign { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 0;
					font-size: 1em;
					font-weight:bold;
					color: black;
					vertical-align: middle;
					text-align: center;
					word-wrap: break-word;
					}

					td.innerTableClassRightValignBottomLess { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 0px;
					border-left-width: 0;
					font-size: 1em;
					font-weight:bold;
					color: black;
					vertical-align: middle;
					text-align: center;
					word-wrap: break-word;
					}

					td.tableClassInnerLeft { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					font-size: 1em;
					font-weight:bold;
					color: black;
					word-wrap: break-word;
					}

					td.tableClassInnerLeftBottomLess { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 0px;
					border-left-width: 1px;
					font-size: 1em;
					font-weight:bold;
					color: black;
					word-wrap: break-word;
					}

					td.tableClassNoBorderAlignCenter { border: solid black;
					border-top-width: 0px;
					border-right-width: 0px;
					border-bottom-width: 0px;
					border-left-width: 0px;
					font-size: 0.9em;
					font-weight:bold;
					color: black;
					text-align: center;
					word-wrap: break-word;
					}

					tr.tableClass { border: solid black;
					border-top-width: 1px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					}
					tr.tableClassWithBg { border: solid black;
					border-top-width: 0;
					border-right-width: 1;
					border-bottom-width: 1;
					border-left-width: 0;
					background-color: #e0e0ff
					}

					tr.tableClassWithBgBlack { border: solid black;
					border-top-width: 0;
					border-right-width: 1;
					border-bottom-width: 1;
					border-left-width: 0;
					background-color: #D3D3D3
					}

					hr.header {
					position: relative;
					top: 20px;
					border: none;
					height: 6px;
					background: black;
					margin-bottom: 10px;
					}

					hr.separatorThin {
					position: relative;
					top: 2px;
					border: none;
					height: 2px;
					background: black;
					margin-bottom: 2px;
					}

					hr.headerThin {
					position: relative;
					top: 10px;
					border: none;
					height: 2px;
					background: black;
					margin-bottom: 10px;
					}

					hr.separator {
					position: relative;
					top: 20px;
					border: none;
					height: 4px;
					background: black;
					margin-bottom: 5px;
					}

					div.text {
					background-color: #ffffff;
					color: blue;
					font-size: 1em;
					font-weight:normal;
					text-align:justify;
					}

					div.largetext {
					background-color: #ffffff;
					color: blue;
					font-size: 1em;
					font-weight:normal;
					text-align:justify;
					white-space: pre-wrap;
					}


					div.information {
					background-color: #ffffff;
					color: black;
					font-size: 1em;
					font-weight:normal;
					text-align:justify;
					}

					#scheader {
					font-size: 0.9em;
					border: 0px solid #404040;
					border-spacing: 2px;
					}

				</style>
			</head>

			<body lang="en-US" text="#000000" bgcolor="#ffffff">
				<hr class="header"/>
				<br/>
				<hr class="headerThin"/>
				<xsl:call-template name="issuerInfo" />
				<hr class="headerThin"/>
				<hr class="header"/>
				<br/><br/>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>

	<!-- Issuer Info Template START -->
	<xsl:template name="issuerInfo" >
		<div class="contentwrapper">
			<table role="presentation"  id="scheader">
				<tr>
					<td class="tableClassNoBorderAlignCenter" style="font-size:2em;" >
						SECURITIES AND EXCHANGE COMMISSION
						<br />
						Washington, D.C. 20549
					</td>
				</tr>
				<tr><td class="tableClassNoBorderAlignCenter" >
					<br />
					<br />
					<div style="font-size:1.5em;" >
						<xsl:choose>
							<xsl:when test="$submissionType = 'SCHEDULE 13G'">
								SCHEDULE 13G
							</xsl:when>
							<xsl:otherwise>
								SCHEDULE 13G
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<br/>
					<br/>
				</td>
				</tr>
				<tr>
					<td class="tableClassNoBorderAlignCenter">
						<div style="font-size:1.2em;" >
							UNDER THE SECURITIES EXCHANGE ACT OF 1934
						</div>
					</td>
				</tr>
				<tr>
					<td class="center">
						<xsl:if test="$submissionType = 'SCHEDULE 13G/A'">
							<xsl:if test="count(p:edgarSubmission/p:formData/p:coverPageHeader/p:amendmentNo) &gt; 0">

								<div class="information" style="text-align:center; font-weight:bold;">
									(Amendment No. <span style="color:blue;" ><xsl:value-of select="string(p:edgarSubmission/p:formData/p:coverPageHeader/p:amendmentNo)" /></span>)
								</div>
							</xsl:if>
							<br/>
							<br/>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td class="center">
						<div class="information" style="text-align:center; font-weight:bold; color:blue;">
							<xsl:value-of select="string(p:edgarSubmission/p:formData/p:coverPageHeader/p:issuerInfo/p:issuerName)" />

						</div>
						<div class="information" style="text-align:center; font-weight:bold;">
							<hr class="separatorThin"/>
							<xsl:text>(Name of Issuer)</xsl:text>
						</div>
						<br/>
						<br/>
					</td>
				</tr>
				<tr>
					<td class="center">
						<div class="information" style="text-align:center; font-weight:bold; color:blue;">
							<xsl:value-of select="string(p:edgarSubmission/p:formData/p:coverPageHeader/p:securitiesClassTitle)" />
						</div>
						<div class="information" style="text-align:center; font-weight:bold;">
							<hr class="separatorThin"/>
							<xsl:text>(Title of Class of Securities)</xsl:text>
						</div>
						<br/>
						<br/>
					</td>
				</tr>
				<tr>
					<td class="center">
						<div class="information" style="text-align:center; font-weight:bold; color:blue;">
							<xsl:value-of select="string(p:edgarSubmission/p:formData/p:coverPageHeader/p:issuerInfo/p:issuerCusip)" />
						</div>
						<div class="information" style="text-align:center; font-weight:bold;">
							<hr class="separatorThin"/>
							<xsl:text>(CUSIP Number)</xsl:text>
						</div>
						<br/>
						<br/>
					</td>
				</tr>
				<tr>
					<td class="center">
						<div class="information" style="text-align:center; font-weight:bold; color:blue;">
							<xsl:value-of select="string(p:edgarSubmission/p:formData/p:coverPageHeader/p:eventDateRequiresFilingThisStatement)" />
						</div>
						<div class="information" style="text-align:center; font-weight:bold;">
							<hr class="separatorThin"/>
							<xsl:text>(Date of Event Which Requires Filing of this Statement)</xsl:text>
						</div>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
			<table>
				<tr>
					<td class="label"> Check the appropriate box to designate the rule pursuant to which this Schedule is filed:</td>
				</tr>
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="p:edgarSubmission/p:formData/p:coverPageHeader/p:designateRulesPursuantThisScheduleFiled/p:designateRulePursuantThisScheduleFiled = 'Rule 13d-1(b)'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Rule 13d-1(b)
					</td>
				</tr>
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="p:edgarSubmission/p:formData/p:coverPageHeader/p:designateRulesPursuantThisScheduleFiled/p:designateRulePursuantThisScheduleFiled = 'Rule 13d-1(c)'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Rule 13d-1(c)
					</td>
				</tr>
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="p:edgarSubmission/p:formData/p:coverPageHeader/p:designateRulesPursuantThisScheduleFiled/p:designateRulePursuantThisScheduleFiled = 'Rule 13d-1(d)'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Rule 13d-1(d)
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	<!-- Header Template END -->

	<xsl:template name="schemaVersion" match="p:edgarSubmission/p:schemaVersion">
		<div style="display:none">
			schemaVersion:
			<xsl:value-of select="p:edgarSubmission/p:schemaVersion" />
		</div>
	</xsl:template>

	<xsl:template name="headerData" match="p:edgarSubmission/p:headerData">
		<div class="content">
			<div class="form1">
				<xsl:call-template name="headerInfo"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="formData" match="p:edgarSubmission/p:formData">
		<div class="content">
			<div class="form1">
				<xsl:for-each select="p:coverPageHeaderReportingPersonDetails">
					<xsl:variable name="citizenshipOrOrganizationName">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode" select="string(p:citizenshipOrOrganization)" />
						</xsl:call-template>
					</xsl:variable>
					<xsl:call-template name="reportingPersonDetails">
						<xsl:with-param name="citizenship"  select="$citizenshipOrOrganizationName" />
					</xsl:call-template>
				</xsl:for-each>
			</div>
			<div class="form1">
				<xsl:variable name="stateName">
					<xsl:call-template name="stateDescription">
						<xsl:with-param name="stateCode" select="string(p:coverPageHeader/p:issuerInfo/p:issuerPrincipalExecutiveOfficeAddress/p1:stateOrCountry)" />
					</xsl:call-template>
				</xsl:variable>

				<xsl:call-template name="item1through9">
					<xsl:with-param name="stateCountryName"  select="$stateName" />
				</xsl:call-template>
			</div>
			<div class="form1">
				<xsl:call-template name="certification"/>
			</div>
			<div class="form1">
				<xsl:call-template name="signatureInfo"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="documentsData" match="p:edgarSubmission/p:documents">
		<div style="display:none;">
			<div class="form1">
				<xsl:call-template name="InvisibleDocumentsInfo"/>
			</div>
		</div>
	</xsl:template>

	<xsl:include href="Schedule13G_headerInfoEmpty.xsl" />
	<xsl:include href="Schedule13G_reportingDetails.xsl" />
	<xsl:include href="Schedule13G_1through9.xsl" />
	<xsl:include href="Schedule13G_certifications.xsl" />
	<xsl:include href="Schedule13G_signature.xsl" />
	<xsl:include href="Schedule13G_documents.xsl" />
	<xsl:include href="SDR_State_Codes.xsl" />

</xsl:stylesheet>
