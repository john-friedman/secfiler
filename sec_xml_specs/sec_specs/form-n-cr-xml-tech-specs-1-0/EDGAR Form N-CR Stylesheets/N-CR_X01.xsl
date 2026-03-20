<?xml version="1.0" encoding="UTF-8"?>
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
        xmlns:feecom="http://www.sec.gov/edgar/feecommon">

    <xsl:import href="util.xsl" />

    <xsl:output method="html" indent="no" encoding="iso-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
    <xsl:variable name="submissionType" select = "m1:edgarSubmission/m1:headerData/m1:submissionType" />
    <xsl:variable name="icType" select="m1:edgarSubmission/m1:headerData/m1:filerInfo/m1:investmentCompanyType" />
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="css/N-CR_print.css"/>
            </head>
            <body lang="en-US" text="#000000" bgcolor="#ffffff">
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
                    <td class="title">
                        Form <xsl:value-of select ="$submissionType"/> Filer Information
                    </td>
                    <td rowspan="2" class="center">
                        UNITED STATES
                        <br />
                        SECURITIES AND EXCHANGE COMMISSION
                        <br />
                        Washington, D.C. 20549
                        <br />
                        <br />
                        FORM N-CR
                        <br />
                        Annual Notice of Securities Sold Pursuant to Rule N-CR
                    </td>
                    <td class="title">OMB APPROVAL</td>
                </tr>
                <tr>
                    <td class="side" style="text-align: center;">
                        <p>
                            <br />
                            Form <xsl:value-of select ="$submissionType"/>
                            <br />
                        </p>
                    </td>
                    <td width="25%" class="side">
                        <p>OMB Number:&#160;&#160;3235-0705</p>
                        <hr></hr>
                        <p>Estimated average burden hours per response:&#160;10.5</p>
                    </td>
                </tr>
            </table>
        </div>
    </xsl:template>
    <!-- Header Template END -->

    <xsl:template name="schemaVersion" match="m1:edgarSubmission/m1:schemaVersion">
        <div style="display:none">
            schemaVersion:
            <xsl:value-of select="m1:edgarSubmission/m1:schemaVersion"/>
        </div>
    </xsl:template>

    <!-- headerData -->
    <xsl:template name="headerData"	match="m1:edgarSubmission/m1:headerData">
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
                                    <xsl:value-of select="string(m1:filerInfo/m1:filer/m1:issuerCredentials/m1:cik)"/>
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
                                    <xsl:when test="count(m1:filerInfo/m1:filer/m1:issuerCredentials/m1:ccc) &gt; 0">
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

                        <tr>
                            <td class="label">Date of Report</td>
                            <td>
                                <div class="fakeBox2">
                                    <xsl:value-of select="string(m1:filerInfo/m1:periodOfReport)" />
                                    <span>
                                        <xsl:text>&#160;</xsl:text>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">Filer Investment Company Type</td>
                            <td>
                                <div class="fakeBox3">
                                    <xsl:if test="$icType = ''">
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'N-1A'">
                                        <xsl:text>Form N-1A Filer (Mutual Fund)</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'N-2'">
                                        <xsl:text>Form N-2 Filer (Closed-End Investment Company)</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'N-3'">
                                        <xsl:text>Form N-3 Filer (Separate Account Registered as Open-End Management Investment Company)</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'N-4'">
                                        <xsl:text>Form N-4 Filer (Variable Annuity UIT Separate Account)</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'N-5'">
                                        <xsl:text>Form N-5 Filer (Small Business Investment Company)</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'N-6'">
                                        <xsl:text>Form N-6 Filer (Variable Life UIT Separate Account)</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'S-1 or S-3'">
                                        <xsl:text>Form S-1 or S-3 Filer (Face Amount Certificate Company)</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="$icType = 'S-6'">
                                        <xsl:text>Form S-6 Filer (UIT, Non-Insurance Product)</xsl:text>
                                    </xsl:if>
                                    <span>
                                        <xsl:text>&#160;</xsl:text>
                                    </span>
                                </div>
                            </td>
                        </tr>

                        <!-- Flags -->
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
                                                    <img src="Images/radio-checked.jpg" alt="Radio button checked"/>
                                                    LIVE
                                                    <img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
                                                    TEST
                                                </xsl:when>
                                            </xsl:choose>
                                            <xsl:choose>
                                                <xsl:when test="string(m1:filerInfo/m1:liveTestFlag) = 'TEST'">
                                                    <img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
                                                    LIVE
                                                    <img src="Images/radio-checked.jpg" alt="Radio button checked"/>
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
                        <tr>
                            <td class="label">Is this an electronic	copy of an official filing submitted in paper format?
                            </td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="m1:filerInfo/m1:flags/m1:confirmingCopyFlag = 'true'">
                                        <img src="Images/box-checked.jpg" alt="Checkbox checked"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <img src="Images/box-unchecked.jpg" alt="Checkbox not checked"/>
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

                    <!-- Contact -->
                    <table role="presentation">
                        <tr>
                            <td><h4>Submission Contact Information</h4></td>
                        </tr>
                        <tr>
                            <td class="label">Name</td>
                            <td>
                                <div class="fakeBox3">
                                    <xsl:value-of select="string(m1:filerInfo/m1:contact/m1:name)" />
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
                                    <xsl:value-of select="string(m1:filerInfo/m1:contact/m1:phoneNumber)" />
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
                                    <xsl:value-of select="string(m1:filerInfo/m1:contact/m1:emailAddress)" />
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
                                    <xsl:when test="m1:filerInfo/m1:flags/m1:overrideInternetFlag = 'true'">
                                        <img src="Images/box-checked.jpg" alt="Checkbox checked" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                        <xsl:for-each select="m1:filerInfo/m1:notifications/m1:notificationEmailAddress">
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

                    <!-- Series and Classes -->
                  
                   	<xsl:if test="$icType = 'N-1A' or $icType = 'N-4' or $icType = 'N-3' or $icType = 'N-6'">
				<h1><xsl:value-of select ="$submissionType"/>:Series/Class Information</h1>
				<div class="form1">
				
				 <xsl:if test="count(m1:oneSeriesClasses) &gt; 0">
				   <xsl:call-template name="seriesclasses" />
				</xsl:if>
				
				</div>
			</xsl:if>			

                </div>
            </div>
        </div>
    </xsl:template>
    <!-- END headerData -->
    
    
	<xsl:template	name="formData" match="m1:edgarSubmission/m1:formData">
		<div class="content">
			<div class="label">
			
				<h1><xsl:value-of select ="$submissionType"/>:Part A: General Information</h1>
				<div class="form1">
				    	<xsl:call-template name="PartA" />
				</div>

				<h1><xsl:value-of select ="$submissionType"/>:Part B: Default or event of insolvency of portfolio security issuer</h1>
				<div class="form1">
				 	<xsl:call-template name="PartB" />  
				</div>
			

                <h1><xsl:value-of select ="$submissionType"/>:Part C: Provision of financial support to fund</h1>
				<div class="form1">
				  	<xsl:call-template name="PartC"/>
				</div>
			
			
				<h1><xsl:value-of select ="$submissionType"/>:Part D: Deviation between current net asset value per share and intended stable price per share</h1>
				 <div class="form1"> 
				  <xsl:call-template name="PartD"/> 
				 </div> 
		   
		 
				<h1><xsl:value-of select ="$submissionType"/>:Part E: Liquidity threshold event</h1>
				 <div class="form1"> 
			  	 <xsl:call-template name="PartE" /> 
				 </div>
		 
		
				<h1><xsl:value-of select ="$submissionType"/>:Part F: Optional disclosure</h1>
				<div class="form1">
			  	 <xsl:call-template name="PartF" /> 
				</div> 
				
			 <h1><xsl:value-of select ="$submissionType"/>: Signatures</h1> 
				<div class="form1">
				   <xsl:call-template name="Signatures" />
				</div> 
				<br/>

 

			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="documentsData" match="m1:edgarSubmission/m1:documents">
		<div style="display:none;">
			<div class="form1">
		 <xsl:call-template name="InvisibleDocumentsInfo"/>	
		 	</div>
		</div>
	</xsl:template>	
    
    
    

    <!-- formData -->
     <xsl:include href="N-CR_SeriesClasses.xsl"/>
      <xsl:include href="N-CR_generalInfo.xsl"/>
      <xsl:include href="N-CR_porfolioSecurityIssuer.xsl"/>  
       <xsl:include href="N-CR_provisionFinancialSupport.xsl"/> 
       <xsl:include href="N-CR_deviationAsset.xsl"/>
       <xsl:include href="N-CR_liquidityThreshold.xsl"/>
       <xsl:include href="N-CR_optionalDisclosure.xsl"/>
       <xsl:include href="N-CR_signature.xsl"/>    
       <xsl:include href="N-CR_documents.xsl"/> 
    
    <xsl:include href="iso_State_Codes.xsl" />
    <xsl:include href="iso_Exchange_Code.xsl"/>
</xsl:stylesheet>