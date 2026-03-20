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

	<!-- Item 3 templates -->
	<xsl:template name="Item3">
	
	 <xsl:if test="count(m1:generalInfo/m1:applicantCategory) &gt; 0
		   or count(m1:generalInfo/m1:businessOrgInfo) &gt; 0
		   or count(m1:generalInfo/m1:consentName) &gt; 0
		    or count(m1:generalInfo/m1:consentAddress) &gt; 0 ">
	<h1><xsl:value-of select="$subType"/>: General Information (6-9)
			</h1>
		<h3>
			<em>General Information (6-9)
			</em>
		</h3>
		<xsl:call-template name="generalInfo2" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="generalInfo2">
	
	 <xsl:if test="count(m1:generalInfo/m1:applicantCategory) &gt; 0 ">
		<table role="presentation" style="border:groove">
		<!--  	<tr>
				<h4>
					<em>6. Applicant Category:</em>
				</h4>
			</tr>-->
				 <xsl:if test="count(m1:generalInfo/m1:applicantCategory/m1:applicantTypeConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:applicantCategory/m1:applicantTypeConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
		 <xsl:if test="count(m1:generalInfo/m1:applicantCategory/m1:applicantType) &gt; 0 ">
			<tr>
				<td class="label">
					6. Applicant is a:
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when
								test="count(m1:generalInfo/m1:applicantCategory/m1:applicantType) &gt; 0">
								<xsl:choose>
									<xsl:when
										test="string(m1:generalInfo/m1:applicantCategory/m1:applicantType) = 'Corporation'">
										<img src="Images/radio-checked.jpg" alt="Radio button checked" />
										Corporation
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Partnership
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Limited Liability Company
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Other Form of Organization (specify)
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when
										test="string(m1:generalInfo/m1:applicantCategory/m1:applicantType) = 'Partnership'">
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Corporation
										<img src="Images/radio-checked.jpg" alt="Radio button checked" />
										Partnership
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Limited Liability Company
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Other Form of Organization (specify)
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when
										test="string(m1:generalInfo/m1:applicantCategory/m1:applicantType) = 'Limited Liability Company'">
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Corporation
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										Partnership
										<img src="Images/radio-checked.jpg" alt="Radio button checked" />
										Limited Liability Company
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Other Form of Organization (specify)
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when
										test="string(m1:generalInfo/m1:applicantCategory/m1:applicantType) = 'Other Form of Organization'">
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Corporation
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										Partnership
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Limited Liability Company
										<img src="Images/radio-checked.jpg" alt="Radio button checked" />
										Other Form of Organization (specify)
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Corporation
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Partnership
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Limited Liability Company
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Other Form of Organization (specify)
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
		
			<xsl:choose>
				<xsl:when
					test="string(m1:generalInfo/m1:applicantCategory/m1:applicantType) = 'Other Form of Organization'">
				 <xsl:if test="count(m1:generalInfo/m1:applicantCategory/m1:applicantTypeOtherDesc) &gt; 0 ">	
					<tr>
						<td class="label">Specify
						</td>
						<td>
							<p>
								<div class="fakeBox3">
									<xsl:value-of
										select="string(m1:generalInfo/m1:applicantCategory/m1:applicantTypeOtherDesc)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		
		</xsl:if>
		</table>
