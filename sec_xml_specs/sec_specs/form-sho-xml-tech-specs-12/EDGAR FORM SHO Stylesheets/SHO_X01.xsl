<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:p="http://www.sec.gov/edgar/formSho"
				xmlns:p1="http://www.sec.gov/edgar/common">


	<xsl:output
			method="html"
			indent="no"
			encoding="iso-8859-1"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
	<xsl:variable name = "submissionType" select = "p:edgarSubmission/p:headerData/p:submissionType" />
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="css/common_print.css" />
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
					table.tableClass { 
					border: solid #bdaeae;
					border-top-width: 1;
					border-right-width: 1;
					border-bottom-width: 1;
					border-left-width: 1;
					table-layout:fixed;
					margin-bottom: 15px;
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
					word-wrap: break-word;
					}
					td.tableClassRight { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 0;
					font-size: 0.9em;
					word-wrap: break-word;
					}
					td.tableClass { border: solid black;
					border-top-width: 0px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					font-size: 0.9em;
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
					.authorized {
					   width: 100%;
					   font-family: serif;
					   font-size: larger;
					}
				</style>
			</head>

			<body lang="en-US" text="#000000" bgcolor="#ffffff">
				<xsl:apply-templates/>
			</body>
		</html>		
	</xsl:template>
	
	<!-- Header Template START -->
	<xsl:template name="header" match="p:edgarSubmission/p:headerData">
		<div class="contentwrapper">
			<table role="presentation"  id="header">
				<tr>
					<td class="title">Form <xsl:value-of select="p:submissionType" /> Filer Information</td>
					<td rowspan="2" class="center">
						UNITED STATES
						<br />
						SECURITIES AND EXCHANGE COMMISSION
						<br />
						Washington, D.C. 20549
						<br />
						<br />
						Form <xsl:value-of select="p:submissionType" />
						<br/>
						<br/>
						<div style="font-size:.9em;" >
							Short Position and Short Activity Reporting by Institutional Investment Managers
						</div>
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="side" style="text-align: center;vertical-align:middle">
						<p>
							FORM <xsl:value-of select="p:submissionType" />
						</p>
					</td>
					<td width="25%"></td>
				</tr>
			</table>
		</div>

		<div id="info">
			<div class="contentwrapper">
				<div class="content">
					<h1 style="margin-top: 25px;">Form <xsl:value-of select="p:submissionType" />: Filer Information</h1>
					<table role="presentation"  class="filerInformation">
						<tr>
							<td class="label">Filer CIK</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:filerInfo/p:filer/p:filerCredentials/p:cik)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Filer CCC</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:filerInfo/p:filer/p:filerCredentials/p:ccc)" />
								</div>
							</td>
						</tr>
						<xsl:if test="p:submissionType = 'SHO/A'">
							<tr>
								<td class="label">Previous Accession Number Of The Filing</td>
								<td>
									<div class="fakeBox">
										<xsl:value-of select="string(p:previousAccessionNumber)" />
									</div>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<td class="label">
								Is this a LIVE or TEST Filing?
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="count(p:filerInfo/p:liveTestFlag) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(p:filerInfo/p:liveTestFlag) = 'LIVE'">
												<img src="Images/radio-checked.jpg"   alt="Radio button checked"   /> LIVE
												<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> TEST
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(p:filerInfo/p:liveTestFlag) = 'TEST'">
												<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> LIVE
												<img src="Images/radio-checked.jpg"   alt="Radio button checked"   /> TEST
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> LIVE
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> TEST
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					
						<tr>
							<td><h4><em>Submission Contact Information</em></h4></td>
						</tr>
						<tr>
							<td class="label">Name</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:filerInfo/p:contact/p:contactName)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Phone Number</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:filerInfo/p:contact/p:contactPhoneNumber)" />
								</div>
							</td>
						</tr>

						<tr>
							<td class="label">E-Mail Address</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="p:filerInfo/p:contact/p:contactEmailAddress" />
								</div>
							</td>
						</tr>

						<xsl:if test="count(p:filerInfo/p:notifications) &gt; 0">
							<tr>
								<td><h4><em>Notification Information</em></h4></td>
							</tr>
						</xsl:if>

						<xsl:if test="count(p:filerInfo/p:flags/p:overrideInternetFlag) &gt; 0">
							<tr>
								<td class="label">Notify via Filing Website only?</td>
								<td>
									<xsl:choose>
										<xsl:when test="string(p:filerInfo/p:flags/p:overrideInternetFlag) = 'true'">
											<img src="Images/box-checked.jpg" alt="Checkbox checked" />
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:if>
						<xsl:for-each select="p:filerInfo/p:notifications/p:notificationEmailAddress">
							<tr>
								<td class="label">Notification E-mail Address</td>
								<td>
									<div class="fakeBox">
										<xsl:value-of select="." />
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</div>
		</div>
	</xsl:template>
	<!-- Header Template END -->
	<xsl:template name="p:formData" match="p:edgarSubmission/p:formData">
		<xsl:call-template name="coverPage"/>
		<xsl:if test="string(p:coverPage/p:reportType) != 'FORM SHO NOTICE'">
			<xsl:call-template name="table1"/>
			<xsl:call-template name="table2"/>
		</xsl:if>
	</xsl:template>
   
    <xsl:include href="SHO_coverPage.xsl" />
	<xsl:include href="SHO_table1.xsl" />
	<xsl:include href="SHO_table2.xsl" />
</xsl:stylesheet>