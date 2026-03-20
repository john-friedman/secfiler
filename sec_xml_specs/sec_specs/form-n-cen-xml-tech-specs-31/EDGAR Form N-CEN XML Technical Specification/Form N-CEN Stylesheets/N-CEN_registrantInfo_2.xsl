<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncen"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 1 templates -->
	<xsl:template name="PartB">
<br/>
		<h4>Item B.1. Background information.</h4>
		<xsl:call-template name="backgroundInfo" />
<br/>
		<h4>Item B.2. Address and telephone number of Registrant.</h4>
		<xsl:call-template name="addressTelephoneNumber" />
<br/>
		<h4>Item B.3. Location of books and records.</h4>
		<xsl:call-template name="locationBooksRecords" />
<br/>
		<h4>Item B.4. Initial or final filings.</h4>
		<xsl:call-template name="initialFinalFilings" />
<br/>
		<h4>Item B.5. Family of investment companies.</h4>
		<xsl:call-template name="familyInvestmentCompanies" />
<br/>
		<h4>Item B.6. Organization.</h4>
		<xsl:call-template name="organization" />
<br/>
		<h4>Item B.7. Securities Act registration.</h4>
		<xsl:call-template name="securitiesActRegistration" />
<br/>
		<h4>Item B.8. Directors.</h4>
		<xsl:call-template name="directors" />
<br/>
		<h4>Item B.9. Chief compliance officer.</h4>
		<xsl:call-template name="chiefComplianceOfficer" />
<br/>
		<h4>Item B.10. Matters for security holder vote.</h4>
		<xsl:call-template name="securityHolder" />
<br/>
		<h4>Item B.11. Legal proceeding.</h4>
		<xsl:call-template name="legalProceeding" />
<br/>
		<h4>Item B.12. Fidelity bond and insurance (management investment
			companies only).</h4>
		<xsl:call-template name="fidelityBondsInsurance" />
<br/>
		<h4>Item B.13. Directors and officers/errors and omissions insurance
			(management investment companies only).</h4>
		<xsl:call-template name="directorsOfficersErrors" />
<br/>
		<h4>Item B.14. Provision of financial support.</h4>
		<xsl:call-template name="provisionOfFinancialSupport" />
<br/>
		<h4>Item B.15. Exemptive orders.</h4>
		<xsl:call-template name="exemptiveOrders" />
<br/>
		<h4>Item B.16. Principal underwriters.</h4>
		<xsl:call-template name="principalUnderwriters" />
<br/>
		<h4>Item B.17. Independent public accountant.</h4>
		<xsl:call-template name="independentPublicAccountant" />
<br/>
		<h4>Item B.18. Report on internal control (management investment
			companies only).</h4>
		<xsl:call-template name="reportInternalControl" />
<br/>
		<h4>Item B.19. Audit opinion.</h4>
		<xsl:call-template name="auditOpinion" />
<br/>
		<h4>Item B.20. Change in valuation methods.</h4>
		<xsl:call-template name="changeValuationMethods" />
<br/>
		<h4>Item B.21. Change in accounting principles and practices.</h4>
		<xsl:call-template name="changeAccountingPrinciples" />
<br/>
	<xsl:if test="$icType = 'N-1A' or $icType = 'N-3'">
		<h4>Item B.22. Net asset value error corrections (open-end management
			investment companies only).</h4>
		<xsl:call-template name="netAssetValueError" />
<br/>
	</xsl:if>
	<xsl:if test="$icType = 'N-1A' or $icType = 'N-2' or $icType = 'N-3' or $icType = 'N-5'">
		<h4>Item B.23. Rule 19a-1 notice (management investment companies
			only).</h4>
		<xsl:call-template name="rule19A" />
