<!DOCTYPE xsl:stylesheet  [
        <!ENTITY ndash "&#8211;">
        ]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/npx"
                xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
                xmlns:ns2="http://www.sec.gov/edgar/statecodes">

    <!-- Summary - Included Series templates -->
    <xsl:template name="summarySeriesPage">
        <table role="presentation" class="series-count">
            <tr>
                <td class="label">Number of Series:</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:seriesCount)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
        </table>
        <xsl:choose>
            <xsl:when test="string(m1:seriesCount) = '0'">
                <table role="presentation">
                    <td class="label">Information about the Series:</td>
                    <td>
                        <em>NONE</em>
                    </td>
                </table>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="m1:seriesDetails/m1:seriesReports">
                    <table role="presentation" class="series-list">
                        <tr>
                            <h4>
                                <em>Information about the Series:<xsl:value-of select="position()"></xsl:value-of></em>
                            </h4>
                        </tr>
                        <tr>
                            <td class="label">Series Identification Number:</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:idOfSeries)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">Series Name:</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:nameOfSeries)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">LEI: </td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:leiOfSeries)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                    </table>

                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>