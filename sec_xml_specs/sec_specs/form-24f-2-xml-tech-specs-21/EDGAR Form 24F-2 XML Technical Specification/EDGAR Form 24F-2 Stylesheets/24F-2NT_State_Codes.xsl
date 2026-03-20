<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:output method="html" indent="no" encoding="UTF-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

	<xsl:template name="stateDescription">
		<xsl:param name="stateCode" />
		<xsl:choose>
			<xsl:when test="$stateCode='AK'">
				ALASKA
			</xsl:when>
			<xsl:when test="$stateCode='AL'">
				ALABAMA
			</xsl:when>
			<xsl:when test="$stateCode='AR'">
				ARKANSAS
			</xsl:when>
			<xsl:when test="$stateCode='AZ'">
				ARIZONA
			</xsl:when>
			<xsl:when test="$stateCode='CA'">
				CALIFORNIA
			</xsl:when>
			<xsl:when test="$stateCode='CO'">
				COLORADO
			</xsl:when>
			<xsl:when test="$stateCode='CT'">
				CONNECTICUT
			</xsl:when>
			<xsl:when test="$stateCode='DC'">
				DISTRICT OF COLUMBIA
			</xsl:when>
			<xsl:when test="$stateCode='DE'">
				DELAWARE
			</xsl:when>
			<xsl:when test="$stateCode='FL'">
				FLORIDA
			</xsl:when>
			<xsl:when test="$stateCode='GA'">
				GEORGIA
			</xsl:when>
			<xsl:when test="$stateCode='HI'">
				HAWAII
			</xsl:when>
			<xsl:when test="$stateCode='IA'">
				IOWA
			</xsl:when>
			<xsl:when test="$stateCode='ID'">
				IDAHO
			</xsl:when>
			<xsl:when test="$stateCode='IL'">
				ILLINOIS
			</xsl:when>
			<xsl:when test="$stateCode='IN'">
				INDIANA
			</xsl:when>
			<xsl:when test="$stateCode='KS'">
				KANSAS
			</xsl:when>
			<xsl:when test="$stateCode='KY'">
				KENTUCKY
			</xsl:when>
			<xsl:when test="$stateCode='LA'">
				LOUISIANA
			</xsl:when>
			<xsl:when test="$stateCode='MA'">
				MASSACHUSETTS
			</xsl:when>
			<xsl:when test="$stateCode='MD'">
				MARYLAND
			</xsl:when>
			<xsl:when test="$stateCode='ME'">
				MAINE
			</xsl:when>
			<xsl:when test="$stateCode='MI'">
				MICHIGAN
			</xsl:when>
			<xsl:when test="$stateCode='MN'">
				MINNESOTA
			</xsl:when>
			<xsl:when test="$stateCode='MO'">
				MISSOURI
			</xsl:when>
			<xsl:when test="$stateCode='MS'">
				MISSISSIPPI
			</xsl:when>
			<xsl:when test="$stateCode='MT'">
				MONTANA
			</xsl:when>
			<xsl:when test="$stateCode='NC'">
				NORTH CAROLINA
			</xsl:when>
			<xsl:when test="$stateCode='ND'">
				NORTH DAKOTA
			</xsl:when>
			<xsl:when test="$stateCode='NE'">
				NEBRASKA
			</xsl:when>
			<xsl:when test="$stateCode='NH'">
				NEW HAMPSHIRE
			</xsl:when>
			<xsl:when test="$stateCode='NJ'">
				NEW JERSEY
			</xsl:when>
			<xsl:when test="$stateCode='NM'">
				NEW MEXICO
			</xsl:when>
			<xsl:when test="$stateCode='NV'">
				NEVADA
			</xsl:when>
			<xsl:when test="$stateCode='NY'">
				NEW YORK
			</xsl:when>
			<xsl:when test="$stateCode='OH'">
				OHIO
			</xsl:when>
			<xsl:when test="$stateCode='OK'">
				OKLAHOMA
			</xsl:when>
			<xsl:when test="$stateCode='OR'">
				OREGON
			</xsl:when>
			<xsl:when test="$stateCode='PA'">
				PENNSYLVANIA
			</xsl:when>
			<xsl:when test="$stateCode='RI'">
				RHODE ISLAND
			</xsl:when>
			<xsl:when test="$stateCode='SC'">
				SOUTH CAROLINA
			</xsl:when>
			<xsl:when test="$stateCode='SD'">
				SOUTH DAKOTA
			</xsl:when>
			<xsl:when test="$stateCode='TN'">
				TENNESSEE
			</xsl:when>
			<xsl:when test="$stateCode='TX'">
				TEXAS
			</xsl:when>
			<xsl:when test="$stateCode='UT'">
				UTAH
			</xsl:when>
			<xsl:when test="$stateCode='VA'">
				VIRGINIA
			</xsl:when>
			<xsl:when test="$stateCode='VT'">
				VERMONT
			</xsl:when>
			<xsl:when test="$stateCode='WA'">
				WASHINGTON
			</xsl:when>
			<xsl:when test="$stateCode='WI'">
				WISCONSIN
			</xsl:when>
			<xsl:when test="$stateCode='WV'">
				WEST VIRGINIA
			</xsl:when>
			<xsl:when test="$stateCode='WY'">
				WYOMING
			</xsl:when>
			<xsl:when test="$stateCode='X1'">
				UNITED STATES
			</xsl:when>
			<xsl:when test="$stateCode='A0'">
				ALBERTA, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A1'">
				BRITISH COLUMBIA, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A2'">
				MANITOBA, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A3'">
				NEW BRUNSWICK, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A4'">
				NEWFOUNDLAND, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A5'">
				NOVA SCOTIA, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A6'">
				ONTARIO, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A7'">
				PRINCE EDWARD ISLAND, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A8'">
				QUEBEC, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='A9'">
				SASKATCHEWAN, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='B0'">
				YUKON, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='Z4'">
				CANADA (FEDERAL LEVEL)
			</xsl:when>
			<xsl:when test="$stateCode='1A'">
				ANGUILLA
			</xsl:when>
			<xsl:when test="$stateCode='1B'">
				ARMENIA
			</xsl:when>
			<xsl:when test="$stateCode='1C'">
				ARUBA
			</xsl:when>
			<xsl:when test="$stateCode='1D'">
				AZERBAIJAN
			</xsl:when>
			<xsl:when test="$stateCode='1E'">
				BOSNIA AND HERZEGOVINA
			</xsl:when>
			<xsl:when test="$stateCode='1F'">
				BELARUS
			</xsl:when>
			<xsl:when test="$stateCode='1G'">
				DJIBOUTI
			</xsl:when>
			<xsl:when test="$stateCode='1H'">
				ESTONIA
			</xsl:when>
			<xsl:when test="$stateCode='1J'">
				ERITREA
			</xsl:when>
			<xsl:when test="$stateCode='1K'">
				MICRONESIA, FEDERATED STATES OF
			</xsl:when>
			<xsl:when test="$stateCode='1L'">
				SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='1M'">
				CROATIA
			</xsl:when>
			<xsl:when test="$stateCode='1N'">
				KYRGYZSTAN
			</xsl:when>
			<xsl:when test="$stateCode='1P'">
				KAZAKSTAN
			</xsl:when>
			<xsl:when test="$stateCode='1Q'">
				LITHUANIA
			</xsl:when>
			<xsl:when test="$stateCode='1R'">
				LATVIA
			</xsl:when>
			<xsl:when test="$stateCode='1S'">
				MOLDOVA, REPUBLIC OF
			</xsl:when>
			<xsl:when test="$stateCode='1T'">
				MARSHALL ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='1U'">
				MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF
			</xsl:when>
			<xsl:when test="$stateCode='1V'">
				NORTHERN MARIANA ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='1W'">
				NEW CALEDONIA
			</xsl:when>
			<xsl:when test="$stateCode='1X'">
				PALESTINIAN TERRITORY, OCCUPIED
			</xsl:when>
			<xsl:when test="$stateCode='1Y'">
				PALAU
			</xsl:when>
			<xsl:when test="$stateCode='1Z'">
				RUSSIAN FEDERATION
			</xsl:when>
			<xsl:when test="$stateCode='2A'">
				SLOVENIA
			</xsl:when>
			<xsl:when test="$stateCode='2B'">
				SLOVAKIA
			</xsl:when>
			<xsl:when test="$stateCode='2C'">
				FRENCH SOUTHERN TERRITORIES
			</xsl:when>
			<xsl:when test="$stateCode='2D'">
				TAJIKISTAN
			</xsl:when>
			<xsl:when test="$stateCode='2E'">
				TURKMENISTAN
			</xsl:when>
			<xsl:when test="$stateCode='2G'">
				TUVALU
			</xsl:when>
			<xsl:when test="$stateCode='2H'">
				UKRAINE
			</xsl:when>
			<xsl:when test="$stateCode='2J'">
				UNITED STATES MINOR OUTLYING ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='2K'">
				UZBEKISTAN
			</xsl:when>
			<xsl:when test="$stateCode='2L'">
				VANUATU
			</xsl:when>
			<xsl:when test="$stateCode='2M'">
				GERMANY
			</xsl:when>
			<xsl:when test="$stateCode='2N'">
				CZECH REPUBLIC
			</xsl:when>
			<xsl:when test="$stateCode='2P'">
				MAYOTTE
			</xsl:when>
			<xsl:when test="$stateCode='2Q'">
				GEORGIA (COUNTRY)
			</xsl:when>
			<xsl:when test="$stateCode='B1'">
				BOTSWANA
			</xsl:when>
			<xsl:when test="$stateCode='B2'">
				AFGHANISTAN
			</xsl:when>
			<xsl:when test="$stateCode='B3'">
				ALBANIA
			</xsl:when>
			<xsl:when test="$stateCode='B4'">
				ALGERIA
			</xsl:when>
			<xsl:when test="$stateCode='B5'">
				AMERICAN SAMOA
			</xsl:when>
			<xsl:when test="$stateCode='B6'">
				ANDORRA
			</xsl:when>
			<xsl:when test="$stateCode='B7'">
				ANGOLA
			</xsl:when>
			<xsl:when test="$stateCode='B8'">
				ANTARCTICA
			</xsl:when>
			<xsl:when test="$stateCode='B9'">
				ANTIGUA AND BARBUDA
			</xsl:when>
			<xsl:when test="$stateCode='C0'">
				UNITED ARAB EMIRATES
			</xsl:when>
			<xsl:when test="$stateCode='C1'">
				ARGENTINA
			</xsl:when>
			<xsl:when test="$stateCode='C3'">
				AUSTRALIA
			</xsl:when>
			<xsl:when test="$stateCode='C4'">
				AUSTRIA
			</xsl:when>
			<xsl:when test="$stateCode='C5'">
				BAHAMAS
			</xsl:when>
			<xsl:when test="$stateCode='C6'">
				BAHRAIN
			</xsl:when>
			<xsl:when test="$stateCode='C7'">
				BANGLADESH
			</xsl:when>
			<xsl:when test="$stateCode='C8'">
				BARBADOS
			</xsl:when>
			<xsl:when test="$stateCode='C9'">
				BELGIUM
			</xsl:when>
			<xsl:when test="$stateCode='D0'">
				BERMUDA
			</xsl:when>
			<xsl:when test="$stateCode='D1'">
				BELIZE
			</xsl:when>
			<xsl:when test="$stateCode='D2'">
				BHUTAN
			</xsl:when>
			<xsl:when test="$stateCode='D3'">
				BOLIVIA
			</xsl:when>
			<xsl:when test="$stateCode='D4'">
				BOUVET ISLAND
			</xsl:when>
			<xsl:when test="$stateCode='D5'">
				BRAZIL
			</xsl:when>
			<xsl:when test="$stateCode='D6'">
				BRITISH INDIAN OCEAN TERRITORY
			</xsl:when>
			<xsl:when test="$stateCode='D7'">
				SOLOMON ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='D8'">
				VIRGIN ISLANDS, BRITISH
			</xsl:when>
			<xsl:when test="$stateCode='D9'">
				BRUNEI DARUSSALAM
			</xsl:when>
			<xsl:when test="$stateCode='E0'">
				BULGARIA
			</xsl:when>
			<xsl:when test="$stateCode='E1'">
				MYANMAR
			</xsl:when>
			<xsl:when test="$stateCode='E2'">
				BURUNDI
			</xsl:when>
			<xsl:when test="$stateCode='E3'">
				CAMBODIA
			</xsl:when>
			<xsl:when test="$stateCode='E4'">
				CAMEROON
			</xsl:when>
			<xsl:when test="$stateCode='E8'">
				CAPE VERDE
			</xsl:when>
			<xsl:when test="$stateCode='E9'">
				CAYMAN ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='F0'">
				CENTRAL AFRICAN REPUBLIC
			</xsl:when>
			<xsl:when test="$stateCode='F1'">
				SRI LANKA
			</xsl:when>
			<xsl:when test="$stateCode='F2'">
				CHAD
			</xsl:when>
			<xsl:when test="$stateCode='F3'">
				CHILE
			</xsl:when>
			<xsl:when test="$stateCode='F4'">
				CHINA
			</xsl:when>
			<xsl:when test="$stateCode='F5'">
				TAIWAN
			</xsl:when>
			<xsl:when test="$stateCode='F6'">
				CHRISTMAS ISLAND
			</xsl:when>
			<xsl:when test="$stateCode='F7'">
				COCOS (KEELING) ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='F8'">
				COLOMBIA
			</xsl:when>
			<xsl:when test="$stateCode='F9'">
				COMOROS
			</xsl:when>
			<xsl:when test="$stateCode='G0'">
				CONGO
			</xsl:when>
			<xsl:when test="$stateCode='G1'">
				COOK ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='G2'">
				COSTA RICA
			</xsl:when>
			<xsl:when test="$stateCode='G3'">
				CUBA
			</xsl:when>
			<xsl:when test="$stateCode='G4'">
				CYPRUS
			</xsl:when>
			<xsl:when test="$stateCode='G6'">
				BENIN
			</xsl:when>
			<xsl:when test="$stateCode='G7'">
				DENMARK
			</xsl:when>
			<xsl:when test="$stateCode='G8'">
				DOMINICAN REPUBLIC
			</xsl:when>
			<xsl:when test="$stateCode='G9'">
				DOMINICA
			</xsl:when>
			<xsl:when test="$stateCode='GU'">
				GUAM
			</xsl:when>
			<xsl:when test="$stateCode='H1'">
				ECUADOR
			</xsl:when>
			<xsl:when test="$stateCode='H2'">
				EGYPT
			</xsl:when>
			<xsl:when test="$stateCode='H3'">
				EL SALVADOR
			</xsl:when>
			<xsl:when test="$stateCode='H4'">
				EQUATORIAL GUINEA
			</xsl:when>
			<xsl:when test="$stateCode='H5'">
				ETHIOPIA
			</xsl:when>
			<xsl:when test="$stateCode='H6'">
				FAROE ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='H7'">
				FALKLAND ISLANDS (MALVINAS)
			</xsl:when>
			<xsl:when test="$stateCode='H8'">
				FIJI
			</xsl:when>
			<xsl:when test="$stateCode='H9'">
				FINLAND
			</xsl:when>
			<xsl:when test="$stateCode='I0'">
				FRANCE
			</xsl:when>
			<xsl:when test="$stateCode='I3'">
				FRENCH GUIANA
			</xsl:when>
			<xsl:when test="$stateCode='I4'">
				FRENCH POLYNESIA
			</xsl:when>
			<xsl:when test="$stateCode='I5'">
				GABON
			</xsl:when>
			<xsl:when test="$stateCode='I6'">
				GAMBIA
			</xsl:when>
			<xsl:when test="$stateCode='J0'">
				GHANA
			</xsl:when>
			<xsl:when test="$stateCode='J1'">
				GIBRALTAR
			</xsl:when>
			<xsl:when test="$stateCode='J2'">
				KIRIBATI
			</xsl:when>
			<xsl:when test="$stateCode='J3'">
				GREECE
			</xsl:when>
			<xsl:when test="$stateCode='J4'">
				GREENLAND
			</xsl:when>
			<xsl:when test="$stateCode='J5'">
				GRENADA
			</xsl:when>
			<xsl:when test="$stateCode='J6'">
				GUADELOUPE
			</xsl:when>
			<xsl:when test="$stateCode='J8'">
				GUATEMALA
			</xsl:when>
			<xsl:when test="$stateCode='J9'">
				GUINEA
			</xsl:when>
			<xsl:when test="$stateCode='K0'">
				GUYANA
			</xsl:when>
			<xsl:when test="$stateCode='K1'">
				HAITI
			</xsl:when>
			<xsl:when test="$stateCode='K2'">
				HONDURAS
			</xsl:when>
			<xsl:when test="$stateCode='K3'">
				HONG KONG
			</xsl:when>
			<xsl:when test="$stateCode='K4'">
				HEARD ISLAND AND MCDONALD ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='K5'">
				HUNGARY
			</xsl:when>
			<xsl:when test="$stateCode='K6'">
				ICELAND
			</xsl:when>
			<xsl:when test="$stateCode='K7'">
				INDIA
			</xsl:when>
			<xsl:when test="$stateCode='K8'">
				INDONESIA
			</xsl:when>
			<xsl:when test="$stateCode='K9'">
				IRAN, ISLAMIC REPUBLIC OF
			</xsl:when>
			<xsl:when test="$stateCode='L0'">
				IRAQ
			</xsl:when>
			<xsl:when test="$stateCode='L2'">
				IRELAND
			</xsl:when>
			<xsl:when test="$stateCode='L3'">
				ISRAEL
			</xsl:when>
			<xsl:when test="$stateCode='L6'">
				ITALY
			</xsl:when>
			<xsl:when test="$stateCode='L7'">
				COTE D'IVOIRE
			</xsl:when>
			<xsl:when test="$stateCode='L8'">
				JAMAICA
			</xsl:when>
			<xsl:when test="$stateCode='L9'">
				SVALBARD AND JAN MAYEN
			</xsl:when>
			<xsl:when test="$stateCode='M0'">
				JAPAN
			</xsl:when>
			<xsl:when test="$stateCode='M2'">
				JORDAN
			</xsl:when>
			<xsl:when test="$stateCode='M3'">
				KENYA
			</xsl:when>
			<xsl:when test="$stateCode='M4'">
				KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF
			</xsl:when>
			<xsl:when test="$stateCode='M5'">
				KOREA, REPUBLIC OF
			</xsl:when>
			<xsl:when test="$stateCode='M6'">
				KUWAIT
			</xsl:when>
			<xsl:when test="$stateCode='M7'">
				LAO PEOPLE'S DEMOCRATIC REPUBLIC
			</xsl:when>
			<xsl:when test="$stateCode='M8'">
				LEBANON
			</xsl:when>
			<xsl:when test="$stateCode='M9'">
				LESOTHO
			</xsl:when>
			<xsl:when test="$stateCode='N0'">
				LIBERIA
			</xsl:when>
			<xsl:when test="$stateCode='N1'">
				LIBYAN ARAB JAMAHIRIYA
			</xsl:when>
			<xsl:when test="$stateCode='N2'">
				LIECHTENSTEIN
			</xsl:when>
			<xsl:when test="$stateCode='N4'">
				LUXEMBOURG
			</xsl:when>
			<xsl:when test="$stateCode='N5'">
				MACAU
			</xsl:when>
			<xsl:when test="$stateCode='N6'">
				MADAGASCAR
			</xsl:when>
			<xsl:when test="$stateCode='N7'">
				MALAWI
			</xsl:when>
			<xsl:when test="$stateCode='N8'">
				MALAYSIA
			</xsl:when>
			<xsl:when test="$stateCode='N9'">
				MALDIVES
			</xsl:when>
			<xsl:when test="$stateCode='O0'">
				MALI
			</xsl:when>
			<xsl:when test="$stateCode='O1'">
				MALTA
			</xsl:when>
			<xsl:when test="$stateCode='O2'">
				MARTINIQUE
			</xsl:when>
			<xsl:when test="$stateCode='O3'">
				MAURITANIA
			</xsl:when>
			<xsl:when test="$stateCode='O4'">
				MAURITIUS
			</xsl:when>
			<xsl:when test="$stateCode='O5'">
				MEXICO
			</xsl:when>
			<xsl:when test="$stateCode='O9'">
				MONACO
			</xsl:when>
			<xsl:when test="$stateCode='P0'">
				MONGOLIA
			</xsl:when>
			<xsl:when test="$stateCode='P1'">
				MONTSERRAT
			</xsl:when>
			<xsl:when test="$stateCode='P2'">
				MOROCCO
			</xsl:when>
			<xsl:when test="$stateCode='P3'">
				MOZAMBIQUE
			</xsl:when>
			<xsl:when test="$stateCode='P4'">
				OMAN
			</xsl:when>
			<xsl:when test="$stateCode='P5'">
				NAURU
			</xsl:when>
			<xsl:when test="$stateCode='P6'">
				NEPAL
			</xsl:when>
			<xsl:when test="$stateCode='P7'">
				NETHERLANDS
			</xsl:when>
			<xsl:when test="$stateCode='P8'">
				NETHERLANDS ANTILLES
			</xsl:when>
			<xsl:when test="$stateCode='PR'">
				PUERTO RICO
			</xsl:when>
			<xsl:when test="$stateCode='Q1'">
				VIET NAM
			</xsl:when>
			<xsl:when test="$stateCode='Q2'">
				NEW ZEALAND
			</xsl:when>
			<xsl:when test="$stateCode='Q3'">
				NICARAGUA
			</xsl:when>
			<xsl:when test="$stateCode='Q4'">
				NIGER
			</xsl:when>
			<xsl:when test="$stateCode='Q5'">
				NIGERIA
			</xsl:when>
			<xsl:when test="$stateCode='Q6'">
				NIUE
			</xsl:when>
			<xsl:when test="$stateCode='Q7'">
				NORFOLK ISLAND
			</xsl:when>
			<xsl:when test="$stateCode='Q8'">
				NORWAY
			</xsl:when>
			<xsl:when test="$stateCode='R0'">
				PAKISTAN
			</xsl:when>
			<xsl:when test="$stateCode='R1'">
				PANAMA
			</xsl:when>
			<xsl:when test="$stateCode='R2'">
				PAPUA NEW GUINEA
			</xsl:when>
			<xsl:when test="$stateCode='R4'">
				PARAGUAY
			</xsl:when>
			<xsl:when test="$stateCode='R5'">
				PERU
			</xsl:when>
			<xsl:when test="$stateCode='R6'">
				PHILIPPINES
			</xsl:when>
			<xsl:when test="$stateCode='R8'">
				PITCAIRN
			</xsl:when>
			<xsl:when test="$stateCode='R9'">
				POLAND
			</xsl:when>
			<xsl:when test="$stateCode='S0'">
				GUINEA-BISSAU
			</xsl:when>
			<xsl:when test="$stateCode='S1'">
				PORTUGAL
			</xsl:when>
			<xsl:when test="$stateCode='S3'">
				QATAR
			</xsl:when>
			<xsl:when test="$stateCode='S4'">
				REUNION
			</xsl:when>
			<xsl:when test="$stateCode='S5'">
				ROMANIA
			</xsl:when>
			<xsl:when test="$stateCode='S6'">
				RWANDA
			</xsl:when>
			<xsl:when test="$stateCode='S8'">
				SAN MARINO
			</xsl:when>
			<xsl:when test="$stateCode='S9'">
				SAO TOME AND PRINCIPE
			</xsl:when>
			<xsl:when test="$stateCode='T0'">
				SAUDI ARABIA
			</xsl:when>
			<xsl:when test="$stateCode='T1'">
				SENEGAL
			</xsl:when>
			<xsl:when test="$stateCode='T2'">
				SEYCHELLES
			</xsl:when>
			<xsl:when test="$stateCode='T3'">
				SOUTH AFRICA
			</xsl:when>
			<xsl:when test="$stateCode='T6'">
				NAMIBIA
			</xsl:when>
			<xsl:when test="$stateCode='T7'">
				YEMEN
			</xsl:when>
			<xsl:when test="$stateCode='T8'">
				SIERRA LEONE
			</xsl:when>
			<xsl:when test="$stateCode='U0'">
				SINGAPORE
			</xsl:when>
			<xsl:when test="$stateCode='U1'">
				SOMALIA
			</xsl:when>
			<xsl:when test="$stateCode='U3'">
				SPAIN
			</xsl:when>
			<xsl:when test="$stateCode='U5'">
				WESTERN SAHARA
			</xsl:when>
			<xsl:when test="$stateCode='U7'">
				SAINT KITTS AND NEVIS
			</xsl:when>
			<xsl:when test="$stateCode='U8'">
				SAINT HELENA
			</xsl:when>
			<xsl:when test="$stateCode='U9'">
				SAINT LUCIA
			</xsl:when>
			<xsl:when test="$stateCode='V0'">
				SAINT PIERRE AND MIQUELON
			</xsl:when>
			<xsl:when test="$stateCode='V1'">
				SAINT VINCENT AND THE GRENADINES
			</xsl:when>
			<xsl:when test="$stateCode='V2'">
				SUDAN
			</xsl:when>
			<xsl:when test="$stateCode='V3'">
				SURINAME
			</xsl:when>
			<xsl:when test="$stateCode='V6'">
				SWAZILAND
			</xsl:when>
			<xsl:when test="$stateCode='V7'">
				SWEDEN
			</xsl:when>
			<xsl:when test="$stateCode='V8'">
				SWITZERLAND
			</xsl:when>
			<xsl:when test="$stateCode='V9'">
				SYRIAN ARAB REPUBLIC
			</xsl:when>
			<xsl:when test="$stateCode='VI'">
				VIRGIN ISLANDS, U.S.
			</xsl:when>
			<xsl:when test="$stateCode='W0'">
				TANZANIA, UNITED REPUBLIC OF
			</xsl:when>
			<xsl:when test="$stateCode='W1'">
				THAILAND
			</xsl:when>
			<xsl:when test="$stateCode='W2'">
				TOGO
			</xsl:when>
			<xsl:when test="$stateCode='W3'">
				TOKELAU
			</xsl:when>
			<xsl:when test="$stateCode='W4'">
				TONGA
			</xsl:when>
			<xsl:when test="$stateCode='W5'">
				TRINIDAD AND TOBAGO
			</xsl:when>
			<xsl:when test="$stateCode='W6'">
				TUNISIA
			</xsl:when>
			<xsl:when test="$stateCode='W7'">
				TURKS AND CAICOS ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='W8'">
				TURKEY
			</xsl:when>
			<xsl:when test="$stateCode='W9'">
				UGANDA
			</xsl:when>
			<xsl:when test="$stateCode='X0'">
				UNITED KINGDOM
			</xsl:when>
			<xsl:when test="$stateCode='X2'">
				BURKINA FASO
			</xsl:when>
			<xsl:when test="$stateCode='X3'">
				URUGUAY
			</xsl:when>
			<xsl:when test="$stateCode='X4'">
				HOLY SEE (VATICAN CITY STATE)
			</xsl:when>
			<xsl:when test="$stateCode='X5'">
				VENEZUELA
			</xsl:when>
			<xsl:when test="$stateCode='X8'">
				WALLIS AND FUTUNA
			</xsl:when>
			<xsl:when test="$stateCode='Y0'">
				SAMOA
			</xsl:when>
			<xsl:when test="$stateCode='Y3'">
				CONGO, THE DEMOCRATIC REPUBLIC OF THE
			</xsl:when>
			<xsl:when test="$stateCode='Y4'">
				ZAMBIA
			</xsl:when>
			<xsl:when test="$stateCode='Y5'">
				ZIMBABWE
			</xsl:when>
			<xsl:when test="$stateCode='Y6'">
				ALAND ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='Y7'">
				GUERNSEY
			</xsl:when>
			<xsl:when test="$stateCode='Y8'">
				ISLE OF MAN
			</xsl:when>
			<xsl:when test="$stateCode='Y9'">
				JERSEY
			</xsl:when>
			<xsl:when test="$stateCode='Z0'">
				SAINT BARTHELEMY
			</xsl:when>
			<xsl:when test="$stateCode='Z1'">
				SAINT MARTIN
			</xsl:when>
			<xsl:when test="$stateCode='Z2'">
				SERBIA
			</xsl:when>
			<xsl:when test="$stateCode='Z3'">
				TIMOR-LESTE
			</xsl:when>
			<xsl:when test="$stateCode='Z5'">
				MONTENEGRO
			</xsl:when>
			<xsl:when test="$stateCode='XX'">
				Unknown
			</xsl:when>
			<xsl:when test="$stateCode='2F'">
				EAST TIMOR
			</xsl:when>
			<xsl:when test="$stateCode='C2'">
				ASHMORE &#38; CARTIER IS
			</xsl:when>
			<xsl:when test="$stateCode='E5'">
				CANAL ZONE
			</xsl:when>
			<xsl:when test="$stateCode='E6'">
				MONTREAL, CANADA
			</xsl:when>
			<xsl:when test="$stateCode='E7'">
				CANTON/ENDERBURY IS
			</xsl:when>
			<xsl:when test="$stateCode='G5'">
				CZECHOSLOVAKIA
			</xsl:when>
			<xsl:when test="$stateCode='I7'">
				GAZA STRIP
			</xsl:when>
			<xsl:when test="$stateCode='I8'">
				GERMANY (WEST)
			</xsl:when>
			<xsl:when test="$stateCode='I9'">
				GERMANY, FED. REP.
			</xsl:when>
			<xsl:when test="$stateCode='L1'">
				IRAQ-SAUDI
			</xsl:when>
			<xsl:when test="$stateCode='L4'">
				ISRAEL-JORDAN
			</xsl:when>
			<xsl:when test="$stateCode='L5'">
				ISRAEL-SYRIA
			</xsl:when>
			<xsl:when test="$stateCode='M1'">
				JOHNSTON ATOLL
			</xsl:when>
			<xsl:when test="$stateCode='O6'">
				MIDWAY ISLAND
			</xsl:when>
			<xsl:when test="$stateCode='Q9'">
				PACIFIC ISLANDS TRU
			</xsl:when>
			<xsl:when test="$stateCode='R3'">
				PARACEL ISLANDS
			</xsl:when>
			<xsl:when test="$stateCode='T4'">
				SOUTHERN RHODESIA
			</xsl:when>
			<xsl:when test="$stateCode='U2'">
				SOVIET UNION
			</xsl:when>
			<xsl:when test="$stateCode='U4'">
				SPANISH NORTH AFRICA
			</xsl:when>
			<xsl:when test="$stateCode='U6'">
				SPRATLY ISLAND
			</xsl:when>
			<xsl:when test="$stateCode='X7'">
				WAKE ISLAND
			</xsl:when>
			<xsl:when test="$stateCode='X9'">
				GERMANY (BERLIN)
			</xsl:when>
			<xsl:when test="$stateCode='Y2'">
				YUGOSLAVIA
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$stateCode" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>