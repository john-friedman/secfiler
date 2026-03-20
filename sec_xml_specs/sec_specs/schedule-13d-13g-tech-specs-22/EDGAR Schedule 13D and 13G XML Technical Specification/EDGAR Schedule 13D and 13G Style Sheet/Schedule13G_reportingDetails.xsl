<!DOCTYPE xsl:stylesheet  [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:p="http://www.sec.gov/edgar/schedule13g"
				xmlns:p1="http://www.sec.gov/edgar/common">
	<xsl:template name="reportingPersonDetails">
		<xsl:param name="citizenship" />
		<table>
			<tr>
				<td class="center">
					<br />
					<br />
					<p>
						<div align="center" style="font-size:1.2em;">
							<xsl:choose>
								<xsl:when test="$submissionType = 'SCHEDULE 13G'">
									SCHEDULE 13G
								</xsl:when>
								<xsl:otherwise>
									SCHEDULE 13G
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</p>
				</td>
			</tr>
		</table>
		<table role="presentation" class="tableClass"  id="cusipNumber">
			<tr class="tableClass">
				<td width="25%" style="font-weight:bold;">CUSIP No.</td>
				<td width="75%">
					<div style="font-size:.9em; color:#000000">
						<xsl:value-of select="$cusipNo"/>
					</div>
				</td>
			</tr>
		</table>
		<br/><br/>
		<table role="presentation" class="tableClass" id="reportingPersonDetails">
			<tr class="tableClass">
				<td width="8%" class="tableClassValign">1</td>
				<td width="92%" class="tableClass">Names of Reporting Persons
					<br/>
					<br/>
					<div class="text">
						<xsl:value-of select="string(p:reportingPersonName)" />
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">2</td>
				<td width="92%" class="tableClass">Check the appropriate box if a member of a Group (see instructions)
					<br/>
					<br/>
					<div class="text">
						<xsl:choose>
							<xsl:when test="p:memberGroup = 'a'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160; (a)
						<br/>
						<xsl:choose>
							<xsl:when test="p:memberGroup = 'b'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160; (b)
					</div>
				</td>
			</tr>
			<tr class="tableClassWithBgBlack">
				<td width="8%" class="tableClassValign">3</td>
				<td width="92%" class="tableClass">Sec Use Only</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">4</td>
				<td width="92%" class="tableClass">Citizenship or Place of Organization
					<br/>
					<br/>
					<div class="text">
						<xsl:value-of select="$citizenship"/>
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">Number of Shares Beneficially Owned by Each Reporting Person With:</td>
				<td width="92%" class="tableClass">
					<table class="innerTableClass">
						<tr>
							<td width="8%" class="innerTableClassRightValign">5</td>
							<td width="92%" class="tableClassInnerLeft">Sole Voting Power
								<br/>
								<br/>
								<div class="text">
									<xsl:if test="p:reportingPersonBeneficiallyOwnedNumberOfShares/p:soleVotingPower!=''">
										<xsl:value-of select="format-number(p:reportingPersonBeneficiallyOwnedNumberOfShares/p:soleVotingPower, '#,##0.00')" />
									</xsl:if>
								</div>
							</td>
						</tr>
						<tr>
							<td width="8%" class="innerTableClassRightValign">6</td>
							<td width="92%" class="tableClassInnerLeft">Shared Voting Power
								<br/>
								<br/>
								<div class="text">
									<xsl:if test="p:reportingPersonBeneficiallyOwnedNumberOfShares/p:sharedVotingPower!=''">
										<xsl:value-of select="format-number(p:reportingPersonBeneficiallyOwnedNumberOfShares/p:sharedVotingPower, '#,##0.00')" />
									</xsl:if>
								</div>
							</td>
						</tr>
						<tr>
							<td width="8%" class="innerTableClassRightValign">7</td>
							<td width="92%" class="tableClassInnerLeft">Sole Dispositive Power
								<br/>
								<br/>
								<div class="text">
									<xsl:if test="p:reportingPersonBeneficiallyOwnedNumberOfShares/p:soleDispositivePower!=''">
										<xsl:value-of select="format-number(p:reportingPersonBeneficiallyOwnedNumberOfShares/p:soleDispositivePower, '#,##0.00')" />
									</xsl:if>
								</div>
							</td>
						</tr>
						<tr>
							<td width="8%" class="innerTableClassRightValignBottomLess">8</td>
							<td width="92%" class="tableClassInnerLeftBottomLess">Shared Dispositive Power
								<br/>
								<br/>
								<div class="text">
									<xsl:if test="p:reportingPersonBeneficiallyOwnedNumberOfShares/p:sharedDispositivePower!=''">
										<xsl:value-of select="format-number(p:reportingPersonBeneficiallyOwnedNumberOfShares/p:sharedDispositivePower, '#,##0.00')" />
									</xsl:if>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">9</td>
				<td width="92%" class="tableClass">Aggregate Amount Beneficially Owned by Each Reporting Person
					<br/>
					<br/>
					<div class="text">
						<xsl:if test="p:reportingPersonBeneficiallyOwnedAggregateNumberOfShares!=''">
							<xsl:value-of select="format-number(p:reportingPersonBeneficiallyOwnedAggregateNumberOfShares, '#,##0.00')" />
						</xsl:if>
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">10</td>
				<td width="92%" class="tableClass">Check box if the aggregate amount in row (9) excludes certain shares (See Instructions)
					<br/>
					<br/>
					<xsl:choose>
						<xsl:when test="p:aggregateAmountExcludesCertainSharesFlag = 'Y'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">11</td>
				<td width="92%" class="tableClass">Percent of class represented by amount in row (9)
					<br/>
					<br/>
					<xsl:if test="p:classPercent">
						<div class="text">
							<xsl:value-of select="string(p:classPercent)" />
							<xsl:text> % </xsl:text>
						</div>
					</xsl:if>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">12</td>
				<td width="92%" class="tableClass">Type of Reporting Person (See Instructions)
					<br/>
					<br/>
					<div class="text">
						<xsl:for-each select="p:typeOfReportingPerson">
							<xsl:value-of select="text()" />
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:for-each>
					</div>
				</td>
			</tr>
		</table>
		<xsl:if test="p:comments">
			<br/>
			<div class="largetext">
				<span style="color:black;font-weight:bold;">Comment for Type of Reporting Person:</span>&#160;&#160;<xsl:value-of select="string(p:comments)" />
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>