<br/>
    </xsl:if>

	</xsl:template>

	<xsl:template name="backgroundInfo">

		<table role="presentation">
			<tr>
				<td class="label">a. Full name of Registrant</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:registrantInfo/m1:registrantFullName" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

			<tr>
				<td class="label">b.	Investment Company Act file number ( <i>e.g., 811-</i>)</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:registrantInfo/m1:investmentCompFileNo" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

			<tr>
				<td class="label">c. CIK</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:registrantInfo/m1:registrantCik" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>

			<tr>
				<td class="label">d. LEI</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of select="m1:registrantInfo/m1:registrantLei" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="addressTelephoneNumber">
		<table role="presentation">
			<tr>
				<td class="label">a. Street 1 </td>
				<td>

					<div class="fakeBox">
						<xsl:value-of
							select="string(m1:registrantInfo/m1:registrantstreet1)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">Street 2 </td>
				<td>

					<div class="fakeBox">
						<xsl:value-of
							select="string(m1:registrantInfo/m1:registrantstreet2)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">b. City </td>
				<td>

					<div class="fakeBox">
						<xsl:value-of
							select="string(m1:registrantInfo/m1:registrantcity)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">c.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:registrantInfo/m1:registrantstate)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">d.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:registrantInfo/m1:registrantcountry)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">e. Zip code and zip code extension, or foreign postal
					code</td>
				<td>

					<div align="left">
						<div class="fakeBox2">
							<xsl:value-of
								select="string(m1:registrantInfo/m1:registrantzipCode)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</div>

				</td>
			</tr>
			<tr>
				<td class="label">f. Telephone number (including country code if foreign)</td>
				<td>

					<div class="fakeBox2">
						<xsl:value-of
							select="string(m1:registrantInfo/m1:registrantphoneNumber)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>

				</td>
			</tr>
			<xsl:for-each
				select="m1:registrantInfo/m1:websites/m1:website">
				<tr>
					<td class="label">g. Public Website, if any</td>
					<td>

						<div align="left">
							<div class="fakeBox">
								<xsl:value-of select="string(@webpage)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
			</xsl:for-each>
		</table>

	</xsl:template>

	<xsl:template name="locationBooksRecords">

		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					Provide the requested information for each person
					maintaining
					physical possession of each account, book, or other
					document
					required to be maintained by section 31(a) of the Act (15
					U.S.C.
					80a-30(a)) and the rules under that section.
				</td>
			</tr>
			</table>
			
			<table role="presentation">

			<xsl:for-each select="m1:registrantInfo/m1:locationBooksRecords/m1:locationBooksRecord">
				<tr>
					<td>
							Location books Record:
							<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">a. Name of person (e.g., a custodian of records)</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:officeName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">b. Street 1 </td>
					<td>

						<div class="fakeBox">
							<xsl:value-of select="string(m1:officeAddress1)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">Street 2 </td>
					<td>

						<div class="fakeBox">
							<xsl:value-of select="string(m1:officeAddress2)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">c. City </td>
					<td>

						<div class="fakeBox">
							<xsl:value-of select="string(m1:officeCity)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
			<tr>
				<td class="label">d.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:officeStateCountry/@officeState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">e.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:officeStateCountry/@officeCountry" />
							<xsl:with-param name="code2" select="m1:officeCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
				<tr>
					<td class="label">f. Zip code and zip code extension, or foreign postal code</td>
					<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:officeRecordsZipCode)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
					</td>
				</tr>
				<tr>
					<td class="label">g. Telephone number (including country code if foreign)</td>
					<td>
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:officePhone)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
					</td>
				</tr>
				<tr>
					<td class="label">h. Briefly describe the books and records kept at this location:
					</td>
					<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:booksRecordsDesc)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="initialFinalFilings">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					Respond "yes" to Item B.4.b only if the Registrant has filed an application to deregister or will file an application to deregister before its next required filing on this form.
				</td>
			</tr>
		</table>
			
			<table role="presentation">
			<tr>
				<td class="label">a. Is this the first filing on this form by the Registrant?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:registrantInfo/m1:isRegistrantFirstFiling" />
					</xsl:call-template>
				</td>
			</tr>

			<tr>
				<td class="label">
					b. Is this the last filing on this form by the Registrant?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:registrantInfo/m1:isRegistrantLastFiling" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="familyInvestmentCompanies">

		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					"Family of investment companies" means, except for
					insurance company
					separate accounts, any two or more registered
					investment companies
					that (i) share the same investment adviser or
					principal underwriter;
					and (ii) hold themselves out to investors as
					related companies for
					purposes of investment and investor
					services.In responding to this
					item, all Registrants in the family
					of investment companies should
					report the name of the family of
					investment companies identically.
				</td>
			</tr>
			<tr>
				<td>
					Insurance company separate accounts that may not hold
					themselves
					out to investors as related companies (products) for
					purposes of
					investment and investor services should consider
					themselves part of
					the same family if the operational or accounting
					or control systems
					under which these entities function are
					substantially similar.
				</td>
			</tr>
			</table>
			
			<table role="presentation">

			<tr>
				<td class="label">
					a. Is the Registrant part of a family of
					investment
					companies?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement"	select="m1:registrantInfo/m1:isRegistrantFamilyInvComp" />
						<xsl:with-param name="yesElement"	select="m1:registrantInfo/m1:registrantFamilyInvComp/@isRegistrantFamilyInvComp" />
					</xsl:call-template>
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<xsl:choose>
					<xsl:when
						test="string(m1:registrantInfo/m1:registrantFamilyInvComp/@isRegistrantFamilyInvComp) = 'Y'">
						<td class="label">i. Full name of family of investment companies</td>
						<td>
							<div align="left">
								<div class="fakeBox3">
									<xsl:value-of
										select="string(m1:registrantInfo/m1:registrantFamilyInvComp/@familyInvCompFullName)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</div>
						</td>
					</xsl:when>
				</xsl:choose>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="organization">

		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					For Item B.6.a.i., the Registrant should include all Series that
					have been established by the Registrant
					and have shares outstanding
					(other than shares issued in connection
					with an initial investment
					to satisfy section 14(a)
					of the Act).
				</td>
			</tr>
		</table>	
			
      <table role="presentation">
			<tr>
				<td>
					Indicate the classification of the Registrant by
					checking the
					applicable item below.
				</td>
			</tr>
		</table>
		
		<table role="presentation">	
					<xsl:choose>
						<xsl:when
							test="string(m1:registrantInfo/m1:registrantClassificationType) = 'N-1A'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
					&#160;a. Open-end management investment company registered under the
					Act on Form N-1A&#160;
					<br />
							
												<tr>
						<td class="label">i. Total number of Series of the Registrant</td>
						<td>

							<div align="left">
								<div class="fakeBox2">
									<xsl:value-of select="string(m1:registrantInfo/m1:totalSeries)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</div>

						</td>
					</tr>

					<xsl:for-each select="m1:registrantInfo/m1:terminatedSeries/m1:terminatedSeriesInfo">
						<tr>
							<td colspan="3">ii. If a Series of the Registrant with a fiscal year end covered by the report was terminated during the reporting period, provide the following information:
					</td>
						</tr>
						<tr>
							<td colspan="3">
									Terminated Organization Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>

						<tr>
							<td class="label">i. Name of the Series</td>
							<td>

								<div align="left">
									<div class="fakeBox3">
										<xsl:value-of select="string(@seriesName)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>

							</td>
						</tr>
						<tr>
							<td class="label">ii. Series identification number</td>
							<td>

								<div align="left">
									<div class="fakeBox2">
										<xsl:value-of select="string(@seriesId)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>

							</td>
						</tr>
						<tr>
							<td class="label">iii. Date of termination (month/year)</td>
							<td>

								<div align="left">
									<div class="fakeBox2">
										<xsl:value-of select="string(@terminationDate)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>

							</td>
						</tr>
