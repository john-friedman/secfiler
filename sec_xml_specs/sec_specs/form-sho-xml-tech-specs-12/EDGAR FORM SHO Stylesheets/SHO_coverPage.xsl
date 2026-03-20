<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:p="http://www.sec.gov/edgar/formSho">


	<xsl:output
			method="html"
			indent="no"
			encoding="iso-8859-1"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
	<!-- Cover Page Template START -->
	<xsl:template name="coverPage">
	   <div id="coverPage">
			<div class="contentwrapper">
				<div class="content">
				    <h1 style="margin-top: 25px;">Form <xsl:value-of select="$submissionType" />: Cover Page</h1>
					<table role="presentation"  class="amendmentInformation">
						<tr>
							<td class="label">Report for the Period Ended:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reportPeriodEnded)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Check here if Amendment and Restatement:</td>
							<td>
								<xsl:choose>
									<xsl:when test="$submissionType = 'SHO/A'">
										<img src="Images/box-checked.jpg" alt="Checkbox checked" />
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<xsl:if test="$submissionType = 'SHO/A'">
							<tr>
								<td class="label">Amendment No. :</td>
								<td>
									<div class="fakeBox">
										<xsl:value-of select="string(p:coverPage/p:amendmentNo)" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">Description of the Amendment and Restatement, Reason for the Amendment and Restatement, and Which Additional Form SHO Reporting Period(s) (up to the past 12 calendar months), if any, is/are affected by the Amendment and Restatement:</td>
								<td>
									<div class="fakeBox">
										<xsl:value-of select="string(p:coverPage/p:reasonForAmendment)" />
									</div>
								</td>
							</tr>
						</xsl:if>
					</table>
					<table role="presentation"  class="managerInformation">
						<tr>
							<h4 style="padding-bottom: 8px; padding-top: 8px;"><em>Institutional Investment Manager ("Manager") Filing Report:</em></h4>
						</tr>
						<tr>
							<td class="label">Name:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:name)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Address 1:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:reporterAddress/p:street1)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Address 2:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:reporterAddress/p:street2)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">City:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:reporterAddress/p:city)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">State/Country:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:reporterAddress/p:stateOrCountry)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Zip/Foreign Postal Codes:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:reporterAddress/p:zipCode)" />
								</div>
							</td>
						</tr>
						
						<tr>
							<td class="label">Business Telephone Number:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:phoneNumber)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Business Email:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:email)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Non-Lapsed Legal Entity Identifier ("LEI"):</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:reporterInfo/p:nonLapsedLEI)" />
								</div>
							</td>
						</tr>			
					</table>
					<table role="presentation"  class="employeeInformation">
						<tr>
							<td><h4><em>Contact Employee:</em></h4></td>
						</tr>
						<tr>
							<td class="label">Name:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:employeeContact/p:name)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Title:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:employeeContact/p:title)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Business Telephone Number:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:employeeContact/p:phoneNumber)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Business Email:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:employeeContact/p:email)" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="label">Date Filed:</td>
							<td>
								<div class="fakeBox">
									<xsl:value-of select="string(p:coverPage/p:employeeContact/p:dateFiled)" />
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding-top: 30px; padding-bottom: 20px;"><span class="authorized">The Manager filing this report hereby represents that all information contained herein is true, correct and complete, and that it is understood that all required items, statements, schedules, lists, and tables, are considered integral parts of this form.</span></td>
						</tr>
					</table>
					<table  role="presentation"  class="reportType">
						<tr>
							<td class="label" style="padding-top: 35px;">
								Report Type (Check only one):
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="count(p:coverPage/p:reportType) &gt; 0">
										<xsl:choose>
											<xsl:when test="string(p:coverPage/p:reportType) = 'FORM SHO ENTRIES REPORT'">
												<img src="Images/radio-checked.jpg"   alt="Radio button checked"   /> FORM SHO ENTRIES REPORT. (Check here if all entries of this reporting Manager are reported in this report.)<br/>
												<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> FORM SHO NOTICE. (Check here if no entries reported are in this report, and all entries are reported by other reporting Manager(s).)<br/>
												<img src="Images/radio-unchecked.jpg"   alt="Radio button not checked"   /> FORM SHO COMBINATION REPORT. (Check here if a portion of the entries for this reporting Manager is reported in this report and a portion is reported by other reporting Manager(s).)<br/>
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(p:coverPage/p:reportType) = 'FORM SHO NOTICE'">
												<img src="Images/radio-unchecked.jpg"   alt="Radio button not checked"   /> FORM SHO ENTRIES REPORT. (Check here if all entries of this reporting Manager are reported in this report.)<br/>
												<img src="Images/radio-checked.jpg" alt="Radio button checked" /> FORM SHO NOTICE. (Check here if no entries reported are in this report, and all entries are reported by other reporting Manager(s).)<br/>
												<img src="Images/radio-unchecked.jpg"   alt="Radio button not checked"   /> FORM SHO COMBINATION REPORT. (Check here if a portion of the entries for this reporting Manager is reported in this report and a portion is reported by other reporting Manager(s).)<br/>
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string(p:coverPage/p:reportType) = 'FORM SHO COMBINATION REPORT'">
												<img src="Images/radio-unchecked.jpg"   alt="Radio button not checked"   /> FORM SHO ENTRIES REPORT. (Check here if all entries of this reporting Manager are reported in this report.)<br/>
												<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> FORM SHO NOTICE. (Check here if no entries reported are in this report, and all entries are reported by other reporting Manager(s).)<br/>
												<img src="Images/radio-checked.jpg"   alt="Radio button checked"   /> FORM SHO COMBINATION REPORT. (Check here if a portion of the entries for this reporting Manager is reported in this report and a portion is reported by other reporting Manager(s).)<br/>
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<img src="Images/radio-unchecked.jpg"   alt="Radio button not checked"   /> FORM SHO ENTRIES REPORT. (Check here if all entries of this reporting Manager are reported in this report.)<br/>
										<img src="Images/radio-unchecked.jpg" alt="Radio button not checked" /> FORM SHO NOTICE. (Check here if no entries reported are in this report, and all entries are reported by other reporting Manager(s).)<br/>
										<img src="Images/radio-checked.jpg"   alt="Radio button not checked"   /> FORM SHO COMBINATION REPORT. (Check here if a portion of the entries for this reporting Manager is reported in this report and a portion is reported by other reporting Manager(s).)<br/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
					<xsl:if test="string(p:coverPage/p:reportType) != 'FORM SHO ENTRIES REPORT'">
						<table role="presentation"  class="otherManagerInfo">
							<tr>
								<h4 style="padding-bottom: 8px; padding-top: 8px;"><em>Name and Non-Lapsed LEI of each of the Other Manager(s) Reporting for this Manager:</em></h4>
							</tr>
							<xsl:for-each select="p:coverPage/p:managerInfoList/p:managerInfo">
							 <div>
								<tr>
									<td><h4><em style="font-size: 14px;">Manager Information Record:<xsl:value-of select="position()"/></em></h4></td>
								</tr>
								<tr>
									<td class="label">Name:</td>
									<td>
										<div class="fakeBox">
											<xsl:value-of select="string(p:name)" />
										</div>
									</td>
								</tr>
								<tr>
									<td class="label">Non-Lapsed LEI:</td>
									<td>
										<div class="fakeBox">
											<xsl:value-of select="string(p:nonLapsedLEI)" />
										</div>
									</td>
								</tr>
							 </div>
							</xsl:for-each>
						</table>
					</xsl:if>
				</div>
			</div>
		</div>
	</xsl:template>
	<!-- Cover Page Template END -->
	
</xsl:stylesheet>