<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/nmfp3"
	xmlns:ns3="http://www.sec.gov/edgar/nmfp3common">
	
	<xsl:template name="item1_generalInformation">
		<h3>General Information</h3>
		<table role="presentation" id="generalInfomration">
			<tr>
				<td class="label"><b>Item 1.</b> Report for [YYYY-MM-DD]</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="string(m1:generalInfo/m1:reportDate)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item 2.</b> Name of Registrant</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:registrantFullName)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item 3.</b> CIK Number of Registrant</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:cik)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item 4.</b> LEI of Registrant</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:registrantLEIId)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item 5.</b> Name of Series</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:nameOfSeries)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item 6.</b> LEI of Series</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:leiOfSeries)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item 7.</b> EDGAR Series Identifier</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:seriesId)" />
					</div>
				</td>
			</tr>
			<tr  >
				<td class="label"><b>Item 8.</b> Total number of share classes in the series</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:totalShareClassesInSeries)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">
					<b>Item 9.</b> Do you anticipate that this will be the fund’s final filing on Form N-MFP?  
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:generalInfo/m1:finalFilingFlag) = 'Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:generalInfo/m1:finalFilingFlag) = 'N'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
						</xsl:otherwise>
					</xsl:choose>					
				</td>				
			</tr>
			
				<tr  >
				<td class="label">If Yes, answer Items 9.a – 9.c</td>
				<td>
					
				</td>
			</tr>
		
			
			<xsl:if test="string(m1:generalInfo/m1:finalFilingFlag) = 'Y'">
				<tr>
					<td class="label">
						<blockquote>
							a. Is the fund liquidating?
						</blockquote>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:generalInfo/m1:fundLiquidatingFlag) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:generalInfo/m1:fundLiquidatingFlag) = 'N'">
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
							b. Is the fund merging with, or being acquired by, another fund?
						</blockquote>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:generalInfo/m1:fundMrgOrAcqrdByOthrFlag) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:generalInfo/m1:fundMrgOrAcqrdByOthrFlag) = 'N'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
							</xsl:otherwise>
						</xsl:choose>							
					</td>
				</tr>
				<xsl:if test="count(m1:generalInfo/m1:successorFund) &gt; 0">
					<tr>
						<td class="label">
							<blockquote>
								c. If applicable, identify the successor fund by CIK, 
								Securities Act file number, and EDGAR series identifier
							</blockquote>
						</td>
					</tr>
					<xsl:if test="string(m1:generalInfo/m1:fundMrgOrAcqrdByOthrFlag) = 'Y'">
						<xsl:for-each select="m1:generalInfo/m1:successorFund">
							<tr>
								<td class="label"><blockquote>CIK of successor fund</blockquote></td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:cik" />
									</div>
								</td>
							</tr>
							<tr>	
								<td class="label">
									<blockquote>Securities Act file number of successor fund</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:fileNumber" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<blockquote>EDGAR series identifier of successor fund</blockquote>
								</td>
								<td>
									<div class="fakeBox2">
										<xsl:value-of select="m1:seriesId" />
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<tr>
				<td class="label"><b>Item 10.</b> Has the fund acquired or merged with another fund since the last filing?</td>
				<td>								
					<xsl:choose>
						<xsl:when test="string(m1:generalInfo/m1:fundAcqrdOrMrgdWthAnthrFlag)='Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:generalInfo/m1:fundAcqrdOrMrgdWthAnthrFlag)='N'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
						</xsl:otherwise>
					</xsl:choose>					
				</td>
			</tr>
			<tr>
				<td class="label">If Yes, answer Item 10.a</td>
				<td></td>
			</tr>
			<xsl:if test="string(m1:generalInfo/m1:fundAcqrdOrMrgdWthAnthrFlag) = 'Y'">
				<tr>
					<td class="label">
						a. Identify the acquired or merged fund by CIK, Securities Act file number, and EDGAR series identifier
					</td>
					<td>
					</td>
				</tr>
				<xsl:for-each select="m1:generalInfo/m1:acquiredMergedFund">
					<tr>
						<td class="label">
							<blockquote>CIK of acquired/merged fund</blockquote>
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
								Securities Act file number of acquired/merged fund
							</blockquote>
						</td> 
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="m1:fileNumber" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">
							<blockquote>
								EDGAR series identifier of acquired/merged fund
							</blockquote>
						</td> 
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="m1:seriesId" />
							</div>
						</td>
					</tr>
				</xsl:for-each>
			</xsl:if>
			<tr>
				<td class="label">
					<b>Item 11.</b> Provide the name, e-mail address, and telephone number of the person authorized to receive information and respond to questions about this Form N-MFP
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td class="label"><blockquote>Name</blockquote></td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:generalInfo/m1:contact2/m1:contactName)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label"><blockquote>Phone Number</blockquote></td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="string(m1:generalInfo/m1:contact2/m1:contactPhoneNumber)" />
					</div>
				</td>				
			</tr>
			<tr>
				<td class="label"><blockquote>Email Address</blockquote></td>
				<td>
					<div class="fakeBox">
						<xsl:value-of select="string(m1:generalInfo/m1:contact2/m1:contactEmailAddress)" />
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>

