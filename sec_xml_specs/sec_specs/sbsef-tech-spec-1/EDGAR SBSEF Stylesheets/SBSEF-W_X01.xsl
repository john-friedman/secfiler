<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:p="http://www.sec.gov/edgar/sbsefwvfiler"
				xmlns:p1="http://www.sec.gov/edgar/common">
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
					color: blue;
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
					<td class="title">Form SBSEF Filer Information</td>
					<td rowspan="2" class="center">
						UNITED STATES
						<br />
						SECURITIES AND EXCHANGE COMMISSION
						<br />
						Washington, D.C. 20549
						<br />
						<br />
						FORM SBSEF
						<br />
						UNDER THE SECURITIES EXCHANGE ACT OF 1934
					</td>
					<td class="title">OMB APPROVAL</td>
				</tr>
				<tr>
					<td class="side" style="text-align: center;">
						<p>
							<br />
							FORM <xsl:value-of select="p:submissionType"/>
							<br />
						</p>
					</td>
					<td width="25%" class="side">
							<p>OMB Number:&#160;&#160;3235-0793</p>
							<hr></hr>
							<p>Estimated average burden hours per response:&#160;98.33</p>
					</td>
				</tr>
			</table>
		</div>

		<div id="info">
			<div class="contentwrapper">
				<div class="content">
					<h1><xsl:value-of select="p:submissionType" />: Filer Information</h1>
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
						<xsl:if test="p:submissionType = '144/A'">
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
						<xsl:if test="count(p:filerInfo/p:flags/p:returnCopyFlag) &gt; 0">
							<tr>
								<td class="label">Would you like a Return Copy?</td>
								<td>
									<xsl:choose>
										<xsl:when test="string(p:filerInfo/p:flags/p:returnCopyFlag) = 'true'">
											<img src="Images/box-checked.jpg" alt="Checkbox checked" />
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="count(p:filerInfo/p:flags/p:confirmingCopyFlag) &gt; 0">
							<tr>
								<td class="label">
									Is this an electronic copy of an official filing submitted in paper format?
								</td>
								<td>
									<xsl:choose>
										<xsl:when test="string(p:filerInfo/p:flags/p:confirmingCopyFlag) = 'true'">
											<img src="Images/box-checked.jpg" alt="Checkbox checked" />
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="(p:contact)">
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
							<td class="label">Phone</td>
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
						</xsl:if>
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
	<xsl:variable name = "subType" select = "p:edgarSubmission/p:headerData/p:submissionType" />
	<xsl:include href="SBSEF-WV_Signature.xsl" />
</xsl:stylesheet>
