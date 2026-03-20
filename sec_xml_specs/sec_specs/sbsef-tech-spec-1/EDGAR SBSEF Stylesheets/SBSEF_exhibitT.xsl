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


	<!-- ExhibitN templates -->
	<xsl:template name="ExhibitT">
	
		 <xsl:if test="count(m1:exhibitT) &gt; 0">	
	<h1><xsl:value-of select="$subType"/>: Exhibit T
			</h1>
		<h3>
			<em>Exhibit T
			</em>
		</h3>
		<table role="presentation" >
			<tr>
				<h4>
					<em>
						For Exhibit T, provide a list with the name(s) of the clearing agency(ies) that will clear the Applicant's trades, and a representation that clearing members of that organization will be guaranteeing such trades.

					</em>
				</h4>
			</tr>
			
	</table>
		<xsl:call-template name="exhibitTcontent" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="exhibitTcontent">
	
	
		<xsl:for-each select="m1:exhibitT/ext:exhibitTInfo">
		
		  <xsl:if test="count(ext:clearingAgencyName) &gt; 0
		  or count(ext:nameConfFlag) &gt; 0
		   or count(ext:isGuaranteeingTrades) &gt; 0  ">
		 <br />	
		<table role="presentation"><tr>Exhibit T Record: <xsl:value-of select="position()"></xsl:value-of></tr></table>
		<br/>
		<table role="presentation" style="border:groove">
		 <xsl:if test="count(ext:nameConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(ext:nameConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(ext:clearingAgencyName) &gt; 0 ">
			<tr>
				<td class="label">Name of the clearing agency that will clear the Applicant's trades.  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of
									select="string(ext:clearingAgencyName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			</xsl:if>
			 <xsl:if test="count(ext:isGuaranteeingTrades) &gt; 0 ">
			<tr>
				<td class="label">
					The Applicant hereby represents that clearing members of this organization will be guaranteeing the Applicant's trades 
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(ext:isGuaranteeingTrades) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
		</table>				
	</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>