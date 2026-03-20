<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns="http://www.sec.gov/edgar/document/npxproxy/informationtable">
	<xsl:output method="html"
				doctype-system="http://www.w3.org/TR/html4/strict.dtd"
				doctype-public="-//W3C//DTD HTML 4.01//EN"
				indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<style type="text/css">
					<xsl:comment>
						/* INFO TABLE CSS */
						.infoTable {
						border:1px solid #606020;
						table-layout:fixed !important;
						font-size:0.7em;
						overflow:hidden !important;
						}
						.infoTable th {
						border:1px solid #606020;
						white-space:nowrap !important;
						text-align:center;
						padding:4px 2px;
						border-bottom:1px solid #404040;
						text-transform:inherit;
						word-break:break-all;
						font-size:0.8em;
						letter-spacing: -1px;
						}
						.infoTable th td {
						border:1px solid #606020;
						border-bottom:1px solid #404040;
						}
						.infoTable tr td {
						border:1px solid #606020;
						border-bottom:1px solid #404040;
						white-space:nowrap !important;
						overflow:hidden !important;
						color:#000088;
						}
						.infoTable tr td:hover {
						border:1px solid #606020;
						border-bottom:2px solid #606020;
						white-space:normal !important;
						overflow:auto !important;
						background-color:#FF9;
						font-size:1.2em;
						color:#000088;
						}
						.infoTable td {
						margin:4px 2px;
						}
						.infoCol1 {
						width:auto
						}
						.infoCol2 {
						width:auto;
						}
						.infoCol3 {
						text-align:right;
						width:auto
						}
						.infoCol4 {
						text-align:right;
						}
						.infoCol5 {
						width:auto;
						}
						.infoCol6 {
						width:auto;
						}
						.infoCol7 {
						width:auto
						}
						.infoCol8 {
						width:300px;
						}
						.infoCol9 {
						width:300px;
						}
						.infoCol10 {
						width:300px;
						}
						.infoCol11 {
						width:300px;
						}
						.infoCol12 {
						width:300px;
						}
						.infoCol12a {
						text-align:center;
						width:auto;
						}
						.infoCol12b {
						text-align:center;
						width:auto
						}
						.infoCol12c {
						text-align:center;
						width:auto;
						}
						.infoCol13 {
						text-align:center;
						width:auto;
						}
						.infoCol14 {
						text-align:center;
						width:auto;
						}
						.infoCol15 {
						text-align:center;
						width:auto;
						}
						.fullwidth {
						width:1000px;
						}
					</xsl:comment>
				</style>
			</head>
			<body class="fullwidth">
				<div class="content">
					<h2>FORM N-PX PROXY VOTING RECORD </h2>
					<table border="0" class="infoTable" cellpadding="0" cellspacing="0">

						<tr>
							<th valign="top" class="infoCol1">COLUMN 1</th>
							<th valign="top" class="infoCol2">COLUMN 2</th>
							<th valign="top" class="infoCol3">COLUMN 3</th>
							<th valign="top" class="infoCol4">COLUMN 4</th>
							<th valign="top" class="infoCol5">COLUMN 5</th>
							<th valign="top" class="infoCol6">COLUMN 6</th>
							<th valign="top" class="infoCol7">COLUMN 7</th>
							<th valign="top"  class="infoCol8">COLUMN 8</th>
							<th valign="top"  class="infoCol8">COLUMN 9</th>
							<th valign="top"  class="infoCol8">COLUMN 10</th>
							<th valign="top"  class="infoCol8">COLUMN 11</th>
							<th colspan="3" valign="top" class="infoCol12">COLUMN 12</th>
							<th valign="top"  class="infoCol8">COLUMN 13</th>
							<th valign="top"  class="infoCol8">COLUMN 14</th>
							<th valign="top"  class="infoCol8">COLUMN 15</th>

						</tr>
						<tr>
							<th rowspan="2" class="infoCol1">NAME &#160; OF &#160; ISSUER<br>
							</br></th>
							<th rowspan="2" class="infoCol2">CUSIP</th>
							<th rowspan="2" class="infoCol3">ISIN</th>
							<th rowspan="2" class="infoCol4">FIGI</th>
							<th rowspan="2" class="infoCol5">MEETING &#160; DATE</th>
							<th rowspan="2" class="infoCol6">VOTE &#160; DESCRIPTION</th>
							<th rowspan="2" class="infoCol7">VOTE &#160; CATEGORY</th>
							<th rowspan="2" class="infoCol8">DESCRIPTION &#160; OF &#160; OTHER &#160;CATEGORY</th>
							<th rowspan="2" class="infoCol9">VOTE &#160; SOURCE</th>
							<th rowspan="2" class="infoCol10">SHARES &#160; VOTED </th>
							<th rowspan="2" class="infoCol11">SHARES &#160; ON &#160; LOAN</th>
							<th colspan="3" class="infoCol12">DETAILS &#160; OF &#160; VOTE</th>
							<th rowspan="2" class="infoCol13">MANAGER &#160; NUMBER</th>
							<th rowspan="2" class="infoCol14">SERIES &#160; ID</th>
							<th rowspan="2" class="infoCol15">OTHER &#160; INFO</th>

						</tr>
						<tr>
							<th class="infoCol12a">HOW &#160; VOTED</th>
							<th class="infoCol12b">SHARES &#160;VOTED</th>
							<th class="infoCol12c">FOR &#160; OR &#160; AGAINST &#160; MANAGEMENT</th>
						</tr>

						<xsl:for-each select="proxyVoteTable/proxyTable">
							<tr>
								<xsl:choose>
									<xsl:when test="string-length(issuerName)!=0">
										<td valign="top" class="infoCol1">
											<xsl:value-of select="issuerName"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol1">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(cusip)!=0">
										<td valign="top" class="infoCol2">
											<xsl:value-of select="cusip"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol2">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(isin)!=0">
										<td valign="top" class="infoCol3">
											<xsl:value-of select="isin"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol3">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(figi)!=0">
										<td valign="top" class="infoCol4">
											<xsl:value-of select="figi"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol4">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(meetingDate)!=0">
										<td valign="top" class="infoCol5">
											<xsl:value-of select="meetingDate"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol5">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(voteDescription)!=0">
										<td valign="top" class="infoCol6">
											<xsl:value-of select="voteDescription"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol6">-</td>
									</xsl:otherwise>
								</xsl:choose>
						 	<td valign="top" class="infoCol7">
							 <xsl:for-each select="voteCategories/voteCategory">
							 <xsl:value-of select="categoryType"/><br></br>
							 </xsl:for-each>
										</td>
								<xsl:choose>
									<xsl:when test="string-length(otherVoteDescription)!=0">
										<td valign="top" class="infoCol8">
											<xsl:value-of select="otherVoteDescription"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol8">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(voteSource)!=0">
										<td valign="top" class="infoCol9">
											<xsl:value-of select="voteSource"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol9">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(sharesVoted)!=0">
										<td valign="top" class="infoCol10">
											<xsl:value-of select="sharesVoted"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol10">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(sharesOnLoan)!=0">
										<td valign="top" class="infoCol11">
											<xsl:value-of select="sharesOnLoan"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol11">-</td>
									</xsl:otherwise>
								</xsl:choose>
                                  <td valign="top" class="infoCol12a">
										<xsl:for-each select="vote/voteRecord">
										<xsl:value-of select="howVoted"/><br></br>
											</xsl:for-each>
										</td>
										<td valign="top" class="infoCol12b">
										<xsl:for-each select="vote/voteRecord">
										<xsl:value-of select="sharesVoted"/><br></br>
											</xsl:for-each>
										</td>		
										<td valign="top" class="infoCol12c">
										<xsl:for-each select="vote/voteRecord">
										<xsl:value-of select="managementRecommendation"/><br></br>
											</xsl:for-each>
										</td>
										<td valign="top" class="infoCol13">
										<xsl:for-each select="voteManager/otherManagers">
											<xsl:value-of select="otherManager"/> <br></br>
											</xsl:for-each>
										</td>							
								<xsl:choose>
									<xsl:when test="string-length(voteSeries)!=0">
										<td valign="top" class="infoCol14">
											<xsl:value-of select="voteSeries"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol14">-</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(voteOtherInfo)!=0">
										<td valign="top" class="infoCol15">
											<xsl:value-of select="voteOtherInfo"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td valign="top" class="infoCol15">-</td>
									</xsl:otherwise>
								</xsl:choose>
							</tr>
						</xsl:for-each>
					</table>
					<p>[Repeat as Necessary]</p>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

