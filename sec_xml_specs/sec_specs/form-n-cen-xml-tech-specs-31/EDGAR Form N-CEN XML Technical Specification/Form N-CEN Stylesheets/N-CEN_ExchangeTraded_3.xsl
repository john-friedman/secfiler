<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncen"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 5 templates -->
	<xsl:template name="PartE">
		<xsl:for-each select="m1:exchangeSeriesInfo/m1:exchangeTradedFund">
			<br />
			<table role="presentation">
				<tr>
					<td>
						Exchange Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
			</table>
			<br />
			<xsl:if test="$icType = 'N-1A' or $icType = 'N-2' or $icType = 'N-3'">
				<br />
				<table role="presentation">
					<tr>
						<td class="label">Fund Name</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="m1:fundName" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
				</table>
			</xsl:if>
			<br />
			<h4>Item E.1. Exchange.</h4>
			<xsl:call-template name="exchangeListed" />
			<br />
			<h4>Item E.2. Authorized participants.</h4>
			<xsl:call-template name="authorizedParticipants" />
			<br />
			<h4>Item E.3. Creation units.</h4>
			<xsl:call-template name="creationUnits" />
			<xsl:if test="$icType = 'S-6'">
				<br />
				<h4>Item E.4. Benchmark return difference (Unit Invest Trusts only).</h4>
				<xsl:call-template name="benchmarkReturnDifference" />
			</xsl:if>
			<br />
			<h4>Item E.5. In-Kind ETF.</h4>
			<xsl:call-template name="inKinETF" />

		</xsl:for-each>

	</xsl:template>

	<xsl:template name="exchangeListed">

		<table role="presentation">
			<xsl:for-each select="m1:securityExchanges/m1:securityExchange">
				<tr>
					<td>
						Security Exchanges Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
				<tr>
					<td class="label">a. Exchange where listed. Provide the name of the
						national securities exchange on which the Fund’s shares are
						listed:
					</td>
					<td>

						<div class="fakeBox3">
							<xsl:call-template name="exchangeDescription">
								<xsl:with-param name="exchangeCode"	select="string(@fundExchange)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">b. Ticker. Provide the Fund's ticker symbol:
					</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="@fundsTickerSymbol" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="authorizedParticipants">
		<table role="presentation">
			<tr>
				<td>
				<i>Instruction.</i>
					The term "authorized participant" means 
					a member or participant of a clearing agency registered with the Commission, 
					which has a written agreement with the Exchange-Traded Fund or Exchange-Traded Managed Fund or one of 
					its service providers that allows the authorized participant to place orders for the purchase and redemption of 
					creation units.
					
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>
					For each authorized participant of the Fund, provide
					the
					following information:
				</td>
			</tr>
		</table>

		<table role="presentation">
			<xsl:for-each select="m1:authorizedParticipants/m1:authorizedParticipant">
				<tr>
					<td>
						Authorized Participants Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
				<tr>
					<td class="label">a. Full Name</td>
					<td>

						<div class="fakeBox3">
							<xsl:value-of select="@authorizedParticipantName" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">b. SEC file number</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="@authorizedParticipantFileNo" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">c. CRD number</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="@authorizedParticipantCrdNo" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">d. LEI, if any</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="@authorizedParticipantLei" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">e. The dollar value of the Fund shares the
						authorized
						participant purchased from the Fund during the reporting
						period:
					</td>
					<td>

						<div class="fakeBox3">
							<xsl:call-template name="format_to_dollar_large">
								<xsl:with-param name="money"
									select="@authorizedParticipantPurchaseValue" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">f. The dollar value of the Fund shares the
						authorized
						participant redeemed during
						the reporting period:
					</td>
					<td>
					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money"
								select="@authorizedParticipantRedeemValue" />
						</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
			</xsl:for-each>
			<br />
		</table>

		<table role="presentation">
			<tr>
				<td class="label">
					g. Did the Fund require that an authorized participant post
					collateral to the Fund or
					any of its designated service providers
					in
					<br />
					connection with the
					purchase or
					redemption of Fund shares during
					the
					reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement" select="m1:isCollateralRequired" />
					</xsl:call-template>
				</td>
			</tr>


		</table>
	</xsl:template>

	<xsl:template name="creationUnits">
		<table role="presentation">
			<tr>
				<td>
					<i>Instructions.</i>
					The term “creation unit” means a specified number of
					Exchange-Traded Fund or Exchange-Traded Managed Fund shares that
					the fund will issue to (or redeem from) an authorized participant
					in exchange for the deposit (or delivery) of specified securities,
					positions, cash, and other assets or positions.
				</td>
			</tr>
		</table>
		<table role="presentation">
			<tr>
				<td>a. Number of Fund shares required to form a
					creation
					unit as of the last business day of the reporting period:</td>
			</tr>
		</table>
		<table role="presentation">
			<tr>
				<td class="label">(for purchases)</td>
				<td>
					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money" select="m1:creationUnitNumOfShares" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			 
			<tr>
				<td class="label">(for redemptions, if different)</td>
				<td>
					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money" select="m1:creationUnitRedeemedNumOfShares" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			
		</table>

		<table role="presentation">
			<tr>
				<td>b. Based on the dollar value paid for each creation unit
					purchased by authorized participants during the reporting period,
					provide:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">i. The average percentage of that value
					composed of cash:</td>
				<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:averagePercentagePurchased" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td class="label">ii. The standard deviation of the percentage of
					that
					value composed of cash:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:standardDeviationPurchased" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">iii. The average percentage of that value
					composed of
					non-cash assets and other positions exchanged on an
					"in-kind" basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:creationUnitPurchasedInKind" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">iv. The standard deviation of the percentage of
					that
					value composed
					of non-cash assets and other positions exchanged on
					an "in-kind"
					basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:creationUnitPurchasedSDInKind" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>c. Based on the dollar value paid for creation units redeemed by
					authorized participants during the reporting period, provide:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">i. The average percentage of that value
					composed of
					cash:</td>
				<td>

					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money" select="m1:averagePercentageRedeemed" />
						</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">ii. The standard deviation of the percentage of
					that
					value composed of cash:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:percentSDRedeemed" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">iii. The average percentage of that value
					composed of
					non-cash assets and other positions exchanged on an
					"in-kind" basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:creationUnitPercentageRedeemedInKind" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">iv. The standard deviation of the percentage of
					that
					value composed
					of non-cash assets and other positions exchanged on
					an "in-kind"
					basis:</td>
				<td>

					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money" select="m1:creationUnitSDRedeemedInKind" />
						</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>d. For creation units purchased by authorized
					participants during
					the reporting period, provide:</td>
			</tr>
		</table>


		<table role="presentation">
			<tr>
				<td>i. The average transaction fee charged to an
					authorized
					participant for transacting in the creation units,
					expressed as:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">1. Dollars per creation unit, if charged on
					that basis:</td>
				<td>

					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money"
								select="m1:creationUnitTransactionFeePerUnit" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">2. Dollars for one or more creation units
					purchased on
					the same day, if charged on that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:creationUnitTransactionFeeManyUnits" />
					</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">3. A percentage of the value of each creation
					unit, if
					charged on that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:creationUnitTransactionFeePercentagePerUnit" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>ii. The average transaction fee charged to an authorized
					participant for transacting in those creation units the
					consideration for which was fully or partially composed of cash,
					expressed as:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">1. Dollars per creation unit, if charged on
					that basis:</td>
				<td>

					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money"
								select="m1:creationUnitTransactionFeeCashPerUnit" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">2. Dollars for one or more creation units
					purchased on
					the same day, if charged on that basis:</td>
				<td>

					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money"
								select="m1:creationUnitTransactionFeeCashManyUnits" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">3. A percentage of the value of each creation
					unit, if
					charged on that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:creationUnitTransactionFeeCashPercentagePerUnit" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>e. For creation units redeemed by authorized
					participants during
					the reporting period, provide:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>i. The average transaction fee charged to an
					authorized
					participant for transacting in the creation units,
					expressed as:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">1. Dollars per creation unit, if charged on
					that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:purchaseCreationUnitDollarPerUnit" />
					</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">2. Dollars for one or more creation units
					redeemed on
					the same day, if charged on that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:purchaseCreationUnitDollarPerMoreUnits" />
					</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">3. A percentage of the value of each creation
					unit, if
					charged on that basis:</td>
				<td>

					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money"
								select="m1:purchaseCreationUnitDollarPercentagePerUnit" />
						</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>ii. The average transaction fee charged to an authorized
					participant for transacting in those creation units the
					consideration for which was fully or partially composed of cash,
					expressed as:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">1. Dollars per creation unit, if charged on
					that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:purchaseCreationUnitCashPerUnit" />
					</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">2. Dollars for one or more creation units
					redeemed on
					the same day, if charged on that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:purchaseCreationUnitCashPerMoreUnits" />
					</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">3. A percentage of the value of each creation
					unit, if
					charged on that basis:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"
							select="m1:purchaseCreationUnitCashPercentagePerUnit" />
					</xsl:call-template>
						%
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="benchmarkReturnDifference">
		<table role="presentation">
			<tr>
				<td>a. If the Fund is an Index Fund as defined in Item C.3 of this
					Form, provide the following information:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>i. Is the index whose performance the Fund
					tracks, constructed:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">1. By an affiliated person of the fund?</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement" select="m1:isByAffiliatedPerson" />
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td class="label">2. Exclusively for the fund?</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement" select="m1:isExclusiveFund" />
					</xsl:call-template>
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>ii. The annualized difference between the
					Fund’s total
					return
					during the reporting period
					and the index’s return during the
					reporting period (i.e., the Fund’s
					total return less the index’s
					return):
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">1. Before Fund fees and expenses:</td>
				<td>

					<div class="fakeBox3">
						<xsl:call-template name="format_to_dollar_large">
							<xsl:with-param name="money" select="m1:beforeFundFeesExpensesDiff" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">2. After Fund fees and expenses (i.e., net
					asset value):</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:afterFundFeesExpensesDiff" />
					</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>iii. The annualized standard deviation of the
					daily
					difference
					between the Fund’s total
					return and the index’s
					return
					during the
					reporting period:</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">1. Before Fund fees and expenses:</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:beforeFundFeesExpensesSd" />
					</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">2. After Fund fees and expenses (i.e., net
					asset value):</td>
				<td>

				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:afterFundFeesExpensesSd" />
					</xsl:call-template>	
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="inKinETF">
		<table role="presentation">
			<tr>
				<td class="label">Is the Fund an "In-Kind Exchange-Traded Fund"
					as defined
					in rule 22e-4 under the Act (17 CFR 270.22e-4)?</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement" select="m1:isInKindETF" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

</xsl:stylesheet>