<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/twentyfourf2filer"
	xmlns:ns1="http://www.sec.gov/edgar/common"
	xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes"
	xmlns:feecom="http://www.sec.gov/edgar/feecommon">

	<!-- Item 1 templates -->
	<xsl:template name="annualFilings">

		<xsl:call-template name="annualFiling" />

	</xsl:template>


	<xsl:template name="annualFiling">
		<table role="presentation">
			<tr>
				<td>
					<h4>
						<em>Form 24F-2 Annual Filing</em>
					</h4>
					Filers submitting a Form 24F-2 where the total fee due is based upon the
					aggregate
					net sales of all series and classes with the same fiscal year should
					only complete
					one copy of the form. To begin the form select "Add 24F-2 Form".
				</td>
			</tr>
			<tr>
				<td>
					Filers calculating fees on a class-by-class or series-by-series
					basis must complete a
					separate Form 24F-2 for each class or series. The application will allow
					you to create a
					separate form for each series or class within a single submission. Simply
					select "Add 24F-2 Form" to begin each additional form.
				</td>
			</tr>
			<tr>
				<td>
					Read instructions at end of Form before preparing Form. See
					"INSTRUCTIONS" link above.
				</td>
			</tr>
		</table>

		<xsl:for-each
			select="m1:annualFilings/m1:annualFilingInfo">
			<table role="presentation">
				<tr>
					Annual Filing Information Record:
					<xsl:value-of select="position()"></xsl:value-of>
				</tr>
			</table>

			<xsl:call-template name="Item1" />
			<br />

			<xsl:call-template name="Item2" />
			<br />

			<xsl:call-template name="Item3" />
			<br />

			<xsl:call-template name="Item4" />
			<br />

			<xsl:call-template name="Item5" />
			<br />

			<xsl:call-template name="Item6" />
			<br />

			<xsl:call-template name="Item7" />
			<br />

			<xsl:call-template name="Item8" />
			<br />

			<xsl:call-template name="Signature" />
			<br />

		</xsl:for-each>
	</xsl:template>

	<xsl:template name="Item1">
		<table role="presentation">
			<tr>
				<h4>
					<em>1. Name and address of issuer:</em>
				</h4>
			</tr>

			<tr>
				<td class="label">Name of Issuer</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item1/m1:nameOfIssuer)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">Street 1 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item1/m1:addressOfIssuer/m1:street1)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">Street 2 </td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item1/m1:addressOfIssuer/m1:street2)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">City</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item1/m1:addressOfIssuer/m1:city)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">State</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(m1:item1/m1:addressOfIssuer/m1:state)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">Country</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:call-template name="stateDescription">
								<xsl:with-param name="stateCode"
									select="string(m1:item1/m1:addressOfIssuer/m1:country)" />
							</xsl:call-template>
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">Zip code and zip code extension or foreign postal code</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox2">
								<xsl:value-of
									select="string(m1:item1/m1:addressOfIssuer/m1:zipCode)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="Item2">
		<table role="presentation">
			<tr>
				<h4>
					<em>2. The name and EDGAR identifier of each series or class of
						securities for which this Form is filed.  If the Form is being
						filed for all series and classes of securities of the issuer,
						check the box but do not list series or classes:</em>
				</h4>
			</tr>
		</table>
		<xsl:call-template name="Item2seriesclass" />
		<xsl:call-template name="Item2class" />
		<xsl:call-template name="Item2reportClassName" />

	</xsl:template>

	<xsl:template name="Item2seriesclass">
		<xsl:choose>

			<xsl:when
				test="string(m1:item2/m1:reportSeriesClass/m1:rptIncludeAllSeriesFlag) = 'true'">

				<table role="presentation">
					<tr>
						<td class="label">All?</td>
						<td>
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>

		<xsl:for-each
			select="m1:item2/m1:reportSeriesClass/m1:rptSeriesClassInfo">
			<table role="presentation">
				<tr>
					Series ID Record:
					<xsl:value-of select="position()"></xsl:value-of>
				</tr>
			</table>

			<table role="presentation">
				<tr>
					<td class="label">Series Name</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:seriesName" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">Series ID</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:seriesId" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>

			</table>

			<!-- test 1 -->

			<xsl:choose>
				<xsl:when test="string(m1:includeAllClassesFlag) = 'true'">
					<table role="presentation">
						<tr>
							<td class="label">All Classes?</td>
							<td>
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</td>
						</tr>
					</table>
				</xsl:when>
			</xsl:choose>
			<!-- test 1 end -->

			<xsl:for-each select="m1:classInfo">
				<table role="presentation">
					<tr>
						Class ID Record:
						<xsl:value-of select="position()"></xsl:value-of>
					</tr>
				</table>
				<table role="presentation">
					<tr>
						<td class="label">Class Name</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="m1:className" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">Class ID</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="m1:classId" />
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

	<xsl:template name="Item2class">
		<xsl:choose>
			<xsl:when
				test="string(m1:item2/m1:reportClass/m1:rptIncludeAllClassesFlag) = 'true'">
				<table role="presentation">
					<tr>
						<td class="label">All Classes?</td>
						<td>
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>

		<xsl:for-each
			select="m1:item2/m1:reportClass/m1:annualClassInfo">
			<table role="presentation">
				<tr>
					Class ID Record:
					<xsl:value-of select="position()"></xsl:value-of>
				</tr>
			</table>

			<table role="presentation">
				<tr>
					<td class="label">Class Name</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:className" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">Class ID</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:classId" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
			</table>
		</xsl:for-each>

	</xsl:template>


	<xsl:template name="Item2reportClassName">
		<xsl:choose>
			<xsl:when
				test="string(m1:item2/m1:reportClassName/m1:rptIncludeAllFlag) = 'true'">
				<table role="presentation">
					<tr>
						<td class="label">All?</td>
						<td>
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>

		<xsl:for-each
			select="m1:item2/m1:reportClassName/m1:annualClassNameInfo">
			<table role="presentation">
				<tr>
					Class Name Record:
					<xsl:value-of select="position()"></xsl:value-of>
				</tr>
			</table>

			<table role="presentation">
				<tr>
					<td class="label">Class Name</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:className" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
			</table>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="Item3">
		<table role="presentation">
			<tr>
				<td class="label">3. Investment Company Act File Number:</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of
							select="m1:item3/m1:investmentCompActFileNo" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>

		<xsl:for-each
			select="m1:item3/m1:securitiesActFileNumbers/m1:securitiesActFileNo">
			<table role="presentation">
				<tr>
					Securities Act File Number Record:
					<xsl:value-of select="position()"></xsl:value-of>
				</tr>
			</table>

			<table role="presentation">
				<tr>
					<td class="label">Securities Act File Number:</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:fileNumber" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</td>
				</tr>
			</table>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="Item4">
		<table role="presentation">
			<tr>
				<td class="label">4(a). Last day of fiscal year for which this Form is
					filed:</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of
							select="m1:item4/m1:lastDayOfFiscalYear" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">
					4(b). Check box if this Form is being filed late
					(i.e., more than 90 calendar days after the end of the issuer’s fiscal
					year).
					(See Instruction A.2)
					<br />
					<i>Note: If the Form is being filed late, interest must be paid on
						the registration fee due.</i>
				</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="m1:item4/m1:isThisFormBeingFiledLate = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg"
								alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr>
				<td class="label">4(c). Check box if this is the last time the issuer
					will be filing this Form.</td>
				<td>
					<xsl:choose>
						<xsl:when
							test="m1:item4/m1:isThisTheLastTimeIssuerFilingThisForm = 'true'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg"
								alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="Item5">
		<table role="presentation">
			<tr>
				<h4>
					<em>5. Calculation of registration fee (if calculating on a
						class-by-class or series-by- series basis,
						provide the EDGAR identifier for each such class or series):</em>
				</h4>
			</tr>

			<tr>
				<td class="label">Series or Class (Contract) ID</td>
				<td>
					<p>
						<div class="fakeBox2">
							<xsl:value-of
								select="string(m1:item5/m1:seriesOrClassId)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">(i) Aggregate sale price of securities sold during the
					fiscal year pursuant to section 24(f) or rule 456(e):</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item5/m1:aggregateSalePriceOfSecuritiesSold)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">(ii) Aggregate price of securities redeemed or
					repurchased during the fiscal year:</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item5/m1:aggregatePriceOfSecuritiesRedeemedOrRepurchasedInFiscalYear)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">
					(iii) Aggregate price of securities redeemed or repurchased during any prior
					fiscal year ending no earlier than the date the issuer became eligible to use
					this form that were not previously used to reduce registration fees payable to
					the Commission:
				</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item5/m1:aggregatePriceOfSecuritiesRedeemedOrRepurchasedAnyPrior)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">(iv) Total available redemption credits [add Items
					5(ii) and 5(iii)]:</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item5/m1:totalAvailableRedemptionCredits)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">(v) Net sales -- if Item 5(i)
					is greater than Item 5(iv) [subtract Item 5(iv) from Item 5(i)]:</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox">
								<xsl:value-of select="string(m1:item5/m1:netSales)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">(vi) Redemption credits available for use in future
					years -- if
					Item 5(i) is less than Item 5(iv) [subtract Item 5(iv) from Item 5(i)]:</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox">
								<xsl:value-of
									select="string(m1:item5/m1:redemptionCreditsAvailableForUseInFutureYears)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">(vii) Multiplier for determining registration fee (See
					Instruction C.9):</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox">
								<xsl:value-of
									select="string(m1:item5/m1:multiplierForDeterminingRegistrationFee)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
			<tr>
				<td class="label">(viii) Registration fee due [multiply Item 5(v) by Item
					5(vii)] (enter "0" if no fee is due):</td>
				<td>
					<p>
						<div align="left">
							<div class="fakeBox">
								<xsl:value-of
									select="string(m1:item5/m1:registrationFeeDue)" />
								<span>
									<xsl:text>&#160;</xsl:text>
								</span>
							</div>
						</div>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="Item6">
		<table role="presentation">
			<tr>
				<td class="label">6. Interest due -- if this Form is being filed more
					than 90 days after
					the end of the issuer’s fiscal year (see Instruction D):</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item6/m1:interestDue)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="Item7">
		<table role="presentation">
			<tr>
				<td class="label">
					7. Total of the amount of the registration fee due plus
					any interest due [Item 5(viii) plus Item 6]:
				</td>
				<td>
					<p>
						<div class="fakeBox">
							<xsl:value-of
								select="string(m1:item7/m1:totalOfRegistrationFeePlusAnyInterestDue)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="Item8">
		<table role="presentation">
			<tr>
				<td class="label">8. Explanatory Notes (if any):</td>
				<td>
					<p>
						<div class="fakeBox3">
							<xsl:value-of
								select="string(m1:item8/m1:explanatoryNotes)" />
							<span>
								<xsl:text>&#160;</xsl:text>
							</span>
						</div>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="Signature">
		<table role="presentation">
			<tr>
				<h4>
					<em>Signatures</em>
				</h4>
			</tr>
			<tr>
				<td>
					This report has been signed below by the following persons on
					behalf of the issuer
					and in the capacities and on the dates indicated. By (Signature and
					Title)*
				</td>
			</tr>
		</table>

		<table role="presentation">
			<tr>
				<td class="label">Name and Title</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="m1:signature/m1:nameAndTitle" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>

			<tr>
				<td class="label">Date</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="m1:signature/m1:signatureDate" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>

			<tr>
				<td class="label">Signature</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="m1:signature/m1:signature" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:include href="24F-2NT_State_Codes.xsl" />

</xsl:stylesheet>