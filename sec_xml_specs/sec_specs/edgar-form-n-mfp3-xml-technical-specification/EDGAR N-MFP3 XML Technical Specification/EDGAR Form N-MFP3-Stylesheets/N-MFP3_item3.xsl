	<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/nmfp3"
	xmlns:ns3="http://www.sec.gov/edgar/nmfp3common">
	
	<xsl:template name="item3_partB">
		<xsl:for-each select="m1:classLevelInfo">
			<h3>Part B: Class-Level Information about the Fund</h3>
			<h4 style="padding:10px">For each Class of the Series (regardless of the number of shares outstanding in the Class), disclose the following:</h4>
			<table role="presentation">
				<tr>
					<td class="label"><b>Item B.1.</b> Full name of the Class</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:classFullName" />
						</div>					
					</td>
				</tr>
				<tr>
					<td class="label"><b>Item B.2.</b> EDGAR Class identifier</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:classesId" />
						</div>					
					</td>
				</tr>
				<tr>
					<td class="label"><b>Item B.3.</b> Minimum initial investment</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:minInitialInvestment) &gt; 0">
								<xsl:value-of select='format-number(m1:minInitialInvestment, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>					
					</td>
				</tr>
				<tr>
					<td class="label"><b>Item B.4.</b> Net assets of the Class, to the nearest cent</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:netAssetsOfClass) &gt; 0">
								<xsl:value-of select='format-number(m1:netAssetsOfClass, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>					
					</td>
				</tr>
				<tr>
					<td class="label">
						<b>Item B.5.</b> Number of shares outstanding, to the nearest hundredth
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:numberOfSharesOutstanding) &gt; 0">
								<xsl:value-of select='format-number(m1:numberOfSharesOutstanding ,  "ddd,ddd,ddd,dd0.00dd", "percentage")' />
							</xsl:if>
						</div>					
					</td>
				</tr>	
				<tr>
					<td class="label">
						<b>Item B.6.</b> Net asset value per share. Provide the net asset value per share, calculated using available market quotations (or an appropriate substitute that reflects current market conditions), rounded to the fourth decimal place in the case of a fund with a $1.0000 share price (or an equivalent level of accuracy for funds with a different share price), as of the close of business on each business day of the month reported.
					</td>
					<td>
					</td>
				</tr>
				
					<xsl:for-each select="m1:dailyNetAssetValuePerShareClass">
				<tr>
					<td class="label">
						<blockquote>
							a. Net asset value per share
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">						
							 	<xsl:value-of select='format-number(m1:dailyNetAssetValuePerShareClass, "$#,##0.0000")' />

						</div>									
						
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							b. Date
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:dailyNetAssetValuePerShareDateClass" />
						</div>									
					</td>
				</tr>
				
				</xsl:for-each>
				
				<tr>
					<td class="label">
						<b>Item B.7.</b> Shareholder flow. Provide (a) the daily gross subscriptions (including dividend reinvestments) and gross redemptions, rounded to the nearest cent, as of the close of business on each business day of the month reported; and (b) the total gross subscriptions (including dividend reinvestments) and total gross redemptions for the month reported. For purposes of this Item, report gross subscriptions (including dividend reinvestments) and gross redemptions as of the trade date, and for Master-Feeder Funds, only report the required shareholder flow data at the Feeder Fund level.
					</td>
					<td></td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							a. Daily shareholder flows:
						</blockquote>
					</td>
				</tr>
				<xsl:for-each select="m1:dialyShareholderFlowReported">
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								i. Gross subscriptions <font style="font-size:0.9em">(including dividend reinvestments):</font>
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:dailyGrossSubscriptions) &gt; 0">
								<xsl:value-of select='format-number(m1:dailyGrossSubscriptions, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>				
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								ii. Gross redemptions:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:dailyGrossRedemptions) &gt; 0">
								<xsl:value-of select='format-number(m1:dailyGrossRedemptions, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>				
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								iii. Date:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:dailyShareHolderFlowDate) &gt; 0">
								<xsl:value-of select='m1:dailyShareHolderFlowDate' />
							</xsl:if>
						</div>				
					</td>
				</tr>
				</xsl:for-each>
				<tr>
					<td class="label">
						<blockquote>
							b. Monthly shareholder flows:
						</blockquote>
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								i. Total gross subscriptions
								<font style="font-size:0.9em">(including dividend reinvestments):</font>
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:monthlyShareholderFlowReported/m1:totalGrossSubscriptions) &gt; 0">
								<xsl:value-of select='format-number(m1:monthlyShareholderFlowReported/m1:totalGrossSubscriptions, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>									
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								ii. Total gross redemptions:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:monthlyShareholderFlowReported/m1:totalGrossRedemptions) &gt; 0">
								<xsl:value-of select='format-number(m1:monthlyShareholderFlowReported/m1:totalGrossRedemptions, "$###,###,###,##0.00")' />
							</xsl:if>
						</div>				
					</td>
				</tr>
			</table>
			<table role="presentation">
				<tr>
					<td class="label"><b>Item B.8.</b> 7-day net yield for each business day of the month reported, as calculated under Item 26(a)(1) of Form N-1A (§ 274.11A of this chapter) except based on the 7 business days immediately preceding a given business day</td>
				</tr>
				<xsl:for-each select="m1:sevenDayNetYield">
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								a. 7-day net yield
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:sevenDayNetYieldValue) &gt; 0">
							<!-- 	<xsl:value-of select='m1:sevenDayNetYieldValue' />	 -->	
							
							<xsl:variable name="sevenDayNetYieldValue" select='format-number(number(m1:sevenDayNetYieldValue), "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * number($sevenDayNetYieldValue) ,  "dd0.00", "percentage")' />%
											
							</xsl:if>	
						</div>						
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								b. Date
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:sevenDayNetYieldDate" />
						</div>						
					</td>
				</tr>
				</xsl:for-each>
				<tr>
					<td class="label">
						<b>Item B.9.</b> During the reporting period, did any person pay for, or waive all or part of the fund’s operating expenses or management fees?   
						
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:personPayForFundFlag) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:personPayForFundFlag) = 'N'">
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
								If Yes, answer Item B.9.a
							</blockquote>
						</td>
						<td>
						
						</td>
					</tr>
			
				<xsl:if test="string(m1:nameOfPersonDescExpensePay) &gt; 0">

					<tr>
						<td class="label">
							<blockquote>
								a. Total amount of the expense payment or fee waiver, or both (reported in dollars)
							</blockquote>
						</td>
						<td>
							<div class="fakeBox3">
							 <xsl:if test="string(m1:nameOfPersonDescExpensePay) &gt; 0">
									<xsl:value-of select='format-number(m1:nameOfPersonDescExpensePay, "$###,###,###,##0.00")' />
									</xsl:if>
							</div>						
							
						</td>
					</tr>
				</xsl:if>
				
				
					
				<!-- B.10 start -->
				
				<tr>
					<td class="label">
						<b>Item B.10.</b> For each person who owns of record or is known by the fund to own beneficially 5% or more of the shares outstanding in the Class, provide the following information. For purposes of this question, if the fund knows that two or more beneficial owners of the Class are affiliated with each other, treat them as a single beneficial owner when calculating the percentage ownership and identify separately each affiliated beneficial owner by type and the percentage interest of each affiliated beneficial owner. An affiliated beneficial owner is one that directly or indirectly controls or is controlled by another beneficial owner or is under common control with any other beneficial owner.
					</td>
					</tr>
				
				<xsl:for-each select="m1:beneficialRecordOwnerCategory">
	
					<tr>
						<td class="label">
							<blockquote>
								<blockquote>
									a. Type of beneficial owner or record owner:
								</blockquote>
							</blockquote>
						</td>
					<!-- VARIABLES BEGIN -->
					<!-- 1. -->
					<xsl:variable name="beneficialOrRecordOwner1">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Retail investor')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 2. -->
					<xsl:variable name="beneficialOrRecordOwner2">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Non-financial corporation')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 3. -->
					<xsl:variable name="beneficialOrRecordOwner3">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Pension plan')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 4. -->
					<xsl:variable name="beneficialOrRecordOwner4">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Non-profit')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 5. -->
					<xsl:variable name="beneficialOrRecordOwner5">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'State or municipal government entity (excluding governmental pension plans)')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 6. -->
					<xsl:variable name="beneficialOrRecordOwner6">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Registered investment company')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 7. -->
					<xsl:variable name="beneficialOrRecordOwner7">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Private fund')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 8. -->
					<xsl:variable name="beneficialOrRecordOwner8">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Depository institution or other banking institution')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 9. -->
					<xsl:variable name="beneficialOrRecordOwner9">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Sovereign wealth fund')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 10. -->
					<xsl:variable name="beneficialOrRecordOwner10">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Broker-dealer')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 11. -->
					<xsl:variable name="beneficialOrRecordOwner11">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Insurance company')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- 12. -->
					<xsl:variable name="beneficialOrRecordOwner12">
						<xsl:for-each select="m1:beneficialRecordOwnerCategoryType">
							<xsl:if test="contains(. , 'Other')">
								<xsl:value-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
				<!-- VARIABLES END -->
	
					<td>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner1 = 'Retail investor'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Retail investor<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner2 = 'Non-financial corporation'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Non-financial corporation<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner3 = 'Pension plan'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Pension plan<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner4 = 'Non-profit'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Non-profit<br/>
						
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner5 = 'State or municipal government entity (excluding governmental pension plans)'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;State or municipal government entity (excluding governmental pension plans)<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner6 = 'Registered investment company'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Registered investment company<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner7 = 'Private fund'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Private fund<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner8 = 'Depository institution or other banking institution'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Depository institution or other banking institution<br/>
						
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner9 = 'Sovereign wealth fund'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Sovereign wealth fund<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner10 = 'Broker-dealer'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Broker-dealer<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner11 = 'Insurance company'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Insurance company<br/>
						<xsl:choose>
							<xsl:when test="$beneficialOrRecordOwner12 = 'Other'">
								<img src="Images/box-checked.jpg" alt="Checkbox checked" />
	
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
							</xsl:otherwise>
						</xsl:choose>&#160;Other<br/>							
					</td>
				</tr>
				
				
				 	<tr>
						<td class="label">
							<blockquote>
								If <i>Other</i>, provide a brief description of the type of investor included in this category
							</blockquote>
						</td>
						<td>
							<div class="fakeBox3">
							
										<xsl:value-of select="m1:otherInvestorCategory" />
								
							</div>						
							
						</td>
					</tr>
					
					<tr>
					  <td class="label">
						<blockquote>
							<blockquote>
									b. Percent of shares outstanding in the Class owned of record
							</blockquote>
						</blockquote>
					  </td>
					  <td>
						<div class="fakeBox2">
							
							   <xsl:if test="string(m1:percentOutstandingSharesRecord) &gt;= 0">
										<xsl:variable name="percentOutstandingSharesRecord" select='format-number(number(m1:percentOutstandingSharesRecord), "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * number($percentOutstandingSharesRecord) ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					 </td>
				</tr>
				
					
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								c. Percent of shares outstanding in the Class owned beneficially
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							
							   <xsl:if test="string(m1:percentOutstandingSharesBeneficial) &gt;= 0">
										<xsl:variable name="percentOutstandingSharesBeneficial" select='format-number(number(m1:percentOutstandingSharesBeneficial), "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * number($percentOutstandingSharesBeneficial) ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
				</xsl:for-each>
				
				
				<!-- B.10 End -->
				
				
				
				

				<!-- Include B.11, B.12 -->
				<tr>
					<td class="label">
						<b>Item B.11.</b> Shareholder Composition.  If the fund is not a Government Money Market Fund or Retail Money Market Fund, identify the percentage of investors within the following categories:
					</td>
					</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								a. Non-financial corporations:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
						     <!--   <xsl:if test="count(m1:percentShareHolderCompNonFinancialCorp) &gt; 0"> 
								<xsl:value-of select='format-number(m1:percentShareHolderCompNonFinancialCorp, "#.0000")' />
					  </xsl:if>-->
					  <xsl:if test="string(m1:percentShareHolderCompNonFinancialCorp) &gt;= 0">
										<xsl:variable name="percentShareHolderCompNonFinancialCorp" select='format-number(m1:percentShareHolderCompNonFinancialCorp, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompNonFinancialCorp ,  "dd0.00", "percentage")' />%
									</xsl:if>
					  
						</div>	
											
					</td>
				</tr>
				
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								b. Pension plans:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
					    	
							 	  <xsl:if test="string(m1:percentShareHolderCompPensionPlan) &gt;= 0">
										<xsl:variable name="percentShareHolderCompPensionPlan" select='format-number(m1:percentShareHolderCompPensionPlan, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompPensionPlan ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								c. Non-profits:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
						      
						     <xsl:if test="string(m1:percentShareHolderCompNonProfit) &gt;= 0">
										<xsl:variable name="percentShareHolderCompNonProfit" select='format-number(m1:percentShareHolderCompNonProfit, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompNonProfit ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
					
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								d. State or municipal government entities (excluding governmental pension plans):
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
						    <xsl:if test="string(m1:percentShareHolderCompMunicipal) &gt;= 0">
										<xsl:variable name="percentShareHolderCompMunicipal" select='format-number(m1:percentShareHolderCompMunicipal, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompMunicipal ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								e. Registered investment companies:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
						  	 <xsl:if test="string(m1:percentShareHolderCompRegInvestment) &gt;= 0">
										<xsl:variable name="percentShareHolderCompRegInvestment" select='format-number(m1:percentShareHolderCompRegInvestment, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompRegInvestment ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								f. Private funds:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
						 
							 <xsl:if test="string(m1:percentShareHolderCompPrivateFunds) &gt;= 0">
										<xsl:variable name="percentShareHolderCompPrivateFunds" select='format-number(m1:percentShareHolderCompPrivateFunds, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompPrivateFunds ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
				
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								g. Depository institutions and other banking institutions:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
					
						<xsl:if test="string(m1:percentShareHolderCompDepositoryInst) &gt;= 0">
										<xsl:variable name="percentShareHolderCompDepositoryInst" select='format-number(m1:percentShareHolderCompDepositoryInst, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompDepositoryInst ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								h. Sovereign wealth funds:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
				
						<xsl:if test="string(m1:percentShareHolderCompSovereignFund) &gt;= 0">
										<xsl:variable name="percentShareHolderCompSovereignFund" select='format-number(m1:percentShareHolderCompSovereignFund, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompSovereignFund ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								i. Broker-dealers:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							
						<xsl:if test="string(m1:percentShareHolderCompBrokerDealer) &gt;= 0">
										<xsl:variable name="percentShareHolderCompBrokerDealer" select='format-number(m1:percentShareHolderCompBrokerDealer, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompBrokerDealer ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								j. Insurance companies:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
						
						<xsl:if test="string(m1:percentShareHolderCompInsurance) &gt;= 0">
										<xsl:variable name="percentShareHolderCompInsurance" select='format-number(m1:percentShareHolderCompInsurance, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompInsurance ,  "dd0.00", "percentage")' />%
									</xsl:if>
						</div>						
					</td>
				</tr>
				
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								k. Other:
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							   
						<xsl:if test="string(m1:percentShareHolderCompOther) &gt;= 0">
										<xsl:variable name="percentShareHolderCompOther" select='format-number(m1:percentShareHolderCompOther, "0.0000", "percentage")'/>
										<xsl:value-of select='format-number(100 * $percentShareHolderCompOther ,  "dd0.00", "percentage")' />%
									</xsl:if>
						
						</div>						
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								If <i>Other</i>, provide a brief description of the types of investors included in this category
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox3">
						 <xsl:if test="count(m1:otherInvestorTypeDescription) &gt; 0"> 
							<xsl:value-of select="string(m1:otherInvestorTypeDescription)" />
						</xsl:if>
						</div>						
					</td>
				</tr>
				
				<tr>
					<td class="label">
						<b>Item B.12.</b> Share Cancellation.  During the reporting period, were any shares cancelled under rule 2a-7(c)(3)?
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="string(m1:shareCancellationReportingPeriod) = 'Y'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
							</xsl:otherwise>
						</xsl:choose> &#160;
						<xsl:choose>
							<xsl:when test="string(m1:shareCancellationReportingPeriod) = 'N'">
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
							<blockquote>
								If Yes, answer Item B.12.a
							</blockquote>
						</blockquote>
					</td>
					<td>
									
					</td>
				</tr>
				
					<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								a. For each business day shares were cancelled under rule 2a-7(c)(3) during the reporting period, provide:
							</blockquote>
						</blockquote>
					</td>
					
				</tr>
				<xsl:if test="string(m1:shareCancellationReportingPeriod) = 'Y'">
					<xsl:for-each select="m1:cancelledSharesPerBusinessDay">
						<tr>
							<td class="label">
								<blockquote>
									<blockquote>
										i. Dollar value of shares cancelled
									</blockquote>
								</blockquote>
							</td>
							<td>
								<div class="fakeBox2">
									 <xsl:if test="count(m1:cancelledShareDollarValue) &gt; 0">
										$<xsl:value-of select='format-number(number(m1:cancelledShareDollarValue) ,  "ddd,ddd,ddd,dd0.00dd", "percentage")' />
									</xsl:if>
								</div>
							</td>
						</tr>

						<tr>
							<td class="label">
								<blockquote>
									<blockquote>
										ii. Number of shares cancelled
									</blockquote>
								</blockquote>
							</td>
							<td>
								<div class="fakeBox2">
									<xsl:if test="count(m1:cancelledShareNumber) &gt; 0">
										<xsl:value-of select='format-number(number(m1:cancelledShareNumber) ,  "ddd,ddd,ddd,dd0.00dd", "percentage")' />
									</xsl:if>
								</div>
							</td>
						</tr>
							<tr>
							<td class="label">
								<blockquote>
									<blockquote>
										iii. Date
									</blockquote>
								</blockquote>
							</td>
							<td>
								<div class="fakeBox2">
									<xsl:if test="count(m1:cancelledShareDate) &gt; 0">
										<xsl:value-of select="string(m1:cancelledShareDate)" />
									</xsl:if>
								</div>
							</td>
						</tr>
					</xsl:for-each>
				</xsl:if>
			</table>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