</xsl:for-each>
							
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
					&#160;a. Open-end management investment company registered under the
					Act on Form N-1A&#160;
					<br />
							
						</xsl:otherwise>
					</xsl:choose>

					<xsl:choose>
						<xsl:when
							test="string(m1:registrantInfo/m1:registrantClassificationType) = 'N-2'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;b. Closed-end management investment company registered under
					the Act on Form N-2 &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="string(m1:registrantInfo/m1:registrantClassificationType) = 'N-3'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
					&#160;c. Separate account offering variable annuity contracts which
					is registered under the Act as a management investment company on
					Form N-3&#160;
					<br />
					<tr>i. Registrants that indicate they are a management investment company registered under the Act on Form N-3, should respond to Item F.13 through Item F.16 of this Form in addition to the Parts required by General Instruction A of this Form. </tr>
							
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						&#160;c. Separate account offering variable annuity contracts which
					is registered under the Act as a management investment company on
					Form N-3&#160;
						</xsl:otherwise>
					</xsl:choose>
					<br />
					<xsl:choose>
						<xsl:when
							test="string(m1:registrantInfo/m1:registrantClassificationType) = 'N-4'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;d. Separate account offering variable annuity contracts which
					is registered under the Act as a unit investment trust on Form
					N-4&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="string(m1:registrantInfo/m1:registrantClassificationType) = 'N-5'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;e. Small business investment company registered under the Act
					on Form N-5&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="string(m1:registrantInfo/m1:registrantClassificationType) = 'N-6'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;f. Separate account offering variable insurance contracts
					which is registered under the Act as a unit investment trust on
					Form N-6&#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="string(m1:registrantInfo/m1:registrantClassificationType) = 'S-6'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;g. Unit investment trust registered under the Act on Form
					N-8B-2&#160;
					<br />

		</table>

	</xsl:template>

	<xsl:template name="securitiesActRegistration">
		<table role="presentation">
			<tr>
				<td class="label">
					Is the Registrant the issuer of a class
					of
					securities
					registered
					under the Securities Act of 1933
					("Securities
					Act")?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:registrantInfo/m1:isSecuritiesActRegistration" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="directors">
		<table role="presentation">
			<tr>
				<td>Provide the information requested below about each person serving as director of the Registrant (management investment companies only):
				</td>
			</tr>
		</table>	
			
<table role="presentation">
			<xsl:for-each select="m1:registrantInfo/m1:directors/m1:director">
				<tr>
					<td>
							Director Record:
							<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">a. Full Name</td>
					<td>
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:directorName)" />
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
								<xsl:value-of select="string(m1:crdNumber)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
					</td>
				</tr>
				<tr>
					<td class="label">
						c. Is the person an "interested person" of the Registrant as that term is defined in section 2(a)(19) of the Act (15 U.S.C. 80a-2(a)(19))?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="m1:isDirectorInterestedPerson" />
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="label">d. Investment Company Act file number of any other registered investment company for which the person also serves as a director (e.g., 811-)
					</td>
				</tr>
					<xsl:for-each select="m1:fileNumbers/m1:fileNumberInfo">
					<tr>
					<td>
							File Number Record:
							<xsl:value-of select="position()"></xsl:value-of>
					</td>
                    </tr>
					<tr>
					<td class="label">File Number Record:</td>					
                 <td>
							<div class="fakeBox2">
								<xsl:value-of select="string(@fileNumber)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
						</tr>
					</xsl:for-each>

			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="chiefComplianceOfficer">
		<table role="presentation">
			<tr>
				<td>
					Provide the information requested below about each person serving as chief compliance officer of the Registrant for purposes of rule 38a-1 (17 CFR 270.38a- 1):
				</td>
			</tr>
			</table>
			
			
			<xsl:for-each select="m1:registrantInfo/m1:chiefComplianceOfficers/m1:chiefComplianceOfficer">
			<table role="presentation">
				<tr>
					<td>
							Chief compliance officer Record:
							<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">a. Full Name</td>
					<td>
						<div align="left">
							<div class="fakeBox3">
								<xsl:value-of select="string(m1:ccoName)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">b. CRD Number, if any</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:crdNumber)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">c. Street Address 1</td>
					<td>

						<div class="fakeBox">
							<xsl:value-of select="string(m1:ccoStreet1)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">Street Address 2</td>
					<td>

						<div class="fakeBox">
							<xsl:value-of select="string(m1:ccoStreet2)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">d. City</td>
					<td>

						<div class="fakeBox">
							<xsl:value-of select="string(m1:ccoCity)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>

			<tr>
				<td class="label">e.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:ccoStateCountry/@ccoState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">f.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:ccoStateCountry/@ccoCountry" />
							<xsl:with-param name="code2" select="m1:ccoCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>


				<tr>
					<td class="label">g. Zip code and zip code extension, or foreign postal	code</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:ccoZipCode)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">h. Telephone number (including country code if foreign)</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:ccoPhone)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>

				<tr>
					<td class="label">
						i. Has the chief compliance officer
						changed
						since the
						last
						filing?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="m1:isCcoChangedSinceLastFiling" />
						</xsl:call-template>
					</td>
				</tr>

			</table>
			
			<table role="presentation">
						<tr>
							<td colspan="3">
							If the chief compliance officer is compensated or employed by any person other than the Registrant, or an affiliated person of the Registrant, for providing chief compliance officer services, provide: 
							</td>
						</tr>
			</table>			
						
						<xsl:for-each select="m1:ccoEmployers/m1:ccoEmployer">
						<table role="presentation">
							<tr>
								<td>
										CCO employer Record:
										<xsl:value-of select="position()"></xsl:value-of>
								</td>
							</tr>

							<tr>
								<td class="label">i. Name of the person</td>
								<td>

									<div align="left">
										<div class="fakeBox3">
											<xsl:value-of select="string(@ccoEmployerName)" />
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</div>

								</td>
							</tr>
							<tr>
								<td class="label">ii. Person's IRS Employer Identification Number</td>
								<td>

									<div align="left">
										<div class="fakeBox2">
											<xsl:value-of select="string(@ccoEmployerId)" />
											<span>
												<xsl:text>&#160;</xsl:text>
											</span>
										</div>
									</div>

								</td>
							</tr>
					</table>		
						</xsl:for-each>

			</xsl:for-each>

	</xsl:template>

	<xsl:template name="securityHolder">
		<table role="presentation">
				<tr>
				<td>
					<i>Instruction.</i>
					Registrants registered on Forms N-3, N-4 or N-6, should respond "yes" to this Item only if security holder votes were solicited on contract-level matters. 
				</td>
			</tr>
		</table>
			
		<table role="presentation">	
			<tr>
				<td class="label">
					Were any matters submitted by the
					Registrant for
					its
					security
					holders' vote during the reporting
					period?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:registrantInfo/m1:isRegistrantSubmittedMatter" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:securityMatterSeriesInfo/@isRegistrantSubmittedMatter" />
					</xsl:call-template>
				</td>
			</tr>


			<xsl:choose>
				<xsl:when
					test="string(m1:registrantInfo/m1:securityMatterSeriesInfo/@isRegistrantSubmittedMatter) = 'Y'">

					<tr>
						<td class="label">
							a. If yes, and to the extent the response relates
							only to	certain series of the Registrant,
							indicate the series
							involved:
							</td>
					</tr>
				<!-- This following table is the mockup section just to display the empty 
					section when there is no value -->
				<xsl:choose>
					<xsl:when
						test="string(m1:registrantInfo/m1:securityMatterSeriesInfo/m1:seriesInfo/@seriesName) = ''">
						<tr>
							<td class="label">1. Series name</td>
							<td>
			
								<div align="left">
									<div class="fakeBox3">
									</div>
								</div>
			
							</td>
						</tr>
						<tr>
							<td class="label">2. Series identification number</td>
							<td>
				
								<div align="left">
									<div class="fakeBox2">
									</div>
								</div>
				
							</td>
						</tr>			
					</xsl:when>
				</xsl:choose>
				<!-- End mockup table -->
					<xsl:for-each select="m1:registrantInfo/m1:securityMatterSeriesInfo/m1:seriesInfo">
						<tr>
							<td colspan="3">
									Security Matter Series info Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>
						<xsl:call-template name="seriesInfo" />
					</xsl:for-each>

				</xsl:when>

			</xsl:choose>
		</table>

	</xsl:template>

	<xsl:template name="legalProceeding">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
