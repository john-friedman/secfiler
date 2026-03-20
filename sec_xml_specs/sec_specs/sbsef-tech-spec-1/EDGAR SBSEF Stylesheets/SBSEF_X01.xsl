<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/sbseffiler"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/sbsefcommon"
	xmlns:exa="http://www.sec.gov/edgar/document/sbsef/exhibita"
	xmlns:exb="http://www.sec.gov/edgar/document/sbsef/exhibitb"
	xmlns:exgmn="http://www.sec.gov/edgar/document/sbsef/exhibitgmn"
	xmlns:ext="http://www.sec.gov/edgar/document/sbsef/exhibitt">

	<xsl:import href="util.xsl" />

	<xsl:output method="html" indent="no" encoding="iso-8859-1"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
		
			 <xsl:variable name = "subType" select = "m1:edgarSubmission/m1:headerData/m1:submissionType" />

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="css/SBSEF_print.css" />
			</head>

			<body lang="en-US" text="#000000" bgcolor="#ffffff">
				<div style="display:none">
					schemaVersion:
					<xsl:value-of select="string(m1:edgarSubmission/m1:schemaVersion)" />
				</div>
				<xsl:call-template name="header" />
				<xsl:apply-templates>
					<xsl:with-param name="submissionType"
						select="string(m1:edgarSubmission/m1:headerData/m1:submissionType)" />
				</xsl:apply-templates>

			</body>
		</html>
	</xsl:template>

	<!-- Header Template START -->
	<xsl:template name="header">
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
				<xsl:if test="m1:edgarSubmission/m1:headerData/m1:submissionType = 'SBSEF'">
					<tr>
						<td class="side" style="text-align: center;">
							<p>
								<br />
								FORM <xsl:value-of select="$subType"/>
								<br />
							</p>
						</td>
						<td width="25%" class="side">
							<p>OMB Number:&#160;&#160;3235-0793</p>
							<hr></hr>
							<p>Estimated average burden hours per response:&#160;98.33</p>
						</td>
					</tr>
				</xsl:if>

				<xsl:if
					test="m1:edgarSubmission/m1:headerData/m1:submissionType = 'SBSEF/A'">
					<tr>
						<td class="side" style="text-align: center;">
							<p>
								<br />
								FORM <xsl:value-of select="$subType"/>
								<br />
							</p>
						</td>
						<td width="25%" class="side">
							<p>OMB Number:&#160;&#160;3235-0793</p>
							<hr></hr>
							<p>Estimated average burden hours per response:&#160;98.33</p>
						</td>
					</tr>
				</xsl:if>
			</table>
		</div>
	</xsl:template>
	<!-- Header Template END -->

	<!-- : Filer Information Template START -->
	<xsl:template name="headerData" match="m1:edgarSubmission/m1:headerData">
		<div id="info">
			<div class="contentwrapper">
				<div class="content">
					<h1><xsl:value-of select="$subType"/>: Filer Information</h1>
					 <xsl:if test="count(m1:filerInfo/m1:filer/m1:filerCredentials/m1:cik) &gt; 0 
					 or count(m1:filerInfo/m1:filer/m1:filerCredentials/m1:ccc) &gt; 0">
					<table role="presentation" >
					 <xsl:if test="count(m1:filerInfo/m1:filer/m1:filerCredentials/m1:cik) &gt; 0">	
						<tr>
							<td class="label">Filer CIK</td>
							<td>
								<div class="fakeBox2">
									<xsl:value-of
										select="string(m1:filerInfo/m1:filer/m1:filerCredentials/m1:cik)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>

							</td>
						</tr>
						</xsl:if>
					   <xsl:if test="count(m1:filerInfo/m1:filer/m1:filerCredentials/m1:ccc) &gt; 0">
						<tr>
							<td class="label">Filer CCC</td>
							<td>
								<div class="fakeBox2">
									<xsl:value-of
										select="string(m1:filerInfo/m1:filer/m1:filerCredentials/m1:ccc)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>

							</td>
						</tr>
                      </xsl:if>
					</table>
                   </xsl:if>
                 <xsl:if test="count(m1:filerInfo/m1:liveTestFlag) &gt; 0">	
					<table role="presentation" >
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
													<img src="Images/radio-checked.jpg" alt="Radio button checked" />
													LIVE
													<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
													TEST
												</xsl:when>
											</xsl:choose>
											<xsl:choose>
												<xsl:when test="string(m1:filerInfo/m1:liveTestFlag) = 'TEST'">
													<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
													LIVE
													<img src="Images/radio-checked.jpg" alt="Radio button checked" />
													TEST
												</xsl:when>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
											LIVE
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
											TEST
										</xsl:otherwise>
									</xsl:choose>
								</span>
							</td>
						</tr>
			
					</table>
            </xsl:if>
                   <xsl:if test="count(m1:filerInfo/m1:contact) &gt; 0">
					<h4>Submission Contact Information</h4>
					<table role="presentation" >
					 <xsl:if test="count(m1:filerInfo/m1:contact/m1:contactName) &gt; 0">
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
						</xsl:if>
						 <xsl:if test="count(m1:filerInfo/m1:contact/m1:contactPhoneNumber) &gt; 0">
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
						</xsl:if>
						
                             <xsl:if test="count(m1:filerInfo/m1:contact/m1:contactEmailAddress) &gt; 0">
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
						</xsl:if>

					</table>
					</xsl:if>
					
					<xsl:if test="count(m1:filerInfo/m1:flags) &gt; 0">
					<h4>Notification Information</h4>
					<xsl:if test="count(m1:filerInfo/m1:flags/m1:overrideInternetFlag) &gt; 0">
					<table role="presentation" >
						<tr>
							<td class="label">
								Notify via Filing website only?
							</td>
							<td>
								<xsl:choose>
									<xsl:when
										test="string(m1:filerInfo/m1:flags/m1:overrideInternetFlag) = 'true'">
										<img src="Images/box-checked.jpg" alt="Checkbox checked" />

									</xsl:when>
									<xsl:otherwise>
										<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
					</xsl:if>
                     </xsl:if>

	
					<xsl:if test="count(m1:filerInfo/m1:notifications) &gt; 0">
					<xsl:for-each
						select="m1:filerInfo/m1:notifications/m1:notificationEmailAddress">
						<table role="presentation" >
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
						</table>
					</xsl:for-each>
              </xsl:if>
				</div>
			</div>
		</div>
	</xsl:template>
	<!-- 1-Z: Filer Template Information END -->

	<!-- Form Data Template START -->
	 <xsl:template name="formData" match="m1:edgarSubmission/m1:formData">
		<xsl:param name="submissionType" />
	
		<div class="content">
			<h1><xsl:value-of select="$subType"/>: Application Information</h1>
			<div class="form1">
				<xsl:call-template name="Item1"/>			
			</div>

			<h1><xsl:value-of select="$subType"/>: General Information (1-5)
			</h1>
			<div class="form1">
				<xsl:call-template name="Item2" />
			</div>

		<!-- 	<h1><xsl:value-of select="$subType"/>: General Information (6-9)
			</h1>  -->
			<div class="form1">
				  <xsl:call-template name="Item3" />
			</div>
	
			<!--  <h1><xsl:value-of select="$subType"/>: Exhibit A
			</h1>-->
			<div class="form1">
			  <xsl:call-template name="ExhibitA" />	
			</div>
				<!--  <h1><xsl:value-of select="$subType"/>: Exhibit B
			</h1>-->
			<div class="form1">
				 <xsl:call-template name="ExhibitB" />
			</div>
				<!--  <h1><xsl:value-of select="$subType"/>: Exhibit G
			</h1>-->
			<div class="form1">
				<xsl:call-template name="ExhibitG" /> 
			</div>
				<!--  <h1><xsl:value-of select="$subType"/>: Exhibit M
			</h1>-->
			<div class="form1">
			    <xsl:call-template name="ExhibitM" />	
			</div>
				<!-- <h1><xsl:value-of select="$subType"/>: Exhibit N
			</h1> -->
			<div class="form1">
			 	<xsl:call-template name="ExhibitN" />
			</div>
			<!--  	<h1><xsl:value-of select="$subType"/>: Exhibit T
			</h1>-->
			<div class="form1">
			 	<xsl:call-template name="ExhibitT" />
			</div>
			
			<!-- 	<h1><xsl:value-of select="$subType"/>: Signature
			</h1> -->
			<div class="form1">
				<xsl:call-template name="Signature" /> 
			</div>

		</div>
	</xsl:template>
	<!-- Form Data Template END -->

	<!-- SBSEF Documents Template START -->

 	<xsl:template name="documents"
		match="m1:edgarSubmission/m1:documents/ns1:document">
		<div style="display:none;">
			<div class="content">
				<h1>Attach Documents List</h1>
				<div class="form1">
					<xsl:call-template name="Documents" />
				</div>
			</div>
		</div>
	</xsl:template>
	
	

	<!-- SDR Documents Template END -->

	<!-- items START -->
	 <xsl:include href="SBSEF_item1.xsl" />
      <xsl:include href="SBSEF_item2.xsl" />
	<xsl:include href="SBSEF_item3.xsl" />
	<xsl:include href="SBSEF_exhibitA.xsl" />
	<xsl:include href="SBSEF_exhibitB.xsl" />
	<xsl:include href="SBSEF_exhibitG.xsl" />
	<xsl:include href="SBSEF_exhibitM.xsl" />
	<xsl:include href="SBSEF_exhibitN.xsl" />
	<xsl:include href="SBSEF_exhibitT.xsl" />
	<xsl:include href="SBSEF_signature.xsl" />
	<xsl:include href="SBSEF_documents.xsl" />
	<!-- items END -->
  <xsl:include href="SDR_State_Codes.xsl" />
</xsl:stylesheet>
    