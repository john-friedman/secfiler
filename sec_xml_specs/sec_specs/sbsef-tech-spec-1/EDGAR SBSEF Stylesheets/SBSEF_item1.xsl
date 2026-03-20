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

	<!-- Item 1 templates -->
	
	<xsl:template name="Item1">
	
		<h3>
			<em>Application Information </em>
		</h3>
		<xsl:call-template name="applicationInfo" />
	</xsl:template>

	<xsl:template name="applicationInfo">
	
	
	 <xsl:if test="count(m1:principalInfo/m1:principalConfFlag) &gt; 0
		  or count(m1:principalInfo/m1:applicantName) &gt; 0 or 
		  count(m1:principalInfo/m1:street1) &gt; 0
		   or count(m1:principalInfo/m1:street2) &gt; 0
		   or count(m1:principalInfo/m1:city) &gt; 0
		    or count(./m1:principalInfo/m1:stateOrCountry) &gt; 0
		     or count(m1:principalInfo/m1:zipCode) &gt; 0
		      or count(m1:principalInfo/m1:amendedItemsList) &gt; 0 ">
		   
		<table role="presentation" style="border:groove">
		<xsl:if test="count(m1:principalInfo/m1:principalConfFlag) &gt; 0">
		   <tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:principalInfo/m1:principalConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />

						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:principalInfo/m1:applicantName) &gt; 0">
			<tr>
				<td class="label">Exact Name of Applicant as Specified in Charter:
				</td>
				<td>
					<p>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:principalInfo/m1:applicantName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			
			 <xsl:if test="count(m1:principalInfo/m1:street1) &gt; 0
		   or count(m1:principalInfo/m1:street2) &gt; 0
		   or count(m1:principalInfo/m1:city) &gt; 0
		    or count(./m1:principalInfo/m1:stateOrCountry) &gt; 0
		     or count(m1:principalInfo/m1:zipCode) &gt; 0
		      or count(m1:principalInfo/m1:amendedItemsList) &gt; 0 ">
			<tr>
				<td class="label">Address of Principal Executive Offices:</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(m1:principalInfo/m1:street1) &gt; 0">
			<tr>
				<td class="label">Address 1 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of select="string(m1:principalInfo/m1:street1)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
				<xsl:if test="count(m1:principalInfo/m1:street2) &gt; 0">
			<tr>
				<td class="label">Address 2 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of select="string(m1:principalInfo/m1:street2)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:principalInfo/m1:city) &gt; 0">
			<tr>
				<td class="label">City </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of select="string(m1:principalInfo/m1:city)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(./m1:principalInfo/m1:stateOrCountry) &gt; 0">
			<tr>
				<td class="label">State/Province/Country   </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(./m1:principalInfo/m1:stateOrCountry)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:principalInfo/m1:zipCode) &gt; 0">
			<tr>
				<td class="label">Mailing Zip/ Postal Code  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:principalInfo/m1:zipCode)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			<!--  <xsl:if test="count(m1:principalInfo/m1:amendedItemsList) &gt; 0">-->
			<xsl:if test="$subType='SBSEF/A' and count(m1:principalInfo/m1:amendedItemsList) &gt; 0">
			
				<tr>
					<td class="label">List all items that are amended:
					</td>
					<td>
						<p>
							<div align="left">
								<div class="fakeBox3">
									<xsl:value-of select="string(m1:principalInfo/m1:amendedItemsList)" />
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