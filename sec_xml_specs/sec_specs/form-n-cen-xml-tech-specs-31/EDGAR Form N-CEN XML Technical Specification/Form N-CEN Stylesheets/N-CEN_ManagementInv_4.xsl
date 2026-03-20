<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncen"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 1 templates -->
	<xsl:template name="PartC">
		<table role="presentation">
			<tr>
				<td>
					<h4>
						<i>General Instruction.</i>
					</h4>
					Management investment companies that offer multiple series must
					complete Part C as to each series separately, even if some
					information is the same for two or more series. To begin this
					section or add an additional series(s), click on the bar labeled
					"Add a New Series" below.
				</td>
			</tr>
		</table>

		<xsl:for-each
			select="m1:managementInvestmentQuestionSeriesInfo/m1:managementInvestmentQuestion">
			<table role="presentation">
				<tr>
					<td>
						Management Investment Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
			</table>
			<br />
			<h4>
				Item C.1. Background information.
			</h4>
			<xsl:call-template name="backgroundInformation" />
			<br />

			<h4>
				Item C.2. Classes of open-end management investment companies.
			</h4>
			<xsl:call-template name="classesOpenEndManagement" />
			<br />
			<h4>
				Item C.3. Type of fund.
			</h4>
			<xsl:call-template name="typeOfFund" />
			<br />
			<h4>
				Item C.4. Diversification.
			</h4>
			<xsl:call-template name="diversification" />
			<br />
			<h4>
				Item C.5. Investments in certain foreign corporations.
			</h4>
			<xsl:call-template name="investmentsForeignCorporations" />
			<br />
			<h4>
				Item C.6. Securities lending.
			</h4>
			<xsl:call-template name="securitiesLending" />
			<br />
			<h4>
				Item C.7. Reliance on certain statutory exemption and rules.
			</h4>
			<xsl:call-template name="relianceCertainRules" />
			<br />
			<h4>
				Item C.8. Expense limitations.
			</h4>
			<xsl:call-template name="expenseLimitations" />
			<br />
			<h4>
				Item C.9. Investment advisers.
			</h4>
			<xsl:call-template name="investmentAdvisers" />
			<br />
			<h4>
				Item C.10. Transfer agents.
			</h4>
			<xsl:call-template name="TransferAgents" />
			<br />
			<h4>
				Item C.11. Pricing services.
			</h4>
			<xsl:call-template name="pricingServices" />
			<br />
			<h4>
				Item C.12. Custodians.
			</h4>
			<xsl:call-template name="custodians" />
			<br />
			<h4>
				Item C.13. Shareholder servicing agents.
			</h4>
			<xsl:call-template name="shareholderServicingAgents" />
			<br />
			<h4>
				Item C.14. Administrators.
			</h4>
			<xsl:call-template name="thirdPartyAdministrators" />
			<br />
			<h4>
				Item C.15. Affiliated broker-dealers.
			</h4>
			<xsl:call-template name="afiliatedBrokerDealers" />
			<br />
			<h4>
				Item C.16. Brokers.
			</h4>
			<xsl:call-template name="brokers" />
			<br />
			<h4>
				Item C.17. Principal transactions.
			</h4>
			<xsl:call-template name="principalTransactions" />
			<br />
			<h4>
				Item C.18. Payments for brokerage and research.
			</h4>
			<xsl:call-template name="paymentsBrokerageReaseach" />
			<br />
			<h4>
				Item C.19. Average net assets.
			</h4>
			<xsl:call-template name="averageNetAssets" />
			<br />
			<xsl:if test="$icType = 'N-1A' or $icType = 'N-3'">
				<h4>
					Item C.20. Lines of credit, interfund lending and interfund
					borrowing.
				</h4>
				<xsl:call-template name="linesOfCredit" />
				<br />
			</xsl:if>
			<xsl:call-template name="swingPricing" />
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="backgroundInformation">

		<table role="presentation">
			<tr>
				<td class="label">a. Full Name of the Fund</td>
				<td>
					<p>
						<div class="fakeBox3">
							<xsl:value-of select="m1:mgmtInvFundName" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

			<tr>
				<td class="label">b. Series identication number, if any</td>
				<td>
					<p>
						<div class="fakeBox2">
							<xsl:value-of select="m1:mgmtInvSeriesId" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

			<tr>
				<td class="label">c. LEI</td>
				<td>
					<p>
						<div class="fakeBox2">
							<xsl:value-of select="m1:mgmtInvLei" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

			<tr>
				<td class="label">
					d. Is this the first filing on this form by the Fund?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isFirstFilingByFund) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isFirstFilingByFund) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isFirstFilingByFund) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="classesOpenEndManagement">
		<table role="presentation">
			<tr>
				<td class="label">a. How many Classes of shares of the Fund (if
					any) are
					authorized?
				</td>
				<td>
					<p>
						<div class="fakeBox4">
							<xsl:value-of select="m1:numAuthorizedClass" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

			<tr>
				<td class="label">b. How many new Classes of shares of the Fund
					were
					added
					during the reporting period?
				</td>
				<td>
					<p>
						<div class="fakeBox4">
							<xsl:value-of select="m1:numAddedClass" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

			<tr>
				<td class="label">c. How many Classes of shares of the Fund were
					terminated during the reporting period?
				</td>
				<td>
					<p>
						<div class="fakeBox4">
							<xsl:value-of select="m1:numTerminatedClass" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

			<tr>
				<td class="label">d. For each Class with shares outstanding,
					provide the
					information requested below:</td>
			</tr>

			<tr>
				<xsl:for-each select="m1:sharesOutstandings/m1:sharesOutstanding">
					<tr>
						<td>
							Shares Outstanding Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name of Class</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(@sharesOutstandingClassName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. Class identification number, if any</td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(@sharesOutstandingClassId)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">iii. Ticker symbol, if any </td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(@sharesOutstandingTickerSymbol)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</xsl:for-each>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="typeOfFund">
		<table role="presentation">
			<tr>
				<td>
					<i>Instructions.</i>

					1. "Fund of Funds" means a fund that acquires securities issued by
					any other investment company in excess of the amounts permitted
					under paragraph (A) of section 12(d)(1) of the Act (15 U.S.C.
					80a-12(d)(1)(A)), but, for purposes of this Item, does not include
					a fund that acquires securities issued by another company solely in
					reliance on rule 12d1-1 under the Act (CFR 270.12d1-1).

					2. "Index
					Fund" means an investment company, including an
					Exchange-Traded
					Fund, that seeks to track the performance of a
					specified index.

					3.
					"Interval Fund" means a closed-end management investment company
					that makes periodic repurchases of its shares pursuant to rule
					23c-3 under the Act (17 CFR 270.23c-3).

					4. "Master-Feeder Fund"
					means a two-tiered arrangement in which one
					or more funds (each a
					feeder fund) holds shares of a single Fund
					(the master fund) in
					accordance with section 12(d)(1)(E) of the Act
					(15 U.S.C.
					80a-12(d)(1)(E)) or pursuant to exemptive relief granted
					by the
					Commission.

					5. "Target Date Fund" means an investment company that
					has an
					investment objective or strategy of providing varying degrees
					of
					long-term appreciation and capital preservation through a mix of
					equity and fixed income exposures that changes over time based on
					an investor's age, target retirement date, or life expectancy.
				</td>
			</tr>
		</table>


		<table role="presentation">
			<tr>
				<td>Indicate if the Fund is any one of the types listed below. Check
					all that apply.</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>
					&#160;a. Exchange-Traded Fund or Exchange-Traded Managed Fund or
					offers a Class that itself is an Exchange-Traded Fund or
					Exchange-Traded Managed Fund&#160;
					<br />
					&#160;&#160;&#160;&#160;&#160;&#160;i. &#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:fundType = 'Exchange-Traded Fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Exchange-Traded Fund&#160;
					<br />
					&#160;&#160;&#160;&#160;&#160;&#160;ii.&#160;
					<xsl:choose>
						<xsl:when
							test="m1:fundTypes/m1:fundType = 'Exchange-Traded Managed Fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Exchange-Traded Managed Fund&#160;
					<br />
					&#160;b.&#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:indexFundInfo/@fundType = 'Index Fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />

						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;Index Fund&#160;
					<br />

					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:indexFundInfo/@fundType = 'Index Fund'">
							<table role="presentation">
								<tr>i. Is the index whose performance the Fund tracks,
									constructed:</tr>
								<tr>
									<td class="label">1. By an affiliated person of the fund?</td>
									<td>
										<xsl:call-template name="yesNoRadio">
											<xsl:with-param name="yesNoElement"
												select="m1:fundTypes/m1:indexFundInfo/m1:isIndexFundAffiliated" />
										</xsl:call-template>
									</td>
								</tr>

								<tr>
									<td class="label"> 2. Exclusively for the fund?</td>
									<td>
										<xsl:call-template name="yesNoRadio">
											<xsl:with-param name="yesNoElement"
												select="m1:fundTypes/m1:indexFundInfo/m1:isIndexFundExclusive" />
										</xsl:call-template>
									</td>
								</tr>
							</table>

							<table role="presentation">
								<tr>ii. Provide the annualized difference between the Fund's
									total return during the reporting period and the index's return
									during the reporting period (<i>i.e</i>., the Fund's total return less
									the index's return):
								</tr>

								<tr>
									<td class="label">1. Before Fund fees and expenses:</td>
									<td>
										<div class="fakeBox">
										<xsl:call-template name="format_to_dollar_large">
											<xsl:with-param name="money"
											select="string(m1:fundTypes/m1:indexFundInfo/m1:indexFundReturnDiffBeforeExpense)" />
										</xsl:call-template>
											
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</td>
								</tr>

								<tr>
									<td class="label">2. After Fund fees and expenses (i.e., net
										asset
										value):</td>
									<td>
										<div class="fakeBox">
										<xsl:call-template name="format_to_dollar_large">
											<xsl:with-param name="money"
											select="string(m1:fundTypes/m1:indexFundInfo/m1:indexFundReturnDiffAfterExpense)" />
										</xsl:call-template>
											
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</td>
								</tr>
							</table>

							<table role="presentation">
								<tr>iii. Provide the annualized standard deviation of the daily
									difference between the Fund's total return and the index's
									return during the reporting period:
								</tr>

								<tr>
									<td class="label">1. Before Fund fees and expenses:</td>
									<td>
										<div class="fakeBox">
										<xsl:call-template name="format_to_dollar_large">
											<xsl:with-param name="money"
											select="string(m1:fundTypes/m1:indexFundInfo/m1:indexFundReturnDailyStdevBeforeExpense)" />
										</xsl:call-template>
										
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</td>
								</tr>

								<tr>
									<td class="label">2. After Fund fees and expenses (i.e., net
										asset
										value):</td>
									<td>
										<div class="fakeBox">
											<xsl:call-template name="format_to_dollar_large">
											<xsl:with-param name="money"
											select="string(m1:fundTypes/m1:indexFundInfo/m1:indexFundReturnDailyStdevAfterExpense)" />
											</xsl:call-template>
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</td>
								</tr>

							</table>
						</xsl:when>
					</xsl:choose>
					<br />
					&#160;c.&#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:fundType = 'Inverse of a benchmark'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Seeks to achieve performance results that are a multiple
					of a
					benchmark, the inverse of a benchmark, or a multiple of the
					inverse
					of a benchmark&#160;
					<br />
					&#160;d.&#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:fundType = 'Interval Fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Interval Fund&#160;
					<br />
					&#160;e.&#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:fundType = 'Fund of Funds'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Fund of Funds&#160;
					<br />
					&#160;f. &#160;
					<xsl:choose>
						<xsl:when
							test="m1:fundTypes/m1:masterFeederFundInfo/@fundType = 'Master-Feeder Fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Master-Feeder Fund&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:fundTypes/m1:masterFeederFundInfo/@fundType = 'Master-Feeder Fund'">
							<br />
							<table role="presentation">
								<tr>i. If the Registrant is a master fund, then provide the
									information requested below with respect to each feeder fund:</tr>
							</table>

							<table role="presentation">
								<xsl:call-template name="feederFund" />
							</table>
						</xsl:when>
					</xsl:choose>

					&#160;g.&#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:fundType = 'Money Market Fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Money Market Fund&#160;
					<br />
					&#160;h.&#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:fundType = 'Target Date Fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Target Date Fund&#160;
					<br />
					&#160;i. &#160;
					<xsl:choose>
						<xsl:when test="m1:fundTypes/m1:fundType = 'Underlying fund'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; Underlying fund to a variable annuity or variable life
					insurance contract&#160;
					<br />
					&#160;&#160;&#160;&#160;&#160;
					<xsl:choose>
						<xsl:when test="m1:fundType = 'N/A'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;&#160;N/A&#160;
					<br />

				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="diversification">
		<table role="presentation">
			<tr>
				<td class="label">
					Does the Fund seek to operate as a “non-diversified
					company” as such
					term is defined in section 5(b)(2) of the Act (15
					U.S.C. 80a-
					5(b) (2))?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isNonDiversifiedCompany) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isNonDiversifiedCompany) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isNonDiversifiedCompany) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

		</table>

	</xsl:template>

	<xsl:template name="investmentsForeignCorporations">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					"Controlled foreign corporation" has the meaning
					provided in section
					957 of the Internal Revenue Code [26 U.S.C.
					957].
				</td>
			</tr>
		</table>

		<table role="presentation">


			<tr>
				<td class="label">
					a. Does the fund invest in a controlled foreign
					corporation
					for the purpose of investing in certain types of
					instruments such
					as, but not limited to, commodities?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when
								test="count(m1:isForeignSubsidiary) &gt; 0 or count(m1:foreignInvestments/@isForeignSubsidiary) &gt; 0">
								<xsl:choose>
									<xsl:when
										test="string(m1:foreignInvestments/@isForeignSubsidiary) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isForeignSubsidiary) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

			<xsl:choose>
				<xsl:when test="string(m1:foreignInvestments/@isForeignSubsidiary) = 'Y'">
					<tr>
						<td>b. If yes, provide the following information:</td>
					</tr>

					<tr>
						<xsl:for-each select="m1:foreignInvestments/m1:foreignInvestment">
							<tr>
								<td>
									Foreign Investments Record:
									<xsl:value-of select="position()"></xsl:value-of>
								</td>
							</tr>

							<tr>
								<td class="label">Full name of subsidiary</td>
								<td>
									<div class="fakeBox3">
										<xsl:value-of select="string(@foreignSubsidiaryName)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">LEI of subsidiary, if any</td>
								<td>
									<p>
										<div class="fakeBox2">
											<xsl:value-of select="string(@foreignSubsidiaryLei)" />
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</p>
								</td>
							</tr>
						</xsl:for-each>
					</tr>
				</xsl:when>
			</xsl:choose>
		</table>

	</xsl:template>

	<xsl:template name="securitiesLending">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					For purposes of this Item, other adverse impacts would include, for
					example, (1) a loss to the Fund if collateral and indemnification
					were not sufficient to replace the loaned securities or their
					value, (2) the Fund's ineligibility to vote shares in a proxy, or
					(3) the Fund's ineligibility to receive a direct distribution from
					the issuer.
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">
					a. Is the Fund authorized to engage in
					securities
					lending
					transactions?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isFundSecuritiesLending) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isFundSecuritiesLending) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isFundSecuritiesLending) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

			<tr>
				<td class="label">
					b. Did the Fund lend any of its securities
					during the
					reporting period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when
								test="count(m1:didFundLendSecurities) &gt; 0 or count(m1:fundLendSecurities/@didFundLendSecurities) &gt; 0">
								<xsl:choose>
									<xsl:when
										test="string(m1:fundLendSecurities/@didFundLendSecurities) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:didFundLendSecurities) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
		</table>

	<xsl:choose>
		<xsl:when test="string(m1:fundLendSecurities/@didFundLendSecurities) = 'Y'">
			<table role="presentation">
				<tr>
					<td>i. If yes, during the reporting period, did any borrower fail
						to
						return the loaned securities by
						the contractual deadline with the
						result that:
					</td>
				</tr>
			</table>

			<table role="presentation">
				<tr>
					<td class="label">
						1. The Fund (or its securities lending agent)
						liquidated collateral pledged to secure the loaned securities?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="m1:fundLendSecurities/m1:isFundLiquidated" />
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="label">
						2. The Fund was otherwise adversely impacted?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="m1:fundLendSecurities/m1:isFundAdverselyImpacted" />
						</xsl:call-template>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>

		<table role="presentation">
			<tr>
				<td> c. Provide the information requested below about each
					securities lending agent, if any, retained by the Fund:
				</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:securityLendings/m1:securityLending/m1:securitiesAgentName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">i. Full name of securities lending agent</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. Is the securities lending agent an affiliated
							person,
							or an
							affiliated person of an affiliated person, of the
							Fund?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="/m1:securityLendings/m1:securityLending/m1:isSecuritiesAgentAffiliated" />
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="label">
							iv. Does the securities lending agent or any other
							entity
							indemnify
							the fund against borrower default on loans
							administered
							by this
							agent?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="/m1:securityLendings/m1:securityLending/m1:isSecuritiesAgentAffiliated" />
							</xsl:call-template>
						</td>
					</tr>
				</table>
				
				<table role="presentation">
					<tr>
						<td>
							v. If the entity providing the indemnification is not the
							securities
							lending agent, provide the following information:
						</td>
					</tr>
				</table>
				
				<table role="presentation">
					<tr>
						<td class="label">1. Name of person providing indemnification</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">2. LEI, if any, of person providing
							indemnification
						</td>
						<td>
							<p>
								<div class="fakeBox2">
								</div>
							</p>
						</td>
					</tr>
				</table>

				<table role="presentation">
					<tr>
						<td class="label">
							vi. Did the Fund exercise its indemnification rights
							during the
							reporting period?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="/m1:securityLendings/m1:securityLending/m1:isSecuritiesAgentAffiliated" />
							</xsl:call-template>
						</td>
					</tr>
				</table>

			</xsl:when>
		</xsl:choose>

		<!-- Mockup table end -->

		<xsl:for-each select="m1:securityLendings/m1:securityLending">
			<table role="presentation">
				<tr>
					<tr>
						<td>
							Securities Lending Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>

					<tr>
						<td class="label">i. Full name of securities lending agent</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:securitiesAgentName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:securitiesAgentLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. Is the securities lending agent an affiliated
							person,
							or an
							affiliated person of an affiliated person, of the
							Fund?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isSecuritiesAgentAffiliated) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isSecuritiesAgentAffiliated) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isSecuritiesAgentAffiliated) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>
					<tr>
						<td class="label">
							iv. Does the securities lending agent or any other
							entity
							indemnify
							the fund against borrower default on loans
							administered
							by this
							agent?

						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when
										test="count(m1:isSecurityAgentIdemnity) &gt; 0 or count(m1:securityAgentIdemnity/@isSecurityAgentIdemnity) &gt; 0">
										<xsl:choose>
											<xsl:when
												test="string(m1:securityAgentIdemnity/@isSecurityAgentIdemnity) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isSecurityAgentIdemnity) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>


					<xsl:choose>
						<xsl:when
							test="string(m1:securityAgentIdemnity/@isSecurityAgentIdemnity) = 'Y'">
							<xsl:for-each
								select="m1:securityAgentIdemnity/m1:idemnityProviders/m1:idemnityProvider">
								<table role="presentation">
									<tr>
										<td>
											v. If the entity providing the indemnification is not the
											securities
											lending agent, provide the following information:
										</td>
									</tr>
								</table>
								<table role="presentation">
									<tr>
										<td>
											Idemnity Providers Record:
											<xsl:value-of select="position()"></xsl:value-of>
										</td>
									</tr>
								</table>								
								<table role="presentation">
									<tr>
										<td class="label">1. Name of person providing indemnification</td>
										<td>
											<div class="fakeBox3">
												<xsl:value-of select="string(@idemnityProviderName)" />
												<span>
													<xsl:text>&#160;</xsl:text>
												</span>
											</div>
										</td>
									</tr>
									<tr>
										<td class="label">2. LEI, if any, of person providing
											indemnification
										</td>
										<td>
											<p>
												<div class="fakeBox2">
													<xsl:value-of select="string(@idemnityProviderLei)" />
													<span>
														<xsl:text>&#160;</xsl:text>
													</span>
												</div>
											</p>
										</td>
									</tr>
								</table>
							</xsl:for-each>
						<table role="presentation">
							<tr>
								<td class="label">
									vi. Did the Fund exercise its indemnification rights
									during the
									reporting period?
								</td>
								<td>
									<xsl:call-template name="yesNoRadio">
										<xsl:with-param name="yesNoElement"
											select="m1:securityAgentIdemnity/m1:didIndemnificationRights" />
									</xsl:call-template>
								</td>
							</tr>
						</table>			
						</xsl:when>
					</xsl:choose>
				</tr>
			</table>
		</xsl:for-each>

		<table role="presentation">
			<tr>
				<td> d. If a person providing cash collateral management services
					to
					the Fund in connection with the Fund's securities lending
					activities does not also serve as securities lending agent,
					provide
					the following information about each cash collateral
					manager:
				</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:collateralManagers/m1:collateralManager/@collateralManagerName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">i. Full name of cash collateral manager:</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. LEI, if any:</td>
						<td>
							<p>
								<div class="fakeBox2">
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. Is the cash collateral manager an affiliated
							person, or an
							affiliated person of an affiliated person, of a
							securities
							lending
							agent retained by the Fund?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:collateralManagers/m1:collateralManager/m1:isCollateralManagerAffliliated" />
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td class="label">
							iv. Is the cash collateral manager an affiliated
							person, or an
							affiliated person of an affiliated person, of the
							Fund?

						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:collateralManagers/m1:collateralManager/m1:isCollateralManagerAffliliated" />
							</xsl:call-template>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- Mockup table end -->
		<xsl:for-each select="m1:collateralManagers/m1:collateralManager">
			<table role="presentation">
				<tr>
					<td>
						Collateral Managers Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
				<tr>
					<td class="label">i. Full name of cash collateral manager:</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(@collateralManagerName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">ii. LEI, if any:</td>
					<td>
						<p>
							<div class="fakeBox2">
								<xsl:value-of select="string(@collateralManagerLei)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">
						iii. Is the cash collateral manager an affiliated
						person, or an
						affiliated person of an affiliated person, of a
						securities lending
						agent retained by the Fund?
					</td>
					<td>
						<span class="yesNo">
							<xsl:choose>
								<xsl:when test="count(@isCollateralManagerAffliliated) &gt; 0">
									<xsl:choose>
										<xsl:when test="string(@isCollateralManagerAffliliated) = 'Y'">
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											Yes
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											No
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="string(@isCollateralManagerAffliliated) = 'N'">
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											Yes
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											No
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									Yes
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									No
								</xsl:otherwise>
							</xsl:choose>
						</span>
					</td>
				</tr>
				<tr>
					<td class="label">
						iv. Is the cash collateral manager an affiliated
						person, or an
						affiliated person of an affiliated person, of the
						Fund?

					</td>
					<td>
						<span class="yesNo">
							<xsl:choose>
								<xsl:when
									test="count(@isCollateralManagerAffliliatedWithFund) &gt; 0">
									<xsl:choose>
										<xsl:when
											test="string(@isCollateralManagerAffliliatedWithFund) = 'Y'">
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											Yes
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											No
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when
											test="string(@isCollateralManagerAffliliatedWithFund) = 'N'">
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											Yes
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											No
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									Yes
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									No
								</xsl:otherwise>
							</xsl:choose>
						</span>
					</td>
				</tr>
			</table>
		</xsl:for-each>
		<br />
		<table role="presentation">
			<tr>
				<td class="label">e. Types of payments made to one or more
					securities
					lending agents and cash collateral managers (check all that
					apply):
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="m1:paymentToAgentManagers/m1:paymentToAgentManagerType = 'Revenue sharing split'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;i. Revenue sharing split&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:paymentToAgentManagers/m1:paymentToAgentManagerType ='Non-revenue sharing split (other than administrative fee)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;ii. Non-revenue sharing split (other than administrative
					fee)
					&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:paymentToAgentManagers/m1:paymentToAgentManagerType= 'Administrative fee'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;iii. Administrative fee&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:paymentToAgentManagers/m1:paymentToAgentManagerType= 'Cash collateral reinvestment fee'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;iv. Cash collateral reinvestment fee&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:paymentToAgentManagers/m1:paymentToAgentManagerType= 'Indemnification fee'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;v. Indemnification fee&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:paymentToAgentManagers/m1:paymentToAgentManagerType= 'Other'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;vi. Other &#160;
					<br />
					<xsl:choose>
						<xsl:when test="m1:paymentToAgentManagerType= 'N/A'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; N/A &#160;
					<br />
				</td>
			</tr>
	<xsl:choose>
		<xsl:when test="string(m1:paymentToAgentManagers/m1:otherFeeDesc) != ''">
			<tr>
				<td class="label">If other, describe:
				</td>
				<td>
					<p>
						<div class="fakeBox3">
							<xsl:value-of select="m1:paymentToAgentManagers/m1:otherFeeDesc" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
		</xsl:when>
	</xsl:choose>
			<tr>
				<td class="label">f. Provide the monthly average of the value of
					portfolio securities on loan during the reporting period
				</td>
				<td>
					<p>
						<div class="fakeBox5">
							<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="string(m1:avgPortfolioSecuritiesValue)" />
						</xsl:call-template>
						
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

			<tr>
				<td class="label">g. Provide the net income from securities
					lending
					activities
				</td>
				<td>
					<p>
						<div class="fakeBox5">
						<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="string(m1:netIncomeSecuritiesLending)" />
						</xsl:call-template>
