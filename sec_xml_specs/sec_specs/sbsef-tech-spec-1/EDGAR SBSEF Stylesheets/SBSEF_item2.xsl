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

	<!-- Item 2 templates -->
	<xsl:template name="Item2">
		<h3>
			<em>General Information (1-5)
			</em>
		</h3>
		<xsl:call-template name="generalInfo1" />
	</xsl:template>

	<xsl:template name="generalInfo1">
	
	
	 <xsl:if test="count(m1:generalInfo/m1:businessInfo/m1:businessName/m1:nameOnBusinessConfFlag) &gt; 0
		  or count(m1:generalInfo/m1:businessInfo/m1:businessName/m1:nameOnBusiness) &gt; 0  ">
		<table role="presentation" style="border:groove">
			<xsl:if test="count(m1:generalInfo/m1:businessInfo/m1:businessName/m1:nameOnBusinessConfFlag) &gt; 0">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:businessInfo/m1:businessName/m1:nameOnBusinessConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />

						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(m1:generalInfo/m1:businessInfo/m1:businessName/m1:nameOnBusiness) &gt; 0">
			<tr>
				<td class="label">1. Name under which business of the security-based swap
					 execution facility is or will be conducted, if different from
					  name specified above (include acronyms, if any):
				</td>
				<td>
					<p>
						<div class="fakeBox3">
							<xsl:value-of
								select="string(m1:generalInfo/m1:businessInfo/m1:businessName/m1:nameOnBusiness)" />
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

      <xsl:if test="count(m1:generalInfo/m1:businessInfo/m1:previousBusinessName/m1:previousBusinessNameConfFlag) &gt; 0
		  or count(m1:generalInfo/m1:businessInfo/m1:previousBusinessName/m1:previousBusinessName) &gt; 0  ">
		<table role="presentation" style="border:groove">
				<xsl:if test="count(m1:generalInfo/m1:businessInfo/m1:previousBusinessName/m1:previousBusinessNameConfFlag) &gt; 0">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:businessInfo/m1:previousBusinessName/m1:previousBusinessNameConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />

						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:generalInfo/m1:businessInfo/m1:previousBusinessName/m1:previousBusinessName) &gt; 0">
			<tr>
				<td class="label">2. If name of security-based swap execution facility is being amended,
				 state previous security-based swap execution facility name:
				</td>
				<td>
					<p>
						<div class="fakeBox3">
							<xsl:value-of
								select="string(m1:generalInfo/m1:businessInfo/m1:previousBusinessName/m1:previousBusinessName)" />
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
   	
			 <xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:contactInfoConfFlag) &gt; 0
		   or count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:street1) &gt; 0
		   or count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:street2) &gt; 0
		    or count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:city) &gt; 0
		     or count(./m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:stateOrCountry) &gt; 0
		      or count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:zipCode) &gt; 0
		        or count(m1:generalInfo/m1:contactInfo/m1:phone) &gt; 0
		         or count(m1:generalInfo/m1:contactInfo/m1:faxNumber) &gt; 0
		           or count(m1:generalInfo/m1:contactInfo/m1:webAddress) &gt; 0
		           or count(m1:generalInfo/m1:contactInfo/m1:emailAddress) &gt; 0 ">
   
		<table role="presentation" style="border:groove">
			<tr>
				<h4>
					<em>3. Contact information, including mailing address if different than address of principal executive offices:</em>
				</h4>
			</tr>
			
			<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:contactInfoConfFlag) &gt; 0">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:contactInfo/m1:contactInfoConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />

						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:street1) &gt; 0">
			<tr>			
				<td class="label">Address 1 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:street1)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:street2) &gt; 0">
			<tr>
				<td class="label">Address 2 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:street2)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
					<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:city) &gt; 0">
			<tr>
				<td class="label">City </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:city)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(./m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:stateOrCountry) &gt; 0">
			<tr>
				<td class="label">State/Province/Country  </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(./m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:stateOrCountry)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:zipCode) &gt; 0">
			<tr>
				<td class="label">Mailing Zip/Postal Code  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:generalInfo/m1:contactInfo/m1:mailingAddress/ns3:zipCode)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:phone) &gt; 0">
			<tr>
				<td class="label">Main Phone Number  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:generalInfo/m1:contactInfo/m1:phone)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:faxNumber) &gt; 0">
			<tr>
				<td class="label">Fax (if applicable)  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:generalInfo/m1:contactInfo/m1:faxNumber)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:webAddress) &gt; 0">
			<tr>
				<td class="label">Website URL  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:generalInfo/m1:contactInfo/m1:webAddress)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(m1:generalInfo/m1:contactInfo/m1:emailAddress) &gt; 0">
			<tr>
				<td class="label">E-mail Address  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:generalInfo/m1:contactInfo/m1:emailAddress)" />
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
	
	<xsl:if test="count(m1:generalInfo/m1:officeInfo) &gt; 0">
		<table role="presentation" style="border:groove" >
		    <tr >
				<h4>
					<em>4. List of principal office(s) and address(es) where security-based
					 swap execution facility activities are/will be conducted:
					</em>
				</h4>
			</tr>
		<xsl:if test="count(m1:generalInfo/m1:officeInfo/m1:officeConfFlag) &gt; 0">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:officeInfo/m1:officeConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />

						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
	
		<!-- repeatable -->
		<xsl:for-each select="m1:generalInfo/m1:officeInfo/m1:office">
	
			<!--     <tr>Record:<xsl:value-of select="position()"></xsl:value-of></tr> --> 
			    <tr>
					<td class="label" style="color:black; border:none; background-color:white">Office Record: <xsl:value-of select="position()" />
					</td>
					<td>

					</td>
				</tr>
				
				<xsl:if test="count(m1:officeName) &gt; 0">
				<tr>
					<td class="label">Office
					</td>
					<td>
						<p>
							<div class="fakeBox3">
								<xsl:value-of select="m1:officeName" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				<xsl:if test="count(m1:street1) &gt; 0">
				<tr>
					<td class="label">Address 1 </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of select="m1:street1" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
					<xsl:if test="count(m1:street2) &gt; 0">
				<tr>
					<td class="label">Address 2 </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of select="m1:street2" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
					<xsl:if test="count(m1:city) &gt; 0">
				<tr>
					<td class="label">City </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of select="m1:city" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
				<xsl:if test="count(./m1:stateOrCountry) &gt; 0">
				<tr>
					<td class="label">State/Province/Country   </td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode" select="./m1:stateOrCountry" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				</xsl:if>
					<xsl:if test="count(m1:zipCode) &gt; 0">
				<tr>
					<td class="label">Mailing Zip/Postal Code  </td>
					<td>
						<p>
							<div align="left">
								<div class="fakeBox2">
									<xsl:value-of select="m1:zipCode" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</div>
						</p>
					</td>
				</tr>
			</xsl:if>
		</xsl:for-each>

	
		</table>
		
