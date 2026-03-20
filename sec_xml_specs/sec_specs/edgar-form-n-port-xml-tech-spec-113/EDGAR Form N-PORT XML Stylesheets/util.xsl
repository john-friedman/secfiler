<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- 
		format_to_dollar: This template formats an amount of money (dollars + change) to a pattern that matches EDGAR standards.	
	-->	
	<xsl:template name="format_to_dollar">
		<xsl:param name="money"/>
	    <xsl:choose>
			<xsl:when test="number($money) > 0">
				$<input type="text" class="shortDollar" readonly="1" style="color:#000080;">
					<xsl:attribute name="value">
						<xsl:variable name="dollarAmount" select="number(substring-before($money, '.'))"/>					
						<xsl:variable name="centAmount" select="number(substring-after($money, '.'))" />
						<!-- format and printout dollar amount -->
						<xsl:value-of select="format-number($dollarAmount, '###,###,###,###,###')"/>
						<!-- format and printout cent amount -->
						<xsl:choose>
							<xsl:when test="$centAmount &lt; 100">
								<xsl:value-of select="format-number($centAmount div 100, '.00')"/>
							</xsl:when>
							<!-- the amount entered is incorrect if you reach here. Only 2 digits after decimal point are allowed. -->
							<xsl:otherwise>
								<xsl:value-of select="string('.')"/>
								<xsl:value-of select="substring-after($money, '.')"/> <!-- don't do number conversion. You might lose some value -->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</input>
			</xsl:when>
			<xsl:otherwise>
				$<input type="text" name="court type" class="shortDollar" readonly="1"></input>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="format_to_dollar_large">
	    <xsl:param name="money"/>
	    
    	<xsl:variable name="dollars">
			<xsl:choose>
				<xsl:when test="contains($money,'.')">
					<xsl:value-of select="substring-before($money,'.')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$money"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	    <xsl:choose>
	    	<xsl:when test="string-length($dollars) &lt; 3 or string-length($dollars) = 3">
	            <xsl:value-of select="$money"/>
	        </xsl:when>
	        <xsl:otherwise>
	        	<xsl:choose>
			        <xsl:when test="string-length($dollars) mod 3 = 1 and string-length($dollars) div 3 > 0">
			        	<xsl:choose>
			        		<xsl:when test="starts-with($dollars, '-')">
			            		<xsl:value-of select="concat(substring($dollars,1,1), '')"/>
			            	</xsl:when>
			            	<xsl:otherwise>
			            <xsl:value-of select="concat(substring($dollars,1,1), ',')"/>
			            	</xsl:otherwise>
			            </xsl:choose>

			            <xsl:call-template name="format_to_dollar_large">
				            <xsl:with-param name="money" select="substring($money,2)"/>
				        </xsl:call-template>
			        </xsl:when>
			        <xsl:when test="string-length($dollars) mod 3 = 2 and string-length($dollars) div 3 > 0">
			            <xsl:value-of select="concat(substring($dollars,1,2), ',')"/>
			            <xsl:call-template name="format_to_dollar_large">
				            <xsl:with-param name="money" select="substring($money,3)"/>
				        </xsl:call-template>
			        </xsl:when>
			        <xsl:when test="string-length($dollars) mod 3 = 0 and string-length($dollars) div 3 > 1">
			            <xsl:value-of select="concat(substring($dollars,1,3), ',')"/>
			            <xsl:call-template name="format_to_dollar_large">
				            <xsl:with-param name="money" select="substring($money,4)"/>
				        </xsl:call-template>
			        </xsl:when>
		        </xsl:choose>
		    </xsl:otherwise>
	    </xsl:choose>
	    
	</xsl:template>
	
	<xsl:template name="CIKLink">	 
      <xsl:param name="aCIK" />
      <xsl:param name="label" />      
	  
      <xsl:element name="a">         		 
         <xsl:attribute name="href">/cgi-bin/browse-edgar?action=getcompany&amp;CIK=<xsl:value-of select="$aCIK" /></xsl:attribute>		 
		 <xsl:attribute name="target">_blank</xsl:attribute>
		 <xsl:attribute name="style">color: blue;</xsl:attribute>
         <xsl:apply-templates select="$label"/>
      </xsl:element>
	 
	</xsl:template>
	
   <xsl:template name="FileNoLink">
      <xsl:param name="aFileNumber" />
      <xsl:param name="label" />
	  
      <xsl:element name="a">
         <xsl:attribute name="href">/cgi-bin/browse-edgar?action=getcompany&amp;filenum=<xsl:value-of select="$aFileNumber" /></xsl:attribute>
		 <xsl:attribute name="target">_blank</xsl:attribute>
		 <xsl:attribute name="style">color: blue;</xsl:attribute>
         <xsl:apply-templates select="$label" />
      </xsl:element>
	  
   </xsl:template>
</xsl:stylesheet>
