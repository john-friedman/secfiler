<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncen"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 5 templates -->
	<xsl:template name="PartD">
		<h4>Item D.1. Securities issued by Registrant.</h4>
		<xsl:call-template name="securityIssued" />
<br />
		<h4>Item D.2. Rights offerings.</h4>
		<xsl:call-template name="rightsOffering" />
<br />
		<h4>Item D.3. Secondary offerings.</h4>
		<xsl:call-template name="secondaryOfferings" />
<br />
		<h4>Item D.4. Repurchases.</h4>
		<xsl:call-template name="repurchases" />
<br />
		<h4>Item D.5. Default on long-term debt.</h4>
		<xsl:call-template name="defaultLongTerm" />
<br />
		<h4>Item D.6. Dividends in arrears.</h4>
		<xsl:call-template name="dividendsArrears" />
<br />
		<h4>Item D.7. Modification of securities.</h4>
		<xsl:call-template name="modificationSecurities" />
<br />
		<h4>Item D.8. Management fee (closed-end companies only).</h4>
		<xsl:call-template name="managementFees" />
<br />
		<h4>Item D.9. Net annual operating expense.</h4>
		<xsl:call-template name="netAnnualOperating" />
<br />
		<h4>Item D.10. Market price.</h4>
		<xsl:call-template name="marketPrice" />
<br />
		<h4>Item D.11. Net asset value.</h4>
		<xsl:call-template name="netAssetValue" />
<xsl:if test="$icType = 'N-5'">
<br />
		<h4>Item D.12. Investment advisers (small business investment
			companies only).</h4>
		<xsl:call-template name="investmentAdvisersC" />
<br />
		<h4>Item D.13. Transfer agents (small business investment companies
			only).</h4>
		<xsl:call-template name="transferAgents" />
<br />
		<h4>Item D.14. Custodians (small business investment companies only).</h4>
		<xsl:call-template name="smallCustodians" />
