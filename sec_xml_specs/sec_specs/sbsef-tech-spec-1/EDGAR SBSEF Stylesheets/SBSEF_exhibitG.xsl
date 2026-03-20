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

	<!-- ExhibitG templates -->
	<xsl:template name="ExhibitG">
		 <xsl:if test="count(m1:exhibitG) &gt; 0">	
	<h1><xsl:value-of select="$subType"/>: Exhibit G
			</h1>
		<h3>
			<em>Exhibit G
			</em>
		</h3>
		<table role="presentation" >
			<tr>
				<h4>
					<em>
						Attach as Exhibit G, a copy of the constitution; articles of incorporation,
						 formation, or association, with all amendments thereto; partnership or limited liability
						  agreements; and existing by-laws, operating agreement, rules, or instruments corresponding thereto,
						   of the Applicant. Attach a certificate of good standing dated within one week of the date of this Form SBSEF.
						    These documents can be attached on the "Other Exhibits” tab.

					</em>
				</h4>
			</tr>
			
	</table>
		<xsl:call-template name="exhibitGcontent" />
		</xsl:if>
	</xsl:template>

	<xsl:template name="exhibitGcontent">
	
	
		<xsl:for-each select="m1:exhibitG/exgmn:exhibitGInfo">
		
			  <xsl:if test="count(exgmn:additionalInformationConfFlag) &gt; 0
		  or count(exgmn:additionalInformation) &gt; 0  ">
		 <br />	
		<table role="presentation"><tr>Exhibit G Record: <xsl:value-of select="position()"></xsl:value-of></tr></table> 
		<br/>
		<table role="presentation" style="border:groove">
		<xsl:if test="count(exgmn:additionalInformationConfFlag) &gt; 0 ">
			<tr>
				<td class="label">
					Confidentiality Requested:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(exgmn:additionalInformationConfFlag) = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
					<xsl:if test="count(exgmn:additionalInformation) &gt; 0 ">
			<tr>
				<td class="label">In the box below, include any additional governance fitness information not included in Exhibit C.  </td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of
									select="string(exgmn:additionalInformation)" />
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
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>