For purposes of this Item, the following proceedings should be described: (1) any bankruptcy, receivership or similar proceeding with respect to the Registrant or any of its significant subsidiaries; (2) any proceeding to which any director, officer or other affiliated person of the Registrant is a party adverse to the Registrant or any of its subsidiaries; and (3) any proceeding involving the revocation or suspension of the right of the Registrant to sell securities. 
				</td>
			</tr>
			</table>
			
      <table role="presentation">
			<tr>
				<td class="label">
					a. Have there been any material legal
					proceedings, other
					than
					routine litigation incidental to the
					business, to which the
					Registrant or any of its subsidiaries was a
					party or of which any
					of
					their property was the subject during the
					reporting period?
				</td>

				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement"	select="m1:registrantInfo/m1:isPreviousLegalProceeding" />
						<xsl:with-param name="yesElement"	select="m1:registrantInfo/m1:legalProceedingSeriesInfo/@isPreviousLegalProceeding" />
					</xsl:call-template>
				</td>
			</tr>
			</table>
			
			<xsl:choose>
				<xsl:when
					test="string(m1:registrantInfo/m1:legalProceedingSeriesInfo/@isPreviousLegalProceeding) = 'Y'">
<table role="presentation">
					<tr>
						<td>
							If yes, include the attachment required by Item G.1.a.i.
						</td>
					</tr>
							<br />
					<tr>
						<td>
							i. If yes, and to the extent the response relates only to
							certain	series of the Registrant, indicate the series involved:

						</td>
					</tr>
</table>

<table role="presentation">
					<xsl:for-each select="m1:registrantInfo/m1:legalProceedingSeriesInfo/m1:seriesInfo">
						<tr>
							<td>
									Legal proceeding series info Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>
						<xsl:call-template name="seriesInfo" />
					</xsl:for-each>
</table>
				</xsl:when>
			</xsl:choose>
<table role="presentation">
			<tr>
				<td class="label">
					b. Has any proceeding previously reported been terminated?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement"	select="m1:registrantInfo/m1:isPreviousProceedingTerminated" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:previousProceedingTerminated/@isPreviousProceedingTerminated" />
					</xsl:call-template>
				</td>
			</tr>
</table>


			<xsl:choose>
				<xsl:when
					test="string(m1:registrantInfo/m1:previousProceedingTerminated/@isPreviousProceedingTerminated) = 'Y'">
<table role="presentation">
					<tr>
						<td>
                   If yes, include the attachment required by Item G.1.a.i.
					   </td>
					</tr>   
							<br />
					<tr>
						<td>
							i. If yes, and to the extent the response relates only to
							certain	series of the Registrant, indicate the series involved:

						</td>
					</tr>
</table>

					<xsl:for-each select="m1:registrantInfo/m1:previousProceedingTerminated/m1:seriesInfo">
<table role="presentation">
						<tr>
							<td>
									Proceeding terminated series info Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>
						<xsl:call-template name="seriesInfo" />
