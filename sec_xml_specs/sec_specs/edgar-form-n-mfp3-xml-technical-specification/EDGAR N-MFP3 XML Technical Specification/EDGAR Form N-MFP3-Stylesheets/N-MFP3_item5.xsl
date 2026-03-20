<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/nmfp3"
	xmlns:ns3="http://www.sec.gov/edgar/nmfp3common">

	<xsl:template name="item5_partD">
		<xsl:for-each select="m1:dispositionOfPortfolioSecurities">
			<h3>Part D. Disposition of Portfolio Securities</h3>
			<table role="presentation">
				<tr>
					<td class="label">
						<b>Item D.1.</b>
						Disclose the gross market value of portfolio securities the money
						market fund sold or disposed of during the reporting period by
						category of investment. Do not include portfolio securities that
						the fund held until maturity. A money market fund that is a
						Government Money Market Fund or a tax exempt fund, as defined in
						rule 2a-7(a)(23) [17 CFR 270.2a-7(a)(23)], is not required to
						respond to Part D.
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td class="label">a. U.S. Treasury Debt, to the nearest cent</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:depositionUSTreasuryDebtAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:depositionUSTreasuryDebtAmt, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">b. U.S. Government Agency Debt (if categorized as
						coupon-paying notes), to the nearest cent</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:govtAgencyCouponPayingDebtAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:govtAgencyCouponPayingDebtAmt, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">c. U.S. Government Agency Debt (if categorized as
						no-coupon discount notes), to the nearest cent</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:govtAgencyNonCouponPayingDebtAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:govtAgencyNonCouponPayingDebtAmt, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">d. Non-U.S. Sovereign, Sub-Sovereign and
						Supra-National Debt, to the nearest cent
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:nonUSSovereignSupraNationalDebtAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:nonUSSovereignSupraNationalDebtAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">e. Certificate of Deposit, to the nearest cent </td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:certificateDepositAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:certificateDepositAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">f. Non-Negotiable Time Deposit, to the nearest cent </td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:nonNegotiableTimeDepositAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:nonNegotiableTimeDepositAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">g. Variable Rate Demand Note, to the nearest cent </td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:variableRateDemandNoteAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:variableRateDemandNoteAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">h. Other Municipal Security, to the nearest cent</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:otherMunicipalSecurityAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:otherMunicipalSecurityAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">i. Asset Backed Commercial Paper, to the nearest cent </td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:assetBackedCommercialPaperAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:assetBackedCommercialPaperAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">j. Other Asset Backed Securities, to the nearest cent </td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:otherAssetBackedSecuritiesAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:otherAssetBackedSecuritiesAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">k. U.S. Treasury Repurchase Agreement (if
						collateralized only by U.S. Treasuries (including Strips) and
						cash), to the nearest cent
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:usTreasuryRepurchaseAgreementAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:usTreasuryRepurchaseAgreementAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">l. U.S. Government Agency Repurchase Agreement
						(collateralized only by U.S. Government Agency securities, U.S.
						Treasuries, and cash), to the nearest cent
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:usGovtAgencyRepurchaseAgreementAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:usGovtAgencyRepurchaseAgreementAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">m. Other Repurchase Agreement (if collateral falls
						outside Treasury, Government Agency, and cash), to the nearest
						cent
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:otherRepurchaseAgreementAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:otherRepurchaseAgreementAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">n. Insurance Company Funding Agreement, to the nearest
						cent
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:insuranceCompanyFundAgreementAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:insuranceCompanyFundAgreementAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">o. Investment Company, to the nearest cent </td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:investmentCompanyAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:investmentCompanyAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">p. Financial Company Commercial Paper, to the nearest
						cent
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:financialCompanyCommercialAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:financialCompanyCommercialAmt, "$###,###,###,##0.00")' />
							</xsl:if>

						</div>
					</td>
				</tr>
				<tr>
					<td class="label">q. Non-Financial Company Commercial Paper, to the
						nearest cent
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:nonFinancialCompanyCommercialAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:nonFinancialCompanyCommercialAmt, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">r. Tender Option Bond, to the nearest cent</td>
					<td>
						<div class="fakeBox3">
							<xsl:if
								test="count(m1:tenderOptionBondAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:tenderOptionBondAmt, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">s. Other Instrument, to the nearest cent </td>
					<td>
						<div class="fakeBox3">
							<xsl:if test="count(m1:otherInstrumentAmt) &gt; 0">
								<xsl:value-of
									select='format-number(m1:otherInstrumentAmt, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">If <i>Other Instrument</i>, include a brief description </td>
					<td>
						<div class="fakeBox3">														
										<xsl:value-of select="m1:otherInstrumentBriefDescription" />			
						</div>
					</td>
				</tr>
			</table>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

