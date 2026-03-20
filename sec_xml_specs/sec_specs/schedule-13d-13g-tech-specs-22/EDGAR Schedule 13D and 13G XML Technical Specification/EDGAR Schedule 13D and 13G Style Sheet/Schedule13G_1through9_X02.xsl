<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="http://www.sec.gov/edgar/schedule13g" 
	xmlns:p1="http://www.sec.gov/edgar/common">
	<xsl:template name="item1through9">
	<xsl:param name="stateCountryName" />
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
		<xsl:if test="$submissionType = 'SCHEDULE 13G'">
		<table role="presentation" id="item1to9">
		    <tr>
				<td width="8%" class="tableClassValignNoBorder">Item 1.</td>
				<td width="92%" class="tableClassNoBorder">&#160;</td>
			</tr>
			<tr class="tableClass">
				<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
				<td width="92%" class="tableClassNoBorder">Name of issuer:
				<br/>
				<br/>
				<xsl:if test="p:items/p:item1">
					<div class="text">
							<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:issuerName)" />
					</div>
				</xsl:if>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
				<td width="92%" class="tableClassNoBorder">Address of issuer's principal executive offices:
				<br/>
				<br/>
				<xsl:if test="p:items/p:item1">
				<div class="text">
						<xsl:value-of select="string(p:items/p:item1/p:issuerPrincipalExecutiveOfficeAddress)" />
				</div>
				</xsl:if>				
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 2.</td>
				<td width="92%" class="tableClassNoBorder">&#160;</td>
			</tr>
			<tr class="tableClass">
				<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
				<td width="92%" class="tableClassNoBorder">Name of person filing:
				<br/>
				<br/>
					<div class="largetext">
							<xsl:value-of select="string(p:items/p:item2/p:filingPersonName)" />
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
				<td width="92%" class="tableClassNoBorder">Address or principal business office or, if none, residence:
				<br/>
				<br/>
				<div class="largetext">
					<xsl:value-of select="string(p:items/p:item2/p:principalBusinessOfficeOrResidenceAddress)" />
				</div>				
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
				<td width="92%" class="tableClassNoBorder">Citizenship:
				<br/>
				<br/>
				<div class="largetext">
					<xsl:value-of select="string(p:items/p:item2/p:citizenship)" />	
				</div>				
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(d)</td>
				<td width="92%" class="tableClassNoBorder">Title of class of securities:
				<br/>
				<br/>
				<xsl:if test="p:items/p:item2">
				<div class="text">
					<xsl:value-of select="string(p:coverPageHeader/p:securitiesClassTitle)" />	
				</div>
				</xsl:if>				
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(e)</td>
				<td width="92%" class="tableClassNoBorder">CUSIP Number(s):
				<br/>
				<br/>
					<xsl:if test="p:items/p:item2">
						<div class="text">
							<xsl:for-each select="$cusipNos[string-length(normalize-space(.)) > 0]">
								<xsl:if test="position() != 1">, </xsl:if>
								<xsl:value-of select="normalize-space(.)"/>
							</xsl:for-each>
						</div>
					</xsl:if>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 3.</td>
				<td width="92%" class="tableClassNoBorder">If this statement is filed pursuant to §§ 240.13d-1(b) or 240.13d-2(b) or (c), check whether the person filing is a:</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'BD'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;Broker or dealer registered under section 15 of the Act (15 U.S.C. 78o);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'BK'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;Bank as defined in section 3(a)(6) of the Act (15 U.S.C. 78c);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'IC'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;Insurance company as defined in section 3(a)(19) of the Act (15 U.S.C. 78c);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(d)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'IV'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;Investment company registered under section 8 of the Investment Company Act of 1940 (15 U.S.C. 80a-8);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(e)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'IA'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;An investment adviser in accordance with § 240.13d-1(b)(1)(ii)(E);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(f)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'EP'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;An employee benefit plan or endowment fund in accordance with § 240.13d-1(b)(1)(ii)(F);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(g)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'HC'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;A parent holding company or control person in accordance with § 240.13d-1(b)(1)(ii)(G);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(h)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'SA'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;A savings associations as defined in Section 3(b) of the Federal Deposit Insurance Act (12 U.S.C. 1813);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(i)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'CP'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;A church plan that is excluded from the definition of an investment company under section 3(c)(14) of the Investment Company Act of 1940 (15 U.S.C. 80a-3);
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(j)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'FI'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;A non-U.S. institution in accordance with § 240.13d-1(b)(1)(ii)(J). If filing as a non-U.S. institution in accordance with § 240.13d-1(b)(1)(ii)(J), 
					<br/>&#160;&#160;&#160;&#160;&#160;&#160;&#160;please specify the type of institution:
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(k)</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'OO'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;&#160;&#160;Group, in accordance with Rule 240.13d-1(b)(1)(ii)(K).
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="100%" colspan="2" class="tableClassNoBorder">
					<div class="largetext">
							<xsl:value-of select="string(p:items/p:item3/p:otherTypeOfPersonFiling)" />
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 4.</td>
				<td width="92%" class="tableClassNoBorder">Ownership</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
				<td width="92%" class="tableClassNoBorder">Amount beneficially owned:
				<br/>
				<br/>
					<div class="largetext">
							<xsl:value-of select="string(p:items/p:item4/p:amountBeneficiallyOwned)" />
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
				<td width="92%" class="tableClassNoBorder">Percent of class:
				<br/>
				<br/>
					<xsl:choose>
						<xsl:when test="(p:items/p:item4/p:classPercent) and (number(p:items/p:item4/p:classPercent)=number(p:items/p:item4/p:classPercent)) ">
							<div class="largetext">
								<xsl:value-of select="string(p:items/p:item4/p:classPercent)" />&#160;&#160;%
							</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="largetext">
								<xsl:value-of select="string(p:items/p:item4/p:classPercent)" />
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
				<td width="92%" class="tableClassNoBorder">Number of shares as to which the person has:
				<br/>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">(i) Sole power to vote or to direct the vote:
				<br/>
				<br/>
					<div class="largetext">
							<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:solePowerOrDirectToVote)" />
					</div>
				<br/>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">(ii) Shared power to vote or to direct the vote:
				<br/>
				<br/>
					<div class="largetext">
							<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:sharedPowerOrDirectToVote)" />
					</div>
				<br/>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">(iii) Sole power to dispose or to direct the disposition of:
				<br/>
				<br/>
					<div class="largetext">
							<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:solePowerOrDirectToDispose)" />
					</div>
				<br/>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">(iv) Shared power to dispose or to direct the disposition of:
				<br/>
				<br/>
					<div class="largetext">
							<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:sharedPowerOrDirectToDispose)" />
					</div>
				<br/>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 5.</td>
				<td width="92%" class="tableClassNoBorder">Ownership of 5 Percent or Less of a Class.</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
						<xsl:if test="p:items/p:item5/p:notApplicableFlag = 'Y'">
							<div class="text">
								Not Applicable
							</div>
						</xsl:if>
						<xsl:if test="p:items/p:item5/p:classOwnership5PercentOrLess = 'Y'">
							<div class="text">
								Ownership of 5 percent or less of a class
							</div>
						</xsl:if>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 6.</td>
				<td width="92%" class="tableClassNoBorder">Ownership of more than 5 Percent on Behalf of Another Person.</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item6/p:notApplicableFlag = 'Y'">
						<div class="text">
							Not Applicable
						</div>
						</xsl:when>
						<xsl:otherwise>
						<div class="information" style="text-align:justify">
							If any other person is known to have the right to receive or the power to direct the receipt of dividends from, or the proceeds from the sale of, such securities, a statement to that effect should be included in response to this item and, if such interest relates to more than 5 percent of the class, such person should be identified. A listing of the shareholders of an investment company registered under the Investment Company Act of 1940 or the beneficiaries of employee benefit plan, pension fund or endowment fund is not required.
						</div>
						<br/>
						<br/>
						<div class="largetext">
							<xsl:value-of select="string(p:items/p:item6/p:ownershipMoreThan5PercentOnBehalfOfAnotherPerson)" />
						</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 7.</td>
				<td width="92%" class="tableClassNoBorder">Identification and Classification of the Subsidiary Which Acquired the Security Being Reported on by the Parent Holding Company or Control Person.</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item7/p:notApplicableFlag = 'Y'">
							<div class="text">
								Not Applicable
							</div>
						</xsl:when>
						<xsl:otherwise>
						<div class="information" style="text-align:justify">
							If a parent holding company has filed this schedule, pursuant to Rule 13d-1(b)(ii)(G), so indicate under Item 3(g) and attach an exhibit stating the identity and the Item 3 classification of the relevant subsidiary. If a parent holding company has filed this schedule pursuant to Rule 13d-1(c) or Rule 13d-1(d), attach an exhibit stating the identification of the relevant subsidiary.
						</div>
						<br/>
						<br/>
						<div class="largetext">
							<xsl:value-of select="string(p:items/p:item7/p:subsidiaryIdentificationAndClassification)" />
						</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 8.</td>
				<td width="92%" class="tableClassNoBorder">Identification and Classification of Members of the Group.</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item8/p:notApplicableFlag = 'Y'">
							<div class="text">
								Not Applicable
							</div> 
						</xsl:when>
						<xsl:otherwise>
						<div class="information" style="text-align:justify">
							If a group has filed this schedule pursuant to §240.13d-1(b)(1)(ii)(K), so indicate under Item 3(k) and attach an exhibit stating the identity and Item 3 classification of each member of the group. If a group has filed this schedule pursuant to §240.13d-1(c) or §240.13d-1(d), attach an exhibit stating the identity of each member of the group.
						</div>
						<br/>
						<br/>
						<div class="largetext">
							<xsl:value-of select="string(p:items/p:item8/p:identificationAndClassificationOfGroupMembers)" />
						</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 9.</td>
				<td width="92%" class="tableClassNoBorder">Notice of Dissolution of Group.</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item9/p:notApplicableFlag = 'Y'">
							<div class="text">
								Not Applicable
							</div>
						</xsl:when>
						<xsl:otherwise>
						<div class="information" style="text-align:justify">
							Notice of dissolution of a group may be furnished as an exhibit stating the date of the dissolution and that all further filings with respect to transactions in the security reported on will be filed, if required, by members of the group, in their individual capacity. See Item 5.
						</div>
						<br/>
						<br/>
						<div class="largetext">
							<xsl:value-of select="string(p:items/p:item9/p:groupDissolutionNotice)" />
						</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>
			</xsl:if>
			<xsl:if test="$submissionType = 'SCHEDULE 13G/A'">
			<table role="presentation" id="item1to9">
			<xsl:if test="(p:items/p:item1)">
			    <tr>
					<td width="8%" class="tableClassValignNoBorder">Item 1.</td>
					<td width="92%" class="tableClassNoBorder">&#160;</td>
				</tr>
				<tr class="tableClass">
					<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
					<td width="92%" class="tableClassNoBorder">Name of issuer:
					<br/>
					<br/>
					<xsl:if test="p:items/p:item1">
						<div class="text">
								<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:issuerName)" />
						</div>
					</xsl:if>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
					<td width="92%" class="tableClassNoBorder">Address of issuer's principal executive offices:
					<br/>
					<br/>
					<xsl:if test="p:items/p:item1">
					<div class="text">
							<xsl:value-of select="string(p:items/p:item1/p:issuerPrincipalExecutiveOfficeAddress)" />
					</div>
					</xsl:if>				
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item2)">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 2.</td>
					<td width="92%" class="tableClassNoBorder">&#160;</td>
				</tr>
				<tr class="tableClass">
					<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
					<td width="92%" class="tableClassNoBorder">Name of person filing:
					<br/>
					<br/>
						<div class="largetext">
								<xsl:value-of select="string(p:items/p:item2/p:filingPersonName)" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
					<td width="92%" class="tableClassNoBorder">Address or principal business office or, if none, residence:
					<br/>
					<br/>
					<div class="largetext">
						<xsl:value-of select="string(p:items/p:item2/p:principalBusinessOfficeOrResidenceAddress)" />
					</div>				
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
					<td width="92%" class="tableClassNoBorder">Citizenship:
					<br/>
					<br/>
					<div class="largetext">
						<xsl:value-of select="string(p:items/p:item2/p:citizenship)" />	
					</div>				
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(d)</td>
					<td width="92%" class="tableClassNoBorder">Title of class of securities:
					<br/>
					<br/>
					<xsl:if test="p:items/p:item2">
					<div class="text">
						<xsl:value-of select="string(p:coverPageHeader/p:securitiesClassTitle)" />	
					</div>
					</xsl:if>				
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(e)</td>
					<td width="92%" class="tableClassNoBorder">CUSIP No.:
					<br/>
					<br/>
					<xsl:if test="p:items/p:item2">
					<div class="text">
						<xsl:value-of select="string(p:coverPageHeader/p:issuerInfo/p:issuerCusip)" />	
					</div>				
					</xsl:if>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item3) and (p:items/p:item3/p:notApplicableFlag = 'Y') or (p:items/p:item3/p:typeOfPersonFiling)">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 3.</td>
					<td width="92%" class="tableClassNoBorder">If this statement is filed pursuant to §§ 240.13d-1(b) or 240.13d-2(b) or (c), check whether the person filing is a:</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'BD'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Broker or dealer registered under section 15 of the Act (15 U.S.C. 78o);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'BK'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Bank as defined in section 3(a)(6) of the Act (15 U.S.C. 78c);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'IC'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Insurance company as defined in section 3(a)(19) of the Act (15 U.S.C. 78c);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(d)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'IV'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Investment company registered under section 8 of the Investment Company Act of 1940 (15 U.S.C. 80a-8);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(e)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'IA'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;An investment adviser in accordance with § 240.13d-1(b)(1)(ii)(E);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(f)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'EP'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;An employee benefit plan or endowment fund in accordance with § 240.13d-1(b)(1)(ii)(F);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(g)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'HC'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;A parent holding company or control person in accordance with § 240.13d-1(b)(1)(ii)(G);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(h)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'SA'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;A savings associations as defined in Section 3(b) of the Federal Deposit Insurance Act (12 U.S.C. 1813);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(i)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'CP'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;A church plan that is excluded from the definition of an investment company under section 3(c)(14) of the Investment Company Act of 1940 (15 U.S.C. 80a-3);
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(j)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'FI'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;A non-U.S. institution in accordance with § 240.13d-1(b)(1)(ii)(J). If filing as a non-U.S. institution in accordance with § 240.13d-1(b)(1)(ii)(J), 
						<br/>&#160;&#160;&#160;&#160;&#160;&#160;&#160;please specify the type of institution:
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(k)</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item3/p:typeOfPersonFiling = 'OO'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;&#160;&#160;Group, in accordance with Rule 240.13d-1(b)(1)(ii)(K).
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="100%" colspan="2" class="tableClassNoBorder">
						<div class="largetext">
								<xsl:value-of select="string(p:items/p:item3/p:otherTypeOfPersonFiling)" />
						</div>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item4)">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 4.</td>
					<td width="92%" class="tableClassNoBorder">Ownership</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(a)</td>
					<td width="92%" class="tableClassNoBorder">Amount beneficially owned:
					<br/>
					<br/>
						<div class="largetext">
								<xsl:value-of select="string(p:items/p:item4/p:amountBeneficiallyOwned)" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(b)</td>
					<td width="92%" class="tableClassNoBorder">Percent of class:
					<br/>
					<br/>
						<xsl:choose>
							<xsl:when test="(p:items/p:item4/p:classPercent) and (number(p:items/p:item4/p:classPercent)=number(p:items/p:item4/p:classPercent)) ">
								<div class="largetext">
									<xsl:value-of select="string(p:items/p:item4/p:classPercent)" />&#160;&#160;%
								</div>
							</xsl:when>
							<xsl:otherwise>
								<div class="largetext">
									<xsl:value-of select="string(p:items/p:item4/p:classPercent)" />
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">(c)</td>
					<td width="92%" class="tableClassNoBorder">Number of shares as to which the person has:
					<br/>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">(i) Sole power to vote or to direct the vote:
					<br/>
					<br/>
						<div class="largetext">
								<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:solePowerOrDirectToVote)" />
						</div>
					<br/>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">(ii) Shared power to vote or to direct the vote:
					<br/>
					<br/>
						<div class="largetext">
								<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:sharedPowerOrDirectToVote)" />
						</div>
					<br/>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">(iii) Sole power to dispose or to direct the disposition of:
					<br/>
					<br/>
						<div class="largetext">
								<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:solePowerOrDirectToDispose)" />
						</div>
					<br/>
					</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">(iv) Shared power to dispose or to direct the disposition of:
					<br/>
					<br/>
						<div class="largetext">
								<xsl:value-of select="string(p:items/p:item4/p:numberOfSharesPersonHas/p:sharedPowerOrDirectToDispose)" />
						</div>
					<br/>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item5) and (p:items/p:item5/p:notApplicableFlag = 'Y') or (p:items/p:item5/p:classOwnership5PercentOrLess = 'Y')">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 5.</td>
					<td width="92%" class="tableClassNoBorder">Ownership of 5 Percent or Less of a Class.</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">
						<div class="text">
							<xsl:if test="p:items/p:item5/p:notApplicableFlag = 'Y'">
								Not Applicable
							</xsl:if>
							<xsl:if  test="p:items/p:item5/p:classOwnership5PercentOrLess = 'Y'">
									<img src="Images/box-checked.jpg" alt="Checkbox checked" />
									&#160;&#160;&#160;Ownership of 5 percent or less of a class
							</xsl:if>
						</div>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item6) and (p:items/p:item6/p:notApplicableFlag = 'Y') or (p:items/p:item6/p:ownershipMoreThan5PercentOnBehalfOfAnotherPerson)">
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 6.</td>
				<td width="92%" class="tableClassNoBorder">Ownership of more than 5 Percent on Behalf of Another Person.</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item6/p:notApplicableFlag = 'Y'">
						<div class="text">
							Not Applicable
						</div>
						</xsl:when>
						<xsl:otherwise>
						<div class="information" style="text-align:justify">
							If any other person is known to have the right to receive or the power to direct the receipt of dividends from, or the proceeds from the sale of, such securities, a statement to that effect should be included in response to this item and, if such interest relates to more than 5 percent of the class, such person should be identified. A listing of the shareholders of an investment company registered under the Investment Company Act of 1940 or the beneficiaries of employee benefit plan, pension fund or endowment fund is not required.
						</div>
						<br/>
						<br/>
						<div class="largetext">
							<xsl:value-of select="string(p:items/p:item6/p:ownershipMoreThan5PercentOnBehalfOfAnotherPerson)" />
						</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item7) and (p:items/p:item7/p:notApplicableFlag = 'Y') or (p:items/p:item7/p:subsidiaryIdentificationAndClassification)">
			<tr>
				<td width="8%" class="tableClassValignNoBorder">Item 7.</td>
				<td width="92%" class="tableClassNoBorder">Identification and Classification of the Subsidiary Which Acquired the Security Being Reported on by the Parent Holding Company or Control Person.</td>
			</tr>
			<tr>
				<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
				<td width="92%" class="tableClassNoBorder">
					<xsl:choose>
						<xsl:when test="p:items/p:item7/p:notApplicableFlag = 'Y'">
							<div class="text">
								Not Applicable
							</div>
						</xsl:when>
						<xsl:otherwise>
						<div class="information" style="text-align:justify">
							If a parent holding company has filed this schedule, pursuant to Rule 13d-1(b)(ii)(G), so indicate under Item 3(g) and attach an exhibit stating the identity and the Item 3 classification of the relevant subsidiary. If a parent holding company has filed this schedule pursuant to Rule 13d-1(c) or Rule 13d-1(d), attach an exhibit stating the identification of the relevant subsidiary.
						</div>
						<br/>
						<br/>
						<div class="largetext">
							<xsl:value-of select="string(p:items/p:item7/p:subsidiaryIdentificationAndClassification)" />
						</div>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item8) and (p:items/p:item8/p:notApplicableFlag = 'Y') or (p:items/p:item8/p:identificationAndClassificationOfGroupMembers)">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 8.</td>
					<td width="92%" class="tableClassNoBorder">Identification and Classification of Members of the Group.</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item8/p:notApplicableFlag = 'Y'">
								<div class="text">
									Not Applicable
								</div>
							</xsl:when>
							<xsl:otherwise>
							<div class="information" style="text-align:justify">
								If a group has filed this schedule pursuant to §240.13d-1(b)(1)(ii)(J), so indicate under Item 3(j) and attach an exhibit stating the identity and Item 3 classification of each member of the group. If a group has filed this schedule pursuant to §240.13d-1(c) or §240.13d-1(d), attach an exhibit stating the identity of each member of the group.
							</div>
							<br/>
							<br/>
							<div class="largetext">
								<xsl:value-of select="string(p:items/p:item8/p:identificationAndClassificationOfGroupMembers)" />
							</div>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="(p:items/p:item9) and (p:items/p:item9/p:notApplicableFlag = 'Y') or (p:items/p:item9/p:groupDissolutionNotice)">
				<tr>
					<td width="8%" class="tableClassValignNoBorder">Item 9.</td>
					<td width="92%" class="tableClassNoBorder">Notice of Dissolution of Group.</td>
				</tr>
				<tr>
					<td width="8%" class="tableClassNoBorderAlignCenter">&#160;</td>
					<td width="92%" class="tableClassNoBorder">
						<xsl:choose>
							<xsl:when test="p:items/p:item9/p:notApplicableFlag = 'Y'">
								<div class="text">
									Not Applicable
								</div>
							</xsl:when>
							<xsl:otherwise>
							<div class="information" style="text-align:justify">
								Notice of dissolution of a group may be furnished as an exhibit stating the date of the dissolution and that all further filings with respect to transactions in the security reported on will be filed, if required, by members of the group, in their individual capacity. See Item 5.
							</div>
							<br/>
							<br/>
							<div class="largetext">
								<xsl:value-of select="string(p:items/p:item9/p:groupDissolutionNotice)" />
							</div>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:if>
			</table>
		</xsl:if>
		<br/>
	</xsl:template>
</xsl:stylesheet>