</table>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>
	</xsl:template>

	<xsl:template name="fidelityBondsInsurance">
		<table role="presentation">
			<tr>
				<td class="label">
					a. Were any claims with respect to the
					Registrant
					filed
					under a fidelity bond (including, but not
					limited
					to, the fidelity
					insuring agreement of the bond)
					during the
					reporting period?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:registrantInfo/m1:isClaimFiled" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:claimFiled/@isClaimFiled" />
					</xsl:call-template>
				</td>
			</tr>

			<tr>
				<xsl:choose>
					<xsl:when test="string(m1:registrantInfo/m1:claimFiled/@isClaimFiled) = 'Y'">
						<td class="label">i. If yes, enter the aggregate dollar amount of
							claims filed:
						</td>
						<td>
				<div class="fakeBox3">
					<xsl:call-template name="format_to_dollar_large">
						<xsl:with-param name="money"						
							 select="m1:registrantInfo/m1:claimFiled/@totalClaimAmount" />
							 </xsl:call-template>
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>

						</td>
					</xsl:when>
				</xsl:choose>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="directorsOfficersErrors">
		<table role="presentation">
			<tr>
				<td class="label">
					a. Are the Registrant's officers or
					directors
					covered
					in
					their
					capacities as officers or directors under
					any
					directors
					and
					officers/errors and omissions insurance policy
					owned by
					the
					Registrant or anyone else?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:registrantInfo/m1:isCoveredByInsurancePolicy" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:coveredByInsurancePolicy/@isCoveredByInsurancePolicy" />
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<xsl:choose>
					<xsl:when
						test="string(m1:registrantInfo/m1:coveredByInsurancePolicy/@isCoveredByInsurancePolicy) = 'Y'">

						<td class="label">
							i. If yes, were any claims filed under the policy during the reporting period with respect to the Registrant?
						</td>
						<td>
							<xsl:call-template name="yesNoRadio">
								<xsl:with-param name="yesNoElement"
									select="m1:registrantInfo/m1:coveredByInsurancePolicy/@isClaimFiledDuringPeriod" />
							</xsl:call-template>
						</td>
					</xsl:when>
				</xsl:choose>
			</tr>

		</table>

	</xsl:template>

	<xsl:template name="provisionOfFinancialSupport">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					For purposes of this Item, a provision of financial support includes any (1) capital contribution, (2) purchase of a security from a Money Market Fund in reliance on rule 17a-9 under the Act (17 CFR 270.17a-9), (3) purchase of any defaulted or devalued security at fair value reasonably intended to increase or stabilize the value or liquidity of the Registrant's portfolio, (4) execution of letter of credit or letter of indemnity, (5) capital support agreement (whether or not the Registrant ultimately received support), (6) performance guarantee, or (7) other similar action reasonably intended to increase or stabilize the value or liquidity of the Registrant's portfolio. Provision of financial support does not include any (1) routine waiver of fees or reimbursement of Registrant's expenses, (2) routine inter-fund lending, (3) routine inter-fund purchases of Registrant's shares, or (4) action that would qualify as financial support as defined above, that the board of directors has otherwise determined not to be reasonably intended to increase or stabilize the value or liquidity of the Registrant's portfolio. 
				</td>
			</tr>
			</table>

<table role="presentation">
			<tr>
				<td class="label">
					Did an affiliated person, promoter, or principal underwriter of the Registrant, or an affiliated person of such a person, provide any form of financial support to the Registrant during the reporting period?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:registrantInfo/m1:isFinancialSupportDuringPeriod" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:financialSupportSeriesInfo/@isFinancialSupportDuringPeriod" />
					</xsl:call-template>
				</td>
			</tr>
</table>

			<xsl:choose>
				<xsl:when
					test="string(m1:registrantInfo/m1:financialSupportSeriesInfo/@isFinancialSupportDuringPeriod) = 'Y'">
<table role="presentation">
					<tr>
						<td>

							If yes, include the attachment required by Item G.1.a.ii, unless the Registrant is a Money Market Fund.
							<br />
							a. If yes, and to the extent the response relates only to certain series of the Registrant, indicate the series involved: 

						</td>
					</tr>
