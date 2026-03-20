<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="http://www.sec.gov/edgar/schedule13g" 
	xmlns:p1="http://www.sec.gov/edgar/common">
	
	<xsl:template name="signatureInfo">
		<table role="presentation" id="signatureInfo">
		    <tr>
				<td width="8%" class="tableClassValignNoBorder">&#160;&#160;&#160;&#160;SIGNATURE</td>
				<td width="92%" class="tableClassNoBorder">&#160;</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<div class="information" style="text-align:justify">
						After reasonable inquiry and to the best of my knowledge and belief, I certify that the information set forth in this statement is true, complete and correct.
						<br/>
						<br/>
					</div>
				</td>
			</tr>
			</table>
			<xsl:for-each select="p:signatureInformation">
				<table>
				  <tr class="tableClass">
					<td width="50%" class="tableClassNoBorder">&#160;</td>
					<td width="50%" class="tableClassNoBorder"> 
						<table>
							<tr class="tableClass">
								<td width="100%" class="tableClassInnerNoBorderBlue">
									<div class="text">
										<xsl:value-of select="p:reportingPersonName" />
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				</table>
			<xsl:for-each select="p:signatureDetails">
				<table>
				  <tr class="tableClass">
					<td width="50%" class="tableClassNoBorder">&#160;</td>
					<td width="50%" class="tableClassNoBorder"> 
						<table>
							<tr class="tableClass">
								<td width="8%" class="tableClassNoBorderAlignLeft signature">Signature:</td>
								<td width="92%" class="tableClassNoBorderBlue signature">
											<xsl:value-of select="p:signature" />
								</td>
							</tr>
							<tr class="tableClass">
								<td width="8%" class="tableClassNoBorderAlignLeft signature">Name/Title:</td>
								<td width="92%" class="tableClassNoBorderBlue signature">
											<xsl:value-of select="p:title" />
								</td>
							</tr>
							<tr class="tableClass">
								<td width="8%" class="tableClassNoBorderAlignLeft signature">Date:</td>
								<td width="92%" class="tableClassNoBorderBlue signature">
									<xsl:value-of select="p:date" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				</table>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:if test="p:signatureComments">
		<br/>
		<div class="largetext">
			<span style="color:black;font-weight:bold;">Comments accompanying signature:</span>&#160;&#160;<xsl:value-of select="string(p:signatureComments)" />
		</div>
		</xsl:if>
		<xsl:if test="p:exhibitInfo">
			<table>
			<tr class="tableClass" colspan="2">
			<td width="100%" class="tableClassNoBorder">
				<div class="information" style="text-align:center;font-weight:bold;">
					 Exhibit Information
					<br/>
					<br/>
				</div>
				</td>
			</tr>
			<tr class="tableClass" colspan="2">
			<td width="100%" class="tableClassNoBorder">
				<div class="largetext">
						<xsl:value-of select="p:exhibitInfo" />
					<br/>
					<br/>
				</div>
				</td>
			</tr>
			</table>
		</xsl:if>
	</xsl:template>	
</xsl:stylesheet>