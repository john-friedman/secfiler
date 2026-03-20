<?xml version="1.0" encoding="ISO-8859-1"?><xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:decimal-format name = "x" decimal-separator="." grouping-separator=","/> 

<xsl:template match="exerciseDate|expirationDate">
<xsl:choose>
<xsl:when test="count(value)=0 or value=''">
  &#160;
</xsl:when>
<xsl:otherwise>
  <xsl:value-of select="concat(normalize-space(substring-before(substring-after(value,'-'),'-')),'/',normalize-space(substring-after(substring-after(value,'-'),'-')),'/',normalize-space(substring-before(value,'-')))" />
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="footnoteId"/>
</xsl:template>

<xsl:template match="footnoteId">
<a href="#{@id}"><sup>(<xsl:value-of select="substring-after(@id,'F')"/>)</sup></a>
</xsl:template>

<xsl:template match="value">
<xsl:choose>
  <xsl:when test=".!=''">
    <xsl:choose>
      <xsl:when test="number(.)=number(.)">
        <xsl:value-of select="format-number(.,'###,##0.####')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise>
    &#160;
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="line-break">
  <xsl:param name="text"/>

  <xsl:choose>
    <xsl:when test="contains($text,'&#x0a;')">
      <xsl:value-of select="substring-before($text,'&#x0a;')"/><br/>
      <xsl:call-template name="line-break">
        <xsl:with-param name="text"><xsl:value-of select="substring-after($text,'&#x0a;')"/></xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="/">
  <html>
  <head>
  <title> Ownership Submission </title>
  <style>
  td { border: solid black;
         border-top-width: 0;
	 border-right-width: 1;
	 border-bottom-width: 1;
	 border-left-width: 0;
     }
  </style>
  </head>
  <body BGCOLOR="DCDCDC">

    <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="15%" style="border:none" valign="top"> 
        <div style="width: 150; border: solid black; border-top-width: 1; border-left-width: 1; border-right-width: 1; border-bottom-width: 1"><font face="Arial" size="+3"><b><center>FORM 3</center></b></font></div>
	</td>

	<td width="65%" align="center" style="border:none">
	<b>
	<font size="3">
	UNITED STATES SECURITIES AND EXCHANGE COMMISSION<br/>
	Washington, D.C. 20549<p/>
	</font>
	</b>
	<font size="3">
	<b>INITIAL STATEMENT OF BENEFICIAL OWNERSHIP OF SECURITIES</b><p/>
	Filed pursuant to Section 16(a) of the Securities Exchange Act of 1934 or Section 30(h) of the Investment Company Act of 1940
	</font>
	</td>

	<td width="20%" valign="top" style="border:none">
	<table role="presentation" cellpadding="2" cellspacing="0" border="0">
	  <tr>
	    <td align="center" style="border: solid black; border-top-width: 1; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	    <font face="Arial" size="2">OMB APPROVAL</font>
	    </td>
	  </tr>
	  <tr>
	    <td style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	    <font face="Arial" size="2">
	    <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"><td style="border:none"><font face="Arial" size="2">OMB Number:</font></td><td align="right" style="border:none"><font face="Arial" size="2">3235-0104</font></td></table>
	    <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"><td style="border:none"><font face="Arial" size="2">Estimated average burden hours per response...</font></td><td align="right" valign="bottom" style="border:none"><font face="Arial" size="2">0.5</font></td></table>
	    </font>
	    </td>
	  </tr>
	</table>
	</td>
      </tr>
    </table>

    <p/>

    <font size="-1">(Print or Type Responses)</font>

    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%">
      <tr>
        <td style="border-top-width: 0; border-left-width: 0; border-right-width: 0; border-bottom-width: 0">
	  <table role="presentation" cellpadding="3" cellspacing="0" border="0" width="100%">
	    <tr>
	      <td width="30%" valign="top" style="border: solid black; border-width: 1">
	      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
	        <tr>
		  <td valign="top" width="100%" style="border:none">
		  <font size="2">1. Name and Address of Reporting Person <a href="#*"><sup>*</sup></a></font>
		  </td>
		</tr>
		<tr>
		  <td valign="top" width="33%" style="border:none">&#160;
	          <xsl:value-of select="ownershipDocument/reportingOwner/reportingOwnerId/rptOwnerName" />
		  </td>
		</tr>
	      </table>
	      </td>
              <td valign="top" rowspan="3" width="20%" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	      <font size="2">2. Date of Event Requiring Statement (Month/Day/Year)</font><br></br>
	      <xsl:choose>
	        <xsl:when test="ownershipDocument/periodOfReport!=''">
	          <xsl:value-of select="concat(normalize-space(substring-before(substring-after(ownershipDocument/periodOfReport,'-'),'-')),'/',normalize-space(substring-after(substring-after(ownershipDocument/periodOfReport,'-'),'-')),'/',normalize-space(substring-before(ownershipDocument/periodOfReport,'-')))" />
		</xsl:when>
	      </xsl:choose>
	      </td>
	      <td valign="top" colspan="2" width="50%" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	      <font size="2">3. Issuer Name <b>and</b> Ticker or Trading Symbol</font><br></br>
	      <xsl:value-of select="ownershipDocument/issuer/issuerName"/> [<xsl:value-of select="ownershipDocument/issuer/issuerTradingSymbol" />]
	      </td>
	    </tr>
            <tr>
	      <td valign="top" style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	      <center>
	      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
	        <tr>
		  <td style="border: none" width="33%">
		  <center><font size="1">(Last)</font></center>
		  </td>
		  <td style="border:none" width="33%">
		  <center><font size="1">(First)</font></center>
		  </td>
		  <td style="border:none" width="33%">
		  <center><font size="1">(Middle)</font></center>
		  </td>
		</tr>
              </table>
      	      </center>
	      <xsl:value-of select="ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerStreet1"/><xsl:choose>
	        <xsl:when test="ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerStreet1!='' and ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerStreet2!=''">,&#160;</xsl:when>
	      </xsl:choose><xsl:value-of select="ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerStreet2"/>
	      </td>

	      <td rowspan="2" valign="top" width="25%">
	      <font size="2">4. Relationship of Reporting Person(s) to Issuer<br></br><center>(Check all applicable)</center></font>
	      <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" align="center">
	        <tr>
		  <td valign="top" style="border:none" width="50%">
		  <xsl:for-each select="ownershipDocument/reportingOwner">
		    <xsl:choose>
		      <xsl:when test="position()=1">
		        <xsl:choose>
  		          <xsl:when test="reportingOwnerRelationship/isDirector=1 or reportingOwnerRelationship/isDirector='true'">
		            <font size="1">__X__ Director</font>
		          </xsl:when>
		          <xsl:otherwise>
		            <font size="1">_____ Director</font>
		          </xsl:otherwise>
			</xsl:choose>
                      </xsl:when>
		    </xsl:choose>
		  </xsl:for-each>
		  </td>
		  <td  valign="top" style="border:none" width="50%">
		  <xsl:for-each select="ownershipDocument/reportingOwner">
		    <xsl:choose>
		      <xsl:when test="position()=1">
  		        <xsl:choose>
		          <xsl:when test="reportingOwnerRelationship/isTenPercentOwner=1 or reportingOwnerRelationship/isTenPercentOwner='true'">
		            <font size="1">__X__ 10% Owner</font>
		          </xsl:when>
		          <xsl:otherwise>
		            <font size="1">_____ 10% Owner</font>
		          </xsl:otherwise>
		        </xsl:choose>
		      </xsl:when>
		    </xsl:choose>
                  </xsl:for-each>
		  </td>		  
		</tr>
		<tr>
		  <td  valign="top" style="border:none" width="50%">
		  <xsl:for-each select="ownershipDocument/reportingOwner">
		    <xsl:choose>
		      <xsl:when test="position()=1">
		        <xsl:choose>
		          <xsl:when test="reportingOwnerRelationship/isOfficer=1 or reportingOwnerRelationship/isOfficer='true'">
		            <font size="1">__X__ Officer (give title below)</font>
		          </xsl:when>
		          <xsl:otherwise>
		            <font size="1">_____ Officer (give title below)</font>
		          </xsl:otherwise>
		        </xsl:choose>
		      </xsl:when>
		    </xsl:choose>
		  </xsl:for-each>
		  </td>
		  <td  valign="top" style="border:none" width="50%">
		  <xsl:for-each select="ownershipDocument/reportingOwner">
		    <xsl:choose>
		      <xsl:when test="position()=1">
		        <xsl:choose>
		          <xsl:when test="reportingOwnerRelationship/isOther=1 or reportingOwnerRelationship/isOther='true'">
		            <font size="1">__X__ Other (specify below)</font>
		          </xsl:when>
		          <xsl:otherwise>
		            <font size="1">_____ Other (specify below)</font>
		          </xsl:otherwise>
		        </xsl:choose>
		      </xsl:when>
		    </xsl:choose>
		  </xsl:for-each>
		  </td>		  
		</tr>
		<tr>
		  <td colspan="2" align="center" style="border: solid black; border-top-width: 0; border-left-width: 0; border-right-width: 0; border-bottom-width: 1">
		  <font size="2">
		  <xsl:for-each select="ownershipDocument/reportingOwner">
		    <xsl:choose>
		      <xsl:when test="position()=1 and ( reportingOwnerRelationship/officerTitle!='' or reportingOwnerRelationship/otherText!='' )">
		        <xsl:value-of select="reportingOwnerRelationship/officerTitle" />
			<xsl:choose>
			  <xsl:when test="reportingOwnerRelationship/officerTitle!='' and reportingOwnerRelationship/otherText!=''">
			  /
			  </xsl:when>
			</xsl:choose>
			<xsl:value-of select="reportingOwnerRelationship/otherText" />
		      </xsl:when>
		    </xsl:choose>
		  </xsl:for-each>
		  </font>
		  </td>
		</tr>
	      </table>
	      </td>

	      <td valign="top">
	      <font size="2">5. If Amendment, Date Original Filed</font> <font size="1">(Month/Day/Year)</font><br/>
	      <xsl:choose>
	        <xsl:when test="ownershipDocument/dateOfOriginalSubmission!=''">
	          <xsl:value-of select="concat(normalize-space(substring-before(substring-after(ownershipDocument/dateOfOriginalSubmission,'-'),'-')),'/',normalize-space(substring-after(substring-after(ownershipDocument/dateOfOriginalSubmission,'-'),'-')),'/',normalize-space(substring-before(ownershipDocument/dateOfOriginalSubmission,'-')))" />
		</xsl:when>
	      </xsl:choose>
	      </td>
	    </tr>

	    <tr>
	      <td valign="top" style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
	        <tr>
		  <td valign="top" colspan="3" width="100%" style="border:none">
		  <center><font size="1">(Street)</font></center><br></br>
		  </td>
		</tr>
	      </table>
	      <xsl:value-of select="ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerCity"/><xsl:choose>
	        <xsl:when test="ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerCity!='' and ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerState!=''">,&#160;</xsl:when>
	      </xsl:choose><xsl:value-of select="ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerState"/>&#160;<xsl:value-of select="ownershipDocument/reportingOwner/reportingOwnerAddress/rptOwnerZipCode"/>
	      </td>
              
	      <td valign="top">
              <font size="2">6. Individual or Joint/Group Filing</font> <font size="1">(Check Applicable Line)</font><br></br>
	      <font size="1">
	      <xsl:choose>
	        <xsl:when test="count(ownershipDocument/reportingOwner)&gt;1">
                  ___ Form filed by One Reporting Person<br/>
		  _X_ Form filed by More than One Reporting Person
		</xsl:when>
	        <xsl:otherwise>
		  _X_ Form filed by One Reporting Person<br/>
		  ___ Form filed by More than One Reporting Person
		</xsl:otherwise>
              </xsl:choose>
	      </font>
              </td>
	    </tr>

	    <tr>
	      <td valign="top" style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">
	        <tr>
		  <td style="border:none" width="33%">
		  <center><font size="1">(City)</font></center>
		  </td>
		  <td style="border:none" width="33%">
		  <center><font size="1">(State)</font></center>
		  </td>
		  <td style="border:none" width="33%">
		  <center><font size="1">(Zip)</font></center>
		  </td>
		</tr>
	      </table>
	      </td>
	      <td colspan="3" >
	      <center><b>Table I - Non-Derivative Securities Beneficially Owned</b></center>
	      </td>
	    </tr>
	  </table>
	</td>
      </tr>

      <tr>
        <td style="border-top-width: 0; border-left-width: 0; border-right-width: 0; border-bottom-width: 0">
	  <table role="presentation" cellpadding="3" cellspacing="0" border="0" width="100%">
	    <tr>
	      <td width="40%" valign="top" style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	      <font size="2">1.Title of Security<br/>(Instr. 4)</font>
	      </td>
	      <td width="20%" valign="top"  >
	      <font size="2">2. Amount of Securities Beneficially Owned<br/>(Instr. 4)</font>
	      </td>
	      <td width="10%" valign="top"  >
	      <font size="2">3. Ownership Form: Direct (D) or Indirect (I)<br/>(Instr. 5)</font>
	      </td>
	      <td width="30%" valign="top"  >
	      <font size="2">4. Nature of Indirect Beneficial Ownership<br/>(Instr. 5)</font>
	      </td>
	    </tr>

	    <xsl:for-each select="ownershipDocument/nonDerivativeTable/*">
	    <tr>
	      <td style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width:1">
	      <xsl:choose>
	        <xsl:when test="count(securityTitle/value)=0 and count(securityTitle/footnoteId)=0">
		  &#160;
		</xsl:when>
		<xsl:otherwise>
	          <xsl:apply-templates select="securityTitle"/>
		</xsl:otherwise>
	      </xsl:choose>
	      </td>

	      <td>
		<xsl:choose>
		  <xsl:when test="count(postTransactionAmounts/sharesOwnedFollowingTransaction)!=0">
	            <xsl:apply-templates select="postTransactionAmounts/sharesOwnedFollowingTransaction"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:choose>
		      <xsl:when test="count(postTransactionAmounts/valueOwnedFollowingTransaction)=0">
		        &#160;
		      </xsl:when>
		      <xsl:when test="postTransactionAmounts/valueOwnedFollowingTransaction/value!=''">
		        $<xsl:apply-templates select="postTransactionAmounts/valueOwnedFollowingTransaction"/>
		      </xsl:when>
		      <xsl:otherwise>
                        <xsl:apply-templates select="postTransactionAmounts/valueOwnedFollowingTransaction"/>
	              </xsl:otherwise>
		    </xsl:choose>
		  </xsl:otherwise>
		</xsl:choose>
	      </td>

	      <td>
	      <xsl:choose>
	        <xsl:when test="count(ownershipNature/directOrIndirectOwnership/value)=0 and count(ownershipNature/directOrIndirectOwnership/footnoteId)=0">
		  &#160;
		</xsl:when>
		<xsl:otherwise>
	          <center><xsl:apply-templates select="ownershipNature/directOrIndirectOwnership"/></center>
		</xsl:otherwise>
	      </xsl:choose>
	      </td>

	      <td>
	      <xsl:choose>
	        <xsl:when test="count(ownershipNature/natureOfOwnership/value)=0 and count(ownershipNature/natureOfOwnership/footnoteId)=0">
		  &#160;
		</xsl:when>
		<xsl:otherwise>
	          <xsl:apply-templates select="ownershipNature/natureOfOwnership"/>
		</xsl:otherwise>
	      </xsl:choose>
	      </td>
	    </tr>
	    </xsl:for-each>
	  </table>
	</td>
      </tr>
    </table>

    <p/>

    <table role="presentation" width="100%">
      <tr>
        <td style="border:none" colspan="3" ><font size="2">Reminder: Report on a separate line for each class of securities beneficially owned directly or indirectly.</font></td>
	<td style="border:none" align="right"><font size="2">SEC 1473 (7-02)</font></td>
      </tr>
      <tr>
        <td width="15%"></td>
        <td colspan="2" style="border:none"><font face="Arial" size="2"><b>Persons who respond to the collection of information contained in this form are not required to respond unless the form displays a currently valid OMB control number.</b></font></td>
	<td width="15%"></td>
      </tr>
    </table>

    <p/>

    <font size="2"><center><b>Table II - Derivative Securities Beneficially Owned (<i>e.g.</i>, puts, calls, warrants, options, convertible securities)</b></center></font>

    <table role="presentation" cellpadding="3" cellspacing="0" border="0">
      <tr>
        <td width="30%" valign="top" rowspan="2" style="border: solid black; border-top-width: 1; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	<font size="2">1. Title of Derivative Security<br/>(Instr. 4)</font>
	</td>
	<td width="10%" valign="top" colspan="2" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	<font size="2">2. Date Exercisable and Expiration Date<br/><font size="-2">(Month/Day/Year)</font></font>
	</td>
	<td width="20%" valign="top" colspan="2" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	<font size="2">3. Title and Amount of Securities Underlying Derivative Security<br/>(Instr. 4)</font>
	</td>
	<td width="10%" valign="top" rowspan="2" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	<font size="2">4. Conversion or Exercise Price of Derivative Security</font>
	</td>
	<td width="10%" valign="top" rowspan="2" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	<font size="2">5. Ownership Form of Derivative Security: Direct (D) or Indirect (I)<br/>(Instr. 5)</font>
	</td>
        <td width="20%" valign="top" rowspan="2" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	<font size="2">6. Nature of Indirect Beneficial Ownership<br/>(Instr. 5)</font>
	</td>
      </tr>
      <tr>
        <td valign="top">
	<font size="2">Date Exercisable</font>
	</td>
	<td valign="top">
	<font size="2">Expiration Date</font>
	</td>
	<td>
	<font size="2">Title</font>
	</td>
	<td>
	<font size="2">Amount or Number of Shares</font>
	</td>
     </tr>

     <xsl:for-each select="ownershipDocument/derivativeTable/*">
     <tr>
       <td style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
       <xsl:choose>
         <xsl:when test="count(securityTitle/value)=0 and count(securityTitle/footnoteId)=0">
	   &#160;
	 </xsl:when>
	 <xsl:otherwise>
           <xsl:apply-templates select="securityTitle"/>
	 </xsl:otherwise>
       </xsl:choose>
       </td>

       <td>
       <xsl:choose>
         <xsl:when test="count(exerciseDate/value)=0 and count(exerciseDate/footnoteId)=0">
	   &#160;
	 </xsl:when>
	 <xsl:otherwise>
           <xsl:apply-templates select="exerciseDate"/>
	 </xsl:otherwise>
       </xsl:choose>
       </td>

       <td>
       <xsl:choose>
         <xsl:when test="count(expirationDate/value)=0 and count(expirationDate/footnoteId)=0">
	   &#160;
	 </xsl:when>
	 <xsl:otherwise>
           <xsl:apply-templates select="expirationDate"/>
	 </xsl:otherwise>
       </xsl:choose>
       </td>

       <td>
       <xsl:choose>
         <xsl:when test="count(underlyingSecurity/underlyingSecurityTitle/value)=0 and count(underlyingSecurity/underlyingSecurityTitle/footnoteId)=0">
	   &#160;
	 </xsl:when>
	 <xsl:otherwise>
           <xsl:apply-templates select="underlyingSecurity/underlyingSecurityTitle"/>
	 </xsl:otherwise>
       </xsl:choose>
       </td>

       <td>
 	<xsl:choose>
 	  <xsl:when test="count(underlyingSecurity/underlyingSecurityShares)!=0">
	    <xsl:apply-templates select="underlyingSecurity/underlyingSecurityShares"/>
 	  </xsl:when>
 	  <xsl:otherwise>
	    <xsl:choose>
	      <xsl:when test="count(underlyingSecurity/underlyingSecurityValue)=0">
	        &#160;
	      </xsl:when>
	      <xsl:when test="underlyingSecurity/underlyingSecurityValue/value!=''">
 	        $<xsl:apply-templates select="underlyingSecurity/underlyingSecurityValue"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:apply-templates select="underlyingSecurity/underlyingSecurityValue"/>
	      </xsl:otherwise>
	    </xsl:choose>
 	  </xsl:otherwise>
	</xsl:choose>
       </td>

       <td>
       <xsl:choose>
         <xsl:when test="count(conversionOrExercisePrice/value)=0 and count(conversionOrExercisePrice/footnoteId)=0">
	   &#160;
	 </xsl:when>
         <xsl:when test="conversionOrExercisePrice!=''">
           $<xsl:apply-templates select="conversionOrExercisePrice"/>
         </xsl:when>
	 <xsl:otherwise>
	   <xsl:apply-templates select="conversionOrExercisePrice"/>
	 </xsl:otherwise>
       </xsl:choose>
       </td>

       <td align="center">
       <xsl:choose>
         <xsl:when test="count(ownershipNature/directOrIndirectOwnership/value)=0 and count(ownershipNature/directOrIndirectOwnership/footnoteId)=0">
	   &#160;
	 </xsl:when>
	 <xsl:otherwise>
           <xsl:apply-templates select="ownershipNature/directOrIndirectOwnership"/>
	 </xsl:otherwise>
       </xsl:choose>
       </td>

       <td>
       <xsl:choose>
         <xsl:when test="count(ownershipNature/natureOfOwnership/value)=0 and count(ownershipNature/natureOfOwnership/footnoteId)=0">
	   &#160;
	 </xsl:when>
	 <xsl:otherwise>
           <xsl:apply-templates select="ownershipNature/natureOfOwnership"/>
	 </xsl:otherwise>
       </xsl:choose>
       </td>
     </tr>
     </xsl:for-each>
    </table>

    <p/>

    <h2>Reporting Owners</h2>
    <table role="presentation" cellpadding="3" cellspacing="0" border="0">
      <tr>
        <td rowspan="2" align="center" style="border: solid black; border-top-width: 1; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	<b><font size="2">Reporting Owner Name / Address</font></b>
	</td>
	<td colspan="4" align="center" style="border: solid black; border-top-width: 1; border-left-width: 0; border-right-width: 1; border-bottom-width: 1">
	<b><font size="2">Relationships</font></b>
	</td>
      </tr>

      <tr>
        <td><font size="2">Director</font></td>
	<td><font size="2">10% Owner</font></td>
	<td><font size="2">Officer</font></td>
	<td><font size="2">Other</font></td>
      </tr>

      <xsl:for-each select="ownershipDocument/reportingOwner">
      <tr>
        <td style="border: solid black; border-top-width: 0; border-left-width: 1; border-right-width: 1; border-bottom-width: 1">
	<xsl:choose>
	  <xsl:when test="count(reportingOwnerId/rptOwnerName) + count(reportingOwnerAddress)=0">
	    &#160;
	  </xsl:when>
	</xsl:choose>
	<xsl:choose>
	  <xsl:when test="reportingOwnerId/rptOwnerName!=''">
	    <xsl:value-of select="reportingOwnerId/rptOwnerName"/><br/>
	  </xsl:when>
	</xsl:choose>
        <xsl:value-of select="reportingOwnerAddress/rptOwnerStreet1"/><xsl:choose>
	  <xsl:when test="reportingOwnerAddress/rptOwnerStreet1!='' and reportingOwnerAddress/rptOwnerStreet2!=''"><br/></xsl:when>
	</xsl:choose><xsl:value-of select="reportingOwnerAddress/rptOwnerStreet2"/>
	<xsl:choose>
	  <xsl:when test="count(reportingOwnerAddress/rptOwnerCity) + count(reportingOwnerAddress/rptOwnerState) + count(reportingOwnerAddress/rptOwnerZipCode)=0">
	    &#160;
	  </xsl:when>
	  <xsl:otherwise>
	    <br/>
	  </xsl:otherwise>
	</xsl:choose>
        <xsl:value-of select="reportingOwnerAddress/rptOwnerCity"/><xsl:choose>
	  <xsl:when test="reportingOwnerAddress/rptOwnerCity!='' and reportingOwnerAddress/rptOwnerState!=''">,&#160;</xsl:when>
        </xsl:choose><xsl:value-of select="reportingOwnerAddress/rptOwnerState"/>&#160;<xsl:value-of select="reportingOwnerAddress/rptOwnerZipCode"/>
	</td>
	<td align="center">&#160;
	<xsl:choose>
          <xsl:when test="reportingOwnerRelationship/isDirector=1 or reportingOwnerRelationship/isDirector='true'">
            X
          </xsl:when>
        </xsl:choose>
	</td>
	<td align="center">&#160;
	<xsl:choose>
	  <xsl:when test="reportingOwnerRelationship/isTenPercentOwner=1 or reportingOwnerRelationship/isTenPercentOwner='true'">
            X
	  </xsl:when>
	</xsl:choose>
	</td>
	<td>&#160;
	<xsl:choose>
	  <xsl:when test="reportingOwnerRelationship/officerTitle!=''">
            <xsl:value-of select="reportingOwnerRelationship/officerTitle"/>
	  </xsl:when>
	</xsl:choose>
	</td>
	<td>
	<xsl:choose>
	  <xsl:when test="reportingOwnerRelationship/otherText!=''">
            <xsl:value-of select="reportingOwnerRelationship/otherText" />
	  </xsl:when>
	  <xsl:otherwise>
	    &#160;
	  </xsl:otherwise>
	</xsl:choose>
	</td>
      </tr>
      </xsl:for-each>
    </table>

    <h2>Signatures</h2>
    <dd/><table role="presentation" cellpadding="3" cellspacing="0" border="0">
      <xsl:for-each select="ownershipDocument/ownerSignature">
      <tr>
        <td style="border: solid black; border-top-width: 0; border-right-width: 0; border-left-width: 0; border-bottom-width: 1"><xsl:value-of select="signatureName"/></td>
	<td rowspan="2" width="50"></td>
        <td style="border: solid black; border-top-width: 0; border-right-width: 0; border-left-width: 0; border-bottom-width: 1">
	<xsl:choose>
          <xsl:when test="signatureDate!=''">
            <xsl:value-of select="concat(normalize-space(substring-before(substring-after(signatureDate,'-'),'-')),'/',normalize-space(substring-after(substring-after(signatureDate,'-'),'-')),'/',normalize-space(substring-before(signatureDate,'-')))" />
	  </xsl:when>
        </xsl:choose>
	</td>
      </tr>
      <tr>
        <td style="border: none" align="center" valign="top"><font size="1"><sup><a href="#**">**</a></sup>Signature of Reporting Person</font></td>
        <td style="border: none" align="center" valign="top"><font size="1">Date</font><p/></td>
      </tr>
      </xsl:for-each>
    </table>

    <h2>Explanation of Responses:</h2>
    <dd/><table role="presentation" cellpadding="3" cellspacing="0" border="0">
    <xsl:choose>
      <xsl:when test="ownershipDocument/noSecuritiesOwned=1 or ownershipDocument/noSecuritiesOwned='true'">
      <tr>
        <td colspan="2" style="border: none"><b>No securities are beneficially owned</b><p/></td>
      </tr>
      </xsl:when>
    </xsl:choose>

      <tr>
        <td style="border:none"><font size="2"><b><a name="#*">*</a></b></font></td>
        <td style="border:none"><font size="2">If the form is filed by more than one reporting person, <i>see</i> Instruction 5(b)(v).</font></td>
      </tr>
      <tr>
        <td style="border:none"><font size="2"><b><a name="#**">**</a></b></font></td>
        <td style="border:none"><font size="2">Intentional misstatements or omissions of facts constitute Federal Criminal Violations.  <i>See</i> 18 U.S.C. 1001 and 15 U.S.C. 78ff(a).</font></td>
      </tr>
      <xsl:for-each select="ownershipDocument/footnotes/footnote">
      <tr>
        <td style="border:none"><font size="2"><b>(<a name="#{@id}"></a><xsl:value-of select="substring-after(@id,'F')"/>)</b></font></td>
        <td style="border:none"><font size="2"><xsl:value-of select="."/></font></td>
      </tr>
      </xsl:for-each>

      <xsl:choose>
        <xsl:when test="ownershipDocument/remarks!=''">
	<tr>
	  <td colspan="2" style="border:none">&#160;<br/><b>Remarks:</b><br/>
	  <xsl:call-template name="line-break">
            <xsl:with-param name="text" select='translate(ownershipDocument/remarks,"  ","&#160; ")'/>
          </xsl:call-template>
	  </td>
	</tr>
	</xsl:when>
      </xsl:choose>
    </table>

    <p/>

    <dd/><font size="2">Note: File three copies of this Form, one of which must be manually signed.  If space is insufficient, <i>See</i> Instruction 6 for procedure.</font><p/>
    <dd/><font size="2">Potential persons who are to respond to the collection of information contained in this form are not required to respond unless the form displays a currently valid OMB number.</font>
  </body>
  </html>
</xsl:template></xsl:stylesheet>