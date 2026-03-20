<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="http://www.sec.gov/edgar/schedule13D"
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

		<table role="presentation" class="tableClass"  id="cusipNumber">
			<tr class="tableClass">
				<td width="7%" style="font-weight:bold;">CUSIP Number(s):</td>
				<td width="75%">
					<div style="font-size:.9em; color:#000000">
						<xsl:for-each select="$cusipNos[string-length(normalize-space(.)) > 0]">
							<xsl:if test="position() != 1">, </xsl:if>
							<xsl:value-of select="normalize-space(.)"/>
						</xsl:for-each>
					</div>
				</td>
			</tr>
		</table>
		<br/><br/>
		<table role="presentation" class="tableClass" id="reportingPersonDetails">
			<tr class="tableClass">
				<td width="8%" class="tableClassValign">1</td>
				<td width="92%" class="tableClass">
					Name of reporting person
					<br/>
					<br/>
					<div class="text">
							<xsl:value-of select="string(p:reportingPersonName)" />
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">2</td>
				<td width="92%" class="tableClass">Check the appropriate box if a member of a Group (See Instructions)
				<br/>
				<br/>
				<div class="text">
					<xsl:choose>		
						<xsl:when test="p:memberOfGroup = 'a'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise> 
					</xsl:choose>&#160; (a)
					<br/>
					<xsl:choose>		
						<xsl:when test="p:memberOfGroup = 'b'">
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
				<td width="92%" class="tableClass">SEC use only</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">4</td>
				<td width="92%" class="tableClass">
					Source of funds (See Instructions)
					<br/>
					<br/>
					<div class="text">
						<xsl:for-each select="p:fundType">
							<xsl:value-of select="text()" />
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:for-each>
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">5</td>
				<td width="92%" class="tableClass">
					Check if disclosure of legal proceedings is required pursuant to Items 2(d) or 2(e)
					<br/>
					<br/>
					<xsl:choose>
						<xsl:when test="p:legalProceedings = 'Y'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">6</td>
				<td width="92%" class="tableClass">Citizenship or place of organization
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
							<td width="8%" class="innerTableClassRightValign">7</td>
							<td width="92%" class="tableClassInnerLeft">Sole Voting Power
							<br/>
							<br/>
							<div class="text">
							    <xsl:if test="p:soleVotingPower!=''">
								<xsl:value-of select="format-number(number(p:soleVotingPower), '#,##0.00')" />
								</xsl:if>
							</div>				
							</td>
						</tr>
						<tr>
							<td width="8%" class="innerTableClassRightValign">8</td>
							<td width="92%" class="tableClassInnerLeft">Shared Voting Power
							<br/>
							<br/>
							<div class="text">
								<xsl:if test="p:sharedVotingPower!=''">
								<xsl:value-of select="format-number(number(p:sharedVotingPower), '#,##0.00')" />
								</xsl:if>
							</div>				
							</td>
						</tr>
						<tr>
							<td width="8%" class="innerTableClassRightValign">9</td>
							<td width="92%" class="tableClassInnerLeft">Sole Dispositive Power
							<br/>
							<br/>
							<div class="text">
								<xsl:if test="p:soleDispositivePower!=''">
								<xsl:value-of select="format-number(number(p:soleDispositivePower), '#,##0.00')" />
								</xsl:if>
							</div>				
							</td>
						</tr>
						<tr>
							<td width="8%" class="innerTableClassRightValignBottomLess">10</td>
							<td width="92%" class="tableClassInnerLeftBottomLess">Shared Dispositive Power
							<br/>
							<br/>
							<div class="text">
								<xsl:if test="p:sharedDispositivePower!=''">
								<xsl:value-of select="format-number(number(p:sharedDispositivePower), '#,##0.00')" />
								</xsl:if>
							</div>				
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">11</td>
				<td width="92%" class="tableClass">Aggregate amount beneficially owned by each reporting person
				<br/>
				<br/>
					<div class="text">
						<xsl:if test="p:aggregateAmountOwned!=''">
						<xsl:value-of select="format-number(number(p:aggregateAmountOwned), '#,##0.00')" />
						</xsl:if>
					</div>				
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">12</td>
				<td width="92%" class="tableClass">Check if the aggregate amount in Row (11) excludes certain shares (See Instructions)
				<br/>
				<br/>
					<xsl:choose>		
						<xsl:when test="p:isAggregateExcludeShares = 'Y'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>				
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">13</td>
				<td width="92%" class="tableClass">Percent of class represented by amount in Row (11)
				<br/>
				<br/>
					<xsl:if test="p:percentOfClass">
					<div class="text">
						<xsl:value-of select="string(p:percentOfClass)" />
						<xsl:text> % </xsl:text> 
					</div>
					</xsl:if> 				
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValign">14</td>
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
		<br/>
		<xsl:if test="p:commentContent">
			<div style="display: flex;">
				<div style="font-size: 0.9em; font-weight: bold; margin-right: 5px;">
					Comment for Type of Reporting Person:
				</div>
				<div class="largetext" style="text-align:justify">
					<xsl:value-of select="string(p:commentContent)" />
				</div>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
