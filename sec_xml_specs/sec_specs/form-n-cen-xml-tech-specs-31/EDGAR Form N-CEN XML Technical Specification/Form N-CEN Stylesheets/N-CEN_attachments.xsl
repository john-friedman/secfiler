<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/ncen"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon">

	<!-- Item 4 templates -->
	<xsl:template name="PartG">
		<h4>Item G.1a. Attachments.</h4>
		<xsl:call-template name="parta" />
		<xsl:if test="$icType = 'N-2' or $icType = 'N-5'">
			<h4>Item G.1b. Attachments.</h4>
			<xsl:call-template name="partb" />
		</xsl:if>
		<xsl:call-template name="instructionsG" />
		<xsl:if test="$icType = 'N-2' or $icType = 'N-5'">
			<xsl:call-template name="instructionsGb" />
		</xsl:if>
	</xsl:template>


	<xsl:template name="parta">
		<table role="presentation">
			<tr>
				<td class="label">Attachments applicable to all Registrants. All
					Registrants shall file the following attachments, as applicable,
					with the current report. Indicate the attachments filed with the
					current report by checking the applicable items below:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isLegalProceedings = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; i. Legal proceedings &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:attachmentsTab/m1:isProvisionFinancialSupport = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;ii. Provision of financial support &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:attachmentsTab/m1:isIPAReportInternalControl = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;iii. Independent public accountant's report on internal
					control (management investment companies other than small business
					investment companies only) &#160;
					<br />
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isChangeAccPrinciples = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;iv. Change in accounting principles and practices &#160;
					<br />
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isInfoRequiredEO = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;v. Information required to be filed pursuant to
					exemptive orders &#160;
					<br />
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isOtherInfoRequired = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;vi. Other information required to be included
					as an attachment pursuant to Commission rules and regulations&#160;
					<br />
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="partb">
		<table role="presentation">

			<tr>
				<td class="label">
					Attachments to be filed by closed-end management investment
					companies and small business investment
					<br />
					companies. Registrants shall file the following attachments, as
					applicable, with the current report. Indicate the
					<br />
					attachments filed with the current report by checking the
					applicable items below:
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isMaterialAmendments = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160; i. Material amendments to organizational documents &#160;
					<br />
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isInstDefiningRights = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;ii. Instruments defining the rights of the holders of any new
					or amended class of securities &#160;
					<br />
					<xsl:choose>
						<xsl:when
							test="m1:attachmentsTab/m1:isNewOrAmendedInvAdvContracts = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;iii. New or amended investment advisory contracts &#160;
					<br />
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isInfoItem405 = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;iv. Information called for by Item 405 of Regulation S-K
					&#160;
					<br />
					<xsl:choose>
						<xsl:when test="m1:attachmentsTab/m1:isCodeOfEthics = 'true'">
							<img src="/Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="/Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>
					&#160;v. Code of ethics (small business investment companies only)
					&#160;
					<br />

				</td>
			</tr>

		</table>

	</xsl:template>


	<xsl:template name="instructionsG">

		<br />
		<table role="presentation">
			<tr>
				<td>
					<i>Instructions.</i>
					<br />
					<br />
					1. Item G.1.a.i. Legal proceedings.
					<br />
					<br />
					(a) If the Registrant responded "YES" to Item B.11.a., provide a
					brief description of the proceedings. As part of the description,
					provide the case or docket number (if any), and the full names of
					the principal parties to the proceeding.
					<br />
					(b) If the Registrant responded "YES" to Item B.11.b., identify the
					proceeding and give its date of termination.
					<br />
					<br />
					2. Item G.1.a.ii. Provision of financial support. If the Registrant
					responded "YES" to Item B.14., provide the following information
					(unless the Registrant is a Money Market Fund):
					(a) Description of nature of support.
					<br />
					<br />
					(b) Person providing support.
					<br />
					<br />
					(c) Brief description of relationship between the person providing
					support and the Registrant.
					<br />
					<br />
					(d) Date support provided.
					<br />
					<br />
					(e) Amount of support.
					<br />
					<br />
					(f) Security supported (if applicable). Disclose the full name of
					the issuer, the title of the issue (including coupon or yield, if
					applicable) and at least two identifiers, if available (e.g., CIK,
					CUSIP, ISIN, LEI).
					<br />
					(g) Value of security supported on date support was initiated (if
					applicable).
					<br />
					<br />
					(h) Brief description of reason for support.
					<br />
					<br />
					(i) Term of support.
					<br />
					<br />
					(j) Brief description of any contractual restrictions relating to
					support.
					<br />
					<br />
					3. Item G.1.a.iii. Independent public accountant's report on
					internal control (management investment companies other than small
					business investment companies only). Each management investment
					company shall furnish a report of its independent public accountant
					on the company's system of internal accounting controls. The
					accountant's report shall be based on the review, study and
					evaluation of the accounting system, internal accounting controls,
					and procedures for safeguarding securities made during the audit of
					the financial statements for the reporting period. The report
					should disclose any material weaknesses in: (a) the accounting
					system; (b) system of internal accounting control; or (c)
					procedures for safeguarding securities which exist as of the end of
					the Registrant's fiscal year.
					<br />
					<br />
					The accountant's report shall be furnished as an exhibit to the
					form and shall: (1) be addressed to the Registrant's shareholders
					and board of directors; (2) be dated; (3) be signed manually; and
					(4) indicate the city and state where issued.
					<br />
					<br />
					Attachments that include a report that discloses a material
					weakness should include an indication by the Registrant of any
					corrective action taken or proposed.
					<br />
					<br />
					The fact that an accountant's report is attached to this form shall
					not be regarded as acknowledging any review of this form by the
					independent public accountant.
					<br />
					<br />
					4. Item G.1.a.iv. Change in accounting principles and practices. If
					the Registrant responded "YES" to Item B.21, provide an attachment
					that describes the change in accounting principles or practices, or
					the change in the method of applying any such accounting principles
					or practices. State the date of the change and the reasons
					therefor. A letter from the Registrant's independent accountants,
					approving or otherwise commenting on the change, shall accompany
					the description.
					<br />
					<br />
					5. Item G.1.a.v. Information required to be filed pursuant to
					exemptive orders. File as an attachment any information required to
					be reported on Form N-CEN or any predecessor form to Form N-CEN
					(e.g., Form N-SAR) pursuant to exemptive orders issued by the
					Commission and relied on by the Registrant.
					<br />
					<br />
					6. Item G.1.a.vi. Other information required to be included as an
					attachment pursuant to Commission rules and regulations. File as an
					attachment any other information required to be included as an
					attachment pursuant to Commission rules and regulations.
					<br />
					<br />
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="instructionsGb">
		<br />
		<table role="presentation">
			<tr>
				<td>
					<i>Instructions.</i>
					<br />
					<br />
					7. Item G.1.b.i. Material amendments to organizational documents.
					Provide copies of all material amendments to the Registrant's
					charters, by-laws, or other similar organizational documents that
					occurred during the reporting period.
					<br />
					<br />
					8. Item G.1.b.ii. Instruments defining the rights of the holders of
					any new or amended class of securities. Provide copies of all
					constituent instruments defining the rights of the holders of any
					new or amended class of securities for the current reporting
					period. If the Registrant has issued a new class of securities
					other than short-term paper, furnish a description of the class
					called for by the applicable item of Form N-2. If the constituent
					instruments defining the rights of the holders of any class of the
					Registrant's securities have been materially modified during the
					reporting period, give the title of the class involved and state
					briefly the general effect of the modification upon the rights of
					the holders of such securities.
					<br />
					<br />
					9. Item G.1.b.iii. New or amended investment advisory contracts.
					Provide copies of any new or amended investment advisory contracts
					that became effective during the reporting period.
					<br />
					<br />
					10. Item G.1.b.iv. Information called for by Item 405 of Regulation
					S-K. Provide the information called for by Item 405 of Regulation
					S-K concerning failure of certain closed-end management investment
					company and small business investment company shareholders to file
					certain ownership reports.
					<br />
					<br />
					11. Item G.1.b.v. Code of ethics (small business investment
					companies only).
					<br />
					<br />
					(a) (1) Disclose whether, as of the end of the period covered by
					the report, the Registrant has adopted a code of ethics that
					applies to the Registrant's principal executive officer, principal
					financial officer, principal accounting officer or controller, or
					persons performing similar functions, regardless of whether these
					individuals are employed by the Registrant or a third party. If the
					Registrant has not adopted such a code of ethics, explain why it
					has not done so.
					<br />
					(2) For purposes of this instruction, the term "code of ethics"
					means written standards that are reasonably designed to deter
					wrongdoing and to promote: (i) honest and ethical conduct,
					including the ethical handling of actual or apparent conflicts of
					interest between personal and professional relationships; (ii)
					full, fair, accurate, timely, and understandable disclosure in
					reports and documents that a Registrant files with, or submits to,
					the Commission and in other public communications made by the
					Registrant; (iii) compliance with applicable governmental laws,
					rules, and regulations; (iv) the prompt internal reporting of
					violations of the code to an appropriate person or persons
					identified in the code; and (v) accountability for adherence to the
					code.
					<br />
					<br />
					(3) The Registrant must briefly describe the nature of any
					amendment, during the period covered by the report, to a provision
					of its code of ethics that applies to the Registrant's principal
					executive officer, principal financial officer, principal
					accounting officer or controller, or persons performing similar
					functions, regardless of whether these individuals are employed by
					the Registrant or a third party, and that relates to any element of
					the code of ethics definition enumerated in paragraph (a)(2) of
					this instruction. The Registrant must file a copy of any such
					amendment as an exhibit to this report on Form N-CEN, unless the
					Registrant has elected to satisfy paragraph (a)(6) of this
					instruction by posting its code of ethics on its website pursuant
					to paragraph (a)(6)(ii) of this Instruction, or by undertaking to
					provide its code of ethics to any person without charge, upon
					request, pursuant to paragraph (a)(6)(iii) of this instruction.
					<br />
					<br />
					(4) If the Registrant has, during the period covered by the report,
					granted a waiver, including an implicit waiver, from a provision of
					the code of ethics to the Registrant's principal executive officer,
					principal financial officer, principal accounting officer or
					controller, or persons performing similar functions, regardless of
					whether these individuals are employed by the Registrant or a third
					party, that relates to one or more of the items set forth in
					paragraph (a)(2) of this instruction, the Registrant must briefly
					describe the nature of the waiver, the name of the person to whom
					the waiver was granted, and the date of the waiver.
					<br />
					<br />
					(5) If the Registrant intends to satisfy the disclosure requirement
					under paragraph (a)(3) or (4) of this instruction regarding an
					amendment to, or a waiver from, a provision of its code of ethics
					that applies to the Registrant's principal executive officer,
					principal financial officer, principal accounting officer or
					controller, or persons performing similar functions and that
					relates to any element of the code of ethics definition enumerated
					in paragraph (a)(2) of this instruction by posting such information
					on its Internet website, disclose the Registrant's Internet address
					and such intention.
					<br />
					<br />
					(6) The Registrant must: (i) file with the Commission a copy of its
					code of ethics that applies to the Registrant's principal executive
					officer, principal financial officer, principal accounting officer
					or controller, or persons performing similar functions, as an
					exhibit to its report on this Form N-CEN; (ii) post the text of
					such code of ethics on its Internet website and disclose, in its
					most recent report on this Form N-CEN, its Internet address and the
					fact that it has posted such code of ethics on its Internet
					website; or (iii) undertake in its most recent report on this Form
					N-CEN to provide to any person without charge, upon request, a copy
					of such code of ethics and explain the manner in which such request
					may be made.
					<br />
					<br />
					(7) A Registrant may have separate codes of ethics for different
					types of officers. Furthermore, a "code of ethics" within the
					meaning of paragraph (a)(2) of this instruction may be a portion of
					a broader document that addresses additional topics or that applies
					to more persons than those specified in paragraph (a)(1) of this
					instruction. In satisfying the requirements of paragraph (a)(6) of
					this instruction, a Registrant need only file, post, or provide the
					portions of a broader document that constitutes a "code of ethics"
					as defined in paragraph (a)(2) of this instruction and that apply
					to the persons specified in paragraph (a)(1) of this instruction.
					<br />
					<br />
					(8) If a Registrant elects to satisfy paragraph (a)(6) of this
					instruction by posting its code of ethics on its Internet website
					pursuant to paragraph (a)(6)(ii), the code of ethics must remain
					accessible on its website for as long as the Registrant remains
					subject to the requirements of this instruction and chooses to
					comply with this instruction by posting its code on its Internet
					website pursuant to paragraph (a)(6)(ii).
					<br />
					<br />
					(9) The Registrant does not need to provide any information
					pursuant to paragraphs (a)(3) and (4) of this instruction if it
					discloses the required information on its Internet website within
					five business days following the date of the amendment or waiver
					and the Registrant has disclosed in its most recently filed report
					on this Form N-CEN its Internet website address and intention to
					provide disclosure in this manner. If the amendment or waiver
					occurs on a Saturday, Sunday, or holiday on which the Commission is
					not open for business, then the five business day period shall
					begin to run on and include the first business day thereafter. If
					the Registrant elects to disclose this information through its
					website, such information must remain available on the website for
					at least a 12-month period. The Registrant must retain the
					information for a period of not less than six years following the
					end of the fiscal year in which the amendment or waiver occurred.
					Upon request, the Registrant must furnish to the Commission or its
					staff a copy of any or all information retained pursuant to this
					requirement.
					<br />
					<br />
					(10) The Registrant does not need to disclose technical,
					administrative, or other non-substantive amendments to its code of
					ethics.
					<br />
					<br />
					(11) For purposes of this instruction: (i) the term "waiver" means
					the approval by the Registrant of a material departure from a
					provision of the code of ethics; and (ii) the term "implicit
					waiver" means the Registrant's failure to take action within a
					reasonable period of time regarding a material departure from a
					provision of the code of ethics that has been made known to an
					executive officer, as defined in rule 3b-7 under the Exchange Act
					(17 CFR 240.3b-7), of the Registrant.
					<br />
					<br />
					(b) (1) Disclose that the Registrant's board of directors has
					determined that the Registrant either: (i) has at least one audit
					committee financial expert serving on its audit committee; or (ii)
					does not have an audit committee financial expert serving on its
					audit committee.
					<br />
					<br />
					(2) If the Registrant provides the disclosure required by paragraph
					(b)(1)(i) of this instruction, it must disclose the name of the
					audit committee financial expert and whether that person is
					"independent." In order to be considered "independent" for purposes
					of this instruction, a member of an audit committee may not, other
					than in his or her capacity as a member of the audit committee, the
					board of directors, or any other board committee: (i) accept
					directly or indirectly any consulting, advisory, or other
					compensatory fee from the issuer; or (ii) be an "interested person"
					of the investment company as defined in Section 2(a)(19) of the Act
					(15 U.S.C. 80a-2(a)(19)).
					<br />
					<br />
					(3) If the Registrant provides the disclosure required by paragraph
					(b)(1)(ii) of this instruction, it must explain why it does not
					have an audit committee financial expert.
					<br />
					<br />
					(4) If the Registrant's board of directors has determined that the
					Registrant has more than one audit committee financial expert
					serving on its audit committee, the Registrant may, but is not
					required to, disclose the names of those additional persons. A
					Registrant choosing to identify such persons must indicate whether
					they are independent pursuant to paragraph (b)(2) of this
					instruction.
					<br />
					<br />
					(5) For purposes of this instruction, an "audit committee financial
					expert" means a person who has the following attributes: (i) an
					understanding of generally accepted accounting principles and
					financial statements; (ii) the ability to assess the general
					application of such principles in connection with the accounting
					for estimates, accruals, and reserves; (iii) experience preparing,
					auditing, analyzing, or evaluating financial statements that
					present a breadth and level of complexity of accounting issues that
					are generally comparable to the breadth and complexity of issues
					that can reasonably be expected to be raised by the Registrant's
					financial statements, or experience actively supervising one or
					more persons engaged in such activities; (iv) an understanding of
					internal controls and procedures for financial reporting; and (v)
					an understanding of audit committee functions.
					<br />
					<br />
					(6) A person shall have acquired such attributes through: (i)
					education and experience as a principal financial officer,
					principal accounting officer, controller, public accountant, or
					auditor or experience in one or more positions that involve the
					performance of similar functions; (ii) experience actively
					supervising a principal financial officer, principal accounting
					officer, controller, public accountant, auditor, or person
					performing similar functions; (iii) experience overseeing or
					assessing the performance of companies or public accountants with
					respect to the preparation, auditing, or evaluation of financial
					statements; or (iv) other relevant experience.
					<br />
					<br />
					(7) (i) A person who is determined to be an audit committee
					financial expert will not be deemed an "expert" for any purpose,
					including without limitation for purposes of Section 11 of the
					Securities Act (15 U.S.C. 77k), as a result of being designated or
					identified as an audit committee financial expert pursuant to this
					instruction; (ii) the designation or identification of a person as
					an audit committee financial expert pursuant to this instruction
					does not impose on such person any duties, obligations, or
					liability that are greater than the duties, obligations, and
					liability imposed on such person as a member of the audit committee
					and board of directors in the absence of such designation or
					identification; (iii) the designation or identification of a person
					as an audit committee financial expert pursuant to this instruction
					does not affect the duties, obligations, or liability of any other
					member of the audit committee or board of directors.
					<br />
					<br />
					(8) If a person qualifies as an audit committee financial expert by
					means of having held a position described in paragraph (b)(6)(iv)
					of this Instruction, the Registrant shall provide a brief listing
					of that person's relevant experience.
				</td>
			</tr>
		</table>

	</xsl:template>
</xsl:stylesheet>