</xsl:if>		
	</xsl:template>

	<xsl:template name="securityIssued">
		<table role="presentation">
			<tr>
				<td colspan = "3">
					<i>Instruction.</i> For any security issued by the Fund that is not listed on a securities exchange but that has a ticker symbol, provide that ticker symbol.
					<br/><br/>
					Indicate by checking below which of the following securities have been issued by the Registrant. Indicate all that apply.			
				</td>
			</tr>
		</table>
		
			<xsl:for-each	select="m1:closedEndManagementInvestment/m1:securityRelatedItems/m1:securityRelatedItem">
			<table role="presentation">
				<tr>
					<td colspan = "3">
							Security Issued by Registrants Record:
							<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
				</table>
				
				<table role="presentation">
				<tr>
					<td class="label">Type of security</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:description)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
            </table>

            <table role="presentation">
				<xsl:choose>
					<xsl:when test="string(m1:description) = 'Other'">
						<tr>
							<td class="label">If other, describe</td>
							<td>
								<div class="fakeBox3">
									<xsl:value-of select="string(m1:otherSecurityDescription)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
            </table>
            
            <table role="presentation">
				<tr>
					<td class="label">Title of class</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:securityClassTitle)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				</table>
				
				<xsl:for-each	select="m1:commonStocks/m1:commonStock">
				<table role="presentation">
					<tr><td>Common Record:<xsl:value-of select="position()"></xsl:value-of></td></tr>
				</table>
				
				<table role="presentation">
				<tr>
					<td class="label">Exchange where listed</td>
					<td>
						<div class="fakeBox3">
							<xsl:call-template name="exchangeDescription">
								<xsl:with-param name="exchangeCode"	select="string(@commonStockExchange)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">Ticker symbol</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(@commonStockTickerSymbol)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				</table>
				</xsl:for-each>

			</xsl:for-each>
		
	</xsl:template>

	<xsl:template name="rightsOffering">

		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i> For Item D.2.c, the "percentage of participation in primary rights offering" is calculated as the percentage of subscriptions exercised during the primary rights offering relative to the amount of securities available for primary subscription.
				</td>
			</tr>
			</table>
			
			
	   <table role="presentation">
			<tr>
				<td class="label">
					a. Did the Fund make a rights offering with respect to any type of
					security during the	reporting period?  
					</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:closedEndManagementInvestment/m1:isRightsOffering" />
						<xsl:with-param name="yesElement" select="m1:closedEndManagementInvestment/m1:rightsOfferingFunds/@isRightsOffering"/>
					</xsl:call-template>
				</td>
			</tr>
		</table>
		
				<xsl:choose>
					<xsl:when test="string(m1:closedEndManagementInvestment/m1:rightsOfferingFunds/@isRightsOffering) = 'Y'">
					<table role="presentation">
						<tr>
							<td>
								If yes, answer the following as to each rights offering made by the Fund:
				     </td>
						</tr>
					</table>	
						
						<xsl:for-each	select="m1:closedEndManagementInvestment/m1:rightsOfferingFunds/m1:rightsOfferingFund">
						<table role="presentation">
							<tr>
								<td>
										Rights Offering Types Fund Record:
										<xsl:value-of select="position()"></xsl:value-of>
								</td>
							</tr>
						</table>
						
						<table role="presentation">	
							<tr>
								<td>
										b. Type of security.
								</td>
							</tr>
							<tr>
							<td>
								<xsl:choose>
									<xsl:when
										test="m1:rightsOfferingTypes/m1:rightsOfferingType = 'Common stock'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
								&#160;i. Common stock &#160;
								<br />
								<xsl:choose>
									<xsl:when
										test="m1:rightsOfferingTypes/m1:rightsOfferingType = 'Preferred stock'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
								&#160;ii. Preferred stock &#160;
								<br />
								<xsl:choose>
									<xsl:when
										test="m1:rightsOfferingTypes/m1:rightsOfferingType = 'Warrants'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
								&#160;iii. Warrants &#160;
								<br />
								<xsl:choose>
									<xsl:when
										test="m1:rightsOfferingTypes/m1:rightsOfferingType = 'Convertible securities'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
								&#160;iv. Convertible securities&#160;
								<br />
								<xsl:choose>
									<xsl:when
										test="m1:rightsOfferingTypes/m1:rightsOfferingType = 'Bonds'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
								&#160;v. Bonds &#160;
								<br />
								<xsl:choose>
									<xsl:when
										test="m1:rightsOfferingTypes/m1:rightsOfferingType = 'Other'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
								&#160;vi. Other &#160;
								<br />
								</td>
							</tr>
						</table>
						
							
								<xsl:choose>
									<xsl:when test="m1:rightsOfferingTypes/m1:rightsOfferingType = 'Other'">
									<table role="presentation">
										<tr>
											<td class="label">If other, describe</td>
											<td>
												
													<div class="fakeBox3">
														<xsl:value-of
															select="m1:rightsOfferingTypes/m1:rightsOfferingDesc" />
														<span>
															<xsl:text>&#160;</xsl:text>
														</span>
													</div>
												
											</td>
										</tr>
									</table>	
									</xsl:when>
								</xsl:choose>
								
					<table role="presentation">
							<tr>
								<td class="label">c. Percentage of participation in primary
									rights offering:</td>
								<td>
									
										<div class="fakeBox4">
											<xsl:value-of
												select="m1:rightsOfferingParticipationPercent" />
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									
								</td>
							</tr>
					</table>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>

	</xsl:template>

	<xsl:template name="secondaryOfferings">

		<table role="presentation">
			<tr>
				<td class="label">
					a.	Did the Fund make a secondary offering during the reporting period?
					</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:closedEndManagementInvestment/m1:isSecondaryOffering" />
						<xsl:with-param name="yesElement" select="m1:closedEndManagementInvestment/m1:secondaryOfferings/@isSecondaryOffering"/>
					</xsl:call-template>
				</td>
			</tr>
		</table>	
		
				<xsl:choose>
					<xsl:when test="string(m1:closedEndManagementInvestment/m1:secondaryOfferings/@isSecondaryOffering) = 'Y'">
					<table role="presentation">
						<tr>
							<td>
								b.	If yes, indicate by checking below the type(s) of security. Indicate all that apply.
							</td>
						</tr>
					</table>
					
					<table role="presentation">	
						<tr>
						<td>
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:secondaryOfferingType = 'Common stock'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;i. Common stock &#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:secondaryOfferingType = 'Preferred stock'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;ii. Preferred stock &#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:secondaryOfferingType = 'Warrants'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;iii. Warrants &#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:secondaryOfferingType = 'Convertible securities'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;iv. Convertible securities&#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:secondaryOfferingType = 'Bonds'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;v. Bonds &#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:secondaryOfferingType = 'Other'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;vi. Other &#160;
							<br />
							</td>
						</tr>
						</table>
						
							<xsl:choose>
								<xsl:when test="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:secondaryOfferingType = 'Other'">
								<table role="presentation">
									<tr>
										<td class="label">If other, describe.</td>
										<td>
											
												<div class="fakeBox3">
													<xsl:value-of
														select="m1:closedEndManagementInvestment/m1:secondaryOfferings/m1:otherSecondaryOfferingDesc" />
													<span>
														<xsl:text>&#160;</xsl:text>
													</span>
												</div>
										</td>
									</tr>
								</table>	
								</xsl:when>
							</xsl:choose>
					</xsl:when>
				</xsl:choose>
	</xsl:template>

	<xsl:template name="repurchases">
		<table role="presentation">
			<tr>
				<td class="label">
					a. Did the Fund repurchase any outstanding securities issued by the
					Fund during the reporting period?  
					</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement"	select="m1:closedEndManagementInvestment/m1:isRepurchaseSecurity" />
						<xsl:with-param name="yesElement"	select="m1:closedEndManagementInvestment/m1:repurchaseSecurities/@isRepurchaseSecurity" />
					</xsl:call-template>
				</td>

			</tr>
		</table>
		
				<xsl:choose>
					<xsl:when test="string(m1:closedEndManagementInvestment/m1:repurchaseSecurities/@isRepurchaseSecurity) = 'Y'">
					<table role="presentation">
						<tr>
							<td colspan = "3">
								b. If yes, indicate by checking below the type(s) of security. Indicate all that apply:
						</td>
						</tr>
					</table>
					
					<table role="presentation">	
						<tr>						
						<td>
							<xsl:choose>
								<xsl:when	test="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:repurchaseSecurityType = 'Common stock'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;i. Common stock &#160;
							<br />
							<xsl:choose>
								<xsl:when	test="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:repurchaseSecurityType = 'Preferred stock'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;ii. Preferred stock &#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:repurchaseSecurityType = 'Warrants'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;iii. Warrants &#160;
							<br />
							<xsl:choose>
								<xsl:when	test="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:repurchaseSecurityType = 'Convertible securities'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;iv. Convertible securities&#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:repurchaseSecurityType = 'Bonds'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;v. Bonds &#160;
							<br />
							<xsl:choose>
								<xsl:when
									test="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:repurchaseSecurityType = 'Other'">
									<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;vi. Other &#160;
							<br />
							</td>
						</tr>
					</table>
					
							<xsl:choose>
								<xsl:when	test="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:repurchaseSecurityType = 'Other'">
								<table role="presentation">
									<tr>
										<td class="label">If other, describe.</td>
										<td>
												<div class="fakeBox3">
													<xsl:value-of
														select="m1:closedEndManagementInvestment/m1:repurchaseSecurities/m1:otherRepurchaseSecurityDesc" />
													<span>
														<xsl:text>&#160;</xsl:text>
													</span>
												</div>
										</td>
									</tr>
								</table>	
								</xsl:when>
							</xsl:choose>
					</xsl:when>
				</xsl:choose>
	</xsl:template>

	<xsl:template name="defaultLongTerm">

		<table role="presentation">
			<tr>
				<td>
					<i>Instruction</i>
					. The term "long-term debt" means debt with a period of time from
					date of initial issuance to maturity of one year or greater.
				</td>
			</tr>
		
			<tr>
				<td class="label">
					a. Were any issues of the Fund's long-term debt in default at the
					close of the reporting period with respect to the payment of
					principal, interest, or amortization? 
					</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement"	select="m1:closedEndManagementInvestment/m1:isDefaultLongTermDebt" />
						<xsl:with-param name="yesElement" select="m1:closedEndManagementInvestment/m1:longTermDebtDefault/@isDefaultLongTermDebt" />
					</xsl:call-template>
				</td>
			</tr>
		
			<xsl:choose>
				<xsl:when	test="string(m1:closedEndManagementInvestment/m1:longTermDebtDefault/@isDefaultLongTermDebt) = 'Y'">
					<tr>
						<td>If yes, provide the following:
				</td>
					</tr>

						<xsl:for-each	select="m1:closedEndManagementInvestment/m1:longTermDebtDefault/m1:longTermDebtDefaults/m1:longTermDebtDefault">
							<tr>
								<td>
										Long term debt Record:
										<xsl:value-of select="position()"></xsl:value-of>
								</td>
							</tr>

							<tr>
								<td class="label">i. Nature of default</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="string(@defaultNature)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">ii. Date of default</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="string(@defaultDate)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">iii. Amount of default per $1,000 face
									amount</td>
								<td>
									<div class="fakeBox4">
										<xsl:value-of select="string(@defaultPerThousandAmount)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">iv. Total amount of default</td>
								<td>
									<div class="fakeBox4">
										<xsl:value-of select="string(@defaultTotalAmount)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
						</xsl:for-each>
				</xsl:when>
			</xsl:choose>
		</table>
	</xsl:template>

	<xsl:template name="dividendsArrears">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction</i>
					. The term "dividends in arrears" means dividends that have not
					been declared by the board of directors or other governing body of
					the Fund at the end of each relevant dividend period set forth in
					the constituent instruments establishing the rights of the
					stockholders.
				</td>
			</tr>
			<tr>
				<td class="label">
					a. Were any accumulated dividends in arrears on securities issued by
					the Fund at the close of the reporting period?  
					</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:closedEndManagementInvestment/m1:isDividendsInArrears" />
						<xsl:with-param name="yesElement" select="m1:closedEndManagementInvestment/m1:divdInArrears/@isDividendsInArrears" />
					</xsl:call-template>
				</td>
			</tr>
		
			<xsl:choose>
				<xsl:when test="string(m1:closedEndManagementInvestment/m1:divdInArrears/@isDividendsInArrears) = 'Y'">
					<tr>
						<td>If yes, provide the following:
				</td>
					</tr>

						<xsl:for-each select="m1:closedEndManagementInvestment/m1:divdInArrears/m1:dividendsInArrears/m1:dividendsInArrear">
							<tr>
								<td>
										Dividends arrear Record:
										<xsl:value-of select="position()"></xsl:value-of>
								</td>
							</tr>
							<tr>
								<td class="label">i. Title of issue</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="string(@dividendIssueTitle)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">ii. Amount per share in arrears</td>
								<td>
									<div class="fakeBox4">
										<xsl:value-of select="string(@dividendAmountPerShareInArrear)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
						</xsl:for-each>
				</xsl:when>
			</xsl:choose>
		</table>
	</xsl:template>

	<xsl:template name="modificationSecurities">
		<table role="presentation">
			<tr>
				<td class="label">
					Have the terms of any constituent instruments defining the rights of
					the holders of any class of the Registrant's securities been
					materially modified? 
					</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:closedEndManagementInvestment/m1:isSecuritiesModified" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
		
		<table role="presentation">	
				<xsl:choose>
					<xsl:when	test="string(m1:closedEndManagementInvestment/m1:isSecuritiesModified) = 'Y'">
						<tr><td>
						If yes, provide the attachment required by Item G.1.b.ii.</td></tr>
					</xsl:when>
				</xsl:choose>
		</table>
	</xsl:template>

	<xsl:template name="managementFees">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					Base the percentage on amounts incurred during the reporting period
				</td>
			</tr>
		</table>
		
		<table role="presentation">	
			<tr>
				<td class="label">Provide the Fund's advisory fee as of the end
					of the reporting period as percentage of net assets:</td>
				<td>
					
						<div class="fakeBox4">
							<xsl:value-of select="m1:closedEndManagementInvestment/m1:managementFee" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="netAnnualOperating">
		<table role="presentation">
			<tr>
				<td class="label">Provide the Fund's net annual operating
					expenses as of the end of the reporting period (net of any waivers
					or reimbursements) as a percentage of net assets:</td>
				<td>
						<div class="fakeBox4">
							<xsl:value-of
								select="m1:closedEndManagementInvestment/m1:netOperatingExpenses" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="marketPrice">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					Respond to this item with respect to common stock issued by the
					Registrant only.
				</td>
			</tr>
			<tr>
				<td class="label">Market price per share at end of reporting
					period:</td>
				<td>
						<div class="fakeBox4">
							<xsl:value-of
								select="m1:closedEndManagementInvestment/m1:marketPricePerShare" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="netAssetValue">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					Respond to this item with respect to common stock issued by the
					Registrant only.
				</td>
			</tr>
			<tr>
				<td class="label">Net asset value per share at end of reporting
					period:</td>
				<td>
					
						<div class="fakeBox4">
							<xsl:value-of
								select="m1:closedEndManagementInvestment/m1:netAssetValuePerShare" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="investmentAdvisersC">
		<table role="presentation">
			<tr>
				<td colspan = "3"> a. Provide the following information about each investment
					adviser (other than a sub-adviser) of the Fund:
				</td>
			</tr>
		</table>	
			
		<table role="presentation">
				<xsl:for-each	select="m1:closedEndManagementInvestment/m1:smallInvestmentAdvisers/m1:smallInvestmentAdviser">
					<tr>
						<td colspan = "3">
								Small investment adviser Record:
								<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>

					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:smallInvestmentAdviserName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. SEC file number (<i>e.g., 801-</i>)</td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallInvestmentAdviserFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:smallInvestmentAdviserCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallInvestmentAdviserLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
			<tr>
				<td class="label">v.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:smallInvestmentAdviserStateCountry/@smallInvestmentAdviserState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">vi.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:smallInvestmentAdviserStateCountry/@smallInvestmentAdviserCountry" />
							<xsl:with-param name="code2" select="m1:smallInvestmentAdviserCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>						
			<tr>
						<td class="label">
							vii. Was the investment adviser hired during
							the reporting
							period?
						</td>
						<td>
							<xsl:call-template name="condYesNoRadio">
								<xsl:with-param name="noElement" select="m1:isSmallInvestmentAdviserHired" />
								<xsl:with-param name="yesElement" select="m1:smallInvestmentAdviserHired/@isSmallInvestmentAdviserHired" />
							</xsl:call-template>
						</td>
					</tr>
						<xsl:choose>
							<xsl:when test="string(m1:smallInvestmentAdviserHired/@isSmallInvestmentAdviserHired) = 'Y'">
								<tr>
									<td class="label">1. If the investment adviser was hired
										during the
										reporting period, indicate the investment adviser's
										start
										date:
									</td>
									<td>
											<div class="fakeBox2">
												<xsl:value-of select="string(m1:smallInvestmentAdviserHired/@smallInvestmentAdviserStartDate)" />
												<span>
													<xsl:text>&#160;</xsl:text>
												</span>
											</div>
									</td>
								</tr>
							</xsl:when>
						</xsl:choose>
				</xsl:for-each>
		</table>		
		
		<table role="presentation">		
			<tr>
				<td>b. If an investment adviser (other than a sub-adviser) to the
					Fund was terminated during the reporting period, provide the
					following with respect to each investment adviser:
				</td>
			</tr>
		</table>
		
		<table role="presentation">
				<xsl:for-each select="m1:closedEndManagementInvestment/m1:terminatedSmallInvAdvisers/m1:terminatedSmallInvAdviser">
					<tr>
						<td>
								Terminated small investment Adviser Record:
								<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>

					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:smallInvestmentAdviserTerminatedName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. SEC file number (<i>e.g., 801-</i>)</td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of
										select="string(m1:smallInvestmentAdviserTerminatedFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:smallInvestmentAdviserTerminatedCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallInvestmentAdviserTerminatedLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
			<tr>
				<td class="label">v.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:smallInvestmentAdviserTerminatedStateCountry/@smallInvestmentAdviserTerminatedState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">vi.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:smallInvestmentAdviserTerminatedStateCountry/@smallInvestmentAdviserTerminatedCountry" />
							<xsl:with-param name="code2" select="m1:smallInvestmentAdviserTerminatedCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>						
					<tr>
						<td class="label">vii. Termination date </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallInvestmentAdviserTerminatedDate)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
				</xsl:for-each>
		</table>
				
		<table role="presentation">		
			<tr>
				<td> c. For each sub-adviser to the Fund, provide the information
					requested:
				</td>
			</tr>
		</table>
			
		<table role="presentation">
				<xsl:for-each select="m1:closedEndManagementInvestment/m1:smallSubAdvisers/m1:smallSubAdviser">
					<tr>
						<td>
								Small Sub Adviser Record:
								<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>

					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:smallSubAdviserName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. SEC file number (e.g., 801-), if
							applicable</td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallSubAdviserFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:smallSubAdviserCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallSubAdviserLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
			<tr>
				<td class="label">v.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:smallSubAdviserStateCountry/@smallSubAdviserState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">vi.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:smallSubAdviserStateCountry/@smallSubAdviserCountry" />
							<xsl:with-param name="code2" select="m1:smallSubAdviserCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>						
					<tr>
						<td class="label">
							vii. Is the sub-adviser an affiliated person
							of the Fund's
							investment
							adviser(s)?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:isSmallSubAdviserAffiliated" />
							</xsl:call-template>
						</td>
					</tr>

					<tr>
						<td class="label">
							viii. Was the sub-adviser hired during the
							reporting
							period?
						</td>
						<td>
							<xsl:call-template name="condYesNoRadio">
								<xsl:with-param name="noElement" select="m1:isSmallSubAdviserHired" />
								<xsl:with-param name="yesElement" select="m1:smallSubAdviserHired/@isSmallSubAdviserHired" />
							</xsl:call-template>
						</td>
					</tr>
						<xsl:choose>
							<xsl:when test="string(m1:smallSubAdviserHired/@isSmallSubAdviserHired) = 'Y'">
								<tr>
									<td class="label">1. If the sub-adviser was hired during the
										period,
										indicate the sub-adviser's start date:
									</td>
									<td>
										
											<div class="fakeBox2">
												<xsl:value-of select="string(m1:smallSubAdviserHired/@smallSubAdviserStartDate)" />
												<span>
													<xsl:text>&#160;</xsl:text>
												</span>
											</div>
										
									</td>
								</tr>
							</xsl:when>
						</xsl:choose>
				</xsl:for-each>
		</table>
		
		<table role="presentation">		
			<tr>
				<td >d. If a sub-adviser was terminated during the reporting period,
					provide the following with respect to such sub-adviser:
				</td>
			</tr>
		</table>
		
		<table role="presentation">
				<xsl:for-each select="m1:closedEndManagementInvestment/m1:terminatedSmallSubAdvisers/m1:terminatedSmallSubAdviser">
					<tr>
						<td>
								Terminated small sub Adviser Record:
								<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:smallSubAdviserTerminatedName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. SEC file number (e.g., 801-)</td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallSubAdviserTerminatedFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:smallSubAdviserTerminatedCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallSubAdviserTerminatedLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
			<tr>
				<td class="label">v.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:smallSubAdviserTerminatedStateCountry/@smallSubAdviserTerminatedState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">vi.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:smallSubAdviserTerminatedStateCountry/@smallSubAdviserTerminatedCountry" />
							<xsl:with-param name="code2" select="m1:smallSubAdviserTerminatedCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>						
					<tr>
						<td class="label">vii. Termination date </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallSubAdviserTerminatedDate)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
				</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="transferAgents">
		<table role="presentation">
			<tr>
				<td>a. Provide the following information about each person providing
					transfer agency services to the Fund:
				</td>
			</tr>
		</table>
		
		<table role="presentation">	
				<xsl:for-each	select="m1:closedEndManagementInvestment/m1:smallTransferAgents/m1:smallTransferAgent">
					<tr>
						<td>
								Small transfer agent Record:
								<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>

					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:smallTransferAgentName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. SEC file number (e.g., 84- or 85-) </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallTransferAgentFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>

					<tr>
						<td class="label">iii. LEI, if any </td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallTransferAgentLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>
			<tr>
				<td class="label">iv.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:smallTransferAgentStateCountry/@smallTransferAgentState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">v.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:smallTransferAgentStateCountry/@smallTransferAgentCountry" />
							<xsl:with-param name="code2" select="m1:smallTransferAgentCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>						
					<tr>
						<td class="label">
							vi. Is the transfer agent an affiliated
							person of the Fund
							or its
							investment adviser(s)?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:isSmallTransferAgentAffiliated" />
							</xsl:call-template>
						</td>
					</tr>
					
					<tr>
						<td class="label">
							vii. Is the transfer agent a sub-transfer agent?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:isSmallTransferAgentSubAdmin" />
							</xsl:call-template>
						</td>
					</tr>

				</xsl:for-each>
