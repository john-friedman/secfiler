<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:m1="http://www.sec.gov/edgar/npxctr"
		xmlns:ns1="http://www.sec.gov/edgar/common"
		xmlns:n1="http://www.sec.gov/edgar/common_drp"
		xmlns:ns2="http://www.sec.gov/edgar/statecodes">

	<xsl:import href="util.xsl" />

	<xsl:output
			method="html"
			indent="no"
			encoding="iso-8859-1"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
	<xsl:variable name = "submissionType" select = "m1:edgarSubmission/m1:headerData/m1:submissionType" />	
	<xsl:template match="/">

		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="css/npx_print.css" />
			</head>

			<body
					lang="en-US"
					text="#000000"
					bgcolor="#ffffff">
				<xsl:call-template name="header" />
				<xsl:apply-templates />
			</body>
		</html>
	</xsl:template>

	<!-- Header Template START -->
	<xsl:template name="header">
		<div class="contentwrapper">
			<table role="presentation" id="header">
				<tr>
					<td class="title">Form <xsl:value-of select ="$submissionType"/> Filer Information</td>
					<td rowspan="2" class="center">
						UNITED STATES
						<br />
						SECURITIES AND EXCHANGE COMMISSION
						<br />
						Washington, D.C. 20549
						<br />
						<br />
						FORM N-PX CTR
						<br />
						Form N-PX CTR Confidential Treatment Request
					</td>
					<td class="title">OMB APPROVAL</td>
				</tr>
				<tr>
					<td
							class="side"
							style="text-align: center;">
						<p>
							<br />
							Form <xsl:value-of select ="$submissionType"/>
							<br />
						</p>
					</td>
					<td
							width="25%"
							class="side">
						<p>OMB Number:&#160;&#160;3235-0582</p>
						<hr></hr>
						<p>Estimated average burden hours per response:&#160;20.8</p>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	<!-- Header Template END -->


	<xsl:template name="schemaVersion" match="m1:edgarSubmission/m1:schemaVersion">
		<div style="display:none">
			schemaVersion:
			<xsl:value-of select="m1:edgarSubmission/m1:schemaVersion" />
		</div>
	</xsl:template>

	<!-- 1-A: Filer Information Template START -->


	<xsl:template	name="headerData"	match="m1:edgarSubmission/m1:headerData">
		<div id="info">
			<div class="contentwrapper">
				<div class="content">
					<h1><xsl:value-of select ="$submissionType"/>: Filer Information</h1>

					<!-- Filer -->
					<table role="presentation" class="filerInformation">
						<tr>
							<td class="label">Filer CIK</td>
							<td>
								<div class="fakeBox2">
									<xsl:value-of
											select="string(m1:filerInfo/m1:filer/m1:issuerCredentials/m1:cik)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Filer CCC</td>
							<td>

								<xsl:choose>

									<xsl:when  test="count(m1:filerInfo/m1:filer/m1:issuerCredentials/m1:ccc) &gt; 0">
										<div class="fakeBox2">

											********
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>

										</div>
									</xsl:when>
									<xsl:otherwise>

										<div class="fakeBox2">
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</xsl:otherwise>
								</xsl:choose>


							</td>
						</tr>
												
						<!-- Flags -->
						
						<tr>
							<td class="label"> Is this a de novo request? (Please refer to Confidential Treatment Instruction 7.)</td>
							<td>
								<xsl:choose>
									<xsl:when	test="string(m1:filerInfo/m1:deNovoRequestChoice) = 'Y'">
										<img
												src="Images/box-checked.jpg"
												alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img
												src="Images/box-unchecked.jpg"
												alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>

						<tr>
							<td class="label">
								Is this a LIVE or TEST Filing?
							</td>
							<td>
								<span class="yesNo">
									<xsl:choose>
										<xsl:when test="count(m1:filerInfo/m1:liveTestFlag) &gt; 0">
											<xsl:choose>
												<xsl:when test="string(m1:filerInfo/m1:liveTestFlag) = 'LIVE'">
													<img
															src="Images/radio-checked.jpg"
															alt="Radio button checked" />
													LIVE
													<img
															src="Images/radio-unchecked.jpg"
															alt="Radio button not checked" />
													TEST
												</xsl:when>
											</xsl:choose>
											<xsl:choose>
												<xsl:when test="string(m1:filerInfo/m1:liveTestFlag) = 'TEST'">
													<img
															src="Images/radio-unchecked.jpg"
															alt="Radio button not checked" />
													LIVE
													<img
															src="Images/radio-checked.jpg"
															alt="Radio button checked" />
													TEST
												</xsl:when>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<img
													src="Images/radio-unchecked.jpg"
													alt="Radio button not checked" />
											LIVE
											<img
													src="Images/radio-unchecked.jpg"
													alt="Radio button not checked" />
											TEST
										</xsl:otherwise>
									</xsl:choose>
								</span>
							</td>
						</tr>
						<tr>
							<td class="label">Is this an electronic	copy of an official filing submitted in paper format?
							</td>
							<td>
								<xsl:choose>
									<xsl:when	test="m1:filerInfo/m1:flags/m1:confirmingCopyFlag = 'true'">
										<img
												src="Images/box-checked.jpg"
												alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img
												src="Images/box-unchecked.jpg"
												alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>

						<xsl:if	test="m1:filerInfo/m1:flags/m1:confirmingCopyFlag = 'true'">
							<tr>
								<td class="label">File Number</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:filerInfo/m1:filer/m1:fileNumber" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
						</xsl:if>

					</table>

					<!-- contact -->
					<table role="presentation">
						<tr>
							<td><h4>Submission Contact Information</h4></td>
						</tr>
						<tr>
							<td class="label">Name</td>
							<td>
								<div class="fakeBox3">
									<xsl:value-of select="string(m1:filerInfo/m1:contact/m1:contactName)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Phone Number</td>
							<td>
								<div class="fakeBox2">
									<xsl:value-of
											select="string(m1:filerInfo/m1:contact/m1:contactPhoneNumber)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">E-mail Address</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of
											select="string(m1:filerInfo/m1:contact/m1:contactEmailAddress)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</td>
						</tr>
					</table>
					<!-- Notifications -->
					<table role="presentation">
						<tr>
							<td><h4>Notification Information</h4></td>
						</tr>
					</table>
					<table role="presentation">
						<tr>
							<td class="label">Notify via Filing Website only?</td>
							<td>
								<xsl:choose>
									<xsl:when	test="m1:filerInfo/m1:flags/m1:overrideInternetFlag = 'true'">
										<img
												src="Images/box-checked.jpg"
												alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img
												src="Images/box-unchecked.jpg"
												alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>

						<xsl:for-each	select="m1:filerInfo/m1:notifications/m1:notificationEmailAddress">

							<tr>
								<td class="label">Notification E-mail Address</td>
								<td>
									<div class="fakeBox">
										<xsl:value-of select="." />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</div>
		</div>

		
	</xsl:template>
	<!-- Filer Information Template Information END -->

	<!-- Cover Page Template Information -->
	<xsl:template name="coverPageTemplate" match="m1:edgarSubmission/m1:formData/m1:coverPage">

		<div class="content">
			<div class="label">

				<h1><xsl:value-of select ="$submissionType"/>: Cover Page</h1>
				<div class="form1">
					<xsl:call-template name="coverPageFull" />
				</div>

			</div>
		</div>

	</xsl:template>

	<!-- Summary Page Template Information -->
	
	<xsl:template	name="summaryPageTemplate" match="m1:edgarSubmission/m1:formData/m1:summaryPage">

		<div class="content">
			<div class="label">

				<h1><xsl:value-of select ="$submissionType"/>: Summary - Included Managers</h1>
				<div class="form1">
					<xsl:call-template name="summaryPage" />
				</div>

			</div>
		</div>

	</xsl:template>	

	<!-- Summary Series Page Template Information -->
	

	<!-- Signature Page Template Information -->
	<xsl:template	name="signaturePageTemplate" match="m1:edgarSubmission/m1:formData/m1:signaturePage">

		<div class="content">
			<div class="label">

				<h1><xsl:value-of select ="$submissionType"/>: Signature Block</h1>
				<div class="form1">
					<xsl:call-template name="signaturePage" />
				</div>

			</div>
		</div>

	</xsl:template>


	<!-- Documents Template START -->

	<xsl:template name="documentsData" match="m1:edgarSubmission/m1:documents">
		<div style="display:none;">
			<div class="form1">
				<xsl:call-template name="InvisibleDocumentsInfo"/>
			</div>
		</div>
	</xsl:template>


	<xsl:template name="yesNoRadio">
		<xsl:param name="yesNoElement" />
		<span class="yesNo">
			<xsl:choose>
				<xsl:when
						test="count($yesNoElement) &gt; 0">
					<xsl:choose>
						<xsl:when
								test="string($yesNoElement) = 'Y'">
							<img
									src="Images/radio-checked.jpg"
									alt="Radio button checked" />
							Yes
							<img
									src="Images/radio-unchecked.jpg"
									alt="Radio button not checked" />
							No
						</xsl:when>
					</xsl:choose>
					<xsl:choose>
						<xsl:when
								test="string($yesNoElement) = 'N'">
							<img
									src="Images/radio-unchecked.jpg"
									alt="Radio button not checked" />
							Yes
							<img
									src="Images/radio-checked.jpg"
									alt="Radio button checked" />
							No
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<img
							src="Images/radio-unchecked.jpg"
							alt="Radio button not checked" />
					Yes
					<img
							src="Images/radio-unchecked.jpg"
							alt="Radio button not checked" />
					No
				</xsl:otherwise>
			</xsl:choose>
		</span>

	</xsl:template>

	<xsl:template name="condYesNoRadio">
		<xsl:param name="yesElement" />
		<xsl:param name="noElement" />
		<span class="yesNo">
			<xsl:choose>
				<xsl:when test="count($yesElement) &gt; 0 or count($noElement) &gt; 0">
					<xsl:choose>
						<xsl:when
								test="string($yesElement) = 'Y'">
							<img
									src="Images/radio-checked.jpg"
									alt="Radio button checked" />
							Yes
							<img
									src="Images/radio-unchecked.jpg"
									alt="Radio button not checked" />
							No
						</xsl:when>
					</xsl:choose>
					<xsl:choose>
						<xsl:when
								test="string($noElement) = 'N'">
							<img
									src="Images/radio-unchecked.jpg"
									alt="Radio button not checked" />
							Yes
							<img
									src="Images/radio-checked.jpg"
									alt="Radio button checked" />
							No
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<img
							src="Images/radio-unchecked.jpg"
							alt="Radio button not checked" />
					Yes
					<img
							src="Images/radio-unchecked.jpg"
							alt="Radio button not checked" />
					No
				</xsl:otherwise>
			</xsl:choose>
		</span>

	</xsl:template>

	<xsl:template name="condCountryDescription">
		<xsl:param name="code1" />
		<xsl:param name="code2" />
		<xsl:choose>
			<xsl:when test="string($code1)= 'US'">
				<xsl:call-template name="stateDescription">
					<xsl:with-param name="stateCode"	select="string($code1)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="stateDescription">
					<xsl:with-param name="stateCode"	select="string($code2)" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- 1-A Documents Template END -->
	
	<xsl:include href="N-PX CTR_CoverPage.xsl" />
	<xsl:include href="N-PX CTR_SummaryPage.xsl" />		
	<xsl:include href="N-PX CTR_Documents.xsl" />
	<xsl:include href="N-PX CTR_Signature.xsl" />
	<xsl:include href="SDR_State_Codes.xsl" />
	
</xsl:stylesheet>
