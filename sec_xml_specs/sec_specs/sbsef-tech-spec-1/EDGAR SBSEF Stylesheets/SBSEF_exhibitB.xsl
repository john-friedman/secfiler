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

	<!-- Item 5 templates -->
	<xsl:template name="ExhibitB">
	<xsl:if test="count(m1:exhibitB) &gt; 0">	
	<h1><xsl:value-of select="$subType"/>: Exhibit B
			</h1>
		<h3>
			<em>Exhibit B
			</em>
		</h3>
		<table role="presentation" >
			<tr>
				<h4>
					<em>
						For Exhibit B, provide a list of the present officers, directors, governors
						 (and, in the case of an Applicant that is not a corporation, the members of
						  all standing committees, grouped by committee), or persons performing functions
						   similar to any of the foregoing, of the security-based swap execution facility
						    or of any entity that performs the regulatory activities of the Applicant, indicating for each:
					</em>
				</h4>
			</tr>
			
	</table>
		<xsl:call-template name="exhibitBcontent" />
	</xsl:if>
	</xsl:template>

	<xsl:template name="exhibitBcontent">
		
		<xsl:for-each select="m1:exhibitB/exb:exhibitBInfo">
		
				  <xsl:if test="count(exb:nameTitleConfFlag) &gt; 0
		  or count(exb:name) &gt; 0
		  or count(exb:title) &gt; 0 
		  or count(exb:dateConfFlag) &gt; 0 
		  or count(exb:commencementDate) &gt; 0  
		  or  count(exb:terminationDate) &gt; 0
		   or count(exb:positionLengthConfFlag) &gt; 0
		   or count(exb:positionLength) &gt; 0
		   or count(exb:businessAccountExperienceConfFlag) &gt; 0
		   or count(exb:businessAccountExperience) &gt; 0
		   or count(exb:businessAffiliatesConfFlag) &gt; 0
		   or count(exb:businessAffiliates) &gt; 0   		     
		   or count(exb:directorCommitteesConfFlag) &gt; 0  
		   or count(exb:directorCommittees) &gt; 0   
		   or  count(exb:disciplinaryActionConfFlag) &gt; 0  
		   or  count(exb:hasDisciplinaryAction) &gt; 0
		   or  count(exb:disciplinaryActionReason) &gt; 0">
		 <br />	
		<table role="presentation"><tr>Exhibit B Record: <xsl:value-of select="position()"></xsl:value-of></tr></table> 
		<br/>
		  <xsl:if test="count(exb:nameTitleConfFlag) &gt; 0
		  or count(exb:name) &gt; 0 
		  or count(exb:title) &gt; 0 ">
		<table role="presentation" style="border:groove">
		
		 <xsl:if test="count(exb:nameTitleConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exb:nameTitleConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
				 <xsl:if test="count(exb:name) &gt; 0 ">
			<tr>
				<td class="label">a. Name  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of
									select="string(exb:name)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
	      <xsl:if test="count(exb:title) &gt; 0 ">
			<tr>
				<td class="label">b. Title
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:title)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			</table>
			<br/>
			</xsl:if>
			
					  <xsl:if test="count(exb:dateConfFlag) &gt; 0  
		  or  count(exb:commencementDate) &gt; 0
		  or  count(exb:terminationDate) &gt; 0  ">
			<table role="presentation" >
			
			<tr>
				<h4>
					<em>c. Dates of commencement and termination of the present term of office or position:
					</em>
				</h4>
			</tr>
			</table>
			
		<table role="presentation" style="border:groove">
		
			 <xsl:if test="count(exb:dateConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exb:dateConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			
		   <xsl:if test="count(exb:commencementDate) &gt; 0 ">
			<tr>
				<td class="label">Date of commencement   </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:commencementDate)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			
			 <xsl:if test="count(exb:terminationDate) &gt; 0 ">
			<tr>
				<td class="label">Date of termination   </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:terminationDate)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
		  </xsl:if>
			</table>
			<br/>
			</xsl:if>
			
			  <xsl:if test="count(exb:positionLengthConfFlag) &gt; 0  
		  or  count(exb:positionLength) &gt; 0 ">
			<table role="presentation" style="border:groove" >	
			
			 <xsl:if test="count(exb:positionLengthConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exb:positionLengthConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(exb:positionLength) &gt; 0 ">
			<tr>
				<td class="label">d. Length of time the present officer, director, or governor has held the same office or position:
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:positionLength)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
		</table>
		<br/>
		</xsl:if>
		
		 <xsl:if test="count(exb:businessAccountExperienceConfFlag) &gt; 0  
		  or  count(exb:businessAccountExperience) &gt; 0 ">
		<table role="presentation" style="border:groove"  >	
		 <xsl:if test="count(exb:businessAccountExperienceConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exb:businessAccountExperienceConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(exb:businessAccountExperience) &gt; 0 ">
			<tr>
				<td class="label">e. Brief account of the business experience of the officer and director over the last five years:
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:businessAccountExperience)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			</table>
			<br/>
			</xsl:if>
			
				  <xsl:if test="count(exb:businessAffiliatesConfFlag) &gt; 0  
		  or  count(exb:businessAffiliates) &gt; 0 ">
			<table role="presentation"  style="border:groove" >
			 <xsl:if test="count(exb:businessAffiliatesConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exb:businessAffiliatesConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(exb:businessAffiliates) &gt; 0 ">
			<tr>
				<td class="label">f. Any other business affiliations in the derivatives and securities industry:
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:businessAffiliates)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
		</xsl:if>
			</table>
			<br/>
			</xsl:if>
			
			  <xsl:if test="count(exb:directorCommitteesConfFlag) &gt; 0  
		  or  count(exb:directorCommittees) &gt; 0 ">
				<table role="presentation"  style="border:groove">
				<xsl:if test="count(exb:directorCommitteesConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exb:directorCommitteesConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(exb:directorCommittees) &gt; 0 ">
			<tr>
				<td class="label">g. For directors, list any committees on which they serve and any compensation received by virtue of their directorship:
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:directorCommittees)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			</table>
			<br/>
			</xsl:if>
			
			  <xsl:if test="count(exb:disciplinaryActionConfFlag) &gt; 0  
		  or  count(exb:hasDisciplinaryAction) &gt; 0
		   or  count(exb:disciplinaryActionReason) &gt; 0">
			<table role="presentation" style="border:groove" >
				<xsl:if test="count(exb:disciplinaryActionConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exb:disciplinaryActionConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<!-- radio -->
				<xsl:if test="count(exb:hasDisciplinaryAction ) &gt; 0 ">
			<tr>
				<td class="label">
					h. Indicate whether the person has been subject to a disciplinary action of any type noted in § 242.819(i) of Regulation SE:
				</td>
				<td>					
						<xsl:choose>
							<xsl:when test="exb:hasDisciplinaryAction = 'Y'">
								<img src="Images/radio-checked.jpg" alt="radio button checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="radio button unchecked" />
							</xsl:otherwise>
						</xsl:choose>
						&#160;Yes&#160;
						<xsl:choose>
							<xsl:when test="exb:hasDisciplinaryAction = 'N'">
								<img src="Images/radio-checked.jpg" alt="radio button checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="radio button unchecked" />
							</xsl:otherwise>
						</xsl:choose>
						&#160;No
				</td>
			</tr>
			</xsl:if>
			 	<xsl:if test="exb:hasDisciplinaryAction = 'Y' and count(exb:disciplinaryActionReason) &gt; 0 ">
			<tr>
				<td class="label">If so, describe the disciplinary action of any type noted in § 242.819(i) of Regulation SE to which the person has been subject:
				</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(exb:disciplinaryActionReason)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
	
		</table>
		</xsl:if>
		</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>