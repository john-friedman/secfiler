<!DOCTYPE xsl:stylesheet  [
        <!ENTITY ndash "&#8211;">
        ]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/npxctr"
                xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
                xmlns:ns2="http://www.sec.gov/edgar/statecodes">

    <!-- Summary - Included Managers templates -->
    <xsl:template name="summaryPage">
        <table role="presentation" class="im-count">
            <tr>
                <td class="label">Number of Included Institutional Managers:</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:otherIncludedManagersCount)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
        </table>
        <xsl:choose>
            <xsl:when test="string(m1:otherIncludedManagersCount) = '0'">
                <table role="presentation">
                    <td class="label">Included Institutional Managers:</td>
                    <td>
                        <em>NONE</em>
                    </td>
                </table>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="m1:otherManagers2/m1:investmentManagers">
                    <table role="presentation" class="im-list">
                        <tr>
                            <h4>
                                <em>Included Institutional Managers:<xsl:value-of select="position()"></xsl:value-of></em>
                            </h4>
                        </tr>
                        <tr>
                            <td class="label">No.:</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:serialNo)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">Form 13F File Number [028-]:</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:form13FFileNumber)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">CRD Number (if any):</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:crdNumber)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">SEC File Number (if any):</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:secFileNumber)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">LEI (if any):</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:leiNumber)" />
                                        <span>
                                            <xsl:text>&#160;</xsl:text>
                                        </span>
                                    </div>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">Name:</td>
                            <td>
                                <p>
                                    <div class="fakeBox">
                                        <xsl:value-of select="string(m1:name)" />
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