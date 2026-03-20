<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m1="http://www.sec.gov/edgar/nmfp3"
	xmlns:ns3="http://www.sec.gov/edgar/nmfp3common">
	
	<xsl:template name="item2_partA">
		<h3>Part A: Series-Level Information about the Fund</h3>
		<table role="presentation">
			<tr>
				<td class="label"><b>Item A.1.</b> Securities Act File Number</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="string(m1:seriesLevelInfo/m1:securitiesActFileNumber)" />
					</div>
				</td>
			</tr>
			<xsl:for-each select="m1:seriesLevelInfo/m1:adviser">
				<tr>
					<td class="label"><b>Item A.2.</b> Investment Adviser</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:adviserName" />
						</div>					
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							a. SEC file number of investment adviser
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="m1:adviserFileNumber" />
						</div>
					</td>
				</tr>
			</xsl:for-each>

			<xsl:if test="count(m1:seriesLevelInfo/m1:subAdviser) &gt; 0">
				<xsl:for-each select="m1:seriesLevelInfo/m1:subAdviser">
					<tr>
						<td class="label">
							<b>Item A.3.</b> Sub-Adviser. If a fund has one or more sub-advisers, disclose the name of each sub-adviser
						</td>
						<td>
							<div class="fakeBox3">
								<xsl:value-of select="m1:adviserName" />
							</div>								
						</td>
					</tr>
					<tr>
						<td class="label">
							<blockquote>
								a. SEC file number of sub-adviser
							</blockquote>
						</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="m1:adviserFileNumber" />
							</div>
						</td>
					</tr>
				</xsl:for-each>
			</xsl:if>
			<tr>
				<td class="label"><b>Item A.4.</b> Independent Public Accountant</td>
				<td>
					<div class="fakeBox3">
						<xsl:value-of select="string(m1:seriesLevelInfo/m1:indpPubAccountant/m1:name)" />
					</div>					
				</td>
			</tr>
				<tr>
				<td class="label">
					<blockquote>
						a. City and state of independent public accountant
					</blockquote>
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="label">
					<blockquote>
						City of independent public accountant
					</blockquote>
				</td>
				<td>
					<div class="fakeBox">
						<xsl:value-of select="string(m1:seriesLevelInfo/m1:indpPubAccountant/m1:city)" />
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">
					<blockquote>
						<blockquote>
							State/Province/Country of independent public accountant
						</blockquote>
					</blockquote>
				</td>
				<td>
					<div class="fakeBox">
						<xsl:call-template name="stateDescription">
							<xsl:with-param name="stateCode"
							select="string(m1:seriesLevelInfo/m1:indpPubAccountant/m1:stateCountry)" />
						</xsl:call-template>
					</div>
				</td>
			</tr>		
			<xsl:for-each select="m1:seriesLevelInfo/m1:administrator">
				<tr>
					<td class="label">
						<b>Item A.5.</b> Administrator. If a fund has one or more administrators, disclose the name of each administrator
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:administratorName" />
						</div>
					</td>
				</tr>
			</xsl:for-each>	
			<xsl:for-each select="m1:seriesLevelInfo/m1:transferAgent">
				<tr>
					<td class="label"><b>Item A.6.</b> Transfer Agent</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="m1:name" />
						</div>
					</td>
				</tr>
				<xsl:if test="count(m1:cik) &gt; 0">
					<tr>
						<td class="label">
							<blockquote>
								a. CIK Number
							</blockquote>
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
								b. SEC file number of transfer agent
							</blockquote>
						</td>
						<td>
							<div class="fakeBox2">
								<xsl:value-of select="m1:fileNumber" />
							</div>					
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
			<tr>
				<td class="label">
					<b>Item A.7.</b> Master-Feeder Funds.  Is this a Feeder Fund?    
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:feederFundFlag)='Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:feederFundFlag)='N'">
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
								If Yes, answer Items A.7.a – 7.c
							</blockquote>
						</td>
						<td>
										
						</td>
					</tr>
			
			
			<tr>
				<td class="label">
					<blockquote>
						a. Identify the Master Fund by CIK or, if the fund does not have a CIK, by name
					</blockquote>
				</td>
				<td></td>
			</tr>
			<xsl:if test="string(m1:seriesLevelInfo/m1:feederFundFlag) = 'Y'">
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								CIK of the Master Fund
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:value-of select="string(m1:seriesLevelInfo/m1:masterFeederFund/m1:cik)" />
						</div>					
					</td>
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							<blockquote>
								Name of the Master Fund
							</blockquote>
						</blockquote>
					</td>
					<td>
						<div class="fakeBox3">
							<xsl:value-of select="string(m1:seriesLevelInfo/m1:masterFeederFund/m1:name)" />
						</div>					
					</td>					
				</tr>
				<tr>
					<td class="label">
						<blockquote>
							b. Securities Act file number of the Master Fund
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">	
							<xsl:value-of select="string(m1:seriesLevelInfo/m1:masterFeederFund/m1:fileNumber)" />
						</div>
					</td>
				</tr>
				<xsl:if test="count(m1:seriesLevelInfo/m1:masterFeederFund/m1:cik) &gt; 0">
					<tr>
						<td class="label">
							<blockquote>
								c. EDGAR series identifier of the Master Fund
							</blockquote>
						</td>
						<td>
							<div class="fakeBox2">	
								<xsl:value-of select="m1:seriesLevelInfo/m1:masterFeederFund/m1:seriesId" />
							</div>	
						</td>
					</tr>
				</xsl:if>
			</xsl:if>		
			<tr>
				<td class="label">
					<b>Item A.8.</b> Master-Feeder Funds. Is this a Master Fund? If Yes, answer Items A.8.a - 8.c.
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:masterFundFlag)='Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:masterFundFlag)='N'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
						</xsl:otherwise>
					</xsl:choose>					
				</td>
			</tr>
			
			<xsl:if test="$masterFundFlagYesNo = 'Y'">
				<xsl:for-each select="m1:seriesLevelInfo/m1:feederFund">
					<tr>
						<td class="label">
							<blockquote>
								a. Identify all Feeder Funds by CIK or, if the fund does not have a CIK, by name
							</blockquote>
						</td>
						<td>
						</td>
					</tr>
					<xsl:if test="count(m1:cik) &gt; 0">
						<tr>
							<td class="label"><blockquote><blockquote>CIK of the Feeder Fund</blockquote></blockquote></td>
							<td>
								<div class="fakeBox2">
									<xsl:value-of select="m1:cik" />
								</div>
							</td>										
						</tr>
					</xsl:if>
					<xsl:if test="count(m1:name) &gt; 0">
						<tr>
							<td class="label"><blockquote><blockquote>Name of the Feeder Fund</blockquote></blockquote></td>
							<td>
								<div class="fakeBox3">	
									<xsl:value-of select="m1:name" />
								</div>
							</td>					
						</tr>
					</xsl:if>
					<xsl:if test="$masterFundFlagYesNo = 'Y'">
						<tr>
							<td class="label"><blockquote>b. Securities Act file number of each Feeder Fund</blockquote></td>
							<td>
								<div class="fakeBox2">	
									<xsl:value-of select="string(m1:fileNumber)" />
								</div>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="count(m1:cik) &gt; 0">
						<tr>
							<td class="label"><blockquote>c. EDGAR series identifier of each Feeder Fund</blockquote></td>
							<td>
								<div class="fakeBox2">	
									<xsl:value-of select="m1:seriesId" />
								</div>
							</td>										
						</tr>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
			<tr>
				<td class="label"><b>Item A.9.</b> Is this series primarily used to fund insurance company separate accounts?</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:seriesFundInsuCmpnySepAccntFlag) = 'Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:seriesFundInsuCmpnySepAccntFlag) = 'N'">
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
					<b>Item A.10.</b> Category. Indicate the category that identifies the money market fund from among the following:
				</td>
				<!-- VARIABLES BEGIN -->
				<!-- 1. -->
				<xsl:variable name="marketFund1">
					<xsl:for-each select="m1:seriesLevelInfo/m1:moneyMarketFundCategory">
						<xsl:if test="contains(. , 'Government')">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<!-- 2. -->
				<xsl:variable name="marketFund2">
					<xsl:for-each select="m1:seriesLevelInfo/m1:moneyMarketFundCategory">
						<xsl:if test="contains(. , 'Prime')">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<!-- 3. -->
				<xsl:variable name="marketFund3">
					<xsl:for-each select="m1:seriesLevelInfo/m1:moneyMarketFundCategory">
						<xsl:if test="contains(. , 'Single State')">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<!-- 4. -->
				<xsl:variable name="marketFund4">
					<xsl:for-each select="m1:seriesLevelInfo/m1:moneyMarketFundCategory">
						<xsl:if test="contains(. , 'Other Tax Exempt')">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
			<!-- VARIABLES END -->

				<td>
					<xsl:choose>
						<xsl:when test="$marketFund1 = 'Government'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;Government<br/>
					<xsl:choose>
						<xsl:when test="$marketFund2 = 'Prime'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;Prime<br/>
					<xsl:choose>
						<xsl:when test="$marketFund3 = 'Single State'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;Single State<br/>
					<xsl:choose>
						<xsl:when test="$marketFund4 = 'Other Tax Exempt'">
							<img src="Images/box-checked.jpg" alt="Checkbox checked" />
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
						</xsl:otherwise>
					</xsl:choose>&#160;Other Tax Exempt<br/>							
				</td>
			</tr>
			<tr>
				<td class="label">
					<blockquote>
						a. Is this fund a Retail Money Market Fund?
					</blockquote>
				</td>
				<td>
					<xsl:choose>
						<xsl:when 
							test="string(m1:seriesLevelInfo/m1:fundRetailMoneyMarketFlag) = 'Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when 
							test="string(m1:seriesLevelInfo/m1:fundRetailMoneyMarketFlag) = 'N'">
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
						b. If this is a Government Money Market Fund, does the fund typically invest at least 80% of the value of its assets in U.S. Treasury obligations or repurchase agreements collateralized by U.S. Treasury obligations?
					</blockquote>
				</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:govMoneyMrktFundFlag) = 'Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:govMoneyMrktFundFlag) = 'N'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
						</xsl:otherwise>
					</xsl:choose>							
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item A.11.</b> Dollar-weighted average portfolio maturity ("WAM" as defined in rule 2a-7(d)(1)(ii))</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="string(m1:seriesLevelInfo/m1:averagePortfolioMaturity)" />
					</div>				
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item A.12.</b> Dollar-weighted average life maturity ("WAL" as defined in rule 2a-7(d)(1)(iii)). 
					Calculate WAL without reference to the exceptions in rule 2a-7(i) regarding interest rate readjustments.</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="string(m1:seriesLevelInfo/m1:averageLifeMaturity)" />
					</div>										
				</td>
			</tr>
			<tr> 
				<td class="label">
					<b>Item A.13.</b> Liquidity. Provide the following, as of the close of business on each business day of the month reported:
				</td>
				<td>
				</td>
			</tr>
			<xsl:for-each select="m1:seriesLevelInfo/m1:liquidAssetsDetails">
			<tr >
				<td class="label">
					<blockquote>
						a. Total Value of Daily Liquid Assets to the nearest cent
					</blockquote>
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="string(m1:totalValueDailyLiquidAssets) &gt;= 0">
							<xsl:value-of select='format-number(m1:totalValueDailyLiquidAssets, "$###,###,###,##0.00")' />
						</xsl:if>
					</div>				
				</td>
				<td></td>
			</tr>
			
			<tr>
				<td class="label">
					<blockquote>
						b. Total Value of Weekly Liquid Assets (including Daily Liquid Assets) to the nearest cent:
					</blockquote>
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:totalValueWeeklyLiquidAssets) &gt; 0">
							<xsl:value-of select='format-number(m1:totalValueWeeklyLiquidAssets, "$###,###,###,##0.00")' />
						</xsl:if>
					</div>				
				</td>
			</tr>
			
			<tr>
				<td class="label">
					<blockquote>
						c. Percentage of Total Assets invested in Daily Liquid Assets:
					</blockquote>
				</td>
			
				<td>
					<div class="fakeBox2">
						<xsl:if test="string(m1:percentageDailyLiquidAssets) &gt;= 0">
							<xsl:variable name="dailyWeek1" select='format-number(m1:percentageDailyLiquidAssets,  "0.0000", "percentage")' />
							<xsl:value-of select='format-number(100 * $dailyWeek1 , "dd0.00", "percentage")' />%
						</xsl:if>
					</div>				
				</td>
			</tr>
			
			<tr>
				<td class="label">
					<blockquote>
						d. Percentage of Total Assets invested in Weekly Liquid Assets (including Daily Liquid Assets):
					</blockquote>
				</td>
				
				<td>
					<div class="fakeBox2">
						<xsl:if test="string(m1:percentageWeeklyLiquidAssets) &gt;= 0">
							<xsl:variable name="weeklyWeek1" select='format-number(m1:percentageWeeklyLiquidAssets,  "0.0000", "percentage")' />
							<xsl:value-of select='format-number(100 * $weeklyWeek1 ,  "dd0.00", "percentage")' />%
						</xsl:if>
					</div>				
				</td>
			</tr>
			
			<tr>
				<td class="label">
					<blockquote>
						Date:
					</blockquote>
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="m1:totalLiquidAssetsNearPercentDate" />
					</div>				
				</td>
			</tr>
			</xsl:for-each>
			
			<tr>
				<td class="label">
					<b>Item A.14.</b> Provide the following, to the nearest cent:
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="label">
					<blockquote>
						a. Cash. (See General Instructions E.)
					</blockquote>
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:cash) &gt; 0">
							<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:cash, "$###,##0.00")' />
						</xsl:if>
					</div>				
				</td>
			</tr>
			
			<tr>
				<td class="label">
					<blockquote>
						b. Total Value of portfolio securities. (See General Instructions E.)
					</blockquote>
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:totalValuePortfolioSecurities) &gt; 0">
							<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:totalValuePortfolioSecurities, "$###,###,###,##0.00")' />
						</xsl:if>
					</div>				
				</td>
			</tr>			
			<tr>
				<td class="label">
					<blockquote>
						<blockquote>
							i. If any portfolio securities are valued using amortized cost, the total value of the portfolio securities valued at amortized cost
						</blockquote>
					</blockquote>
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:amortizedCostPortfolioSecurities) &gt; 0">
							<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:amortizedCostPortfolioSecurities, "$###,###,###,##0.00")' />
						</xsl:if>
					</div>				
				</td>
			</tr>
			<tr>
				<td class="label">
					<blockquote>
						c. Total Value of other assets (excluding amounts provided in A.14.a-b.)
					</blockquote>
				</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:totalValueOtherAssets) &gt; 0">
							<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:totalValueOtherAssets, "$###,###,###,##0.00")' />
						</xsl:if>
					</div>				
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item A.15.</b> Total value of liabilities, to the nearest cent</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:totalValueLiabilities) &gt; 0">
							<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:totalValueLiabilities, "$###,###,###,##0.00")' />
						</xsl:if>
					</div>									
				</td>
			</tr>
			<tr>
				<td class="label"><b>Item A.16.</b> Net assets of the series, to the nearest cent</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:netAssetOfSeries) &gt; 0">
							<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:netAssetOfSeries, "$###,###,###,##0.00")' />
						</xsl:if>
					</div>									
				</td>
			</tr>		
			<tr>
				<td class="label"><b>Item A.17.</b> Number of shares outstanding, to the nearest hundredth</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:numberOfSharesOutstanding) &gt; 0">
							<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:numberOfSharesOutstanding ,  "ddd,ddd,ddd,dd0.00dd", "percentage")' />
						</xsl:if>
					</div>									
				</td>
			</tr>	
			<tr>
				<td class="label"><b>Item A.18.</b> Does the fund seek to maintain a stable price per share?</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:seekStablePricePerShare) = 'Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:seekStablePricePerShare) = 'N'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
						</xsl:otherwise>
					</xsl:choose>							
				</td>
			</tr>
				<tr>
				<td class="label">a. If yes, state the price the fund seeks to maintain</td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:seriesLevelInfo/m1:stablePricePerShare) &gt; 0">
							$<xsl:value-of select='format-number(m1:seriesLevelInfo/m1:stablePricePerShare,  "#,##0.0000")' />							
						</xsl:if>
					</div>									
				</td>
			</tr>
			
			<tr>
				<td class="label"><b>Item A.19.</b> 7-day gross yield. For each business day, based on the immediately preceding 7 business days, calculate the fund’s yield by determining the net change, exclusive of capital changes and income other than investment income, in the value of a hypothetical pre-existing account having a balance of one share at the beginning of the period and dividing the difference by the value of the account at the beginning of the base period to obtain the base period return, and then multiplying the base period return by (365/7) with the resulting yield figure carried to at least the nearest hundredth of one percent. The 7-day gross yield should not reflect a deduction of shareholders fees and fund operating expenses. For master funds and feeder funds, report the 7-day gross yield at the master-fund level. </td>
				<td>
				</td>
			</tr>
			<xsl:for-each select="m1:seriesLevelInfo/m1:sevenDayGrossYield">
			<tr>
				<td class="label">a. 7-day gross yield </td>
				<td>
					<div class="fakeBox2">
						<xsl:if test="count(m1:sevenDayGrossYieldValue) &gt; 0">
						<!--	<xsl:value-of select='format-number(m1:sevenDayGrossYieldValue , "0.0000", "percentage")' />	  -->							
								<xsl:variable name="sevenDayGrossYieldValue" select='format-number(m1:sevenDayGrossYieldValue , "0.0000", "percentage")'/>
							<xsl:value-of select='format-number(100 * $sevenDayGrossYieldValue ,  "dd0.00", "percentage")' />%	
																									
						</xsl:if>
					</div>									
				</td>
			</tr>
			<tr>
				<td class="label">b. Date </td>
				<td>
					<div class="fakeBox2">
						<xsl:value-of select="(m1:sevenDayGrossYieldDate)" />
					</div>									
				</td>
			</tr>		
		    </xsl:for-each>


			<tr>
				<td class="label">
					<b>Item A.20.</b> Net asset value per share.  Provide the net asset value per share, calculated using available market quotations (or an appropriate substitute that reflects current market conditions) rounded to the fourth decimal place in the case of a fund with a $1.0000 share price (or an equivalent level of accuracy for funds with a different share price), as of the close of business on each business day of the month reported.

				</td>
				<td>
				</td>
			</tr>
			<xsl:for-each select="m1:seriesLevelInfo/m1:dailyNetAssetValuePerShareSeries">
				<tr>
					<td class="label">
						<blockquote>
							a. Net asset value per share
						</blockquote>
					</td>
					<td>
						<div class="fakeBox2">
							<xsl:if test="count(m1:dailyNetAssetValuePerShareSeries) &gt; 0">
								<xsl:value-of select='format-number(number(m1:dailyNetAssetValuePerShareSeries), "$#,##0.0000")' />
							</xsl:if>
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
							<xsl:value-of select="(m1:dailyNetAssetValuePerShareDateSeries)" />
						</div>
					</td>
				</tr>
			</xsl:for-each>
			
			<tr>
				<td class="label"><b>Item A.21. </b>Is the fund established as a cash management vehicle for affiliated funds or other accounts managed by related entities or their affiliates and not available to other investors?</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:cashMgmtVehicleAffliatedFundFlag)='Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:cashMgmtVehicleAffliatedFundFlag)='N'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
						</xsl:otherwise>
					</xsl:choose>							
				</td>
			</tr>
			
			<tr>
				<td class="label"><b>Item A.22. </b>Liquidity Fee. During the reporting period, did the fund apply any liquidity fees under rule 2a-7(c)(2)?</td>
				<td>
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:liquidityFeeFundApplyFlag)='Y'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> Yes
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> Yes
						</xsl:otherwise>
					</xsl:choose> &#160;
					<xsl:choose>
						<xsl:when test="string(m1:seriesLevelInfo/m1:liquidityFeeFundApplyFlag)='N'">
							<img src="Images/radio-checked.jpg" alt="Radio button checked"/> No
						</xsl:when>
						<xsl:otherwise>
							<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/> No
						</xsl:otherwise>
					</xsl:choose>							
				</td>
			</tr>
			<tr>
				<td class="label">If Yes, answer Item A.22.a</td>
				<td>
										
				</td>
			</tr>						
			
			<xsl:if test="string(m1:seriesLevelInfo/m1:liquidityFeeFundApplyFlag)='Y'">
				<tr>
					<td class="label">
						<blockquote>
							a.	For each business day the fund applied a liquidity fee during the reporting period, provide:								
						</blockquote>
					</td>
					<td>
					</td>
				</tr>
				
				<!--start  for loop -->
				
				<xsl:for-each select="m1:seriesLevelInfo/m1:liquidityFeeReportingPeriod">
				
				<tr>
					<td class="label"><blockquote><blockquote>i. The date on which the liquidity fee was applied:</blockquote></blockquote></td>
					<td>
						<div class="fakeBox2">
								<xsl:value-of select="(m1:liquidityFeeApplyDate)" />
						</div>
					</td>										
				</tr>
				
				
				<tr>
					<td class="label"><blockquote><blockquote>ii. The type of liquidity fee:</blockquote></blockquote></td>
					<td>
						
						<xsl:choose>
							<xsl:when test="string(m1:liquidityFeeTypeForReportingPeriod) = 'Mandatory liquidity fee, with the amount of the fee based on good faith estimates of liquidity costs under rule 2a-7(c)(2)(iii)(A)'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Mandatory liquidity fee, with the amount of the fee based on good faith estimates of liquidity costs under rule 2a-7(c)(2)(iii)(A)<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:liquidityFeeTypeForReportingPeriod) = 'Mandatory liquidity fee, using the default amount under rule 2a-7(c)(2)(iii)(C)'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Mandatory liquidity fee, using the default amount under rule 2a-7(c)(2)(iii)(C)<br/>
						
						<xsl:choose>
							<xsl:when test="string(m1:liquidityFeeTypeForReportingPeriod) = 'Discretionary liquidity fee under rule 2a-7(c)(2)(ii)'">
								<img src="Images/radio-checked.jpg" alt="Radio button checked"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="Images/radio-unchecked.jpg" alt="Radio button not checked"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>&#160;</xsl:text> Discretionary liquidity fee under rule 2a-7(c)(2)(ii)<br/>
						
					</td>					
				</tr>
				
				<tr>
					<td class="label"><blockquote><blockquote>iii. The total dollar amount of the liquidity fee applied to redemptions:</blockquote></blockquote></td>
					<td>
						<div class="fakeBox2">	
							<xsl:if test="count(m1:liquidityFeeAmountApplyToRedemption) &gt; 0">
							<xsl:value-of select='format-number(m1:liquidityFeeAmountApplyToRedemption, "$###,###,###,##0.00")' />
						</xsl:if>
						</div>
					</td>
				</tr>
				
				<tr>
					<td class="label"><blockquote><blockquote>iv. The amount of the liquidity fee as a percentage of the value of shares redeemed:</blockquote></blockquote></td>
					<td>
						<div class="fakeBox2">	
							<xsl:if test="string(m1:liquidityFeePercentSharesRedeemed) &gt;= -1.9999">
							<xsl:variable name="liquidityFeePercentSharesRedeemed" select='format-number(m1:liquidityFeePercentSharesRedeemed , "0.0000", "percentage")'/>
							<xsl:value-of select='format-number(100 * $liquidityFeePercentSharesRedeemed ,  "dd0.00", "percentage")' />%							
						</xsl:if>
						</div>
					</td>										
				</tr>
				
				</xsl:for-each>
				<!-- end for loop -->
				
				
			</xsl:if>
			
		</table>
	</xsl:template>
</xsl:stylesheet>

