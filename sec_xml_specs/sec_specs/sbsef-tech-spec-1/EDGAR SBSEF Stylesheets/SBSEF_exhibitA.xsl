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

	<!-- Exhibit A templates -->
	<xsl:template name="ExhibitA">
	
	 <xsl:if test="count(m1:exhibitA) &gt; 0">	
	<h1><xsl:value-of select="$subType"/>: Exhibit A
			</h1>
	<h3>
			<em>Exhibit A
			</em>
		</h3>
		<table role="presentation" >
			<tr>
				<h4>
					<em>
						For Exhibit A, provide the name of any person who owns ten percent (10%) or
						 more of the Applicant's stock or who, either directly or indirectly, through
						  agreement or otherwise, in any other manner, may control or direct the management
						   or policies of the Applicant. Provide as part of Exhibit A the full name and address
						    of each such person and attach a copy of the agreement or, if there is none written,
						     describe the agreement or basis upon which such person exercises or may exercise such
						      control or direction. The agreement can be attached on the "Other Exhibits" tab.

					</em>
				</h4>
			</tr>
			
	</table>
			 <xsl:if test="count(m1:exhibitA/exa:questionApplicableFlag) &gt; 0">	
		<table role="presentation" >
			<tr>
				<td class="label">
					Not Applicable
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:exhibitA/exa:questionApplicableFlag) = 'true'">
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
		<xsl:call-template name="exhibitAcontent" />
		
		</xsl:if>
	</xsl:template>

	<xsl:template name="exhibitAcontent">
	
		<xsl:for-each select="m1:exhibitA/exa:exhibitAInfo">
		
		  <xsl:if test="count(exa:ownershipNameConfFlag) &gt; 0
		  or count(exa:ownershipName) &gt; 0
		   or count(exa:percentageOwnershipConfFlag) &gt; 0 
		  or count(exa:percentageOwnership) &gt; 0 
		   or count(exa:address/ns3:businessAddressConfFlag) &gt; 0  
		  or  count(exa:address/ns3:street1) &gt; 0
		   or count(exa:address/ns3:street2) &gt; 0
		   or count(exa:address/ns3:city) &gt; 0
		   or count(exa:address/ns3:stateOrCountry) &gt; 0
		    or count(exa:address/ns3:zipCode) &gt; 0
		       or count(exa:agreementDescriptionConfFlag) &gt; 0
		     or count(exa:agreementDescription) &gt; 0   ">
		 <br />	
		<table role="presentation"><tr>Exhibit A Record: <xsl:value-of select="position()"></xsl:value-of></tr></table>
		<br/>
		  <xsl:if test="count(exa:ownershipNameConfFlag) &gt; 0
		  or count(exa:ownershipName) &gt; 0  ">
			<table role="presentation" style="border:groove">
				 <xsl:if test="count(exa:ownershipNameConfFlag ) &gt; 0 ">
			   <tr>
					<td class="label">
						Confidentiality Requested:
					</td>
					<td>
						<xsl:choose>
							<xsl:when
								test="exa:ownershipNameConfFlag = 'true'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				</xsl:if>
						 <xsl:if test="count(exa:ownershipName ) &gt; 0 ">
				<tr>
					<td class="label">Full name of any person who owns ten percent (10%) or more of the Applicant's stock or who,
					 either directly or indirectly, through agreement or otherwise, in any other manner,
					  may control or direct the management or policies of the Applicant. 
					</td>
					<td>
						<p>
							<div align="left">
								<div class="fakeBox3">
									<xsl:value-of select="exa:ownershipName" />
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
			
			<xsl:if test="count(exa:percentageOwnershipConfFlag) &gt; 0
		  or count(exa:percentageOwnership ) &gt; 0  ">
			<table role="presentation" style="border:groove">
			 <xsl:if test="count(exa:percentageOwnershipConfFlag ) &gt; 0 ">
					<tr>
					<td class="label">
						Confidentiality Requested:
					</td>
					<td>
						<xsl:choose>
							<xsl:when
								test="exa:percentageOwnershipConfFlag = 'true'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				</xsl:if>
					 <xsl:if test="count(exa:percentageOwnership ) &gt; 0 ">
				<tr>
					<td class="label">Percentage of ownership in SBSEF
					</td>
					<td>
						<p>
							<div align="left">
								<div class="fakeBox2">
									<xsl:value-of
										select="exa:percentageOwnership" />
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
				
					
		  <xsl:if test="count(exa:address/ns3:businessAddressConfFlag) &gt; 0  
		  or  count(exa:address/ns3:street1) &gt; 0
		   or count(exa:address/ns3:street2) &gt; 0
		   or count(exa:address/ns3:city) &gt; 0
		   or count(exa:address/ns3:stateOrCountry) &gt; 0
		    or count(exa:address/ns3:zipCode) &gt; 0  ">
		     
				<table role="presentation" style="border:groove">
				<xsl:if test="count(exa:address/ns3:businessAddressConfFlag) &gt; 0 ">
					<tr>
					<td class="label">
						Confidentiality Requested:
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="(exa:address/ns3:businessAddressConfFlag) = 'true'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				</xsl:if>
					<xsl:if test="count(exa:address/ns3:street1) &gt; 0 ">
				<tr>
					<td class="label">Address 1 </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of select="exa:address/ns3:street1" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				<xsl:if test="count(exa:address/ns3:street2) &gt; 0 ">
				<tr>
					<td class="label">Address 2 </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of select="exa:address/ns3:street2" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				<xsl:if test="count(exa:address/ns3:city) &gt; 0 ">
				<tr>
					<td class="label">City </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of select="exa:address/ns3:city" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				<xsl:if test="count(./exa:address/ns3:stateOrCountry) &gt; 0 ">
				<tr>
					<td class="label">State/Province/Country </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(./exa:address/ns3:stateOrCountry)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				<xsl:if test="count(exa:address/ns3:zipCode) &gt; 0 ">
				<tr>
					<td class="label">Mailing Zip/Postal Code </td>
					<td>
						<p>
							<div class="fakeBox2">
								<xsl:value-of select="exa:address/ns3:zipCode" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
			</xsl:if>
			</table>
			</xsl:if>
			
			
					
		  <xsl:if test="count(exa:agreementDescriptionConfFlag) &gt; 0  
		  or  count(exa:agreementDescription) &gt; 0 ">
		     
			<table role="presentation" >
			<tr>
				<h4>
					<em>
						Attach a copy of the agreement through which such person exercises or may exercise control or
			            direction of the management or policies of the Applicant. The agreement can be attached on the
			             "Other Exhibits" tab.

					</em>
				</h4>
			</tr>
			
	</table>

			<table role="presentation" style="border:groove">
			<xsl:if test="count(exa:agreementDescriptionConfFlag) &gt; 0 ">
				<tr>
					<td class="label">
						Confidentiality Requested:
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="(exa:agreementDescriptionConfFlag) = 'true'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				</xsl:if>
				<xsl:if test="count(exa:agreementDescription) &gt; 0 ">
				<tr>
					<td class="label">
                             If no written agreement exists, describe the agreement or basis upon which such person exercises
                              or may exercise control or direction of the management or policies of the Applicant. </td>
					<td>
						<p>
							<div class="fakeBox2">
								<xsl:value-of select="exa:agreementDescription" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
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