</table>

					<xsl:for-each select="m1:registrantInfo/m1:financialSupportSeriesInfo/m1:seriesInfo">
					<table role="presentation">
						<tr>
							<td>
									Financial support series info Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>
					</table>
					
					<table role="presentation">
						<xsl:call-template name="seriesInfo" />
					</table>
						
					</xsl:for-each>

				</xsl:when>
			</xsl:choose>
	</xsl:template>

	<xsl:template name="exemptiveOrders">
		<table role="presentation">
			<tr>
				<td class="label">
					a. During the reporting period, did the Registrant rely on any orders from the Commission granting an exemption from one or more provisions of the Act, Securities Act or Exchange Act?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement"	select="m1:registrantInfo/m1:isExemptionFromAct" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:releaseNumbers/@isExemptionFromAct" />
					</xsl:call-template>
				</td>
			</tr>
			<xsl:choose>
				<xsl:when test="string(m1:registrantInfo/m1:releaseNumbers/@isExemptionFromAct) = 'Y'">
					<xsl:for-each select="m1:registrantInfo/m1:releaseNumbers/m1:releaseNumberInfo">
						<tr>
							<td>
									Release number Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>

						<tr>
							<td class="label">i. If yes, provide below the release number for each order 
					</td>
							<td>

								<div class="fakeBox3">
									<xsl:value-of select="string(@releaseNumber)" />
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

	<xsl:template name="principalUnderwriters">
		<table role="presentation">
			<tr>
				<td>a. Provide the information requested below about each principal underwriter:</td>
			</tr>
		</table>
		
   <!-- This following table is the mockup section just to display the empty section when there is no value -->
      <table role="presentation">
		<xsl:choose>
			<xsl:when
				test="string(m1:registrantInfo/m1:principalUnderwriters/m1:principalUnderwriter/m1:principalUnderwriterName) = ''"> 
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
					<td class="label">ii. SEC file number (e.g., 8-)</td>
					<td>

						<div class="fakeBox2">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">iii. CRD number </td>
					<td>
						<div class="fakeBox2">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td>iv. Identifying number(s)</td>
				</tr>
				<tr>
					<td class="label">LEI</td>
					<td>
						<div align="left">
							<div class="fakeBox2">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">RSSD ID</td>
					<td>
						<div align="left">
							<div class="fakeBox2">
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</td>
				</tr>
			<tr>
				<td class="label">v.	State, if applicable</td>
				<td>
					<div class="fakeBox">
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
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>

				<tr>
					<td class="label">
						vii. Is the principal underwriter an affiliated person of the Registrant, or its investment adviser(s) or depositor?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="/m1:registrantInfo/m1:principalUnderwriters/m1:principalUnderwriter/m1:isPrincipalUnderwriterAffiliatedWithRegistrant" />
						</xsl:call-template>
					</td>
				</tr>				
		</xsl:when>
		</xsl:choose>		       
			<xsl:for-each select="m1:registrantInfo/m1:principalUnderwriters/m1:principalUnderwriter">
				<tr>
					<td>
							Principal underwriter Record:
							<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>

				<tr>
					<td class="label">i. Full name</td>
					<td>

						<div class="fakeBox3">
							<xsl:value-of select="string(m1:principalUnderwriterName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">ii. SEC file number (e.g., 8-)</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="string(m1:principalUnderwriterFileNumber)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">iii. CRD number </td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="string(m1:principalUnderwriterCrdNumber)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td>iv. Identifying number(s)</td>
				</tr>
				<tr>
					<td class="label">LEI</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:principalUnderwriterLei)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">RSSD ID</td>
					<td>

						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of select="string(m1:principalUnderwriterRssdId)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>

					</td>
				</tr>
			<tr>
				<td class="label">v.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:principalUnderWriterStateCountry/@principalUnderWriterState)" />
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
							<xsl:with-param name="code1" select="m1:principalUnderWriterStateCountry/@principalUnderWriterCountry" />
							<xsl:with-param name="code2" select="m1:principalUnderWriterCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>

				<tr>
					<td class="label">
						vii. Is the principal underwriter an affiliated person of the Registrant, or its investment adviser(s) or depositor?
					</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement"
								select="m1:isPrincipalUnderwriterAffiliatedWithRegistrant" />
						</xsl:call-template>
					</td>
				</tr>

			</xsl:for-each>

			<tr>
				<td class="label">
					b. Have any principal underwriters been hired or terminated during the reporting period?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:registrantInfo/m1:isUnderwriterHiredOrTerminated" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="independentPublicAccountant">
		<table role="presentation">
			<tr>
				<td>
					Provide the following information about each independent public accountant:
				</td>
			</tr>
		</table>
	<!-- This following table is the mockup section just to display the empty 
		section when there is no value -->
	<table role="presentation">
		<xsl:choose>
			<xsl:when
				test="string(m1:registrantInfo/m1:publicAccountants/m1:publicAccountant/m1:publicAccountantName) = ''">
				<tr>
					<td class="label">a. Full Name</td>
					<td>

						<div class="fakeBox3">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">b. PCAOB Number</td>
					<td>

						<div class="fakeBox2">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td>c. Identifying number(s)</td>
				</tr>
				<tr>
					<td class="label">LEI</td>
					<td>

						<div class="fakeBox2">
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">RSSD ID</td>
					<td>

						<div class="fakeBox2">
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
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

			</xsl:when>
		</xsl:choose>
	</table>  
 <!-- End mockup table --> 
  
       
      <table role="presentation">
			<xsl:for-each select="m1:registrantInfo/m1:publicAccountants/m1:publicAccountant">
				<tr>
					<td>
							Public accountant Record:
							<xsl:value-of select="position()"></xsl:value-of>
					</td>
				</tr>
				<tr>
					<td class="label">a. Full Name</td>
					<td>

						<div class="fakeBox3">
							<xsl:value-of select="string(m1:publicAccountantName)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">b. PCAOB Number</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="string(m1:pcaobNumber)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td>c. Identifying number(s)</td>
				</tr>
				<tr>
					<td class="label">LEI</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="string(m1:publicAccountantLei)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
				<tr>
					<td class="label">RSSD ID</td>
					<td>

						<div class="fakeBox2">
							<xsl:value-of select="string(m1:publicAccountantRssdId)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>

					</td>
				</tr>
			<tr>
				<td class="label">d.	State, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
								select="string(m1:publicAccountantStateCountry/@publicAccountantState)" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">e.	Foreign country, if applicable</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="condCountryDescription">
							<xsl:with-param name="code1" select="m1:publicAccountantStateCountry/@publicAccountantCountry" />
							<xsl:with-param name="code2" select="m1:publicAccountantCountry" />
						</xsl:call-template>
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			</xsl:for-each>
		</table>	
			
		<table>
			<tr>
					<td class="label">f. Has the independent public accountant changed since the last filing?</td>
					<td>
						<xsl:call-template name="yesNoRadio">
							<xsl:with-param name="yesNoElement" select="m1:registrantInfo/m1:isPublicAccountantChanged" />
						</xsl:call-template>
					</td>
			</tr>	
		</table>
	</xsl:template>

	<xsl:template name="reportInternalControl">
		<table role="presentation">
			<tr>
				<td>
					<i>Instruction.</i>
					Small business investment companies are not
					required to respond to
					this item.
				</td>
			</tr>
		</table>	
		
		<table role="presentation">	
			<tr>

				<td class="label">
					For the reporting period, did an independent public accountant's report on internal control note any material weaknesses? 
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:registrantInfo/m1:isMaterialWeakness" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="auditOpinion">
		<table role="presentation">
			<tr>
				<td class="label">
					For the reporting period, did an
					independent
					public
					accountant issue an opinion other than an
					unqualified opinion
					with
					respect to its audit of the Registrant's
					financial statements?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:registrantInfo/m1:isOpinionOffered" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:auditOpinionSeries/@isOpinionOffered" />
					</xsl:call-template>
				</td>
			</tr>
          </table>

	<xsl:choose>
		<xsl:when
			test="string(m1:registrantInfo/m1:auditOpinionSeries/@isOpinionOffered) = 'Y'">
			<table role="presentation">
				<tr>
					<td>
						a. If yes, and to the extent the response relates
						only to
						certain series of the Registrant,
						indicate the series
						involved:
					</td>
				</tr>
				<!-- This following table is the mockup section just to display the empty 
					section when there is no value -->

				<xsl:choose>
					<xsl:when
						test="string(m1:registrantInfo/m1:auditOpinionSeries/m1:seriesInfo/@seriesName) = ''">
						<tr>
							<td class="label">1. Series name</td>
							<td>

								<div align="left">
									<div class="fakeBox3">
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>

							</td>
						</tr>

						<tr>
							<td class="label">2. Series identification number</td>
							<td>

								<div align="left">
									<div class="fakeBox2">
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>

							</td>
						</tr>

					</xsl:when>
				</xsl:choose>

				<!-- End mockup table -->
				<xsl:for-each
					select="m1:registrantInfo/m1:auditOpinionSeries/m1:seriesInfo">
					<tr>
						<td>
							Audit opinion series info Record:
							<xsl:value-of select="position()"></xsl:value-of>
						</td>
					</tr>
					<tr>
						<td class="label">1. Series name</td>
						<td>

							<div align="left">
								<div class="fakeBox3">
									<xsl:value-of select="string(@seriesName)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</div>

						</td>
					</tr>

					<tr>
						<td class="label">2. Series identification number</td>
						<td>

							<div align="left">
								<div class="fakeBox2">
									<xsl:value-of select="string(@seriesId)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>
							</div>

						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:when>
	</xsl:choose>
	

	</xsl:template>

	<xsl:template name="changeValuationMethods">
		<table role="presentation">
			<tr>
				<td colspan="3">
					<i>Instruction.</i>
					Responses to this item need not include changes to valuation techniques used for individual securities (e.g., changing from market approach to income approach for a private equity security). In responding to Item B.20.c., provide the applicable "asset type" category specified in Item C.4.a. of Form N-PORT. In responding to Item B.20.d., provide a brief description of the type of investments involved. If the change in valuation methods applies only to certain sub-asset types included in the response to Item B.20.c., please provide the sub-asset types in the response to Item B.20.d. The responses to Item B.20.c. and Item B.20.d. should be identical only if the change in valuation methods applies to all assets within that category. 
				</td>
			</tr>
			</table>
			
			<table role="presentation">
			<tr>
				<td class="label">
					Have there been material changes in the method of valuation (e.g., change from use of bid price to mid price for fixed income securities or change in trigger threshold for use of fair value factors on international equity securities) of the Registrant's assets during the reporting period?
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:registrantInfo/m1:isMaterialChange" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:valuationMethodsChanges/@isMaterialChange" />
					</xsl:call-template>
				</td>
			</tr>
			</table>

			<xsl:choose>
				<xsl:when test="string(m1:registrantInfo/m1:valuationMethodsChanges/@isMaterialChange) = 'Y'">
				<table role="presentation">
					<tr>
						<td>
							If yes, provide the following:
							</td>
					</tr>
				</table>	

					<xsl:for-each select="m1:registrantInfo/m1:valuationMethodsChanges/m1:valuationMethodsChange">
					<table role="presentation">
						<tr>
							<td>
									Valuation methods change Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>
					</table>
					
					<table role="presentation">
						<tr>
							<td class="label">a. Date of Change</td>
							<td>

								<div align="left">
									<div class="fakeBox2">
										<xsl:value-of select="string(m1:dateOfChange)" />
										<span>
											<xsl:text>&#160;</xsl:text>
										</span>
									</div>
								</div>

							</td>
						</tr>

						<tr>
							<td class="label">b. Explanation of the change</td>
							<td>

								<div class="fakeBox3">
									<xsl:value-of select="string(m1:changeExplanation)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>

							</td>
						</tr>
					</table>	
						
					<table role="presentation">
						<tr>
							<td class="label">c. Asset type involved </td>
							<td>
							<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Short-term investment vehicle'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;1. Short-term investment vehicle &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Repurchase agreement'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;2. Repurchase agreement&#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Equity-common'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;3. Equity-common &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Equity-preferred'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;4. Equity-preferred&#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Debt'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;5. Debt&#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Derivative-commodity'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;6. Derivative-commodity&#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Derivative-credit'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;7. Derivative-credit &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Derivative-equity'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;8. Derivative-equity &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Derivative-foreign exchange'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;9. Derivative-foreign exchange &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Derivative-interest rate'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;10. Derivative-interest rate&#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Derivative-other'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;11. Derivative-other&#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Structured note'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;12. Structured note &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Loan'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;13. Loan &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'ABS-mortgage backed security'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;14. ABS-mortgage backed security &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'ABS-asset backed commercial paper'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;15. ABS-asset backed commercial paper &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'ABS-collateralized bond/debt obligation'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;16. ABS-collateralized bond/debt obligation &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'ABS-other'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;17. ABS-other &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Commodity'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;18. Commodity &#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Real estate'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;19. Real estate&#160;
							<br />
							
														<xsl:choose>
								<xsl:when
									test="m1:assetType = 'Other'">
										<img
											src="Images/radio-checked.jpg"
											alt="Radio button checked" />
								</xsl:when>
								<xsl:otherwise>
										<img
											src="Images/radio-unchecked.jpg"
											alt="Radio button not checked" />
								</xsl:otherwise>
							</xsl:choose>
							&#160;20. Other&#160;
							<br />
							</td>
						</tr>
						</table>
						
						
						<table role="presentation">
						<xsl:choose>
								<xsl:when test="m1:assetType = 'Other'">
						<tr>
							<td class="label">If "other", provide a brief description</td>
							<td>

								<div class="fakeBox3">
									<xsl:value-of select="string(m1:assetTypeOtherDesc)" />
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
							<td class="label">d. Types of investments involved </td>
							<td>

								<div class="fakeBox3">
									<xsl:value-of select="string(m1:investmentType)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>

							</td>
						</tr>

						<tr>
							<td class="label">e. Statutory or regulatory basis, if any </td>
							<td>

								<div class="fakeBox3">
									<xsl:value-of select="string(m1:statutoryRegulatoryBasis)" />
									<span>
										<xsl:text>&#160;</xsl:text>
									</span>
								</div>

							</td>
						</tr>
					</table>
	
					<table role="presentation">
						<tr class="label">
							<td>f. To the extent the response relates only to certain series of the Registrant, indicate the series involved: </td>
						</tr>
					</table>

						<xsl:for-each select="m1:valuationMethodsChangeSeries/m1:seriesInfo">
					<table role="presentation">
							<tr>
								<td>
										Fund Record:
										<xsl:value-of select="position()"></xsl:value-of>
								</td>
							</tr>

							<xsl:call-template name="seriesInfo" />
					</table>		
						</xsl:for-each>

					</xsl:for-each>

				</xsl:when>

			</xsl:choose>

	</xsl:template>

	<xsl:template name="changeAccountingPrinciples">
		<table role="presentation">
			<tr>
				<td class="label">
					Have there been any changes in accounting principles or practices, or any change in the method of applying any such accounting principles or practices, which will materially affect the financial statements filed or to be filed for the current year with the Commission and which has not been previously reported?
				</td>
				<td>
					<xsl:call-template name="yesNoRadio">
						<xsl:with-param name="yesNoElement"
							select="m1:registrantInfo/m1:isAccountingPrincipleChange" />
					</xsl:call-template>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="netAssetValueError">
		<table role="presentation">
			<tr>
				<td class="label">
					a. During the reporting period, were any payments made to shareholders or shareholder accounts reprocessed as a result of an error in calculating the Registrant's net asset value (or net asset value per share)? 
				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement"	select="m1:registrantInfo/m1:isPaymentErrorInNetAssetValue" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:paymentErrorSeries/@isPaymentErrorInNetAssetValue" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
			
			<xsl:choose>
				<xsl:when
					test="string(m1:registrantInfo/m1:paymentErrorSeries/@isPaymentErrorInNetAssetValue) = 'Y'">
	
					<xsl:for-each select="m1:registrantInfo/m1:paymentErrorSeries/m1:seriesInfo">
					<table role="presentation">
						<tr>
							<td>
									Payment error series info Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>

						<tr>
							<td>
								a. If yes, and to the extent the response relates only to certain series of the Registrant, indicate the series involved: 
							</td>
						</tr>
						<xsl:call-template name="seriesInfo" />
						
					</table>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>

	</xsl:template>

	<xsl:template name="rule19A">
		<table role="presentation">
			<tr>
				<td class="label">
					During the reporting period, did the Registrant
					pay any
					dividend or make
					any distribution in the nature of a
					dividend
					payment,
					required to be accompanied by a written statement
					pursuant
					to section 19(a)
					of the Act (15 U.S.C. 80a-19(a)) and rule
					19a-1
					thereunder (17 CFR
					270.19a-1)? 

				</td>
				<td>
					<xsl:call-template name="condYesNoRadio">
						<xsl:with-param name="noElement" select="m1:registrantInfo/m1:isPaymentDividend" />
						<xsl:with-param name="yesElement" select="m1:registrantInfo/m1:paymentDividendSeries/@isPaymentDividend" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
			
			<xsl:choose>
				<xsl:when test="string(m1:registrantInfo/m1:paymentDividendSeries/@isPaymentDividend) = 'Y'">

					<xsl:for-each select="m1:registrantInfo/m1:paymentDividendSeries/m1:seriesInfo">
		<table role="presentation">
						<tr>
							<td>
									Payment dividend series info Record:
									<xsl:value-of select="position()"></xsl:value-of>
							</td>
						</tr>

						<tr>
							<td>
								a. If yes, and to the extent the response relates
								only to
								certain series of the Registrant,
								indicate the series
								involved: 
							</td>
						</tr>
								<tr>
   			<td class="label">i. Series name</td>
			<td>

				<div align="left">
					<div class="fakeBox3">
						<xsl:value-of select="string(@seriesName)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</div>

			</td>
		</tr>

		<tr>
			<td class="label">ii. Series identification number</td>
			<td>

				<div align="left">
					<div class="fakeBox2">
						<xsl:value-of select="string(@seriesId)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</div>

			</td>
		</tr>
</table>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>

	</xsl:template>

	<xsl:template name="seriesInfo">
		<tr>
			<td class="label">1. Series name</td>
			<td>

				<div align="left">
					<div class="fakeBox3">
						<xsl:value-of select="string(@seriesName)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</div>

			</td>
		</tr>

		<tr>
			<td class="label">2. Series identification number</td>
			<td>

				<div align="left">
					<div class="fakeBox2">
						<xsl:value-of select="string(@seriesId)" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</div>

			</td>
		</tr>
     
	</xsl:template>




</xsl:stylesheet>