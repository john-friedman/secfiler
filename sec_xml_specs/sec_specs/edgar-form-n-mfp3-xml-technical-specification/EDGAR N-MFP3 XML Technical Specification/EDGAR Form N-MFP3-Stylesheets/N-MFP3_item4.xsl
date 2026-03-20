<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/nmfp3"
	xmlns:ns3="http://www.sec.gov/edgar/nmfp3common">
	
	<xsl:template name="item4_partC">
		<xsl:for-each select="m1:scheduleOfPortfolioSecuritiesInfo">
			<h3>Part C: Schedule of Portfolio Securities </h3>
			<table role="presentation">
			<tr>
					<td class="label"><i>For each security held by the money market fund, disclose the following information</i></td>
					<td>
									
					</td>
				</tr>
				<tr>
					<td class="label"><b>Item C.1.</b> The name of the issuer or the name of the counterparty in a repurchase agreement</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:nameOfIssuer" />
						</div>					
					</td>
				</tr>
				<tr >
					<td class="label"><b>Item C.2.</b> The title of the issue</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:titleOfIssuer" />
						</div>					
					</td>
				</tr>
					<tr >
					<td class="label">Coupon, if applicable</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:coupon" />
						</div>					
					</td>
				</tr>
				<tr>
					<td class="label"><b>Item C.3.</b> The CUSIP</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:CUSIPMember" />
						</div>
					</td>
				</tr>	
				
				<tr>
					<td class="label"><b>Item C.4.</b> The LEI</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:LEIID" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						<b>Item C.5.</b> 
						Other identifier. In addition to CUSIP and LEI, provide at least one of the
						following other identifiers, if available:
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							a. The ISIN;
						</blockquote>
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:ISINId" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							b. The CIK;
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:cik" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							c. The RSSD ID; or
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
						 <xsl:value-of select="m1:RSSDID" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							d. Other unique identifier
						</blockquote>
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:otherUniqueId" />
						</div>
					</td>
				</tr>	
				<tr>
					<td class="label"><b>Item C.6.</b> The category of investment. Indicate the category that most closely identifies the instrument from among the following:
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'U.S. Treasury Debt'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> U.S. Treasury Debt<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'U.S. Government Agency Debt (if categorized as coupon-paying notes)'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> U.S. Government Agency Debt (if categorized as coupon-paying notes)<br/>
						
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'U.S. Government Agency Debt (if categorized as no-coupon discount notes)'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> U.S. Government Agency Debt (if categorized as no-coupon discount notes)<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Non-U.S. Sovereign, Sub-Sovereign and Supra-National debt'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Non-U.S. Sovereign, Sub-Sovereign and Supra-National debt<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Certificate of Deposit'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Certificate of Deposit<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Non-Negotiable Time Deposit'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Non-Negotiable Time Deposit<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Variable Rate Demand Note'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Variable Rate Demand Note<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Other Municipal Security'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Other Municipal Security<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Asset Backed Commercial Paper'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Asset Backed Commercial Paper<br/>

						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Other Asset Backed Securities'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Other Asset Backed Securities<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'U.S. Treasury Repurchase Agreement, if collateralized only by U.S. Treasuries (including Strips) and cash'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> U.S. Treasury Repurchase Agreement <i>if collateralized only by U.S. Treasuries (including Strips) and cash </i><br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'U.S. Government Agency Repurchase Agreement, collateralized only by U.S. Government Agency securities, U.S. Treasuries, and cash'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> U.S. Government Agency Repurchase Agreement <i>collateralized only by U.S. Government Agency securities, U.S. Treasuries, and cash</i><br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Other Repurchase Agreement, if collateral falls outside Treasury, Government Agency and cash'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Other Repurchase Agreement if collateral falls outside Treasury, Government Agency, and cash<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Insurance Company Funding Agreement'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Insurance Company Funding Agreement<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Investment Company'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Investment Company<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Financial Company Commercial Paper'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Financial Company Commercial Paper<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Non-Financial Company Commercial Paper'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Non-Financial Company Commercial Paper<br/>

						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Tender Option Bond'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Tender Option Bond<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:investmentCategory) = 'Other Instrument'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Other Instrument<br/>
					</td>					
				</tr>
				<xsl:if test="(count(m1:briefDescription) &gt; 0) and (string(m1:investmentCategory) = 'Other Instrument')">
					<tr>
						<td class="label">
							<blockquote>
								If <i>Other Instrument</i>, include a brief description
							</blockquote>
						</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="m1:briefDescription" />
							</div>						
						</td>					
					</tr>
				</xsl:if>
				<tr>
					<td class="label"><b>Item C.7.</b> If the security is a repurchase agreement, is the fund treating the acquisition of the repurchase agreement as the acquisition of the underlying securities (<i>i.e.</i>, collateral) for purposes of portfolio diversification under rule 2a-7? 
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:fundAcqstnUndrlyngSecurityFlag)='Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>&#160;Yes
						<xsl:choose>
							<xsl:when test="string(m1:fundAcqstnUndrlyngSecurityFlag)='N'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>&#160;No
					</td>					
				</tr>				
				<tr>
					<td class="label">
						<b>Item C.8.</b> For all repurchase agreements, specify whether the repurchase agreement is "open" 
						(<i>i.e.</i>, the repurchase agreement has no specified end date and, by its terms, will be extended 
						or "rolled" each business day (or at another specified period) unless the investor chooses to terminate it), 
						and describe the securities subject to the repurchase agreement (<i>i.e.</i>, collateral)
					</td>
					<td>
					</td>
				</tr>
				<xsl:for-each select="m1:repurchaseAgreement">
					<xsl:if test="count(m1:repurchaseAgreementOpenFlag) &gt; 0">
						<tr>
							<td class="label">
								<blockquote>
									a. Is the repurchase agreement "open"?
								</blockquote>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string(m1:repurchaseAgreementOpenFlag)='Y'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
									</xsl:otherwise>
								</xsl:choose> &#160;
								<xsl:choose>
									<xsl:when test="string(m1:repurchaseAgreementOpenFlag)='N'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No 
									</xsl:otherwise>
								</xsl:choose>											
							</td>					
						</tr>
					</xsl:if>
					
					<xsl:if test="count(m1:repurchaseAgreementClearedFlag) &gt; 0">
					
						<tr>
							<td class="label">
								<blockquote>
									b. Is the repurchase agreement centrally cleared?
								</blockquote>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string(m1:repurchaseAgreementClearedFlag)='Y'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
									</xsl:otherwise>
								</xsl:choose> &#160;
								<xsl:choose>
									<xsl:when test="string(m1:repurchaseAgreementClearedFlag)='N'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No 
									</xsl:otherwise>
								</xsl:choose>											
							</td>					
						</tr>
		           </xsl:if>
		           
		           
					<!-- Add section c -->
					<xsl:if test="count(m1:nameOfCCP) &gt; 0">
					
						<tr>
								<td class="label">
									<blockquote>
										If Yes, provide the name of the central clearing counterparty (CCP)
									</blockquote>
								</td>
								<td>						
									<div class="fakeBox3">
									 	<xsl:value-of select="m1:nameOfCCP" />
									</div>	
								</td>
							</tr>
					</xsl:if>
					
					<xsl:if test="count(m1:repurchaseAgreementTripartyFlag) &gt; 0">
						<tr>
							<td class="label">
								<blockquote>
									c. Is the repurchase agreement settled on the triparty platform?
								</blockquote>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string(m1:repurchaseAgreementTripartyFlag)='Y'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
									</xsl:otherwise>
								</xsl:choose> &#160;
								<xsl:choose>
									<xsl:when test="string(m1:repurchaseAgreementTripartyFlag)='N'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No 
									</xsl:otherwise>
								</xsl:choose>											
							</td>					
						</tr>
					</xsl:if>
					
					
					
					<xsl:for-each select="m1:collateralIssuers">
						<xsl:if test="count(m1:nameOfCollateralIssuer) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										d. The name of the collateral issuer
									</blockquote>
								</td>
								<td>						
									<div class="fakeBox3">
										<xsl:value-of select="m1:nameOfCollateralIssuer" />
									</div>	
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="count(m1:LEIID) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										e. LEI
									</blockquote>
								</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="m1:LEIID" />
									</div>	
								</td>
							</tr>
						</xsl:if>
						
						<xsl:if test="count(m1:CUSIPMember) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										f. The CUSIP
									</blockquote>
								</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="m1:CUSIPMember" />
									</div>	
								</td>
							</tr>
						</xsl:if>
						
						<xsl:if test="count(m1:maturityDate/m1:date) &gt; 0 or count(m1:maturityDate/m1:dateRange) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										g. Maturity date
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:if test="count(m1:maturityDate/m1:date) &gt; 0">
											<xsl:value-of select="m1:maturityDate/m1:date" />
										</xsl:if>
										<xsl:if test="count(m1:maturityDate/m1:dateRange) &gt; 0">
											<xsl:value-of select="m1:maturityDate/m1:dateRange/ns3:from" /> 
											&#160;<font color="black">-</font>&#160;
											<xsl:value-of select="m1:maturityDate/m1:dateRange/ns3:to" />
										</xsl:if>
									</div>						
								</td>
							</tr>
						</xsl:if>
							<xsl:if test="count(m1:coupon) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										h. Coupon
									</blockquote>
								</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="m1:coupon" />
									</div>						
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="count(m1:yield) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										Yield
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:yield" />
									</div>						
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="count(m1:principalAmountToTheNearestCent) &gt; 0 and string(m1:principalAmountToTheNearestCent) &gt;= 0">
							<tr>
								<td class="label">
									<blockquote>
										i. The principal amount, to the nearest cent
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select='format-number(m1:principalAmountToTheNearestCent, "$###,###,###,##0.00")' />
									</div>						
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="count(m1:valueOfCollateralToTheNearestCent) &gt; 0 and string(m1:valueOfCollateralToTheNearestCent) &gt;= 0">
							<tr>
								<td class="label">
									<blockquote>
										j. Value of collateral, to the nearest cent
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select='format-number(m1:valueOfCollateralToTheNearestCent, "$###,###,###,##0.00")' />
									</div>						
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="count(m1:ctgryInvestmentsRprsntsCollateral) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										k. The category of investment that most closely represents the collateral, selected from among the following:
									</blockquote>
								</td>
								<td>
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Asset-Backed Securities'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Asset-Backed Securities<br/>
									
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Agency Collateralized Mortgage Obligation'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Agency Collateralized Mortgage Obligations<br/>
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Agency Debentures and Agency Strips'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Agency Debentures and Agency Strips<br/>			
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Agency Mortgage-Backed Securities'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Agency Mortgage-Backed Securities<br/>	
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Private Label Collateralized Mortgage Obligations'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Private Label Collateralized Mortgage Obligations<br/>	
									
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Corporate Debt Securities'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Corporate Debt Securities<br/>
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Equities'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Equities<br/>
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Money Market'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Money Market<br/>									
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'U.S. Treasuries (including strips)'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> U.S. Treasuries (including strips)<br/>	
									
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Cash'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Cash<br/>	
									<xsl:choose>
										<xsl:when test="m1:ctgryInvestmentsRprsntsCollateral = 'Other Instrument'">
											<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
										</xsl:when>
										<xsl:otherwise>
											<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
										</xsl:otherwise>
									</xsl:choose><xsl:text>&#160;</xsl:text> Other Instrument  <br/>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="count(m1:otherInstrumentBriefDesc) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
										<blockquote>
											If <i>Other Instrument</i>, include a brief description, including, if applicable, 
											whether it is a collateralized debt obligation, municipal debt, whole loan, or international debt
										</blockquote>
									</blockquote>
								</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="m1:otherInstrumentBriefDesc" />
									</div>						
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>					
				</xsl:for-each>
				<tr>
					<td class="label">If multiple securities of an issuer are subject to the repurchase agreement, the securities may be aggregated, in which case disclose:</td>
					<td></td>
				</tr>
				<tr>
					<td class="label">(a) the total principal amount and value and</td>
					<td></td>
				</tr>
				<tr>
					<td class="label">(b) the range of maturity dates and interest rates</td>
					<td></td>
				</tr>
				<tr>
					<td class="label">
						<b>Item C.9.</b> Is the security an Eligible Security?
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="m1:securityEligibilityFlag = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose><xsl:text>&#160;</xsl:text>Yes&#160;	
						<xsl:choose>
							<xsl:when test="m1:securityEligibilityFlag = 'N'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose><xsl:text>&#160;</xsl:text>No	
					</td>
				</tr>
				<tr>
					<td class="label">
						<b>Item C.10.</b> Security rating(s) considered. Provide each rating assigned 
						by any NRSRO that the fund's board of directors (or its delegate) considered 
						in determining that the security presents minimal credit risks (together with 
						the name of the assigning NRSRO). If none, leave blank.
					</td>
					<td></td>
				</tr>
				<xsl:for-each select="m1:assigningNRSRORating">
				<tr>
					<td class="label">
						<blockquote>
							Name of NRSRO
						</blockquote>
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:nameOfNRSRO" />
						</div>
					</td>
				</tr>
				<xsl:if test="count(m1:nameOfNRSRO) &gt; 0">
							<tr>
								<td class="label">
									<blockquote>
									Rating
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:rating" />
									</div>	
								</td>
							</tr>
				</xsl:if>
				</xsl:for-each>
				<tr>
					<td class="label">
						<b>Item C.11.</b> The maturity date determined by taking into account the maturity shortening provisions of rule 2a-7(i) (i.e., the maturity date used to calculate WAM under rule 2a-7(d)(1)(ii))
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:investmentMaturityDateWAM" />
						</div>							
					</td>
				</tr>				
				<tr>
					<td class="label">
						<b>Item C.12.</b> The maturity date determined without reference to the exceptions in rule 2a-7(i) regarding interest rate readjustments (i.e., the maturity date used to calculate WAL under rule 2a-7(d)(1)(iii))
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:investmentMaturityDateWAL" />
						</div>							
					</td>
				</tr>				
				<tr >
					<td class="label">
						<b>Item C.13.</b> The maturity date determined without reference to the maturity shortening provisions of rule 2a-7(i) (<i>i.e.</i>, the
						ultimate legal maturity date on which, in accordance with the terms of the security without regard to any interest rate readjustment 
						or demand feature, the principal amount must unconditionally be paid)
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:finalLegalInvestmentMaturityDate" />
						</div>							
					</td>
				</tr>
				<tr>
					<td class="label">
						<b>Item C.14.</b> Does the security have a Demand Feature on which the fund is 
						relying to determine the quality, maturity or liquidity of the security? 
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:securityDemandFeatureFlag)='Y'">	
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:securityDemandFeatureFlag)='N'">	
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
							</xsl:otherwise>
						</xsl:choose>									
					</td>						
				</tr>
				<tr>
					<td class="label">
						<i>If Yes, answer Items C.14.a - 14.e.  Where applicable, provide the information 
						required in Items C.14b - 14.e in the order that each Demand Feature issuer was 
						reported in Item C.14.a</i>
					</td>
					<td></td>
				</tr>
				<xsl:if test="string(m1:securityDemandFeatureFlag) ='Y'">
					<xsl:for-each select="m1:demandFeature">
						<tr>
							<td class="label">
								<blockquote>
									a. The identity of the Demand Feature issuer(s)
								</blockquote>
							</td>
							<td>
								<div class="fakeBox3">
									<xsl:value-of select="m1:identityOfDemandFeatureIssuer" />
								</div>							
							</td>
						</tr>		
						<tr>
							<td class="label">
								<blockquote>
									b. The amount (i.e., percentage) of fractional support provided by each Demand Feature issuer
								</blockquote>
							</td>
							<td>
								<div class="fakeBox2">
									<xsl:if test="string(m1:amountProvidedByDemandFeatureIssuer) &gt;= 0">
										<xsl:variable name="amountProvidedByDemandFeatureIssuer" select='format-number(m1:amountProvidedByDemandFeatureIssuer, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $amountProvidedByDemandFeatureIssuer ,  "dd0.00", "percentage")' />%
									</xsl:if>
								</div>									
							</td>
						</tr>	
						<tr>
							<td class="label">
								<blockquote>
									c. The period remaining until the principal amount of the security may be recovered through the Demand Feature
								</blockquote>
							</td>
							<td>
								<div class="fakeBox2">
									<xsl:value-of select="m1:remainingPeriodDemandFeature" />
								</div>	
							</td>
						</tr>
						<tr>
							<td class="label">
								<blockquote>
									d. Is the demand feature conditional?
								</blockquote>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string(m1:demandFeatureConditionalFlag)='Y'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
									</xsl:otherwise>
								</xsl:choose> &#160;
								<xsl:choose>
									<xsl:when test="string(m1:demandFeatureConditionalFlag)='N'">	
										<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
									</xsl:otherwise>
								</xsl:choose>											
							</td>
						</tr>
						<tr>
							<td class="label">
								<blockquote>
									e. Rating(s) considered. Provide each rating assigned to the demand feature(s)
									or demand feature provider(s) by any NRSRO that the board of directors (or its delegate) 
									considered in evaluating the quality, maturity or liquidity of the security (together 
									with the name of the assigning NRSRO). If none, leave blank
								</blockquote>
							</td>
							<td></td>
						</tr>
						<xsl:for-each select="m1:demandFeatureRatingOrNRSRO">
							<tr>
								<td class="label">
									<blockquote>
										<blockquote>
											Name of NRSRO
										</blockquote>
									</blockquote>
								</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="m1:nameOfNRSRO"/> 
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<blockquote>
										<blockquote>
											Rating
										</blockquote>
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:rating"/> 
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
				<tr>
					<td class="label">
						<b>Item C.15.</b> Does the security have a Guarantee 
						(other than an unconditional letter of credit disclosed in item C.14 
						above) on which the fund is relying to determine the quality, maturity 
						or liquidity of the security? 
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:securityGuaranteeFlag)='Y'">	
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:securityGuaranteeFlag)='N'">	
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
							</xsl:otherwise>
						</xsl:choose>							
					</td>
				</tr>
				<tr>
					<td class="label">
						<i>If Yes, answer Items C.15.a - 15.c.  
						Where applicable, provide the information required in Item C.15.b - 15.c 
						in the order that each Guarantor was reported in Item C.15.a</i>
					</td>
					<td></td>
				</tr>
				<xsl:if test="string(m1:securityGuaranteeFlag) = 'Y'">
					<xsl:for-each select="m1:guarantor">
						<tr>
							<td class="label">
								<blockquote>
									a. The identity of the Guarantor(s)
								</blockquote>
							</td>
							<td>
								<div class="fakeBox3">
									<xsl:value-of select="m1:identityOfTheGuarantor" />
								</div>							
							</td>
						</tr>
						<tr>
							<td class="label">
								<blockquote>
									b. The amount (<i>i.e.</i>, percentage) of fractional support provided by each Guarantor
								</blockquote>
							</td>
							<td>
								<div class="fakeBox2">
									<xsl:if test="string(m1:amountProvidedByGuarantor) &gt;= 0">
										<xsl:variable name="amountProvidedByGuarantor" select='format-number(m1:amountProvidedByGuarantor , "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $amountProvidedByGuarantor ,  "dd0.00", "percentage")' />%
									</xsl:if>
								</div>									
							</td>
						</tr>
						<tr>
							<td class="label">
								<blockquote>
									c. Rating(s) considered. Provide each rating assigned to the guarantee(s) or guarantor(s) 
									by any NRSRO that the board of directors (or its delegate) considered in evaluating the 
									quality, maturity or liquidity of the security (together with the name of the assigning 
									NRSRO). If none, leave blank
								</blockquote>
							</td>
							<td></td>
						</tr>
						<xsl:for-each select="m1:guarantorRatingOrNRSRO">
							<tr>
								<td class="label">
									<blockquote>
										<blockquote>
											Name of NRSRO
										</blockquote>
									</blockquote>
								</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="m1:nameOfNRSRO"/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<blockquote>
										<blockquote>
											Rating
										</blockquote>
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:rating"/>
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
				<tr>
					<td class="label">
						<b>Item C.16.</b> Does the security have any enhancements, other than those identified in Items C.14 and C.15 
						above, on which the fund is relying to determine the quality, maturity or liquidity of the security? 
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:securityEnhancementsFlag)='Y'">	
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:securityEnhancementsFlag)='N'">	
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td class="label">
						<i>If Yes, answer Items C.16.a – 16.d.  Where applicable, provide the information required in Items C.16.b – 16.d in the order that each enhancement provider was reported in Item C.16.a.x</i>
					</td>
					<td></td>
				</tr>
				<xsl:if test="string(m1:securityEnhancementsFlag)='Y'">
					<xsl:for-each select="m1:enhancementProvider">
						<tr>
							<td class="label">
								<blockquote>
									a. The identity of the enhancement provider(s)
								</blockquote>
							</td>
							<td>
								<div class="fakeBox3">
									<xsl:value-of select="m1:identityOfTheEnhancementProvider" />
								</div>							
							</td>
						</tr>
						<tr>
							<td class="label">
								<blockquote>
									b. The type of enhancement(s)
								</blockquote>
							</td>
							<td>
								<div class="fakeBox3">
									<xsl:value-of select="m1:typeOfEnhancement" />
								</div>							
							</td>
						</tr>					
						<tr>
							<td class="label">
								<blockquote>
									c. The amount (<i>i.e.</i>, percentage) of fractional support provided by each enhancement provider
								</blockquote>
							</td>
							<td>
								<div class="fakeBox2">
									<xsl:if test="string(m1:amountProvidedByEnhancement) &gt;= 0">
										<xsl:variable name="amountProvidedByEnhancement" select='format-number(m1:amountProvidedByEnhancement, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $amountProvidedByEnhancement ,  "dd0.00", "percentage")' />%
									</xsl:if>
								</div>									
							</td>
						</tr>
						<tr>
							<td class="label">
								<blockquote>
									d. Rating(s) considered. Provide each rating assigned to the enhancement(s) or 
									enhancement provider(s) by any NRSRO that the board of directors (or its delegate) 
									considered in evaluating the quality, maturity or liquidity of the security 
									(together with the name of the assigning NRSRO). If none, leave blank
								</blockquote>
							</td>
							<td></td>
						</tr>
						<xsl:for-each select="m1:enhancementRatingOrNRSRO">
							<tr>
								<td class="label">
									<blockquote>
										<blockquote>
											Name of NRSRO
										</blockquote>
									</blockquote>
								</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="m1:nameOfNRSRO"/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<blockquote>
										<blockquote>
											Rating
										</blockquote>
									</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:rating"/>
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
				<tr>
					<td class="label"><b>Item C.17.</b> The yield of the security as of the reporting date</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="string(m1:yieldOfTheSecurityAsOfReportingDate)">
								<xsl:variable name="yieldOfTheSecurityAsOfReportingDate" select='format-number(m1:yieldOfTheSecurityAsOfReportingDate, "0.0000", "percentage")'/>
								<xsl:value-of select='format-number(100 * $yieldOfTheSecurityAsOfReportingDate ,  "dd0.00", "percentage")' />%
							</xsl:if>
						</div>										
					</td>
				</tr>				
				<tr>
					<td class="label"><b>Item C.18.</b> The total Value of the fund's position in the 
					security, to the nearest cent:  (See General Instruction E.)</td>
					<td>
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							a. <i>Including</i> the value of any sponsor support:
						</blockquote>
					</td>	
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:includingValueOfAnySponsorSupport) &gt; 0">
								<xsl:value-of select='format-number(m1:includingValueOfAnySponsorSupport, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>										
					</td>
				</tr>	
				<tr>
					<td class="label">
						<blockquote>
							b. <i>Excluding</i> the value of any sponsor support:
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:excludingValueOfAnySponsorSupport) &gt; 0">
								<xsl:value-of select='format-number(m1:excludingValueOfAnySponsorSupport, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>										
					</td>
				</tr>	
				<tr>
					<td class="label"><b>Item C.19</b> The percentage of the money market fund's net assets
					invested in the security, to the nearest hundredth of a percent</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="string(m1:percentageOfMoneyMarketFundNetAssets) &gt;= 0">
								<xsl:variable name="percentageOfMoneyMarketFundNetAssets" select='format-number(m1:percentageOfMoneyMarketFundNetAssets, "0.0000", "percentage")'/>
								<xsl:value-of select='format-number(100 * $percentageOfMoneyMarketFundNetAssets ,  "dd0.00", "percentage")' />%
							</xsl:if>
						</div>										
					</td>
				</tr>				
				<tr>
					<td class="label"><b>Item C.20.</b> Is the security categorized at level 3 in the fair value hierarchy under U.S. Generally Accepted Accounting Principles (ASC 820, Fair Value Measurement)?</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:securityCategorizedAtLevel3Flag) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:securityCategorizedAtLevel3Flag) = 'N'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
							</xsl:otherwise>
						</xsl:choose>						
					</td>
				</tr>				
				<tr>
					<td class="label"><b>Item C.21.</b> Is the security a Daily Liquid Asset?</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:dailyLiquidAssetSecurityFlag) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked" /> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:dailyLiquidAssetSecurityFlag) = 'N'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked" /> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> No
							</xsl:otherwise>
						</xsl:choose>						
					</td>
				</tr>
				<tr>
					<td class="label"><b>Item C.22.</b> Is the security a Weekly Liquid Asset?  </td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:weeklyLiquidAssetSecurityFlag) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked" /> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:weeklyLiquidAssetSecurityFlag) = 'N'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked" /> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> No
							</xsl:otherwise>
						</xsl:choose>						
					</td>
				</tr>				
				<tr>
					<td class="label"><b>Item C.23.</b> Is the security an Illiquid Security?</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:illiquidSecurityFlag) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked" /> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:illiquidSecurityFlag) = 'N'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked" /> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> No
							</xsl:otherwise>
						</xsl:choose>						
					</td>
				</tr>
				<tr>
					<td class="label"><b>Item C.24.</b>
					Explanatory notes. Disclose any other information that may be material to other disclosures related to the portfolio security. If none, leave blank.</td>
					<td>
						<div class="fakeBox3">
							<xsl:if test="count(m1:explanatoryNotes) &gt; 0">
								<xsl:value-of select="m1:explanatoryNotes" />
							</xsl:if>
						</div>	
					</td>
				</tr>
			</table>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

