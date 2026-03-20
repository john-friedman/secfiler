<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="http://www.sec.gov/edgar/schedule13D"
	xmlns:p1="http://www.sec.gov/edgar/common">
	
	<xsl:template name="headerInfo">
			<xsl:if test="string(p:filerInfo/p:filer/p:filerCredentials/p:cik) != ''"/>
	</xsl:template>
	
</xsl:stylesheet>