<!-- 								<xsl:value-of select='string(m1:netIncomeSecuritiesLending)' /> -->
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="relianceCertainRules">
		<table role="presentation">
			<tr>
				<td class="label">Did the Fund rely on the following statutory 
				exemption or any of the rules under the Act during the reporting period? (check all that apply)
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 10f-3 (17 CFR 270.10f-3)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;a. Rule 10f-3 (17 CFR 270.10f-3) &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 12d1-1 (17 CFR 270.12d1-1)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;b. Rule 12d1-1 (17 CFR 270.12d1-1)&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 15a-4 (17 CFR 270.15a-4)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;c. Rule 15a-4 (17 CFR 270.15a-4) &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 17a-6 (17 CFR 270.17a-6)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;d. Rule 17a-6 (17 CFR 270.17a-6) &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 17a-7 (17 CFR 270.17a-7)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;e. Rule 17a-7 (17 CFR 270.17a-7)&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 17a-8 (17 CFR 270.17a-8)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;f. Rule 17a-8 (17 CFR 270.17a-8)&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 17e-1 (17 CFR 270.17e-1)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;g. Rule 17e-1 (17 CFR 270.17e-1)&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 22d-1 (17 CFR 270.22d-1)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;h. Rule 22d-1 (17 CFR 270.22d-1)&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 23c-1 (17 CFR 270.23c-1)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;i. Rule 23c-1 (17 CFR 270.23c-1) &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 32a-4 (17 CFR 270.32a-4)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;j. Rule 32a-4 (17 CFR 270.32a-4)&#160;
					<br />
					
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 6c-11 (17 CFR 270.6c-11)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;k. Rule 6c-11 (17 CFR 270.6c-11)&#160;
					<br />
					
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 12d1-4 (17 CFR 270.12d1-4)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;l. Rule 12d1-4 (17 CFR 270.12d1-4)&#160;
					<br />
					
					<xsl:choose>
						<xsl:when
							test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Section 12(d)(1)(G) of the Act (15 USC 80a-12(d)(1)(G))'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;m. Section 12(d)(1)(G) of the Act (15 USC 80a-12(d)(1)(G))&#160;
					<br />
					
					<xsl:choose>
						<xsl:when
								test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 18f-4 (17 CFR 270.18f-4)'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;n. Rule 18f-4 (17 CFR 270.18f-4)&#160;

					<table role="presentation">
						<tr>
							<td>
							</td>
							<td>
								<xsl:choose>
									<xsl:when
											test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 18f-4(c)(4) (17CFR 270.18f-4(c)(4))'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								&#160;i.
							</td>
							<td>
								Is the Fund excepted from the rule 18f-4 (17 CFR 270.18f-4)
								program requirement and limit on fund leverage risk under
								rule 18f-4(c)(4) (17CFR 270.18f-4(c)(4))?&#160;
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td>
								<xsl:choose>
									<xsl:when
											test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 18f-4(c)(2) (17 CFR 270.18f-4(c)(2))'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								&#160;ii.
							</td>
							<td>
								Is the Fund a leveraged/inverse fund that, under
								rule 18f-4(c)(5) (17 CFR 270.18f-4(c)(5)), is excepted from the
								requirement to comply with the limit on fund leverage risk described
								in rule 18f-4(c)(2) (17 CFR 270.18f-4(c)(2))?&#160;
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td>
								<xsl:choose>
									<xsl:when
											test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 18f-4(d)(i) (17 CFR 270.18f-4(d)(i))'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								&#160;iii.
							</td>
							<td>
								Did the Fund enter into any reverse repurchase agreements
								or similar financing transactions under
								rule 18f-4(d)(i) (17 CFR 270.18f-4(d)(i))?&#160;
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td>
								<xsl:choose>
									<xsl:when
											test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 18f-4(d)(ii) (17 CFR 270.18f-4(d)(ii))'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								&#160;iv.
							</td>
							<td>
								Did the Fund enter into any reverse repurchase
								agreements or similar financing transactions under
								rule 18f-4(d)(ii) (17 CFR 270.18f-4(d)(ii))?&#160;
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td>
								<xsl:choose>
									<xsl:when
											test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 18f-4(e) (17 CFR 270.18f-4(e))'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								&#160;v.
							</td>
							<td>
								Did the Fund enter into any unfunded commitment agreements
								under rule 18f-4(e) (17 CFR 270.18f-4(e))?&#160;
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td>
								<xsl:choose>
									<xsl:when
											test="m1:relyOnRuleTypes/m1:relyOnRuleType = 'Rule 18f-4(f)(17 CFR 270.18f-4(f))'">
										<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								&#160;vi.
							</td>
							<td>
								Did the Fund invest in a security on a when-issued or
								forward-settling basis, or with a non-standard settlement cycle,
								in reliance on rule 18f-4(f) (17 CFR 270.18f-4(f))?&#160;
							</td>
						</tr>
					</table>

					<xsl:choose>
						<xsl:when test="m1:relyOnRuleType = 'N/A'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;N/A&#160;
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="expenseLimitations">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					Provide information concerning any direct or indirect limitations,
					waivers or reductions, on the level of expenses incurred by the
					fund during the reporting period. A limitation, for example, may
					be
					applied indirectly (such as when an adviser agrees to accept a
					reduced fee pursuant to a voluntary fee waiver) or it may apply
					only for a temporary period such as for a new fund in its start-up
					phase.
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">
					a. Did the Fund have an expense limitation
					arrangement
					in
					place during the reporting period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isExpenseLimitationInPlace) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isExpenseLimitationInPlace) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isExpenseLimitationInPlace) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
			<tr>
				<td class="label">
					b. Were any expenses of the Fund reduced or
					waived
					pursuant
					to an expense limitation arrangement during the
					reporting
					period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isExpenseReducedOrWaived) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isExpenseReducedOrWaived) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isExpenseReducedOrWaived) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
			<tr>
				<td class="label">
					c. Are the fees waived subject to recoupment?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isFeesWaivedRecoupable) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isFeesWaivedRecoupable) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isFeesWaivedRecoupable) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
			<tr>
				<td class="label">
					d. Were any expenses previously waived recouped
					during
					the
					period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isExpenseWaivedRecoupable) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isExpenseWaivedRecoupable) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isExpenseWaivedRecoupable) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="investmentAdvisers">
		<table role="presentation">
			<tr>
				<td> a. Provide the following information about each investment
					adviser (other than a sub-adviser) of the Fund:
				</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:investmentAdvisers/m1:investmentAdviser/m1:investmentAdviserName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							ii. SEC file number (
							<i>e.g., 801-</i>
							)
						</td>
						<td>
							<p>
								<div class="fakeBox2">
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii.CRD number</td>
						<td>
							<div class="fakeBox2">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
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
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:investmentAdviserHired/@isInvestmentAdviserHired" />
							</xsl:call-template>
						</td>
					</tr>

					<tr>
						<td class="label">1. If the investment adviser was hired
							during the
							reporting period, indicate the investment adviser's
							start
							date:
						</td>
						<td>
							<p>
								<div class="fakeBox">
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- Mockup table end -->

		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:investmentAdvisers/m1:investmentAdviser">
					<tr>
						<td>
							Investment Advisers Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:investmentAdviserName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							ii. SEC file number (
							<i>e.g., 801-</i>
							)
						</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:investmentAdviserFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii.CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:investmentAdviserCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:investmentAdviserLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:investmentAdviserStateCountry/@investmentAdviserState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:investmentAdviserStateCountry/@investmentAdviserCountry" />
									<xsl:with-param name="code2"
										select="m1:investmentAdviserCountry" />
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
							the
							reporting
							period?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when
										test="count(m1:investmentAdviserHired/@isInvestmentAdviserHired) &gt; 0 or count(m1:isInvestmentAdviserHired) &gt; 0">
										<xsl:choose>
											<xsl:when
												test="string(m1:investmentAdviserHired/@isInvestmentAdviserHired) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isInvestmentAdviserHired) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>
					<tr>
						<xsl:choose>
							<xsl:when
								test="string(m1:investmentAdviserHired/@isInvestmentAdviserHired) = 'Y'">
								<tr>
									<td class="label">1. If the investment adviser was hired
										during the
										reporting period, indicate the investment adviser's
										start
										date:
									</td>
									<td>
										<p>
											<div class="fakeBox">
												<xsl:value-of
													select="string(m1:investmentAdviserHired/m1:investmentAdviserStartDate)" />
												<span>
													<xsl:text>&#160;</xsl:text>
												</span>
											</div>
										</p>
									</td>
								</tr>
							</xsl:when>
						</xsl:choose>
					</tr>
				</xsl:for-each>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td> b. If an investment adviser (other than a sub- adviser) to the
					Fund was terminated during the reporting period, provide the
					following with respect to each investment adviser:
				</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:investmentAdvisersTerminated/m1:investmentAdviserTerminated/m1:investmentAdviserTerminatedName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">i. Full name</td>
						<td>
							<div class="fakeBox3">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							ii. SEC file number (
							<i>e.g., 801-</i>
							)
						</td>
						<td>
							<p>
								<div class="fakeBox2">
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox">
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vii. Termination date </td>
						<td>
							<p>
								<div class="fakeBox">
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>

		<!-- Mockup table end -->

		<table role="presentation">
			<tr>
				<xsl:for-each
					select="m1:investmentAdvisersTerminated/m1:investmentAdviserTerminated">
					<tr>
						<td>
							Investment Advisers Terminated Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:investmentAdviserTerminatedName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							ii. SEC file number (
							<i>e.g., 801-</i>
							)
						</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:investAdviserTerminatedFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:investAdviserTerminatedCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(m1:investAdviserTerminatedLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:investmentAdviserTerminatedStateCountry/@investmentAdviserTerminatedState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:investmentAdviserTerminatedStateCountry/@investmentAdviserTerminatedCountry" />
									<xsl:with-param name="code2"
										select="m1:investmentAdviserTerminatedCountry" />
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
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(m1:investAdviserTerminationDate)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</xsl:for-each>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td> c. For each sub-adviser to the Fund, provide the information
					requested:
				</td>
			</tr>
		</table>
	<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
	<xsl:choose>
		<xsl:when
			test="string(m1:subAdvisers/m1:subAdviser/m1:subAdviserName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name </td>
					<td>
						<div class="fakeBox3">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						ii. SEC file number (
						<i>e.g., 801-</i>
						), if applicable
					</td>
					<td>
						<p>
							<div class="fakeBox2">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">
						iii. CRD number</td>
					<td>
						<div class="fakeBox2">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. LEI, if any </td>
					<td>
						<p>
							<div class="fakeBox2">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">v. State, if applicable</td>
					<td>
						<div class="fakeBox">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">vi. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						vii. Is the sub-adviser an affiliated person
						of the
						Fund's
						investment
						adviser(s)?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="m1:subAdviserHired/@isSubAdviserHired" />
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
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="m1:subAdviserHired/@isSubAdviserHired" />
						</xsl:call-template>
						</td>
					</tr>				
			</table>
		</xsl:when>
	</xsl:choose>
    <!-- End mockup table -->	
    		
		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:subAdvisers/m1:subAdviser">
					<tr>
						<td>
							Sub Advisors Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:subAdviserName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							ii. SEC file number (
							<i>e.g., 801-</i>
							), if applicable
						</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:subAdviserFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:subAdviserCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:subAdviserLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:subAdviserStateCountry/@subAdviserState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:subAdviserStateCountry/@subAdviserCountry" />
									<xsl:with-param name="code2" select="m1:subAdviserCountry" />
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
							of the
							Fund's
							investment
							adviser(s)?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isSubAdviserAffiliated) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isSubAdviserAffiliated) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isSubAdviserAffiliated) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>

					<tr>
						<td class="label">
							viii. Was the sub-adviser hired during the
							reporting
							period?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when
										test="count(m1:isSubAdviserHired) &gt; 0 or count(m1:subAdviserHired/@isSubAdviserHired) &gt; 0">
										<xsl:choose>
											<xsl:when
												test="string(m1:subAdviserHired/@isSubAdviserHired) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isSubAdviserHired) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>
					<tr>
						<xsl:choose>
							<xsl:when test="string(m1:subAdviserHired/@isSubAdviserHired) = 'Y'">
								<tr>
									<td class="label">1. If the sub-adviser was hired during the
										period,
										indicate the sub-adviser's start date:
									</td>
									<td>
										<p>
											<div class="fakeBox">
												<xsl:value-of
													select="string(m1:subAdviserHired/@subAdviserStartDate)" />
												<span>
													<xsl:text>&#160;</xsl:text>
												</span>
											</div>
										</p>
									</td>
								</tr>
							</xsl:when>
						</xsl:choose>
					</tr>
				</xsl:for-each>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>d. If a sub-adviser was terminated during the reporting period,
					provide the following with respect to such sub-adviser:
				</td>
			</tr>
		</table>
	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when
			test="string(m1:subAdvisersTerminated/m1:subAdviserTerminated/m1:subAdviserTerminatedName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name </td>
					<td>
						<div class="fakeBox3">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						ii. SEC file number (
						<i>e.g., 801-</i>
						)
					</td>
					<td>
						<p>
							<div class="fakeBox2">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">
						iii. CRD number</td>
					<td>
						<div class="fakeBox2">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. LEI, if any </td>
					<td>
						<p>
							<div class="fakeBox">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">v. State, if applicable</td>
					<td>
						<div class="fakeBox">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">vi. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">vii. Termination date </td>
					<td>
						<p>
							<div class="fakeBox">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!-- END mockup table -->		
		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:subAdvisersTerminated/m1:subAdviserTerminated">
					<tr>
						<td>
							SubAdvisors Terminated Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:subAdviserTerminatedName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							ii. SEC file number (
							<i>e.g., 801-</i>
							)
						</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:subAdviserTerminatedFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:subAdviserTerminatedCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(m1:subAdviserTerminatedLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:subAdviserTerminatedStateCountry/@subAdviserTerminatedState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:subAdviserTerminatedStateCountry/@subAdviserTerminatedCountry" />
									<xsl:with-param name="code2"
										select="m1:subAdviserTerminatedCountry" />
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
							<p>
								<div class="fakeBox">
									<xsl:value-of select="string(m1:subAdviserTerminationDate)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</xsl:for-each>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="TransferAgents">
		<table role="presentation">
			<tr>
				<td>a. Provide the following information about each person providing
					transfer agency services to the Fund:
				</td>
			</tr>
		</table>

	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when
			test="string(m1:transferAgents/m1:transferAgent/m1:transferAgentName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name </td>
					<td>
						<div class="fakeBox3">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						ii.SEC file number (
						<i>e.g., 84- or 85-</i>
						)
					</td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>

				<tr>
					<td class="label">iii. LEI, if any </td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">iv. State, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">v. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						vi. Is the transfer agent an affiliated
						person of the
						Fund
						or its
						investment adviser(s)?
					</td>
					<td>
						<span class="yesNo">
							<xsl:choose>
								<xsl:when test="count(m1:isTransferAgentAffiliated) &gt; 0">
									<xsl:choose>
										<xsl:when test="string(m1:isTransferAgentAffiliated) = 'Y'">
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											Yes
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											No
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="string(m1:isTransferAgentAffiliated) = 'N'">
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											Yes
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											No
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									Yes
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									No
								</xsl:otherwise>
							</xsl:choose>
						</span>
					</td>
				</tr>

				<tr>
					<td class="label">
						vii. Is the transfer agent a sub-transfer
						agent?
					</td>
					<td>
		<span class="yesNo">
			<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
			Yes
			<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
			No
		</span>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!--End mockup table -->	
		
		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:transferAgents/m1:transferAgent">
					<tr>
						<td>
							Transfer Agents Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:transferAgentName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							ii.SEC file number (
							<i>e.g., 84- or 85-</i>
							)
						</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:transferAgentFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>

					<tr>
						<td class="label">iii. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:transferAgentLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">iv. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:transferAgentStateCountry/@transferAgentState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">v. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:transferAgentStateCountry/@transferAgentCountry" />
									<xsl:with-param name="code2" select="m1:transferAgentCountry" />
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
							person of the
							Fund
							or its
							investment adviser(s)?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isTransferAgentAffiliated) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isTransferAgentAffiliated) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isTransferAgentAffiliated) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>

					<tr>
						<td class="label">
							vii. Is the transfer agent a sub-transfer
							agent?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isTransferAgentSubAgent) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isTransferAgentSubAgent) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isTransferAgentSubAgent) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>

				</xsl:for-each>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">
					b. Has a transfer agent been hired or
					terminated during
					the
					reporting period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isTransferAgentHiredOrTerminated) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isTransferAgentHiredOrTerminated) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isTransferAgentHiredOrTerminated) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="pricingServices">
	<table role="presentation">
		<tr>
			<td>
				a. Provide the following information about each person that provided
				pricing services to the Fund during the reporting period:
			</td>
		</tr>
	</table>

	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when
			test="string(m1:pricingServices/m1:pricingService/m1:pricingServiceName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name </td>
					<td>
						<div class="fakeBox3">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">ii. LEI, if any, or provide and describe other
						identifying number
					</td>
					<td>
						<p>
							<div class="fakeBox">
							</div>
						</p>
					</td>
				</tr>

				<tr>
					<td class="label">Description of other identifying number </td>
					<td>
						<p>
							<div class="fakeBox3">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">iii. State, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						v. Is the pricing service an affiliated person of the
						Fund or its
						investment adviser(s)?
					</td>
					<td>
						<span class="yesNo">
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							Yes
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							No
						</span>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!-- End mockup table -->	
		
		<table role="presentation">
			<xsl:for-each select="m1:pricingServices/m1:pricingService">
				<tr>
					<td>
						Pricing Services Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
				<tr>
					<td class="label">i. Full name </td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:pricingServiceName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">ii. LEI, if any, or provide and describe other
						identifying number
					</td>
					<td>
						<p>
							<div class="fakeBox">
								<xsl:value-of select="string(m1:pricingServiceLei)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>

				<tr>
					<td class="label">Description of other identifying number </td>
					<td>
						<p>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:pricingServiceIdNumberDesc)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">iii. State, if applicable</td>
					<td>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(m1:pricingServiceStateCountry/@pricingServiceState)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
							<xsl:call-template name="condCountryDescription">
								<xsl:with-param name="code1"
									select="m1:pricingServiceStateCountry/@pricingServiceCountry" />
								<xsl:with-param name="code2" select="m1:pricingServiceCountry" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						v. Is the pricing service an affiliated person of the
						Fund or its
						investment adviser(s)?
					</td>
					<td>
						<span class="yesNo">
							<xsl:choose>
								<xsl:when test="count(m1:isPricingServiceAffiliated) &gt; 0">
									<xsl:choose>
										<xsl:when test="string(m1:isPricingServiceAffiliated) = 'Y'">
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											Yes
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											No
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="string(m1:isPricingServiceAffiliated) = 'N'">
											<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
											Yes
											<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
											No
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									Yes
									<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
									No
								</xsl:otherwise>
							</xsl:choose>
						</span>
					</td>
				</tr>
			</xsl:for-each>
		</table>

		<table role="presentation">

			<tr>
				<td class="label">
					b. Was a pricing service hired or terminated during the
					reporting
					period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isPricingServiceHiredOrTerminated) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isPricingServiceHiredOrTerminated) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isPricingServiceHiredOrTerminated) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="custodians">

		<table role="presentation">
			<tr>
				<td>a. Provide the following information about each person that
					provided custodial services to the Fund during the reporting
					period:
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:custodians/m1:custodian">
					<tr>
						<td>
							Custodians Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:custodianName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. LEI, if any</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:custodianLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>

					<tr>
						<td class="label">iii. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:custodianStateCountry/@custodianState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:custodianStateCountry/@custodianCountry" />
									<xsl:with-param name="code2" select="m1:custodianCountry" />
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
							the Fund
							or its
							investment adviser(s)?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isCustodianAffiliated) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isCustodianAffiliated) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isCustodianAffiliated) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>
					<tr>
						<td class="label">
							vi. Is the custodian a sub-custodian?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isSubCustodian) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isSubCustodian) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isSubCustodian) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>

					<tr>
						<td class="label">
							vii. With respect to the custodian, check
							below to
							indicate
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
												1.Bank - section 17(f)(1) (15 U.S.C. 80a-17(f)(1))
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												1.Bank - section 17(f)(1) (15 U.S.C. 80a-17(f)(1))
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Member national securities exchange - rule 17f-1 (17 CFR 270.17f-1)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												2.Member national securities exchange - rule 17f-1 (17 CFR
												270.17f-1)
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												2.Member national securities exchange - rule 17f-1 (17 CFR
												270.17f-1)
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Self - rule 17f-2 (17 CFR 270.17f-2)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												3.Self - rule 17f-2 (17 CFR 270.17f-2)
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												3.Self - rule 17f-2 (17 CFR 270.17f-2)
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Securities depository - rule 17f-4 (17 CFR 270.17f-4)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												4.Securities depository - rule 17f-4 (17 CFR 270.17f-4)
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												4.Securities depository - rule 17f-4 (17 CFR 270.17f-4)
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Foreign custodian - rule 17f-5 (17 CFR 270.17f-5)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												5.Foreign custodian - rule 17f-5 (17 CFR 270.17f-5)
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												5.Foreign custodian - rule 17f-5 (17 CFR 270.17f-5)
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Futures commission merchants and commodity clearing organizations - rule 17f-6 (17 CFR 270.17f-6)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												6.Futures commission merchants and commodity clearing
												organizations - rule 17f-6 (17 CFR 270.17f-6)
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												6.Futures commission merchants and commodity clearing
												organizations - rule 17f-6 (17 CFR 270.17f-6)
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Foreign securities depository - rule 17f-7 (17 CFR 270.17f-7)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												7.Foreign securities depository - rule 17f-7 (17 CFR
												270.17f-7)
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												7.Foreign securities depository - rule 17f-7 (17 CFR
												270.17f-7)
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:custodyType) = 'Insurance company sponsor - rule 26a-2 (17 CFR 270.26a-2)'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												8.Insurance company sponsor - rule 26a-2 (17 CFR 270.26a-2)
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												8.Insurance company sponsor - rule 26a-2 (17 CFR 270.26a-2)
												<br />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:custodyType) = 'Other'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												9.Other
												<br />
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												9.Other
												<br />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
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
										<xsl:value-of select="string(m1:otherCustodianDesc)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>


				</xsl:for-each>
			</tr>
		</table>
		<br />
		<table role="presentation">
			<tr>
				<td class="label">
					b. Has a custodian been hired or terminated during the
					reporting
					period?*
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isCustodianHiredOrTerminated) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isCustodianHiredOrTerminated) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isCustodianHiredOrTerminated) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>
		</table>


	</xsl:template>

	<xsl:template name="shareholderServicingAgents">

		<table role="presentation">
			<tr>
				<td>a. Provide the following information about each shareholder
					servicing agent of the Fund:
				</td>
			</tr>
		</table>

	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when
			test="string(m1:shareholderServicingAgents/m1:shareholderServicingAgent/m1:shareholderServiceAgentName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name </td>
					<td>
						<div class="fakeBox3">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">ii. LEI, if any, or provide and describe
						other
						identifying number</td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>

				<tr>
					<td class="label">Description of other identifying number </td>
					<td>
						<p>
							<div class="fakeBox3">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">iii. State, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						v. Is the shareholder servicing agent an
						affiliated
						person
						of the
						Fund or its investment adviser(s)?
					</td>
					<td>
						<span class="yesNo">
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							Yes
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							No
						</span>
					</td>
				</tr>

				<tr>
					<td class="label">
						vi. Is the shareholder servicing agent a
						sub-shareholder servicing agent?
					</td>
					<td>
						<span class="yesNo">
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							Yes
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							No
						</span>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!-- End mockup table -->		
			
		<table role="presentation">
			<tr>
				<xsl:for-each
					select="m1:shareholderServicingAgents/m1:shareholderServicingAgent">
					<tr>
						<td>
							Shareholder servicing agents Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:shareholderServiceAgentName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. LEI, if any, or provide and describe
							other
							identifying number</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:shareholderServiceAgentLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>

					<tr>
						<td class="label">Description of other identifying number </td>
						<td>
							<p>
								<div class="fakeBox3">
									<xsl:value-of select="string(m1:shareholderServiceIdNumberDesc)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">iii. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:shareholderServiceAgentStateCountry/@shareholderServiceAgentState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:shareholderServiceAgentStateCountry/@shareholderServiceAgentCountry" />
									<xsl:with-param name="code2"
										select="m1:shareholderServiceAgentCountry" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							v. Is the shareholder servicing agent an
							affiliated
							person
							of the
							Fund or its investment adviser(s)?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when
										test="count(m1:isShareholderServiceAgentAffiliated) &gt; 0">
										<xsl:choose>
											<xsl:when
												test="string(m1:isShareholderServiceAgentAffiliated) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:isShareholderServiceAgentAffiliated) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>

					<tr>
						<td class="label">
							vi. Is the shareholder servicing agent a
							sub-shareholder servicing agent?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isShareholderServiceAgentSubshare) &gt; 0">
										<xsl:choose>
											<xsl:when
												test="string(m1:isShareholderServiceAgentSubshare) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when
												test="string(m1:isShareholderServiceAgentSubshare) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>
				</xsl:for-each>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">
					b. Has a shareholder servicing agent been hired
					or
					terminated
					during the reporting period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isShareholderServiceHiredTerminated) &gt; 0">
								<xsl:choose>
									<xsl:when
										test="string(m1:isShareholderServiceHiredTerminated) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when
										test="string(m1:isShareholderServiceHiredTerminated) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

		</table>

	</xsl:template>

	<xsl:template name="thirdPartyAdministrators">

		<table role="presentation">
			<tr>
				<td>a. Provide the following information about each administrator of
					the Fund:
				</td>
			</tr>
		</table>

	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when test="string(m1:admins/m1:admin/m1:adminName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name </td>
					<td>
						<div class="fakeBox3">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">ii. LEI, if any, or other identifying number </td>
					<td>
						<p>
							<div class="fakeBox3">
							</div>
						</p>
					</td>
				</tr>

				<tr>
					<td class="label">Description of other identifying number </td>
					<td>
						<p>
							<div class="fakeBox3">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">iii. State, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						v. Is the administrator an affiliated person of the
						Fund or its
						investment adviser(s)?
					</td>
					<td>
						<span class="yesNo">
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							Yes
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							No
						</span>
					</td>
				</tr>
				<tr>
					<td class="label">
						vi. Is the administrator a sub-administrator?
					</td>
					<td>
						<span class="yesNo">
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							Yes
							<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
							No
						</span>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!-- End mockup table -->		
		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:admins/m1:admin">
					<tr>
						<td>
							Administrators Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:adminName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. LEI, if any, or other identifying number </td>
						<td>
							<p>
								<div class="fakeBox3">
									<xsl:value-of select="string(m1:adminLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>

					<tr>
						<td class="label">Description of other identifying number </td>
						<td>
							<p>
								<div class="fakeBox3">
									<xsl:value-of select="string(m1:idNumberDesc)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">iii. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:adminStateCountry/@adminState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:adminStateCountry/@adminCountry" />
									<xsl:with-param name="code2" select="m1:adminCountry" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							v. Is the administrator an affiliated person of the
							Fund or its
							investment adviser(s)?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isAdminAffiliated) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isAdminAffiliated) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isAdminAffiliated) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>

					<tr>
						<td class="label">
							vi. Is the administrator a sub-administrator?
						</td>
						<td>
							<span class="yesNo">
								<xsl:choose>
									<xsl:when test="count(m1:isAdminSubAdmin) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(m1:isAdminSubAdmin) = 'Y'">
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												Yes
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												No
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(m1:isAdminSubAdmin) = 'N'">
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Yes
												<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
												No
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>

				</xsl:for-each>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">
					b.Has a third-party administrator been hired or
					terminated
					during the reporting period?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isAdminHiredOrTerminated) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isAdminHiredOrTerminated) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isAdminHiredOrTerminated) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

		</table>

	</xsl:template>

	<xsl:template name="afiliatedBrokerDealers">

		<table role="presentation">
			<tr>
				<td>Provide the following information about each affiliated
					broker-dealer:
				</td>
			</tr>
		</table>

	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when
			test="string(m1:brokerDealers/m1:brokerDealer/m1:brokerDealerName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">a. Full name </td>
					<td>
						<div class="fakeBox3">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">b. SEC file number</td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">
						c. CRD number</td>
					<td>
						<div class="fakeBox2">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">d. LEI, if any </td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">e. State, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">f. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">g. Total commissions paid to the affiliated
						broker-dealer for the reporting period:
					</td>
					<td>
						<p>
							<div class="fakeBox4">
							</div>
						</p>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!-- End mockup table -->
		
		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:brokerDealers/m1:brokerDealer">
					<tr>
						<td>
							Broker Dealers Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">a. Full name </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:brokerDealerName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">b. SEC file number</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:brokerDealerFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							c. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:brokerDealerCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">d. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:brokerDealerLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">e. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:brokerDealerStateCountry/@brokerDealerState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">f. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:brokerDealerStateCountry/@brokerDealerCountry" />
									<xsl:with-param name="code2" select="m1:brokerDealerCountry" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">g. Total commissions paid to the affiliated
							broker-dealer for the reporting period:
						</td>
						<td>
							<p>
								<div class="fakeBox5">
									<xsl:call-template name="format_to_dollar_large">
										<xsl:with-param name="money"
										select="string(m1:brokerDealerCommission)" />
									</xsl:call-template>
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</xsl:for-each>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="brokers">

		<table role="presentation">
			<tr>
				<td>
						<i>Instructions to Item C.16 and Item C.17.</i>
		<br />
		To help Registrants distinguish between agency and principal
		transactions, and to promote consistent reporting of the information
		required by these items, the following criteria should be used:
		<br />
		1. If a security is purchased or sold in a transaction for which the
		confirmation specifies the amount of the commission to be paid by the
		Registrant, the transaction should be considered an agency transaction
		and included in determining the answers to Item C.16.
		<br />
		2. If a security is purchased or sold in a transaction for which the
		confirmation specifies only the net amount to be paid or received by
		the Registrant and such net amount is equal to the market value of the
		security at the time of the transaction, the transaction should be
		considered a principal transaction and included in determining the
		amounts in Item C.17.
		<br />
		3. If a security is purchased by the Registrant in an underwritten
		offering, the acquisition should be considered a principal transaction
		and included in answering Item C.17 even though the Registrant has
		knowledge of the amount the underwriters are receiving from the issuer.
		<br />
		4. If a security is sold by the Registrant in a tender offer, the sale
		should be considered a principal transaction and included in answering
		Item C.17 even though the Registrant has knowledge of the amount the
		offeror is paying to soliciting brokers or dealers.
		<br />
		5. If a security is purchased directly from the issuer (such as a bank
		CD), the purchase should be considered a principal transaction and
		included in answering Item C.17.
		<br />
		6. The value of called or maturing securities should not be counted in
		either agency or principal transactions and should not be included in
		determining the amounts shown in Item C.16 and Item C.17. This means
		that the acquisition of a security may be included, but it is possible
		that its disposition may not be included. Disposition of a repurchase
		agreement at its expiration date should not be included.
		<br />
		7. The purchase or sales of securities in transactions not described in
		paragraphs (1) through (6) above should be evaluated by the Fund based
		upon the guidelines established in those paragraphs and classified
		accordingly. The agents considered in Item C.16 may be persons or
		companies not registered under the Exchange Act as securities brokers.
		The persons or companies from whom the investment company purchased or
		to whom it sold portfolio instruments on a principal basis may be
		persons or entities not registered under the Exchange Act as securities
		dealers. 
				</td>
			</tr>
		</table>
	<table role="presentation">
		<tr>
			<td>a. For each of the ten brokers that received the largest dollar
				amount of brokerage commissions (excluding dealer concessions in
				underwritings) by virtue of direct or indirect participation in the
				Fund’s portfolio transactions, provide the information below:
			</td>
		</tr>
	</table>

	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when test="string(m1:brokers/m1:broker/m1:brokerName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name of broker </td>
					<td>
						<div class="fakeBox3">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">ii. SEC file number</td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">
						iii. CRD number</td>
					<td>
						<div class="fakeBox2">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. LEI, if any </td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">v. State, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">vi. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">vii. Gross commissions paid by the Fund for
						the
						reporting period</td>
					<td>
						<p>
							<div class="fakeBox4">
							</div>
						</p>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!-- End mockup table -->
			
		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:brokers/m1:broker">
					<tr>
						<td>
							Brokers Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name of broker </td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:brokerName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. SEC file number</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:brokerFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:brokerCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any </td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:brokerLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:brokerStateCountry/@brokerState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:brokerStateCountry/@brokerCountry" />
									<xsl:with-param name="code2" select="m1:brokerCountry" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vii. Gross commissions paid by the Fund for
							the
							reporting period</td>
						<td>
							<p>
							  <div class="fakeBox5">
								<xsl:call-template name="format_to_dollar_large">
								<xsl:with-param name="money" select="m1:grossCommission" />
								</xsl:call-template>
							
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</xsl:for-each>
			</tr>
			<tr>
				<td class="label">b. Aggregate brokerage commissions paid by Fund
					during
					the reporting period:
				</td>
				<td>
					<p>
						<div class="fakeBox5">
						<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
						select="string(m1:aggregateCommission)" />
						</xsl:call-template>
					
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="principalTransactions">
	<table role="presentation">
		<tr>
			<td>
				a. For each of the ten entities acting as principals with which the
				Fund did the largest dollar amount of principal transactions
				(include
				all short-term obligations, and U.S. government and tax-free
				securities) in both the secondary market and in underwritten
				offerings,
				provide the information below:

			</td>
		</tr>
	</table>
	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<xsl:choose>
		<xsl:when
			test="string(m1:principalTransactions/m1:principalTransaction/m1:principalName) = ''">
			<table role="presentation">
				<tr>
					<td class="label">i. Full name of dealer</td>
					<td>
						<div class="fakeBox3">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">ii. SEC file number</td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">
						iii. CRD number</td>
					<td>
						<div class="fakeBox2">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">iv. LEI, if any</td>
					<td>
						<p>
							<div class="fakeBox2">
							</div>
						</p>
					</td>
				</tr>
				<tr>
					<td class="label">v. State, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">vi. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">vii. Total value of purchases and sales
						(excluding
						maturing securities) with Fund:
					</td>
					<td>
						<p>
							<div class="fakeBox4">
							</div>
						</p>
					</td>
				</tr>
			</table>
		</xsl:when>
	</xsl:choose>
	<!-- End mockup section -->	
	
		<table role="presentation">
			<tr>
				<xsl:for-each select="m1:principalTransactions/m1:principalTransaction">
					<tr>
						<td>
							Principal Transactions Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">i. Full name of dealer</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:principalName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">ii. SEC file number</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:principalFileNo)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">
							iii. CRD number</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:principalCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">iv. LEI, if any</td>
						<td>
							<p>
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:principalLei)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
					<tr>
						<td class="label">v. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:principalStateCountry/@principalState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vi. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:principalStateCountry/@principalCountry" />
									<xsl:with-param name="code2" select="m1:principalCountry" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">vii. Total value of purchases and sales
							(excluding
							maturing securities) with Fund:
						</td>
						<td>
							<p>
								<div class="fakeBox5">
								<xsl:call-template name="format_to_dollar_large">
								<xsl:with-param name="money"
								select="string(m1:principalTotalPurchaseSale)" />
								</xsl:call-template>
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</p>
						</td>
					</tr>
				</xsl:for-each>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">b. Aggregate value of principal purchase/sale
					transactions of Fund during the reporting period:
				</td>
				<td>
					<p>
						<div class="fakeBox5">
						<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
						select="string(m1:principalAggregatePurchase)" />
						</xsl:call-template>
											
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="paymentsBrokerageReaseach">
		<table role="presentation">
			<tr>
				<td class="label">
					During the reporting period, did the Fund pay
					commissions to
					broker-dealers for "brokerage and research services"
					within the
					meaning of section 28(e) of the Exchange Act (15 U.S.C.
					78bb)?
				</td>
				<td>
					<span class="yesNo">
						<xsl:choose>
							<xsl:when test="count(m1:isBrokerageResearchPayment) &gt; 0">
								<xsl:choose>
									<xsl:when test="string(m1:isBrokerageResearchPayment) = 'Y'">
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										Yes
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										No
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(m1:isBrokerageResearchPayment) = 'N'">
										<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
										Yes
										<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
										No
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								Yes
								<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
								No
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="averageNetAssets">
		<table role="presentation">
			<tr>
				<td class="label">a. Provide the Fund's (other than a money
					market fund's)
					monthly average net assets during the reporting
					period
				</td>
				<td>
					<p>
						<div class="fakeBox4">
						<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
						select="m1:mnthlyAvgNetAssets" />
						
						</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">b. Provide the money market fund's daily
					average net
					assets during the reporting period
				</td>
				<td>
					<p>
						<div class="fakeBox4">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money"
									select="string(m1:dailyAvgNetAssets)" />
						</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="linesOfCredit">

		<table role="presentation">
			<tr>For open-end management investment companies, respond to the
				following:</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">a. Does the Fund have available a line of credit?</td>

				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:hasLineOfCredit" />
						<xsl:with-param name="yesElement"
							select="m1:lineOfCredit/@hasLineOfCredit" />
					</xsl:call-template>
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<xsl:choose>
					<xsl:when test="string(m1:lineOfCredit/@hasLineOfCredit) = 'Y'">
						<tr>If yes, for each line of credit, provide the information
							requested below:</tr>

						<xsl:for-each
							select="m1:lineOfCredit/m1:lineOfCreditDetails/m1:lineOfCreditDetail">
							<tr>
								<td>
									Line of Credit details Record:
									<xsl:value-of select="position()"></xsl:value-of>
								</td>
							</tr>
							<tr>
								<td class="label">
									i. Is the line of credit a committed or uncommitted
									line of
									credit?
								</td>
								<td>
									<span class="yesNo">
										<xsl:choose>
											<xsl:when test="count(m1:isCreditLineCommitted) &gt; 0">
												<xsl:choose>
													<xsl:when test="string(m1:isCreditLineCommitted) = 'Committed'">
														<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
														Committed
														<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
														Uncommitted
													</xsl:when>
												</xsl:choose>
												<xsl:choose>
													<xsl:when
														test="string(m1:isCreditLineCommitted) = 'Uncommitted'">
														<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
														Committed
														<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
														Uncommitted
													</xsl:when>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Committed
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Uncommitted
											</xsl:otherwise>
										</xsl:choose>
									</span>
								</td>
							</tr>

							<tr>
								<td class="label">ii. What size is the line of credit?
								</td>
								<td>
									<p>
										<div class="fakeBox5">
										<xsl:call-template name="format_to_dollar_large">
										<xsl:with-param name="money"
											select="string(m1:lineOfCreditSize)" />
										</xsl:call-template>
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</p>
								</td>
							</tr>

							<tr>
								<td>iii. With which institution(s) is the line of credit?</td>
								<xsl:for-each
									select="m1:lineOfCreditInstitutions/m1:lineOfCreditInstitution">
									<tr>
										<td>
											Line Institutions Record:
											<xsl:value-of select="position()"></xsl:value-of>
										</td>
									</tr>
									<tr>
										<td class="label">Name of institution</td>
										<td>
											<div class="fakeBox3">
												<xsl:value-of select="string(@creditInstitutionName)" />
												<span>
													<xsl:text>&#160;</xsl:text>
												</span>
											</div>
										</td>
									</tr>
								</xsl:for-each>
							</tr>

							<tr>
								<td class="label">
									iv. Is the line of credit just for the Fund, or is
									it shared among
									multiple funds?
								</td>
								<td>
									<span class="yesNo">
										<xsl:choose>
											<xsl:when
												test="count(m1:soleCreditType/@creditType) &gt; 0 or count(m1:sharedCreditType/@creditType) &gt; 0">
												<xsl:choose>
													<xsl:when test="string(m1:soleCreditType/@creditType) = 'Sole'">
														<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
														Sole
														<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
														Shared
													</xsl:when>
												</xsl:choose>
												<xsl:choose>
													<xsl:when
														test="string(m1:sharedCreditType/@creditType) = 'Shared'">
														<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
														Sole
														<img src="/Images/radio-checked.jpg" alt="Radio button checked" />
														Shared
													</xsl:when>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Sole
												<img src="/Images/radio-unchecked.jpg" alt="Radio button not checked" />
												Shared
											</xsl:otherwise>
										</xsl:choose>
									</span>
								</td>
							</tr>

							<tr>
								<xsl:choose>
									<xsl:when test="string(m1:sharedCreditType/@creditType) = 'Shared'">
										<table role="presentation">
											<tr>1. If shared, list the names of other funds that may use
												the line of credit.</tr>
											<xsl:for-each select="m1:sharedCreditType/m1:creditUser">
												<tr>
													<td>
														Shared Credit Users Record:
														<xsl:value-of select="position()"></xsl:value-of>
													</td>
												</tr>
												<table role="presentation">
													<tr>
														<td class="label">Name of fund</td>
														<td>
															<div class="fakeBox3">
																<xsl:value-of select="string(@fundName)" />
																<span>
																	<xsl:text>&#160;</xsl:text>
																</span>
															</div>
														</td>
													</tr>

													<tr>
														<td class="label">
															SEC File number(
															<i>e.g., 811-</i>
															)
														</td>
														<td>
															<div class="fakeBox2">
																<xsl:value-of select="string(@secFileNo)" />
																<span>
																	<xsl:text>&#160;</xsl:text>
																</span>
															</div>
														</td>
													</tr>
												</table>
											</xsl:for-each>
										</table>
									</xsl:when>
								</xsl:choose>
							</tr>

							<tr>
								<td class="label">v. Did the Fund draw on the line of credit this
									period?</td>

								<td>
									
									<xsl:call-template name="condYesNoRadio">
									<xsl:with-param name="noElement" select="m1:isCreditLineUsed" />
									<xsl:with-param name="yesElement" select=" m1:creditLineUsed/@isCreditLineUsed" />
								</xsl:call-template>
									
								</td>
							</tr>
							<xsl:choose>
							<xsl:when test="string(m1:creditLineUsed/@isCreditLineUsed) = 'Y'">
							<tr>
								<td class="label">vi. If the fund drew on the line of credit during this period, what was the average amount outstanding when the line of credit was in use?
								</td>
								<td>
									<div class="fakeBox4">
										<xsl:call-template name="format_to_dollar_large">
										<xsl:with-param name="money"
											select="m1:creditLineUsed/@averageCreditLineUsed" />
										</xsl:call-template>
									
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">vii. If the fund drew on the line of credit during this period, what was the number of days that the line of credit was in use?
								</td>
								<td>
									<div class="fakeBox4">
										<xsl:value-of select="string(m1:creditLineUsed/@daysCreditUsed)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>
							<br />
							<br />
						
					</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</tr>
		</table>
		<br />
	<xsl:choose>
		<xsl:when test="string(m1:lineOfCredit/@hasLineOfCredit) = 'Y'">
          <xsl:call-template name="c20b" />
		</xsl:when>
		<xsl:when test="string(m1:lineOfCredit/@hasLineOfCredit) != 'Y'">
          <xsl:call-template name="c20b" />
		</xsl:when>		
	</xsl:choose>

	</xsl:template>
	<xsl:template name="c20b">				
			<table role="presentation">
				<tr>
					<td class="label">
						b. Did the Fund engage in interfund lending?
					</td>					
					<td>
						<xsl:call-template name="condYesNoRadio">
							<xsl:with-param name="noElement" select="m1:isInterfundLending" />
							<xsl:with-param name="yesElement"
								select="m1:interfundLendingDetails/@isInterfundLending" />
						</xsl:call-template>					
					</td>
					
				</tr>

				<tr>
					<xsl:choose>
						<xsl:when test="string(m1:interfundLendingDetails/@isInterfundLending) = 'Y'">
							<table role="presentation">
								<tr>If yes, for each loan provide the information requested
									below:
								</tr>
								<tr>
									<xsl:for-each select="m1:interfundLendingDetails/m1:interfundLending">
										<tr>
											<td class="label">i. What was the average amount of the
												interfund loan when the loan was outstanding?</td>
											<td>
												<div class="fakeBox5">
												<xsl:call-template name="format_to_dollar_large">
													<xsl:with-param name="money"
													select="@interfundLendingLoanAverage" />
													
												</xsl:call-template>
													
													<span>
														<xsl:text>&#160;</xsl:text>
													</span>
												</div>
											</td>
										</tr>

										<tr>
											<td class="label">ii. What was the number of days that
												the
												interfund loan was outstanding?
											</td>
											<td>
												<div class="fakeBox4">
													<xsl:value-of select="string(@interfundLendingDaysOutstanding)" />
													<span>
														<xsl:text>&#160;</xsl:text>
													</span>
												</div>
											</td>
										</tr>
									</xsl:for-each>
								</tr>
							</table>
						</xsl:when>
					</xsl:choose>
				</tr>
			</table>
			<br></br>
			<table role="presentation">
				<tr>
					<td class="label">
						c.Did the Fund engage in interfund borrowing?
					</td>
					<td>
						<xsl:call-template name="condYesNoRadio">
							<xsl:with-param name="noElement" select="m1:isInterfundBorrowing" />
							<xsl:with-param name="yesElement"
								select="m1:interfundBorrowingDetails/@isInterfundBorrowing" />
						</xsl:call-template>					
					</td>
				</tr>
		
				<tr>
					<xsl:choose>
						<xsl:when test="string(m1:interfundBorrowingDetails/@isInterfundBorrowing) = 'Y'">
							<table role="presentation">
								<tr>If yes, for each loan provide the information requested
									below:
								</tr>
								<tr>
									<xsl:for-each
										select="m1:interfundBorrowingDetails/m1:interfundBorrowing">
										<tr>
											<td class="label">i. What was the average amount of the
												interfund loan when the loan was outstanding?</td>
											<td>
												<div class="fakeBox5">
												<xsl:call-template name="format_to_dollar_large">
														<xsl:with-param name="money"
														select="@interfundBorrowingLoanAverage" />
													</xsl:call-template>
																										
													<span>
														<xsl:text>&#160;</xsl:text>
													</span>
												</div>
											</td>
										</tr>
		
										<tr>
											<td class="label">ii. What was the number of days that
												the
												interfund loan was outstanding?</td>
											<td>
												<div class="fakeBox4">
													<xsl:value-of select="@interfundBorrowingDaysOutstanding" />
													<span>
														<xsl:text>&#160;</xsl:text>
													</span>
												</div>
											</td>
										</tr>
									</xsl:for-each>
								</tr>
							</table>
						</xsl:when>
					</xsl:choose>
				</tr>
			</table>
     </xsl:template>
	<xsl:template name="swingPricing">

	<xsl:choose>
		<xsl:when
			test="string(m1:fundTypes/m1:fundType) = 'Inverse of a benchmark' or string(m1:fundTypes/m1:fundType) = 'Interval Fund' or string(m1:fundType) = 'N/A' 
                                                   or  string(m1:fundTypes/m1:fundType) = 'Fund of Funds' or  string(m1:fundTypes/m1:fundType) = 'Target Date Fund'
                                                   or  string(m1:fundTypes/m1:fundType) = 'Underlying fund' or  string(m1:fundTypes/m1:indexFundInfo/@fundType) = 'Index Fund'
                                                   or  string(m1:fundTypes/m1:masterFeederFundInfo/@fundType) = 'Master-Feeder Fund'">
			<h4>
				Item C.21. Swing pricing.
			</h4>
			<table role="presentation">

				<tr>
					<td> For open-end management investment companies, respond to the
						following:</td>
				</tr>
			</table>

			<table role="presentation">
				<tr>
					<td class="label">
						a. Did the Fund (if not a Money Market Fund,
						Exchange-Traded Fund, or Exchange-Traded Managed Fund) engage in
						swing pricing?
					</td>
					<td>
						<xsl:call-template name="condYesNoRadio">
							<xsl:with-param name="noElement" select="m1:isSwingPricing" />
							<xsl:with-param name="yesElement"
								select="m1:swingPricingDetail/@isSwingPricing" />
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<xsl:choose>
						<xsl:when test="string(m1:swingPricingDetail/@isSwingPricing) = 'Y'">
							<tr>
								<td class="label">i. If so, what was the swing factor upper limit?
								</td>
								<td>
									<div class="fakeBox4">
										<xsl:call-template name="format_to_dollar_large">
										<xsl:with-param name="money"
										select="string(m1:swingPricingDetail/@swingUpperLimit)" />
									</xsl:call-template>
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>
				</tr>

			</table>
		</xsl:when>
	</xsl:choose>
	</xsl:template>

	<xsl:template name="feederFund">
		<table role="presentation">
			<xsl:for-each select="m1:fundTypes/m1:masterFeederFundInfo/m1:feederFunds">
				<tr>
					<td>
						Feeder funds Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
				<tr>
					<td class="label">1. Full name</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(@feederFundName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td>2. For registered feeder funds:</td>
				</tr>
				<tr>
					<td class="label">A. Investment Company Act file number (e.g., 811-) </td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@regFeederFundFileNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">B. Series identification number, if any</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@regFeederFundSeriesIdNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">C. LEI of feeder fund</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@regFeederFundLei)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td>3. For unregistered feeder funds:</td>
				</tr>
				<tr>
					<td class="label">A. SEC file number of the feeder fund's investment
						adviser (e.g., 801-)
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@unregFeederFileNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">B. LEI of feeder fund, if any</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@unregFeederFundLei)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

			</xsl:for-each>
		</table>
		<br />

		<table role="presentation">
			<tr>
				<td>ii. If the Registrant is a feeder fund, then provide the
					information requested below with respect to a master fund
					registered under the Act:</td>
			</tr>
		</table>

		<table role="presentation">
			<xsl:for-each select="m1:fundTypes/m1:masterFeederFundInfo/m1:masterFunds">
				<tr>
					<td>
						Master funds Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">1. Full name</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(@masterFundName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">2. Investment Company Act file number (e.g., 811-) </td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@masterFundFileNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">3. SEC file number of the master fund's investment
						adviser</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@masterFundSECFileNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">4. LEI</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@masterFundLei)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

</xsl:stylesheet>