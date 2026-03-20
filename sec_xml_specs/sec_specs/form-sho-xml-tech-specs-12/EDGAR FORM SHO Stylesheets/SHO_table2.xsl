<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
		<!ENTITY ndash "&#8211;">
		]>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:p="http://www.sec.gov/edgar/formSho"
				xmlns:p1="http://www.sec.gov/edgar/common"
				xmlns:ns2="http://www.sec.gov/edgar/statecodes">


	<xsl:output
			method="html"
			indent="no"
			encoding="iso-8859-1"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
	
	 <!-- Table 2 Template START -->
	<xsl:template name="table2">
	  <div id="table2">
		  <div class="contentwrapper">
			<div class="content">
				<h1 style="margin-top: 25px;">Form <xsl:value-of select="$submissionType" />: Table 2 - Daily Activity Affecting Manager's Gross Short Position During the Reporting Period</h1>
				<table role="presentation" class="tableClass" id="table2Header">
				   <tr width="100%" class="tableClassWithBg">
						<th  width="14%" class="tableClassRight">Column 1</th>
						<th  width="8%" class="tableClass">Column 2</th>
						<th  width="16%" class="tableClass">Column 3</th>
						<th  width="10%" class="tableClass">Column 4</th>
						<th  width="8%" class="tableClass">Column 5</th>
						<th  width="8%" class="tableClass">Column 6</th>
						<th  width="12%" class="tableClass">Column 7</th>				
					</tr>
					<tr width="100%" class="tableClassWithBg">
					   <th  width="14%" class="tableClassRight">Settlement Date</th>	
						<th  width="8%" class="tableClass">Issuer Name</th>
						<th  width="16%" class="tableClass">Issuer LEI</th>
						<th  width="10%" class="tableClass">Title of Class</th>
						<th  width="8%" class="tableClass">CUSIP Number</th>
						<th  width="8%" class="tableClass">FIGI</th>
						<th  width="12%" class="tableClass">Net Change in Short Position (Number of Shares)</th>			
					</tr>
				</table>
				<xsl:for-each select="p:managersDailyGrossShortTable2/p:table2IssuerList">
					<xsl:variable name = "issuerName" select="string(p:shortIssuerName)" />
					<xsl:variable name = "leiNumber" select="string(p:leiNumber)" />
					<xsl:variable name = "securitiesClassTitle" select="string(p:securitiesClassTitle)" />
					<xsl:variable name = "issuerCusip" select="string(p:issuerCusip)" />
					<xsl:variable name = "figiNumber" select="string(p:figiNumber)" />
				  	<span><h4><em>Issuer Name: <xsl:value-of select="$issuerName" /></em></h4></span>
				  	<table role="presentation" class="tableClass" id="table2">
					 	<xsl:for-each select="p:table2Details">
					   		<tr width="100%" class="tableClass">
						  		<td width="14%" class="tableClassRight">
							 		<xsl:value-of select="string(p:settlementDate)" />
						   		</td>
								<td width="8%" class="tableClass">
									<xsl:value-of select="$issuerName" />
								</td>
								<td width="16%" class="tableClass">
									<xsl:value-of select="$leiNumber" />
								</td>
								<td width="10%" class="tableClass">
									<xsl:value-of select="$securitiesClassTitle" />
								</td>
								<td width="8%" class="tableClass">
									<xsl:value-of select="$issuerCusip" />
								</td>
								<td width="8%" class="tableClass">
									<xsl:value-of select="$figiNumber" />
								</td>
								<td width="12%" class="tableClass">
									<xsl:value-of select="string(p:netChangeOfShares)" />
								</td>
							</tr>
					  	</xsl:for-each>
				    </table>
				</xsl:for-each>
				<div id="table2Note">
                    <p>
                    <a href="https://www.sec.gov/files/rules/final/2023/34-98738.pdf" target="_blank" rel="noopener noreferrer">
                    <i>Federal Register :: Short Position and Short Activity Reporting by Institutional Investment Managers</i></a><br/><br/>
                    For each settlement date during the reporting period, report how a Manager established or increased its gross short position, or reduced and/or closed out its gross short 
                    position, in an equity security through activities that affect the Manager&apos;s gross short position as prescribed in Form SHO Special Instruction 9.g. A positive number of 
                    shares indicates net acquisition activity in the equity security on the specified settlement date—i.e., reducing a Manager&apos;s gross short position. A negative number of
                    shares indicates net sale activity in the equity security on the specified settlement date—i.e., increasing a Manager&apos;s gross short position. Report zero (&quot;0&quot;)
                    shares only if there is buy/sell activity affecting a Manager&apos;s gross short position but no net change in that short position on the specified settlement date. Enter &quot;None&quot;
                    if, on the specified settlement date, there are no activities that affect the Manager&apos;s gross short position as prescribed in Form SHO Special Instruction 9.g.</p>
                </div>
			</div>
		</div>
	  </div>
   </xsl:template>
   <!-- Table 2 Template END -->
	
</xsl:stylesheet>