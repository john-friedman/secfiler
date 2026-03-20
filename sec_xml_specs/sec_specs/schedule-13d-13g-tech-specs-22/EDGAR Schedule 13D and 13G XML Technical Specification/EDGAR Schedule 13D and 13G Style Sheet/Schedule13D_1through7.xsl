<!DOCTYPE xsl:stylesheet  [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:p="http://www.sec.gov/edgar/schedule13D"
				xmlns:p1="http://www.sec.gov/edgar/common">
	<xsl:template name="item1through7">
		<xsl:param name="stateCountryName" />
		<table>
			<tr>
				<td class="center">
					<br />
					<br />
					<p>
						<div align="center" style="font-size:1.2em;">
							<xsl:choose>
								<xsl:when test="$submissionType = 'SCHEDULE 13D'">
									SCHEDULE 13D
								</xsl:when>
								<xsl:otherwise>
									SCHEDULE 13D
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</p>
				</td>
			</tr>
		</table>
		<table role="presentation" id="item1to7">
			<xsl:if test="p:items1To7/p:item1">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 1.</td>
					<td width="92%" class="tableClassNoBorder">Security and Issuer</td>
				</tr>
				<xsl:if test="p:coverPageHeader/p:securitiesClassTitle">
					<tr class="tableClass">

						<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
						<td width="92%" class="tableClassNoBorder">Title of Class of Securities:
							<br/>
							<br/>
							<div class="text">
								<xsl:value-of select="string(p:coverPageHeader/p:securitiesClassTitle)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:coverPageHeader/p:issuerInfo/p:issuerName">
					<tr class="tableClass">
						<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
						<td width="92%" class="tableClassNoBorder">Name of Issuer:
							<br/>
							<br/>
							<div class="text">
								<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:issuerName)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:coverPageHeader/p:issuerInfo/p:address">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
						<td width="92%" class="tableClassNoBorder">Address of Issuer's Principal Executive Offices:
							<br/>
							<br/>
							<div class="text">
								<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:address/p1:street1)" />
								<xsl:text>, </xsl:text>
								<xsl:if test="string(p:coverPageHeader/p:issuerInfo/p:address/p1:street2)!=''">
									<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:address/p1:street2)" />
									<xsl:text>, </xsl:text>
								</xsl:if>
								<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:address/p1:city)" />
								<xsl:text>, </xsl:text>
								<xsl:value-of select="$stateCountryName"/>
								<xsl:text>, </xsl:text>
								<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:address/p1:zipCode)" />
								<xsl:text>.</xsl:text>
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item1/p:commentText">
					<tr>
						<td  colspan="3">
							<div style="display: flex;">
								<div style="font-size: 0.9em; font-weight: bold; margin-right: 5px;">
									Item 1 Comment:
								</div>
								<div class="largetext" style="text-align:justify">
									<xsl:value-of select="string(p:items1To7/p:item1/p:commentText)" />
								</div>
							</div>
						</td>
					</tr>
				</xsl:if>
			</xsl:if>

			<xsl:if test="p:items1To7/p:item2">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 2.</td>
					<td width="92%" class="tableClassNoBorder">Identity and Background</td>
				</tr>
				<tr>

				</tr>
				<xsl:if test="p:items1To7/p:item2/p:filingPersonName">
					<tr class="tableClass">
						<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item2/p:filingPersonName)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item2/p:principalBusinessAddress">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item2/p:principalBusinessAddress)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item2/p:principalJob">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item2/p:principalJob)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item2/p:hasBeenConvicted">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(d)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item2/p:hasBeenConvicted)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item2/p:convictionDescription">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(e)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item2/p:convictionDescription)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item2/p:citizenship">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(f)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item2/p:citizenship)" />
							</div>
						</td>
					</tr>
				</xsl:if>
			</xsl:if>
			<xsl:if test="p:items1To7/p:item3">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 3.</td>
					<td width="92%" class="tableClassNoBorder">Source and Amount of Funds or Other Consideration</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">
						<div class="largetext">
							<xsl:value-of select="string(p:items1To7/p:item3/p:fundsSource)" />
						</div>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="p:items1To7/p:item4">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 4.</td>
					<td width="92%" class="tableClassNoBorder">Purpose of Transaction</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">
						<div class="largetext">
							<xsl:value-of select="string(p:items1To7/p:item4/p:transactionPurpose)" />
						</div>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="p:items1To7/p:item5">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 5.</td>
					<td width="92%" class="tableClassNoBorder">Interest in Securities of the Issuer</td>
				</tr>
				<xsl:if test="p:items1To7/p:item5/p:percentageOfClassSecurities">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item5/p:percentageOfClassSecurities)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item5/p:numberOfShares">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item5/p:numberOfShares)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item5/p:transactionDesc">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item5/p:transactionDesc)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item5/p:listOfShareholders">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(d)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item5/p:listOfShareholders)" />
							</div>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="p:items1To7/p:item5/p:date5PercentOwnership">
					<tr>
						<td width="8%" class="tableClassNoBorderAlignCenter">(e)</td>
						<td width="92%" class="tableClassNoBorder">
							<div class="largetext">
								<xsl:value-of select="string(p:items1To7/p:item5/p:date5PercentOwnership)" />
							</div>
						</td>
					</tr>
				</xsl:if>
			</xsl:if>
			<xsl:if test="p:items1To7/p:item6">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 6.</td>
					<td width="92%" class="tableClassNoBorder">Contracts, Arrangements, Understandings or Relationships With Respect to Securities of the Issuer</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">
						<div class="largetext">
							<xsl:value-of select="string(p:items1To7/p:item6/p:contractDescription)" />
						</div>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="p:items1To7/p:item7">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 7.</td>
					<td width="92%" class="tableClassNoBorder">Material to be Filed as Exhibits.</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">
						<div class="largetext">
							<xsl:value-of select="string(p:items1To7/p:item7/p:filedExhibits)" />
						</div>
					</td>
				</tr>
			</xsl:if>
		</table>
		<br/>
	</xsl:template>
</xsl:stylesheet>