<br/>
</xsl:if>
 <xsl:if test="count(m1:generalInfo/m1:successor) &gt; 0">
		<table role="presentation" style="border:groove">
			<tr>
				<h4>
					<em>5. If the applicant is a successor to a previously registered security-based swap
					 execution facility, please complete the following:</em>
				</h4>
			</tr>
			 <xsl:if test="count(m1:generalInfo/m1:successor/m1:generalInfoSuccessorConfidentialFlag) &gt; 0">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:successor/m1:generalInfoSuccessorConfidentialFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />

						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(m1:generalInfo/m1:successor/m1:generalInfoSuccessorNotApplicableFlag) &gt; 0">
			<tr>
				<td class="label">
					Not Applicable
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="string(m1:generalInfo/m1:successor/m1:generalInfoSuccessorNotApplicableFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if
				test="string(m1:generalInfo/m1:successor/m1:generalInfoSuccessorNotApplicableFlag) = 'false'">
		    <xsl:if test="count(m1:generalInfo/m1:successor/m1:successionDate) &gt; 0">
					<tr>
						<td class="label">a. Date of Succession:
						</td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of
										select="string(m1:generalInfo/m1:successor/m1:successionDate)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="count(m1:generalInfo/m1:successor/m1:predecessorName) &gt; 0">
					<tr>
						<td class="label">b. Full name and address of predecessor security-based swap
						 execution facility: 
						</td>
						</tr>
						<tr>
						<td class="label">Name</td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of
										select="string(m1:generalInfo/m1:successor/m1:predecessorName)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
							<xsl:if test="count(m1:generalInfo/m1:successor/m1:street1) &gt; 0">
					<tr>
						<td class="label">Address 1 </td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(m1:generalInfo/m1:successor/m1:street1)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
					<xsl:if test="count(m1:generalInfo/m1:successor/m1:street2) &gt; 0">
					<tr>
						<td class="label">Address 2 </td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(m1:generalInfo/m1:successor/m1:street2)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
					<xsl:if test="count(m1:generalInfo/m1:successor/m1:city) &gt; 0">
					<tr>
						<td class="label">City </td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(m1:generalInfo/m1:successor/m1:city)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
					<xsl:if test="count(./m1:generalInfo/m1:successor/m1:stateOrCountry) &gt; 0">
					<tr>
						<td class="label">State/Province/Country   </td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:call-template name="stateDescription">
										<xsl:with-param name="stateCode"
											select="string(./m1:generalInfo/m1:successor/m1:stateOrCountry)" />
									</xsl:call-template>
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
						<xsl:if test="count(m1:generalInfo/m1:successor/m1:zipCode) &gt; 0">
					<tr>
						<td class="label">Mailing Zip/Postal Code  </td>
						<td>
							<p>
								<div align="left">
									<div class="fakeBox2">
										<xsl:value-of select="string(m1:generalInfo/m1:successor/m1:zipCode)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
					<xsl:if test="count(m1:generalInfo/m1:successor/m1:businessPhone) &gt; 0">
					<tr>
						<td class="label">Main Phone Number  </td>
						<td>
							<p>
								<div align="left">
									<div class="fakeBox2">
										<xsl:value-of select="string(m1:generalInfo/m1:successor/m1:businessPhone)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
						<xsl:if test="count(m1:generalInfo/m1:successor/m1:webAddress) &gt; 0">
					<tr>
						<td class="label">Website URL  </td>
						<td>
							<p>
								<div align="left">
									<div class="fakeBox2">
										<xsl:value-of select="string(m1:generalInfo/m1:successor/m1:webAddress)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>
							</p>
						</td>
					</tr>
					</xsl:if>
				
				
			</xsl:if>
		
		</table>
</xsl:if>
	</xsl:template>
</xsl:stylesheet>