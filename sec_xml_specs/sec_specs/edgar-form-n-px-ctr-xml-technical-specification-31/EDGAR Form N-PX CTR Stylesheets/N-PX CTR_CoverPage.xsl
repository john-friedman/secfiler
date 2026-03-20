<!DOCTYPE xsl:stylesheet  [
        <!ENTITY ndash "&#8211;">
        ]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m1="http://www.sec.gov/edgar/npxctr"
                xmlns:ns1="http://www.sec.gov/edgar/common" xmlns:n1="http://www.sec.gov/edgar/common_drp"
                xmlns:ns2="http://www.sec.gov/edgar/statecodes">

    <!-- Cover Page templates -->
    <xsl:template name="coverPageFull">
        <xsl:if test="$submissionType = 'N-PX CTR/A'">
            <xsl:call-template name="amendment" />
        </xsl:if>
        <xsl:call-template name="coverPage" />
    </xsl:template>

    <xsl:template name="amendment">
        <table role="presentation" class="amendmentInfo">
            <tr>
                <td class="label">Check here if amendment:</td>
                <td>
                    <xsl:choose>
                        <xsl:when	test="$submissionType = 'N-PX CTR/A'">
                            <img
                                    src="Images/box-checked.jpg"
                                    alt="Checkbox checked" />
                        </xsl:when>
                        <xsl:otherwise>
                            <img
                                    src="Images/box-unchecked.jpg"
                                    alt="Checkbox not checked" />
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
            <tr>
                <td class="label">Amendment number:</td>
                <td>
                    <div class="fakeBox2">
                        <xsl:value-of
                                select="string(m1:amendmentInfo/m1:amendmentNo)" />
                        <span>
                            <xsl:text>&#160;</xsl:text>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">
                    This Amendment (check only one):
                </td>
                <td>
                    <span class="yesNo">
                        <xsl:choose>
                            <xsl:when test="count(m1:amendmentInfo/m1:amendmentType) &gt; 0">
                                <xsl:choose>
                                    <xsl:when test="string(m1:amendmentInfo/m1:amendmentType) = 'NEW PROXY'">
                                        <img
                                                src="Images/radio-checked.jpg"
                                                alt="Radio button checked" />
                                        Adds new proxy voting entries.
                                        <img
                                                src="Images/radio-unchecked.jpg"
                                                alt="Radio button not checked" />
                                        Is a restatement.
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="string(m1:amendmentInfo/m1:amendmentType) = 'RESTATEMENT'">
                                        <img
                                                src="Images/radio-unchecked.jpg"
                                                alt="Radio button not checked" />
                                        Adds new proxy voting entries.
                                        <img
                                                src="Images/radio-checked.jpg"
                                                alt="Radio button checked" />
                                        Is a restatement.
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <img
                                        src="Images/radio-unchecked.jpg"
                                        alt="Radio button not checked" />
                                Adds new proxy voting entries.
                                <img
                                        src="Images/radio-unchecked.jpg"
                                        alt="Radio button not checked" />
                                Is a restatement.
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </td>
            </tr>
            
        </table>
    </xsl:template>

    <xsl:template name="coverPage">
        <table role="presentation" class="reportingPersonInfo">
            <tr>
                <h4>
                    <em>Name and address of reporting person:</em>
                </h4>
            </tr>

            <tr>
                <td class="label">Name of reporting person (For registered management investment companies, provide
                    exact name of registrant as specified in charter)</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:reportingPerson/m1:name)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Street 1 </td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:reportingPerson/m1:address/ns1:street1)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Street 2 </td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:reportingPerson/m1:address/ns1:street2)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">City</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:reportingPerson/m1:address/ns1:city)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">State/Country</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:call-template name="stateDescription">
                                <xsl:with-param name="stateCode"
                                                select="string(m1:reportingPerson/m1:address/ns1:stateOrCountry)" />
                            </xsl:call-template>
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Zip code and zip code extension or foreign postal code</td>
                <td>
                    <p>
                        <div align="left">
                            <div class="fakeBox2">
                                <xsl:value-of select="string(m1:reportingPerson/m1:address/ns1:zipCode)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </div>
                        </div>
                    </p>
                </td>
            </tr>
			<tr>
                <td class="label">Telephone number of reporting person, including area code:</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:reportingPerson/m1:phoneNumber)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>

        </table>

        <table role="presentation" class="agentForServiceInfo">
            <tr>
                <h4>
                    <em>Name and address of agent for service:</em>
                </h4>
            </tr>

            <tr>
                <td class="label">Name of agent for service</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:agentForService/m1:name)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Street 1 </td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:agentForService/m1:address/ns1:street1)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Street 2 </td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:agentForService/m1:address/ns1:street2)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">City</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:agentForService/m1:address/ns1:city)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">State/Country</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:call-template name="stateDescription">
                                <xsl:with-param name="stateCode"
                                                select="string(m1:agentForService/m1:address/ns1:stateOrCountry)" />
                            </xsl:call-template>
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
           <tr>
                <td class="label">Zip code and zip code extension or foreign postal code</td>
                <td>
                    <p>
                        <div align="left">
                            <div class="fakeBox2">
                                <xsl:value-of select="string(m1:agentForService/m1:address/ns1:zipCode)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </div>
                        </div>
                    </p>
                </td>
            </tr>

        </table>

        <table role="presentation" class="reportPeriod">
            <tr>
                <td class="label">Reporting Period:</td>
                <td>
                    <xsl:choose>
                        <xsl:when test="string(m1:yearOrQuarter) = 'YEAR'">
                            <span>Report for the year ended June 30, </span>
                            <span class="fakeBox2">
                                <xsl:value-of
                                        select="string(m1:reportCalendarYear)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span>Report for the period July 1, </span>
                            <span class="fakeBox2">
                                <xsl:value-of
                                        select="string(m1:reportQuarterYear)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </span>
                            <span>to September 30, </span>
                            <span class="fakeBox2">
                                <xsl:value-of
                                        select="string(m1:reportQuarterYear)" />
                                <span>
                                    <xsl:text>&#160;</xsl:text>
                                </span>
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
        </table>

        <table role="presentation" class="secNumbers">
            <tr>
                <td class="label">SEC Investment Company Act or Form 13F File Number:</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:fileNumber)" />
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
                            <xsl:value-of select="string(m1:reportingCrdNumber)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Other SEC File Number (if any):</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:reportingSecFileNumber)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
            <tr>
                <td class="label">Legal Entity Identifier (if any):</td>
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
        </table>

        <table role="presentation" class="reportType">
            <tr>
                <h4>
                    <em>Report Type (check only one):</em>
                </h4>
            </tr>
            <tr>
                <td class="label"></td>
                <td>
                    <span class="yesNo">
                        <xsl:choose>
                            <xsl:when test="count(m1:reportInfo/m1:reportType) &gt; 0">
                                                        
                                <xsl:choose>
                                    <xsl:when test="string(m1:reportInfo/m1:reportType) = 'INSTITUTIONAL MANAGER VOTING REPORT'">
                                       
                                        <div class="report-subLabel">Institutional Manager.</div>
                                        <div class="pl-25">
                                            <img
                                                    src="Images/radio-checked.jpg"
                                                    alt="Radio button checked" />
                                            Institutional Manager Voting Report (Check here if all proxy votes of this reporting manager are reported in this report.)
                                        </div>
                                       
                                        <div class="pl-25">
                                            <img
                                                    src="Images/radio-unchecked.jpg"
                                                    alt="Radio button not checked" />
                                            Institutional Manager Combination Report (Check here if a portion of the proxy votes for this reporting manager are reported in this report and a portion are reported by other reporting person(s).)
                                        </div>
                                    </xsl:when>
                                </xsl:choose>
                                
                                <xsl:choose>
                                    <xsl:when test="string(m1:reportInfo/m1:reportType) = 'INSTITUTIONAL MANAGER COMBINATION REPORT'">                                       
                                        <div class="report-subLabel">Institutional Manager.</div>
                                        <div class="pl-25">
                                            <img
                                                    src="Images/radio-unchecked.jpg"
                                                    alt="Radio button not checked" />
                                            Institutional Manager Voting Report (Check here if all proxy votes of this reporting manager are reported in this report.)
                                        </div>                                       
                                        <div class="pl-25">
                                            <img
                                                    src="Images/radio-checked.jpg"
                                                    alt="Radio button checked" />
                                            Institutional Manager Combination Report (Check here if a portion of the proxy votes for this reporting manager are reported in this report and a portion are reported by other reporting person(s).)
                                        </div>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>                               
                                <div class="report-subLabel">Institutional Manager.</div>
                                <div class="pl-25">
                                    <img
                                            src="Images/radio-unchecked.jpg"
                                            alt="Radio button not checked" />
                                    Institutional Manager Voting Report (Check here if all proxy votes of this reporting manager are reported in this report.)
                                </div>                                
                                <div class="pl-25">
                                    <img
                                            src="Images/radio-unchecked.jpg"
                                            alt="Radio button not checked" />
                                    Institutional Manager Combination Report (Check here if a portion of the proxy votes for this reporting manager are reported in this report and a portion are reported by other reporting person(s).)
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </td>
            </tr>
        </table>       

        <table role="presentation" class="otherManagersList">
            <xsl:for-each select="m1:otherManagersInfo/m1:otherManager">
                <table role="presentation" class="secNumbers">
                    <tr>
                        <h4>
                            <em>Other Persons Reporting for this Manager:<xsl:value-of select="position()"></xsl:value-of></em>
                        </h4>
                    </tr>
                    <tr>
                        <td class="label">Investment Company Act or Form 13F File Number:</td>
                        <td>
                            <p>
                                <div class="fakeBox">
                                    <xsl:value-of select="string(m1:icaOr13FFileNumber)" />
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
                        <td class="label">Other SEC File Number (if any):</td>
                        <td>
                            <p>
                                <div class="fakeBox">
                                    <xsl:value-of select="string(m1:otherFileNumber)" />
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
                                    <xsl:value-of select="string(m1:leiNumberOM)" />
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
                                    <xsl:value-of select="string(m1:managerName)" />
                                    <span>
                                        <xsl:text>&#160;</xsl:text>
                                    </span>
                                </div>
                            </p>
                        </td>
                    </tr>
                </table>

            </xsl:for-each>
        </table>

        <table role="presentation" class="specialInstructionB4">
            <tr>
                <td class="label">
                    Do you wish to provide explanatory information pursuant to Special Instruction B.4?:
                </td>
                <td>
                    <span class="yesNo">
                        <xsl:choose>
                            <xsl:when test="count(m1:explanatoryInformation/m1:explanatoryChoice) &gt; 0">
                                <xsl:choose>
                                    <xsl:when test="string(m1:explanatoryInformation/m1:explanatoryChoice) = 'Y'">
                                        <img
                                                src="Images/radio-checked.jpg"
                                                alt="Radio button checked" />
                                        Yes
                                        <img
                                                src="Images/radio-unchecked.jpg"
                                                alt="Radio button not checked" />
                                        No
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="string(m1:explanatoryInformation/m1:explanatoryChoice) = 'N'">
                                        <img
                                                src="Images/radio-unchecked.jpg"
                                                alt="Radio button not checked" />
                                        Yes
                                        <img
                                                src="Images/radio-checked.jpg"
                                                alt="Radio button checked" />
                                        No
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <img
                                        src="Images/radio-unchecked.jpg"
                                        alt="Radio button not checked" />
                                Yes
                                <img
                                        src="Images/radio-unchecked.jpg"
                                        alt="Radio button not checked" />
                                No
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </td>
            </tr>
            <tr>
                <td class="label">Additional information:</td>
                <td>
                    <p>
                        <div class="fakeBox">
                            <xsl:value-of select="string(m1:explanatoryInformation/m1:explanatoryNotes)" />
                            <span>
                                <xsl:text>&#160;</xsl:text>
                            </span>
                        </div>
                    </p>
                </td>
            </tr>
        </table>

    </xsl:template>

</xsl:stylesheet>