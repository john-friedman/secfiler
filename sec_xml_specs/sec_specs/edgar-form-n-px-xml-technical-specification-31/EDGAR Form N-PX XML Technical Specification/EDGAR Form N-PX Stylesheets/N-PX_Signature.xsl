<!DOCTYPE xsl:stylesheet  [
        <!ENTITY ndash "&#8211;">
        ]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/npx"
                xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
                xmlns:ns2="http://www.sec.gov/edgar/statecodes">

    <!-- Cover Page templates -->
    <xsl:template name="signaturePage">
        <table role="presentation" class="signature">
            <tr>
                <td class="label">Reporting Person:</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:reportingPerson)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">By (Signature):</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:txSignature)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">By (Printed Signature):</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:txPrintedSignature)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">By (Title):</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:txTitle)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Date:</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:txAsOfDate)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
        </table>

        <xsl:for-each select="m1:secondaryRecords/m1:secondaryRecord">
            <table role="presentation" class="signature-list">
                <tr>
                    <h4>
                        <em>Additional Signatures:<xsl:value-of select="position()"></xsl:value-of></em>
                    </h4>
                </tr>
                <tr>
                    <td class="label">By (Signature):</td>
                    <td>
                        <p>
                            <div class="fakeBox">
                                <xsl:value-of select="string(m1:txSignature)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </div>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td class="label">By (Printed Signature):</td>
                    <td>
                        <p>
                            <div class="fakeBox">
                                <xsl:value-of select="string(m1:printedSign)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </div>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td class="label">By (Title):</td>
                    <td>
                        <p>
                            <div class="fakeBox">
                                <xsl:value-of select="string(m1:txTitle)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </div>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td class="label">Date:</td>
                    <td>
                        <p>
                            <div class="fakeBox">
                                <xsl:value-of select="string(m1:txAsOfDate)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </div>
                        </p>
                    </td>
                </tr>
            </table>

        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>