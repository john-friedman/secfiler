<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncen"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 6 templates -->
	<xsl:template name="PartF">

		<xsl:if test="$icType = 'N-3'">

			<br />
			<h4>Item F.13. Number of contracts.</h4>
			<xsl:call-template name="numberOfContracts" />
			<br />
			<h4>Item F.14. Information on the security issued through the
				separate
				account.</h4>
			<xsl:call-template name="informationSecurity" />
			<br />
			<h4>Item F.15. Reliance on rule 6c-7.</h4>
			<xsl:call-template name="relianceRule6C7" />
			<br />
			<h4>Item F.16. Reliance on rule 11a-2.</h4>
			<xsl:call-template name="relianceRule11A2" />

		</xsl:if>

		<xsl:if test="not($icType = 'N-3')">

			<h4>Item F.1. Depositor.</h4>
			<xsl:call-template name="depositor" />
			<br />
			<h4>Item F.2. Third-party administrator.</h4>
			<xsl:call-template name="thirdPartyAdministratorsUIT" />
			<br />
			<h4>Item F.3. Insurance company separate accounts.</h4>
			<xsl:call-template name="insuranceCompanySeparateAccounts" />

			<xsl:choose>
				<xsl:when
					test="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/@isRegistrantSeparateInsuranceAccount) = 'N'">
					<br />
					<h4>Item F.4. Sponsor.</h4>
					<xsl:call-template name="sponsor" />
					<br />
					<h4>Item F.5. Trustees.</h4>
					<xsl:call-template name="trustees" />
					<br />
					<h4>Item F.6. Securities Act registration.</h4>
					<xsl:call-template name="securitiesRegistration" />
					<br />
					<h4>Item F.7. New Series.</h4>
					<xsl:call-template name="newSeries" />
					<br />
					<h4>Item F.8. Series with a current prospectus.</h4>
					<xsl:call-template name="seriesCurrentProspectus" />
					<br />
					<h4>Item F.9. Number of existing series for which additional units
						were registered under the securities Act.</h4>
					<xsl:call-template name="numberExistingSeries" />
					<br />
					<h4>Item F.10. Value of units placed in portfolios of subsequent
						series.</h4>
					<xsl:call-template name="valueSubsequentSeries" />
					<br />
					<h4>Item F.11. Assets.</h4>
					<xsl:call-template name="assets" />

				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when
					test="string(m1:unitInvestmentTrust/m1:registrantSeparateInsuranceAccount/@isRegistrantSeparateInsuranceAccount) = 'Y'">
					<br />
					<h4>Item F.12. Series ID of separate account.</h4>
					<xsl:call-template name="seriesSeparateAccount" />
					<br />
					<h4>Item F.13. Number of contracts.</h4>
					<xsl:call-template name="numberOfContracts" />
					<br />
					<h4>Item F.14. Information on the security issued through the
						separate
						account.</h4>
					<xsl:call-template name="informationSecurity" />
					<br />
					<h4>Item F.15. Reliance on rule 6c-7.</h4>
					<xsl:call-template name="relianceRule6C7" />
					<br />
					<h4>Item F.16. Reliance on rule 11a-2.</h4>
					<xsl:call-template name="relianceRule11A2" />

				</xsl:when>
			</xsl:choose>
			<br />
			<h4>Item F.17. Divestments under section 13(c) of the Act.</h4>
			<xsl:call-template name="diversementsSection" />
			<br />
			<h4>Item F.18. Reliance on rule 12d1-4.</h4>
			<xsl:call-template name="reliance12d14Section" />
			<br />
			<h4>Item F.19. Reliance on section 12(d)(1)(G).</h4>
			<xsl:call-template name="reliance12d1gSection" />
		</xsl:if>

	</xsl:template>

	<xsl:template name="depositor">
		<table role="presentation">
			<tr>
				<td>Provide the following information about the depositor:</td>
			</tr>
		</table>
		<!-- This following table is the dummy section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:unitInvestmentTrust/m1:depositors/m1:depositor/m1:depositorName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">a. Full Name</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>
					<br />
					<tr>
						<td class="label">b. CRD number, if any</td>
						<td>

							<div class="fakeBox2">
							</div>

						</td>
					</tr>
					<br />
					<tr>
						<td class="label">c. LEI, if any</td>
						<td>

							<div class="fakeBox2">
							</div>

						</td>
					</tr>
					<br />
					<tr>
						<td class="label">d. State, if applicable</td>
						<td>
							<div class="fakeBox">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">e. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">f. Full Name of ultimate parent of depositor</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- End of dummy -->


		<xsl:for-each select="m1:unitInvestmentTrust/m1:depositors/m1:depositor">
			<table role="presentation">
				<tr>
					<tr>
						<td>
							Depositor Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>

					<tr>
						<td class="label">a. Full Name</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:depositorName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">b. CRD number, if any</td>
						<td>

							<div class="fakeBox2">
								<xsl:value-of select="string(m1:depositorCrdNo)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>

						</td>
					</tr>
					<tr>
						<td class="label">c. LEI, if any</td>
						<td>

							<div class="fakeBox2">
								<xsl:value-of select="string(m1:depositorLei)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>

						</td>
					</tr>
					<tr>
						<td class="label">d. State, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="stateDescription">
									<xsl:with-param name="stateCode"
										select="string(m1:depositorStateCountry/@depositorState)" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">e. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
								<xsl:call-template name="condCountryDescription">
									<xsl:with-param name="code1"
										select="m1:depositorStateCountry/@depositorCountry" />
									<xsl:with-param name="code2" select="m1:depositorCountry" />
								</xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">f. Full Name of ultimate parent of depositor</td>
						<td>

							<div class="fakeBox3">
								<xsl:value-of select="string(m1:depositorUltimateParentname)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>

						</td>
					</tr>
				</tr>
			</table>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="thirdPartyAdministratorsUIT">
		<table role="presentation">
			<tr>
				<td>a. Provide the following information about each administrator of
					the Fund:</td>
			</tr>
		</table>
		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:unitInvestmentTrust/m1:uitAdmins/m1:uitAdmin) = ''">
				<table role="presentation">
					<tr>
						<td class="label">i. Full Name</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">ii. LEI, if any, or provide and describe other
							identifying number</td>
						<td>

							<div class="fakeBox">
							</div>

						</td>
					</tr>

					<tr>
						<td class="label">Description of other identifying number</td>
						<td>

							<div class="fakeBox3">
							</div>

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
							v. Is the administrator an affiliated person of
							the
							Fund
							or depositor?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement" select="m1:isUitAdminAffiliated" />
							</xsl:call-template>
						</td>
					</tr>

					<tr>
						<td class="label">
							vi. Is the administrator a sub-administrator?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement" select="m1:isUitAdminSubAdmin" />
							</xsl:call-template>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- End of mockup table -->

		<xsl:for-each select="m1:unitInvestmentTrust/m1:uitAdmins/m1:uitAdmin">
			<table role="presentation">
				<tr>
					<td>
						UIT admin Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">i. Full Name</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:uitAdminName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">ii. LEI, if any, or provide and describe other
						identifying number</td>
					<td>

						<div class="fakeBox">
							<xsl:value-of select="string(m1:uitAdminLei)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>

				<tr>
					<td class="label">Description of other identifying number</td>
					<td>

						<div class="fakeBox3">
							<xsl:value-of select="string(m1:uitAdminDescOtherNumber)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>

				<tr>
					<td class="label">iii. State, if applicable</td>
					<td>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(m1:uitAdminStateCountry/@uitAdminState)" />
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
									select="m1:uitAdminStateCountry/@uitAdminCountry" />
								<xsl:with-param name="code2" select="m1:uitAdminCountry" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">
						v. Is the administrator an affiliated person of
						the
						Fund
						or depositor?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement" select="m1:isUitAdminAffiliated" />
						</xsl:call-template>
					</td>
				</tr>

				<tr>
					<td class="label">
						vi. Is the administrator a sub-administrator?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement" select="m1:isUitAdminSubAdmin" />
						</xsl:call-template>
					</td>
				</tr>
			</table>
		</xsl:for-each>

		<br />
		<table role="presentation">
			<tr>
				<td class="label">
					b. Has an administrator been hired or terminated
					during
					the reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:unitInvestmentTrust/m1:isUitAdminHiredTerminated" />
					</xsl:call-template>
				</td>
			</tr>

		</table>

	</xsl:template>

	<xsl:template name="insuranceCompanySeparateAccounts">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					If the answer to Item F.3 is yes, respond to Item F.12 through Item
					F.19. If the answer to Item F.3 is no, respond to Item F.4 through
					Item F.11, and Item F.17 through Item F.19.
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">
					Is the Registrant a separate account of an insurance
					company?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="yesElement"
							select="m1:unitInvestmentTrust/m1:registrantSeparateInsuranceAccount/@isRegistrantSeparateInsuranceAccount" />
						<xsl:with-param name="noElement"
							select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/@isRegistrantSeparateInsuranceAccount" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="sponsor">
		<table role="presentation">
			<tr>
				<td>Provide the following information about each sponsor:</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:sponsors/m1:sponsor/m1:sponsorName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">a. Full Name</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">b. CRD number, if any</td>
						<td>

							<div class="fakeBox2">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">c. LEI, if any</td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">d. State, if applicable</td>
						<td>
							<div class="fakeBox">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">e. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
							</div>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- End of Mockup table -->

		<xsl:for-each
			select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:sponsors/m1:sponsor">
			<table role="presentation">
				<tr>
					<td colspan="3">
						Sponsor Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">a. Full Name</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:sponsorName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">b. CRD number, if any</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="string(m1:sponsorCrdNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">c. LEI, if any</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="string(m1:sponsorLei)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">d. State, if applicable</td>
					<td>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(m1:sponsorStateCountry/@sponsorState)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">e. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
							<xsl:call-template name="condCountryDescription">
								<xsl:with-param name="code1"
									select="m1:sponsorStateCountry/@sponsorCountry" />
								<xsl:with-param name="code2" select="m1:sponsorCountry" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
			</table>
		</xsl:for-each>


	</xsl:template>

	<xsl:template name="trustees">
		<table role="presentation">
			<tr>
				<td>Provide the following information about each trustee:</td>
			</tr>
		</table>
		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:trustees/m1:trustee/m1:trusteeName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">a. Full Name</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">b. State, if applicable</td>
						<td>
							<div class="fakeBox">
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">c. Foreign country, if applicable</td>
						<td>
							<div class="fakeBox">
							</div>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- End of Mockup table -->

		<xsl:for-each
			select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:trustees/m1:trustee">
			<table role="presentation">
				<tr>
					<td colspan="3">
						Trustee Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">a. Full Name</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:trusteeName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">b. State, if applicable</td>
					<td>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(m1:trusteeStateCountry/@trusteeState)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">c. Foreign country, if applicable</td>
					<td>
						<div class="fakeBox">
							<xsl:call-template name="condCountryDescription">
								<xsl:with-param name="code1"
									select="m1:trusteeStateCountry/@trusteeCountry" />
								<xsl:with-param name="code2" select="m1:trusteeCountry" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
			</table>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="securitiesRegistration">
		<table role="presentation">
			<tr>
				<td class="label">a. Provide the number of series existing at the end of
					the reporting period that had outstanding securities registered under
					the Securities Act:
				</td>
				<td>
					<div class="fakeBox4">
						<xsl:value-of
							select="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:numOfExistingSeries)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td>b. Provide the CIK for each of these existing series:</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:seriesCIKs/m1:seriesCIK/@cik) = ''">
				<table role="presentation">
					<tr>
						<td class="label">Series CIK:
						</td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- End Mockup table -->

		<table role="presentation">
			<xsl:for-each
				select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:seriesCIKs/m1:seriesCIK">
				<tr>
					<td colspan="3">

						Series CIK Record:
						<xsl:value-of select="position()"></xsl:value-of>

					</td>
				</tr>
				<tr>
					<td class="label">Series CIK:
					</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="@cik" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
			</xsl:for-each>
		</table>

	</xsl:template>

	<xsl:template name="newSeries">
		<table role="presentation">
			<tr>
				<td class="label">a. Number of new series for which registration
					statements under the Securities Act became effective during the
					reporting period:
				</td>
				<td>
					<div class="fakeBox4">
						<xsl:value-of
							select="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:numOfNewSeriesRegistration)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">b. Total aggregate value of the portfolio securities on
					the date of deposit for the new series:
				</td>
				<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:newSeriesAggregateValue" />
						</xsl:call-template>	
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="seriesCurrentProspectus">
		<table role="presentation">
			<tr>
				<td class="label">Number of series for which a current prospectus was in
					existence at the end of the reporting period:
				</td>
				<td>
					<div class="fakeBox4">
						<xsl:value-of
							select="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:numOfSeriesCurrentProspectus)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="numberExistingSeries">
		<table role="presentation">
			<tr>
				<td class="label">a. Number of existing series for which additional units
					were registered under the Securities Act during the reporting
					period:
				</td>
				<td>
					<div class="fakeBox4">
						<xsl:value-of
							select="string(m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:numOfExistingSeriesAdditionalUnits)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">
					b. Total value of additional units:
				</td>
				<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:additionalUnitsTotalValue" />	
						</xsl:call-template>							
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="valueSubsequentSeries">
		<table role="presentation">
			<tr>
				<td class="label">Total value of units of prior series that were placed
					in the portfolios of subsequent series during the reporting period
					(the value of these units is to be measured on the date they were
					placed in the subsequent series):
				</td>
				<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:unitInPortfolioValue" />
						</xsl:call-template>							
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="assets">
		<table role="presentation">
			<tr>
				<td class="label">
					Provide the total assets of all series of the Registrant combined as of the end of the reporting period: 
				</td>
				<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="m1:unitInvestmentTrust/m1:notRegistrantSeparateInsuranceAccount/m1:totalAssetsSeries" />
						</xsl:call-template>								
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="seriesSeparateAccount">
		<table role="presentation">
			<tr>
				<td class="label">Series identification number:</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of
							select="string(m1:unitInvestmentTrust/m1:registrantSeparateInsuranceAccount/@separateAccountSeriesId)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="numberOfContracts">
		<table role="presentation">
			<tr>
				<td colspan="3">
					<i>Instruction.</i>
					In the case of group contracts, each participant
					certificate should
					be counted as an individual contract.
				</td>
			</tr>
			<tr>
				<td class="label">For each security that has a contract identification
					number assigned pursuant to rule 313 of Regulation S-T (17 CFR
					232.313), provide the number of individual contracts that are in
					force at the end of the reporting period:
				</td>
				<td>
					<div class="fakeBox4">
						<xsl:value-of select="string(m1:unitInvestmentTrust/m1:numOfContracts)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="informationSecurity">
		<table role="presentation">
			<tr>
				<td colspan="3">
					<i>Instruction.</i>
					In the case of group contracts, each participant
					certificate should
					be counted as an individual contract.
				</td>
			</tr>

			<tr>
				<td colspan="3">
					For each security that has a contract identification
					number
					assigned
					pursuant to rule 313 of Regulation S-T (17 CFR
					232.313),
					provide
					the following information as of the end of the
					reporting
					period:</td>
			</tr>
			<!-- This following table is the mockup section just to display the empty 
				section when there is no value -->
			<xsl:choose>
				<xsl:when
					test="string(m1:unitInvestmentTrust/m1:contractSecurities/m1:contractSecurity/@separateAccountSecurityName) = ''">
					<tr>
						<td class="label">a. Full name of the security: </td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">b. Contract identification number: </td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">c. Total assets attributable to the security: </td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">d. Number of contracts sold during the reporting
							period:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">e. Gross premiums received during the reporting
							period:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">f. Gross premiums received pursuant to section 1035
							exchanges:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">g. Number of contracts affected in connection with
							premiums paid in pursuant to section 1035 exchanges:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">h. Amount of contract value redeemed during the
							reporting period
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">i. Amount of contract value redeemed pursuant to
							section 1035 exchanges:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">j. Number of contracts affected in connection with
							contract value redeemed pursuant to section 1035 exchanges:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

				</xsl:when>
			</xsl:choose>
			<!-- End mockup table -->

			<xsl:for-each
				select="m1:unitInvestmentTrust/m1:contractSecurities/m1:contractSecurity">
				<tr>
					<td colspan="3">
						Contact security Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">a. Full name of the security: </td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(@separateAccountSecurityName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">b. Contract identification number: </td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@separateAccountContractId)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">c. Total assets attributable to the security: </td>
					<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="@separateAccountTotalAsset" />
                </xsl:call-template>								
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">d. Number of contracts sold during the reporting
						period:
					</td>
					<td>
						<div class="fakeBox4">
							<xsl:value-of select="string(@numContractsSold)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">e. Gross premiums received during the reporting
						period:
					</td>
					<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"  select="@grossPremiumReceived" />	
						</xsl:call-template>							
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">f. Gross premiums received pursuant to section 1035
						exchanges:
					</td>
					<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money" select="@grossPremiumReceivedSection1035" />
						</xsl:call-template>								
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">g. Number of contracts affected in connection with
						premiums paid in pursuant to section 1035 exchanges:
					</td>
					<td>
						<div class="fakeBox4">
							<xsl:value-of select="string(@numContractsAffected)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">h. Amount of contract value redeemed during the
						reporting period
					</td>
					<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"  select="@contractValueRedeemed" />	
						</xsl:call-template>							
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">i. Amount of contract value redeemed pursuant to
						section 1035 exchanges:
					</td>
					<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"  select="@contractValueRedeemedSection1035" />		
						</xsl:call-template>						
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">j. Number of contracts affected in connection with
						contract value redeemed pursuant to section 1035 exchanges:
					</td>
					<td>
						<div class="fakeBox4">
							<xsl:value-of select="string(@numContractsAffectedRedeemed)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="relianceRule6C7">
		<table role="presentation">
			<tr>
				<td class="label">
					Did the Registrant rely on rule 6c-7 under the Act (17
					CFR
					270.6c-7) during the reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:unitInvestmentTrust/m1:isRule6C7Reliance" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="relianceRule11A2">
		<table role="presentation">
			<tr>
				<td class="label">
					Did the Registrant rely on rule 11a-2 under the Act (17
					CFR 270.11a-2) during the reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:unitInvestmentTrust/m1:isRule11A2Reliance" />
					</xsl:call-template>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="diversementsSection">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					This item may be used by a unit investment
					trust that divested
					itself of securities in accordance with
					section 13(c). A unit
					investment trust is not required to include
					disclosure under this
					item; however, the limitation on civil,
					criminal, and administrative
					actions under section 13(c) does not
					apply with respect to a
					divestment that is not disclosed under
					this item.
					<br />
					If a unit investment trust divests itself of
					securities in
					accordance with section 13(c) during the period that
					begins on the
					fifth business day before the date of filing a
					report on Form N-CEN
					and ends on the date of filing, the unit
					investment trust may
					disclose the divestment in either the report
					or an amendment thereto
					that is filed not later than five business
					days after the date of
					filing the report.
					<br />
					For purposes of determining when a divestment
					should be reported
					under this item, if a unit investment trust
					divests its holdings in
					a particular security in a related series
					of transactions, the unit
					investment trust may deem the divestment
					to occur at the time of the
					final transaction in the series. In
					that case, the unit investment
					trust should report each
					transaction in the series on a single
					report on Form N-CEN, but
					should separately state each date on which
					securities were
					divested and the total number of shares or, for debt
					securities,
					principal amount divested, on each such date.
					<br />
					Item F.17 shall
					terminate one year after the first date on which all
					statutory
					provisions that underlie section 13(c) have terminated.
				</td>
			</tr>
		</table>

		<table role="presentation">

			<tr>
				<td colspan="3">

					a. If the Registrant has divested itself of
					securities in
					accordance
					with section 13(c) of the Act (15 U.S.C.
					80a-13(c)) since
					the end
					of the reporting period immediately prior to
					the current
					reporting
					period and before filing of the current report,
					disclose
					the
					information requested below for each such divested
					security:</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:unitInvestmentTrust/m1:divestments/m1:divestment/@divestmentSecurityName) = ''">
				<table role="presentation">
					<tr>
						<td class="label">i. Full name of the issuer </td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">ii. Ticker Symbol </td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">iii. CUSIP number</td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">iv. Total number of shares or, for debt securities,
							principal amount divested:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">v. Date that the securities were divested:
						</td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">vi. Name of the statute that added the provision of
							section 13(c) in accordance with which the securities were
							divested:
						</td>
						<td>
							<div class="fakeBox3">
							</div>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- End mockup table -->

		<table role="presentation">
			<xsl:for-each select="m1:unitInvestmentTrust/m1:divestments/m1:divestment">
				<tr>
					<td colspan="3">
						Divestment Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">i. Full name of the issuer </td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(@divestmentSecurityName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">ii. Ticker Symbol </td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@divestmentSecurityTickerSymbol)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">iii. CUSIP number</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@divestmentSecurityCusipNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">iv. Total number of shares or, for debt securities,
						principal amount divested:
					</td>
					<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"  select="string(@divestedNumShares)" />
						</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">v. Date that the securities were divested:
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@divestedDate)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">vi. Name of the statute that added the provision of
						section 13(c) in accordance with which the securities were
						divested:
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(@divestmentStatuteName)" />
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
				<td colspan="3">
					b. If the Registrant holds any securities of the
					issuer on the date
					of
					the filing, provide the information requested
					below:</td>
			</tr>
		</table>

		<!-- This following table is the mockup section just to display the empty 
			section when there is no value -->
		<xsl:choose>
			<xsl:when
				test="string(m1:unitInvestmentTrust/m1:registrantHeldSecurities/m1:registrantHeldSecurity/@registrantHeldSecurityTickerSymbol) = ''">
				<table role="presentation">
					<tr>
						<td class="label">i. Ticker Symbol </td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">ii. CUSIP number  </td>
						<td>
							<div class="fakeBox2">
							</div>
						</td>
					</tr>

					<tr>
						<td class="label">iii. Total number of shares or, for debt securities,
							principal amount held on the date of the filing:
						</td>
						<td>
							<div class="fakeBox4">
							</div>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- End mockup table -->

		<table role="presentation">
			<xsl:for-each
				select="m1:unitInvestmentTrust/m1:registrantHeldSecurities/m1:registrantHeldSecurity">
				<tr>
					<td colspan="3">
						Registrant held security Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">i. Ticker Symbol </td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@registrantHeldSecurityTickerSymbol)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">ii. CUSIP number  </td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(@registrantHoldsSecurityCusipNo)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="label">iii. Total number of shares or, for debt securities,
						principal amount held on the date of the filing:
					</td>
					<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"  select="string(@registrantNumShare)" />
						</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="reliance12d14Section">
		<table role="presentation">
			<tr>
				<td class="label">
					Did the Registrant rely on rule 12d1-4 under 
					the Act (17 CFR 270.12d1-4) during the reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:unitInvestmentTrust/m1:isRule12D1Dash4Reliance" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="reliance12d1gSection">
		<table role="presentation">
			<tr>
				<td class="label">
					Did the Registrant rely on the statutory exception in 
					section 12(d)(1)(G) of the Act (15 USC 80a-12(d)(1)(G)) during the reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:unitInvestmentTrust/m1:isRule12D1GReliance" />
					</xsl:call-template>
				</td>
			</tr>
		</table>

	</xsl:template>
</xsl:stylesheet>