</table>
<br/>
<table role="presentation">
			<tr>
				<td class="label">
					b. Has a transfer agent been hired or
					terminated during the
					reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:closedEndManagementInvestment/m1:isSmallTransferAgentHiredOrTerminated" />
					</xsl:call-template>
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="smallCustodians">
		<table role="presentation">
			<tr>
				<td>a. Provide the following information about each person that
					provided custodial services to the Fund during the reporting
					period:
				</td>
			</tr>
			</table>

         <table role="presentation">
				<xsl:for-each select="m1:closedEndManagementInvestment/m1:smallCustodians/m1:smallCustodian">
					<tr>
						<td>
								Small custodian Record:
								<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>

					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:smallCustodianName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. LEI, if any</td>
						<td>
							
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:smallCustodianLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							
						</td>
					</tr>

			<tr>
				<td class="label">iii.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:smallCustodianStateCountry/@smallCustodianState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">iv.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:smallCustodianStateCountry/@smallCustodianCountry" />
							<xsl:with-param name="code2" select="m1:smallCustodianCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>						
					<tr>
						<td class="label">
							v. Is the custodian an affiliated person of
							the Fund or its
							investment adviser(s)?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:isSmallCustodianAffiliated" />
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="label">
							vi. Is the custodian a sub-custodian?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement" select="m1:isSmallCustodianSub" />
							</xsl:call-template>
						</td>
					</tr>

					<tr>
						<td class="label">
							vii. With respect to the custodian, check
							below to indicate
							the type
							of custody:
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:custodyType) &gt; 0">
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Bank - section 17(f)(1) (15 U.S.C. 80a-17(f)(1))'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												1.Bank - section 17(f)(1) (15 U.S.C. 80a-17(f)(1))<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												1.Bank - section 17(f)(1) (15 U.S.C. 80a-17(f)(1))<br/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Member national securities exchange - rule 17f-1 (17 CFR 270.17f-1)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												2.Member national securities exchange - rule 17f-1 (17 CFR
												270.17f-1)<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												2.Member national securities exchange - rule 17f-1 (17 CFR
												270.17f-1)<br/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Self - rule 17f-2 (17 CFR 270.17f-2)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												3.Self - rule 17f-2 (17 CFR 270.17f-2)<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												3.Self - rule 17f-2 (17 CFR 270.17f-2)<br/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Securities depository - rule 17f-4 (17 CFR 270.17f-4)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												4.Securities depository - rule 17f-4 (17 CFR 270.17f-4)<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												4.Securities depository - rule 17f-4 (17 CFR 270.17f-4)<br/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Foreign custodian - rule 17f-5 (17 CFR 270.17f-5)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												5.Foreign custodian - rule 17f-5 (17 CFR 270.17f-5)<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												5.Foreign custodian - rule 17f-5 (17 CFR 270.17f-5)<br/>
											</xsl:otherwise>											
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Futures commission merchants and commodity clearing organizations - rule 17f-6 (17 CFR 270.17f-6)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												6.Futures commission merchants and commodity clearing
												organizations - rule 17f-6 (17 CFR 270.17f-6)<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												6.Futures commission merchants and commodity clearing
												organizations - rule 17f-6 (17 CFR 270.17f-6)<br/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Foreign securities depository - rule 17f-7 (17 CFR 270.17f-7) '">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												7.Foreign securities depository - rule 17f-7 (17 CFR
												270.17f-7)<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												7.Foreign securities depository - rule 17f-7 (17 CFR
												270.17f-7)<br/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Insurance company sponsor - rule 26a-2 (17 CFR 270.26a-2) '">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												8.Insurance company sponsor - rule 26a-2 (17 CFR 270.26a-2)<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												8.Insurance company sponsor - rule 26a-2 (17 CFR 270.26a-2)<br/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:custodyType) = 'Other'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												9.Other<br/>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												9.Other<br/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										1.Bank - section 17(f)(1) (15 U.S.C. 80a-17(f)(1))<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										2.Member national securities exchange - rule 17f-1 (17 CFR
										270.17f-1)<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										3.Self - rule 17f-2 (17 CFR 270.17f-2)<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										4.Securities depository - rule 17f-4 (17 CFR 270.17f-4)<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										5.Foreign custodian - rule 17f-5 (17 CFR 270.17f-5)<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										6.Futures commission merchants and commodity clearing
										organizations - rule 17f-6 (17 CFR 270.17f-6)<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										7.Foreign securities depository - rule 17f-7 (17 CFR
										270.17f-7)<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										8.Insurance company sponsor - rule 26a-2 (17 CFR 270.26a-2)<br/>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										9.Other<br/>
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>
					
						<xsl:choose>
							<xsl:when test="string(m1:custodyType) = 'Other'">
								<tr>
									<td class="label">If other, describe</td>
									<td>
										
											<div class="fakeBox3">
												<xsl:value-of select="m1:otherSmallCustodianDesc" />
												<span>
													<xsl:text>&#160;</xsl:text>
												</span>
											</div>
										
									</td>
								</tr>
							</xsl:when>
						</xsl:choose>

				</xsl:for-each>
			</table>
			<br/>
			<table role="presentation">	
			<tr>
				<td class="label">
					b. Has a custodian been hired or terminated during the reporting
					period?
					</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:closedEndManagementInvestment/m1:isSmallCustodianHiredTerminated" />
					</xsl:call-template>
				</td>
			</tr>
		</table>

	</xsl:template>

</xsl:stylesheet>
	