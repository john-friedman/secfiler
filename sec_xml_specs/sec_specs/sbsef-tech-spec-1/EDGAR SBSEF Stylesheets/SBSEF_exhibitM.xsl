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


	<!-- ExhibitM templates -->
	<xsl:template name="ExhibitM">
	<xsl:if test="count(m1:exhibitM) &gt; 0">	
	<h1><xsl:value-of select="$subType"/>: Exhibit M
			</h1>
		<h3>
			<em>Exhibit M
			</em>
		</h3>
		<table role="presentation" >
			<tr>
				<h4>
					<em>
						Attach as Exhibit M, a copy of the Applicant's rules and any technical manuals,
						 other guides, or instructions for members, including minimum financial standards
						  for members. Include rules on publication of daily trading information with regards
						   to the requirements of Regulation SBSR (§§ 242.900 through 242.909). These documents
						    can be attached on the "Other Exhibits" tab.

					</em>
				</h4>
			</tr>
			
	</table>
		<xsl:call-template name="exhibitMcontent" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="exhibitMcontent">
	
		<xsl:if test="count(m1:exhibitM/exgmn:additionalInformationConfFlag) &gt; 0
		  or count(m1:exhibitM/exgmn:additionalInformation ) &gt; 0  ">
		<table role="presentation" style="border:groove">
		<xsl:if test="count(m1:exhibitM/exgmn:additionalInformationConfFlag ) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:exhibitM/exgmn:additionalInformationConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="count(m1:exhibitM/exgmn:additionalInformation) &gt; 0 ">
			<tr>
				<td class="label">The Applicant should include an explanation and any other form of documentation that the Applicant thinks will be helpful to its explanation, demonstrating how its rules, technical manuals, other guides, or instructions for members or minimum financial standards for members, as provided in this Exhibit M, help support the security-based swap execution facility's compliance with the Core Principles.  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of
									select="string(m1:exhibitM/exgmn:additionalInformation)" />
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