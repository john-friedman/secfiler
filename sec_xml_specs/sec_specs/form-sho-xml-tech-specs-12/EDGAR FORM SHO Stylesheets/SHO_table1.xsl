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
	
	<!-- Table 1 Template START -->
	<xsl:template name="table1">
	   <div id="table1">
		 <div class="contentwrapper">
			<div class="content">
			   <h1 style="margin-top: 25px;">Form <xsl:value-of select="$submissionType" />: Table 1 - Manager's Monthly Gross Short Position</h1>
			   <table role="presentation" class="tableClass" id="table1">
				   <tr width="100%" class="tableClassWithBg">
						<th  width="14%" class="tableClassRight">Column 1</th>
						<th  width="8%" class="tableClass">Column 2</th>
						<th  width="16%" class="tableClass">Column 3</th>
						<th  width="10%" class="tableClass">Column 4</th>
						<th  width="8%" class="tableClass">Column 5</th>
						<th  width="8%" class="tableClass">Column 6</th>
						<th  width="12%" class="tableClass">Column 7</th>
						<th  width="8%" class="tableClass">Column 8</th>				
					</tr>
					<tr width="100%" class="tableClassWithBg">
						<th  width="14%" class="tableClassRight">Settlement Date (Month End)</th>
						<th  width="8%" class="tableClass">Issuer Name</th>
						<th  width="16%" class="tableClass">Issuer LEI</th>
						<th  width="10%" class="tableClass">Title of Class</th>
						<th  width="8%" class="tableClass">CUSIP Number</th>
						<th  width="8%" class="tableClass">FIGI</th>
						<th  width="12%" class="tableClass">End of Month Gross Short Position (Number of Shares)</th>
						<th  width="8%" class="tableClass">End of Month Gross Short Position (Rounded to nearest USD)</th>				
					</tr>
					<xsl:for-each select="p:managersGrossShortTable1/p:managersGrossShortTable1Info">
						<tr width="100%" class="tableClass">
							<td width="14%" class="tableClassRight">
								<xsl:value-of select="string(p:settlementDate)" />
							</td>
							<td width="8%" class="tableClass">
								<xsl:value-of select="string(p:issuerName)" />
							</td>
							<td width="16%" class="tableClass">
								<xsl:value-of select="string(p:leiNumber)" />
							</td>
							<td width="14%" class="tableClass">
								<xsl:value-of select="string(p:securitiesClassTitle)" />
							</td>
							<td width="8%" class="tableClass">
								<xsl:value-of select="string(p:issuerCusip)" />
							</td>
							<td width="12%" class="tableClass">
								<xsl:value-of select="string(p:figiNumber)" />
							</td>
							<td width="8%" class="tableClass">
								<xsl:value-of select="string(p:numberOfShares)" />
							</td>
							<td width="16%" class="tableClassLeft">
								<xsl:value-of select="string(p:valueOfShares)" />
							</td>
						</tr>
					</xsl:for-each>
				 
				 </table>
				  <div id="table1Note">
                    <p>
	                    <a href="https://www.sec.gov/files/rules/final/2023/34-98738.pdf" target="_blank" rel="noopener noreferrer">
	                    <i>Federal Register :: Short Position and Short Activity Reporting by Institutional Investment Managers</i></a><br/><br/>
	                	Report the gross short position at the close of regular trading hours on the last settlement date of the reporting period
	                    in terms of both the number of shares (rounded down to the nearest positive integer, or zero if less than one share) and
	                    the U.S. dollar value (rounded to the nearest dollar). A positive number of shares and dollar value indicates the Manager
	                    has a gross short position as of the last settlement date of the reporting period. A value of zero (&quot;0&quot;) shares
	                    and U.S. dollars indicates the Manager has no gross short position as of the last settlement date of the reporting period.
	                    Neither value should be expressed as a negative number.<br/><br/>
	                    Under Rule 13f-2, &quot;gross short position&quot; is a short position resulting from a short sale, without inclusion of 
	                    any offsetting economic positions such as shares of an equity security or derivatives of such equity security. Under Rule 
	                    200(a) of Regulation SHO, a short sale is any sale of securities which the seller, such as a desk or account, does not own 
	                    or has borrowed to consummate delivery. Accordingly, any short sale, including any sale order marked &quot;long&quot; 
	                    consistent with Rule 200 of Regulation SHO, can result in a gross short position that Rule 13f-2 may require to be reported.</p>
	                </div>
			</div>
		</div>
	  </div>
   </xsl:template>
   <!-- Table 1 Template END -->
	
</xsl:stylesheet>