<br/>
</xsl:if>
	 <xsl:if test="count(m1:generalInfo/m1:businessOrgInfo/m1:dateOfIncorporationOrFormationConfFlag) &gt; 0
		   or count(m1:generalInfo/m1:businessOrgInfo/m1:dateOfIncorporationOrFormation) &gt; 0">
			<table role="presentation" style="border:groove">
			 <xsl:if test="count(m1:generalInfo/m1:businessOrgInfo/m1:dateOfIncorporationOrFormationConfFlag) &gt; 0 ">
				<tr>
					<td class="label">
						Confidentiality Requested:
					</td>
					<td>
						<xsl:choose>
							<xsl:when
								test="string(m1:generalInfo/m1:businessOrgInfo/m1:dateOfIncorporationOrFormationConfFlag) = 'true'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				</xsl:if>
				 <xsl:if test="count(m1:generalInfo/m1:businessOrgInfo/m1:dateOfIncorporationOrFormation) &gt; 0 ">
				<tr>
					<td class="label">7. Date of incorporation or formation:
					</td>
					<td>
						<p>
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:generalInfo/m1:businessOrgInfo/m1:dateOfIncorporationOrFormation)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				
				</table>
				<br/>
				</xsl:if>
				
				 <xsl:if test="count(m1:generalInfo/m1:businessOrgInfo/m1:stateOfIncorporationOrJurisdictionOfOrganizationConfFlag) &gt; 0
		   or count(./m1:generalInfo/m1:businessOrgInfo/m1:stateOfIncorporationOrJurisdictionOfOrganization) &gt; 0">	
				<table role="presentation" style="border:groove">
				 <xsl:if test="count(m1:generalInfo/m1:businessOrgInfo/m1:stateOfIncorporationOrJurisdictionOfOrganizationConfFlag) &gt; 0 ">
				<tr>
					<td class="label">
						Confidentiality Requested:
					</td>
					<td>
						<xsl:choose>
							<xsl:when
								test="string(m1:generalInfo/m1:businessOrgInfo/m1:stateOfIncorporationOrJurisdictionOfOrganizationConfFlag) = 'true'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				</xsl:if>
				 <xsl:if test="count(./m1:generalInfo/m1:businessOrgInfo/m1:stateOfIncorporationOrJurisdictionOfOrganization) &gt; 0 ">
				<tr>
					<td class="label">8. State of incorporation or jurisdiction of organization:
					</td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="./m1:generalInfo/m1:businessOrgInfo/m1:stateOfIncorporationOrJurisdictionOfOrganization" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
		</xsl:if>
			</table>		
			<br/>
			</xsl:if>
			
						 <xsl:if test="count(m1:generalInfo/m1:consentName/m1:consentNameConfFlag) &gt; 0
		   or count(m1:generalInfo/m1:consentName/m1:personNameOrOfficerTitle) &gt; 0
		    or count(m1:generalInfo/m1:consentName/m1:applicantNameOrApplcblEntity) &gt; 0">	
				<table role="presentation" style="border:groove">
				<tr>
					<h4>
						<em>9. The Applicant agrees and consents that the notice of any proceeding before the
						 Commission in connection with this application may be given by sending such notice
						  by certified mail to the person named below at the address given.
						</em>
					</h4>
				</tr>
				 <xsl:if test="count(m1:generalInfo/m1:consentName/m1:consentNameConfFlag) &gt; 0 ">
				<tr>
					<td class="label">
						Confidentiality Requested:
					</td>
					<td>
						<xsl:choose>
							<xsl:when
								test="string(m1:generalInfo/m1:consentName/m1:consentNameConfFlag) = 'true'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				</xsl:if>
					 <xsl:if test="count(m1:generalInfo/m1:consentName/m1:personNameOrOfficerTitle) &gt; 0 ">
				<tr>
					<td class="label">Print Name and Title
					</td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of
									select="string(m1:generalInfo/m1:consentName/m1:personNameOrOfficerTitle)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				 <xsl:if test="count(m1:generalInfo/m1:consentName/m1:applicantNameOrApplcblEntity) &gt; 0 ">
				<tr>
					<td class="label">Name of Applicant
					</td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of
										select="string(m1:generalInfo/m1:consentName/m1:applicantNameOrApplcblEntity)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
			</table>
<br/>
</xsl:if>

 <xsl:if test="count(m1:generalInfo/m1:consentAddress/m1:consentAddressConfFlag) &gt; 0
		   or count(m1:generalInfo/m1:consentAddress/m1:street1) &gt; 0
		    or count(m1:generalInfo/m1:consentAddress/m1:street2) &gt; 0
		    or count(m1:generalInfo/m1:consentAddress/m1:city) &gt; 0
		     or count(./m1:generalInfo/m1:consentAddress/m1:stateCountry) &gt; 0
		     or count(m1:generalInfo/m1:consentAddress/m1:zipCode) &gt; 0">	
		<table role="presentation" style="border:groove">
				 <xsl:if test="count(m1:generalInfo/m1:consentAddress/m1:consentAddressConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:consentAddress/m1:consentAddressConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(m1:generalInfo/m1:consentAddress/m1:street1) &gt; 0 ">
			<tr>
				<td class="label">Address 1 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:generalInfo/m1:consentAddress/m1:street1)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(m1:generalInfo/m1:consentAddress/m1:street2) &gt; 0 ">
			<tr>
				<td class="label">Address 2 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:generalInfo/m1:consentAddress/m1:street2)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(m1:generalInfo/m1:consentAddress/m1:city) &gt; 0 ">
			<tr>
				<td class="label">City </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of select="string(m1:generalInfo/m1:consentAddress/m1:city)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
				 <xsl:if test="count(./m1:generalInfo/m1:consentAddress/m1:stateCountry) &gt; 0 ">
			<tr>
				<td class="label">State </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(./m1:generalInfo/m1:consentAddress/m1:stateCountry)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
				 </xsl:if>
				  <xsl:if test="count(m1:generalInfo/m1:consentAddress/m1:zipCode) &gt; 0 ">
			<tr>
				<td class="label">Zip Code  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:generalInfo/m1:consentAddress/m1:zipCode)" />
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

	</xsl:template>
</xsl:stylesheet>