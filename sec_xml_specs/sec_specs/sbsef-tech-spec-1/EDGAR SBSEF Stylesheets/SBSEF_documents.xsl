<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/sbseffiler"
    xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
    xmlns:ns2="http://www.sec.gov/edgar/statecodes" xmlns:ns3="http://www.sec.gov/edgar/sbsefcommon"
    xmlns:exa="http://www.sec.gov/edgar/document/sbsef/exhibita"
	xmlns:exb="http://www.sec.gov/edgar/document/sbsef/exhibitb"
	xmlns:exgmn="http://www.sec.gov/edgar/document/sbsef/exhibitgmn"
	xmlns:ext="http://www.sec.gov/edgar/document/sbsef/exhibitt">

	<!-- Documents templates -->
    
	<xsl:template name="Documents">		
		<h3>
			<em>Documents</em>
		</h3>
		<xsl:call-template name="SBSEF_Documents"/>
	</xsl:template>
	

	<xsl:template name="SBSEF_Documents">
		<table role="presentation" >
			<tr>
				<td class="label">FILE NAME
				</td>
				<td>
					<div class="fakeBox">
						<xsl:value-of select="ns1:conformedName" />
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
				</td>
			</tr>
			<tr>
                <td class="label">TYPE
                </td>
                <td>
                    <div class="fakeBox">
                        <xsl:value-of select="ns1:conformedDocumentType" />
                        <span>
                            <xsl:text>&#160;</xsl:text>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">DESCRIPTION
                </td>
                <td>
                    <div class="fakeBox">
                        <xsl:value-of select="ns1:description" />
                        <span>
                            <xsl:text>&#160;</xsl:text>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">ERRORS
                </td>
                <td>
                    <div class="fakeBox">
                        <xsl:value-of select="ns1:contents" />
                        <span>
                            <xsl:text>&#160;</xsl:text>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Request Confidentiality:
                </td>
                <td>
                    <xsl:choose>
                        <xsl:when test="(ns1:confidentiality) = 'true'">
                            <img src="Images/box-checked.jpg" alt="Checkbox checked" />
                        </xsl:when>
                        <xsl:otherwise>
                            <img src="Images/box-unchecked.jpg" alt="Checkbox not checked" />
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
		</table>
	</xsl:template>
</xsl:stylesheet>