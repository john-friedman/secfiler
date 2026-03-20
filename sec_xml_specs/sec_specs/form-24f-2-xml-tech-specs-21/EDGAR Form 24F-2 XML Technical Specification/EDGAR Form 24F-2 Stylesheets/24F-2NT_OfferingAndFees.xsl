<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/twentyfourf2filer"
	xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
	xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/regacommon" xmlns:feecom="http://www.sec.gov/edgar/feecommon">

	<!-- Item 1 templates -->
	<xsl:template name="offeringsAndFee">
     
     
	 <table role="presentation">
			<tr>
				<td>
					
					This section is optional, unless you owe a fee with this filing. To calculate the fee, please
					 enter the incremental increases between the original 24F-2NT form and the amended form 24F-2NT/A
					  in the Sales Proceeds and Redeemed Value fields.
				</td>
					
			</tr>
			<tr>
				<td>
					
					Example:  The original 24F-2NT showed Sales Proceeds of $1,000,000 and Redeemed Value of $750,000.
					 A fee was paid on $250,000.  
				</td>
		
			</tr>
			<tr>
				<td>
					
					If the 24F-2NT is amended to show Sales Proceeds of $1,500,000 and a Redeemed Value of $1,000,000,
					 the header for the amendment should show Sales Proceeds of $500,000 and Redeemed Value of $250,000
					  (the incremental difference between the two filings). A fee will be paid on $250,000. 
				</td>
		
			</tr>
			
		</table>
     <xsl:for-each select="m1:offeringsAndFees/m1:offeringsAndFeesInfo">
      <table role="presentation"><tr>Offerings and Fees Record:<xsl:value-of select="position()"></xsl:value-of></tr></table>
     

        <table role="presentation">
         	<tr>
				<td class="label">Sales Proceeds</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:salesProceeds" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			 </tr>
			 
			 <tr>
				<td class="label">Redeemed Value</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:redeemedValue" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			 </tr>
			 
			 <tr>
				<td class="label">Net Value</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:netValue" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			 </tr>
			 <tr>
				<td class="label">Fee</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:feeAmount" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			 </tr>
			 
        </table>			
   
    </xsl:for-each>
    
      <table role="presentation">
      <br/>
         	<tr>
				<td class="label">Total Due</td>
				<td>

					<div class="fakeBox3">
						<xsl:value-of select="m1:offeringsAndFees/m1:totalDue" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			 </tr>
	 </table>

</xsl:template>
	



</xsl:stylesheet>