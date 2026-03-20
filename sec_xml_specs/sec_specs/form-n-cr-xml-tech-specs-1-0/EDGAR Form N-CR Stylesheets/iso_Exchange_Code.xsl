<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:output method="html" indent="no" encoding="UTF-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

	<xsl:template name="exchangeDescription">
		<xsl:param name="exchangeCode" />
		<xsl:choose>
			<xsl:when test="$exchangeCode='N/A'">
				N/A
			</xsl:when>
			<xsl:when test="$exchangeCode='BATS'">
				BATS Z-EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNAS'">
				NASDAQ - ALL MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='XNYS'">
				NEW YORK STOCK EXCHANGE, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='XTIR'">
				TIRANA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XALG'">
				ALGIERS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBDV'">
				BOLSA DE DIVIDA E VALORES DE ANGOLA (BODIVA) - ANGOLA SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BACE'">
				BOLSA DE CEREALES DE BUENOS AIRES
			</xsl:when>
			<xsl:when test="$exchangeCode='BCFS'">
				BOLSA DE COMERCIO DE SANTA FE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMVL'">
				MERCADO DE VALORES DEL LITORAL S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='ROFX'">
				ROSARIO FUTURE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBCC'">
				BOLSA DE COMERCIO DE CORDOBA
			</xsl:when>
			<xsl:when test="$exchangeCode='MVCX'">
				MERCADO DE VALORES DE CORDOBA S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XBCM'">
				BOLSA DE COMERCIO DE MENDOZA S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XBCX'">
				MERCADO DE VALORES DE MENDOZA S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XBUE'">
				BOLSA DE COMERCIO DE BUENOS AIRES
			</xsl:when>
			<xsl:when test="$exchangeCode='XMEV'">
				MERCADO DE VALORES DE BUENOS AIRES S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XCNF'">
				BOLSA DE COMERCIO CONFEDERADA S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAB'">
				MERCADO ABIERTO ELECTRONICO S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XMTB'">
				MERCADO A TERMINO DE BUENOS AIRES S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XROS'">
				BOLSA DE COMERCIO ROSARIO
			</xsl:when>
			<xsl:when test="$exchangeCode='XROX'">
				MERCADO DE VALORES DE ROSARIO S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XTUC'">
				NUEVA BOLSA DE COMERCIO DE TUCUMAN S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XARM'">
				NASDAQ OMX ARMENIA
			</xsl:when>
			<xsl:when test="$exchangeCode='APXL'">
				SYDNEY STOCK EXCHANGE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='AWBX'">
				AUSTRALIAN WHEAT BOARD
			</xsl:when>
			<xsl:when test="$exchangeCode='AWEX'">
				AUSTRALIAN WOOL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BLEV'">
				BLOCK EVENT
			</xsl:when>
			<xsl:when test="$exchangeCode='CGMA'">
				CITI MATCH AUSTRALIA
			</xsl:when>
			<xsl:when test="$exchangeCode='CHIA'">
				CHI-X AUSTRALIA
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAC'">
				CHI-X MARKET AUSTRALIA - LIMIT VENUE
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAV'">
				CHI-X VWAP
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAM'">
				CHI-X MOC
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAP'">
				CHI-X AUSTRALIA MID-POINT VENUE
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAN'">
				CHI-X AUSTRALIA PRIMARY PEG (NEARPOINT) VENUE
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAF'">
				CHI-X AUSTRALIA MARKET PEG (FARPOINT) VENUE
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAW'">
				CHI-X AUSTRALIA - WARRANTS
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAR'">
				CHI-X AUSTRALIA - TRANSFERABLE CUSTODY RECEIPT MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='CXAQ'">
				CHI-X AUSTRALIA -QUOTED MANAGED FUNDS
			</xsl:when>
			<xsl:when test="$exchangeCode='CLAU'">
				CLSA AUSTRALIA - DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='CSAU'">
				CREDIT SUISSE EQUITIES (AUSTRALIA) LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='CFAU'">
				CROSSFINDER AUSTRALIA
			</xsl:when>
			<xsl:when test="$exchangeCode='MAQX'">
				MACQUARIE INTERNAL MARKETS (AUSTRALIA)
			</xsl:when>
			<xsl:when test="$exchangeCode='MSAL'">
				MORGAN STANLEY AUSTRALIA SECURITIES LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='NSXB'">
				BENDIGO STOCK EXCHANGE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='SIGA'">
				SIGMA X AUSTRALIA
			</xsl:when>
			<xsl:when test="$exchangeCode='SIMV'">
				SIM VENTURE SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XASX'">
				ASX - ALL MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='ASXC'">
				ASX - CENTER POINT
			</xsl:when>
			<xsl:when test="$exchangeCode='ASXP'">
				ASX - PUREMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='ASXT'">
				ASX TRADEMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='ASXV'">
				ASX - VOLUMEMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='XSFE'">
				ASX - TRADE24
			</xsl:when>
			<xsl:when test="$exchangeCode='ASXB'">
				ASX BOOKBUILD
			</xsl:when>
			<xsl:when test="$exchangeCode='XFEX'">
				FINANCIAL AND ENERGY EXCHANGE GROUP
			</xsl:when>
			<xsl:when test="$exchangeCode='XNEC'">
				NATIONAL STOCK EXCHANGE OF AUSTRALIA LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='XYIE'">
				YIELDBROKER PTY LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='EGSI'">
				ERSTE GROUP BANK AG 
			</xsl:when>
			<xsl:when test="$exchangeCode='XWBO'">
				WIENER BOERSE AG
			</xsl:when>
			<xsl:when test="$exchangeCode='EXAA'">
				WIENER BOERSE AG, AUSTRIAN ENERGY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='WBAH'">
				WIENER BOERSE AG AMTLICHER HANDEL (OFFICIAL MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='WBDM'">
				WIENER BOERSE AG DRITTER MARKT (THIRD MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='WBGF'">
				WIENER BOERSE AG GEREGELTER FREIVERKEHR (SECOND REGULATED MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='XVIE'">
				WIENER BOERSE AG, WERTPAPIERBOERSE (SECURITIES EXCHANGE)
			</xsl:when>
			<xsl:when test="$exchangeCode='BSEX'">
				BAKU STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XIBE'">
				BAKU INTERBANK CURRENCY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBAA'">
				BAHAMAS INTERNATIONAL SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BFEX'">
				BAHRAIN FINANCIAL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBAH'">
				BAHRAIN BOURSE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCHG'">
				CHITTAGONG STOCK EXCHANGE LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='XDHA'">
				DHAKA STOCK EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XBAB'">
				BARBADOS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BAJM'">
				BARBADOS STOCK EXCHANGE - JUNIOR MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='BCSE'">
				BELARUS CURRENCY AND STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BLPX'">
				BELGIAN POWER EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BMTS'">
				MTS BELGIUM
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSD'">
				MTS DENMARK
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSF'">
				MTS FINLAND
			</xsl:when>
			<xsl:when test="$exchangeCode='XBRU'">
				EURONEXT - EURONEXT BRUSSELS
			</xsl:when>
			<xsl:when test="$exchangeCode='ALXB'">
				EURONEXT - ALTERNEXT BRUSSELS
			</xsl:when>
			<xsl:when test="$exchangeCode='ENXB'">
				EURONEXT - EASY NEXT
			</xsl:when>
			<xsl:when test="$exchangeCode='MLXB'">
				EURONEXT - MARCHE LIBRE BRUSSELS
			</xsl:when>
			<xsl:when test="$exchangeCode='TNLB'">
				EURONEXT - TRADING FACILITY BRUSSELS
			</xsl:when>
			<xsl:when test="$exchangeCode='VPXB'">
				EURONEXT - VENTES PUBLIQUES BRUSSELS
			</xsl:when>
			<xsl:when test="$exchangeCode='XBRD'">
				EURONEXT - EURONEXT BRUSSELS - DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='XBDA'">
				BERMUDA STOCK EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XBOL'">
				BOLSA BOLIVIANA DE VALORES S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XBLB'">
				BANJA LUKA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BLBF'">
				BANJA LUKA STOCK EXCHANGE - FREE MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSSE'">
				SARAJEVO STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBOT'">
				BOTSWANA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BOTV'">
				BOTSWANA STOCK EXCHANGE - VENTURE CAPITAL
			</xsl:when>
			<xsl:when test="$exchangeCode='BOTE'">
				BOTSWANA STOCK EXCHANGE - EXCHANGE TRADED FUNDS (ETF)
			</xsl:when>
			<xsl:when test="$exchangeCode='BCMM'">
				BOLSA DE CEREAIS E MERCADORIAS DE MARINGÁ
			</xsl:when>
			<xsl:when test="$exchangeCode='BOVM'">
				BOLSA DE VALORES MINAS-ESPÍRITO SANTO-BRASÍLIA
			</xsl:when>
			<xsl:when test="$exchangeCode='BRIX'">
				BRAZILIAN ENERGY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BVMF'">
				BM&amp;FBOVESPA S.A. - BOLSA DE VALORES, MERCADORIAS E FUTUROS
			</xsl:when>
			<xsl:when test="$exchangeCode='CETI'">
				CETIP S.A. - MERCADOS ORGANIZADOS
			</xsl:when>
			<xsl:when test="$exchangeCode='SELC'">
				SISTEMA ESPECIAL DE LIQUIDACAO E CUSTODIA DE TITULOS PUBLICOS
			</xsl:when>
			<xsl:when test="$exchangeCode='IBEX'">
				INDEPENDENT BULGARIAN ENERGY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='MBUL'">
				MTF SOFIA
			</xsl:when>
			<xsl:when test="$exchangeCode='XBUL'">
				BULGARIAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ABUL'">
				BULGARIAN STOCK EXCHANGE - ALTERNATIVE MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XCSX'">
				CAMBODIA SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XDSX'">
				DOUALA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='CAND'">
				CANDEAL.CA INC
			</xsl:when>
			<xsl:when test="$exchangeCode='CANX'">
				CANNEX FINANCIAL EXCHANGE LTS
			</xsl:when>
			<xsl:when test="$exchangeCode='CHIC'">
				CHI-X CANADA ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='XCX2'">
				CX2
			</xsl:when>
			<xsl:when test="$exchangeCode='COTC'">
				BMO CAPITAL MARKETS - CAD OTC TRADES
			</xsl:when>
			<xsl:when test="$exchangeCode='IFCA'">
				ICE FUTURES CANADA
			</xsl:when>
			<xsl:when test="$exchangeCode='IVZX'">
				INVESCO CANADA PTF TRADES
			</xsl:when>
			<xsl:when test="$exchangeCode='LICA'">
				LIQUIDNET CANADA ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='MATN'">
				MATCH NOW
			</xsl:when>
			<xsl:when test="$exchangeCode='NEOE'">
				AEQUITAS NEO EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='NGXC'">
				NATURAL GAS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='OMGA'">
				OMEGA ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='LYNX'">
				LYNX ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='TMXS'">
				TMX SELECT
			</xsl:when>
			<xsl:when test="$exchangeCode='XATS'">
				ALPHA EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBBK'">
				PERIMETER FINANCIAL CORP. - BLOCKBOOK ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='XCNQ'">
				CANADIAN NATIONAL STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='PURE'">
				PURE TRADING
			</xsl:when>
			<xsl:when test="$exchangeCode='XCXD'">
				NASDAQ CXD
			</xsl:when>
			<xsl:when test="$exchangeCode='XICX'">
				INSTINET CANADA CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='XMOC'">
				MONTREAL CLIMATE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMOD'">
				THE MONTREAL EXCHANGE / BOURSE DE MONTREAL
			</xsl:when>
			<xsl:when test="$exchangeCode='XTSE'">
				TORONTO STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTSX'">
				TSX VENTURE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTNX'">
				TSX VENTURE EXCHANGE - NEX
			</xsl:when>
			<xsl:when test="$exchangeCode='XBVC'">
				CAPE VERDE STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCAY'">
				CAYMAN ISLANDS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BOVA'">
				BOLSA DE CORREDORES - BOLSA DE VALORES
			</xsl:when>
			<xsl:when test="$exchangeCode='XBCL'">
				LA BOLSA ELECTRONICA DE CHILE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSGO'">
				SANTIAGO STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='CCFX'">
				CHINA FINANCIAL FUTURES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='CSSX'">
				CHINA STAINLESS STEEL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='SGEX'">
				SHANGHAI GOLD EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCFE'">
				CHINA FOREIGN EXCHANGE TRADE SYSTEM
			</xsl:when>
			<xsl:when test="$exchangeCode='XDCE'">
				DALIAN COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSGE'">
				SHANGHAI FUTURES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XINE'">
				SHANGHAI INTERNATIONAL ENERGY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSHE'">
				SHENZHEN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSEC'">
				SHENZHEN STOCK EXCHANGE - SHENZHEN - HONG KONG STOCK CONNECT
			</xsl:when>
			<xsl:when test="$exchangeCode='XSHG'">
				SHANGHAI STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSSC'">
				SHANGHAI STOCK EXCHANGE - SHANGHAI - HONG KONG STOCK CONNECT
			</xsl:when>
			<xsl:when test="$exchangeCode='XZCE'">
				ZHENGZHOU COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBOG'">
				BOLSA DE VALORES DE COLOMBIA
			</xsl:when>
			<xsl:when test="$exchangeCode='XBNV'">
				BOLSA NACIONAL DE VALORES, S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XCRO'">
				CROATIAN POWER EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTRZ'">
				ZAGREB MONEY AND SHORT TERM SECURITIES MARKET INC
			</xsl:when>
			<xsl:when test="$exchangeCode='XZAG'">
				ZAGREB STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XZAM'">
				THE ZAGREB STOCK EXCHANGE MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='DCSX'">
				DUTCH CARIBBEAN SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCYS'">
				CYPRUS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCYO'">
				CYPRUS STOCK EXCHANGE - OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='XECM'">
				MTF - CYPRUS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='FTFS'">
				42 FINANCIAL SERVICES
			</xsl:when>
			<xsl:when test="$exchangeCode='XPRA'">
				PRAGUE STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPRM'">
				PRAGUE STOCK EXCHANGE - MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XPXE'">
				POWER EXCHANGE CENTRAL EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='XRMZ'">
				RM-SYSTEM CZECH STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XRMO'">
				RM-SYSTEM CZECH STOCK EXCHANGE (MTF)
			</xsl:when>
			<xsl:when test="$exchangeCode='DASI'">
				DANSKE BANK A/S - SYSTEMATIC INTERNALISER
			</xsl:when>
			<xsl:when test="$exchangeCode='DKTC'">
				DANSK OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='GXGR'">
				GXG MARKETS A/S
			</xsl:when>
			<xsl:when test="$exchangeCode='GXGF'">
				GXG MTF FIRST QUOTE
			</xsl:when>
			<xsl:when test="$exchangeCode='GXGM'">
				GXG MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='NPGA'">
				GASPOINT NORDIC A/S
			</xsl:when>
			<xsl:when test="$exchangeCode='XCSE'">
				NASDAQ COPENHAGEN A/S
			</xsl:when>
			<xsl:when test="$exchangeCode='DCSE'">
				NASDAQ COPENHAGEN A/S - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='FNDK'">
				FIRST NORTH DENMARK
			</xsl:when>
			<xsl:when test="$exchangeCode='DNDK'">
				FIRST NORTH DENMARK - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='MCSE'">
				NASDAQ COPENHAGEN A/S – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='MNDK'">
				FIRST NORTH DENMARK – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='XBVR'">
				BOLSA DE VALORES DE LA REPUBLICA DOMINICANA SA.
			</xsl:when>
			<xsl:when test="$exchangeCode='XGUA'">
				BOLSA DE VALORES DE GUAYAQUIL
			</xsl:when>
			<xsl:when test="$exchangeCode='XQUI'">
				BOLSA DE VALORES DE QUITO
			</xsl:when>
			<xsl:when test="$exchangeCode='NILX'">
				NILE STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCAI'">
				EGYPTIAN EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSVA'">
				EL SALVADOR STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTAL'">
				NASDAQ TALLINN AS
			</xsl:when>
			<xsl:when test="$exchangeCode='FNEE'">
				FIRST NORTH ESTONIA
			</xsl:when>
			<xsl:when test="$exchangeCode='VMFX'">
				THE FAROESE SECURITIES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSPS'">
				SOUTH PACIFIC STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='FGEX'">
				KAASUPORSSI - FINNISH GAS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XHEL'">
				NASDAQ HELSINKI LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='FNFI'">
				FIRST NORTH FINLAND
			</xsl:when>
			<xsl:when test="$exchangeCode='DHEL'">
				NASDAQ HELSINKI LTD - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='DNFI'">
				FIRST NORTH FINLAND - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='MHEL'">
				NASDAQ HELSINKI LTD – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='MNFI'">
				FIRST NORTH FINLAND – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='COAL'">
				LA COTE ALPHA
			</xsl:when>
			<xsl:when test="$exchangeCode='EPEX'">
				EPEX SPOT SE
			</xsl:when>
			<xsl:when test="$exchangeCode='FMTS'">
				MTS FRANCE SAS
			</xsl:when>
			<xsl:when test="$exchangeCode='GMTF'">
				GALAXY
			</xsl:when>
			<xsl:when test="$exchangeCode='LCHC'">
				LCH.CLEARNET
			</xsl:when>
			<xsl:when test="$exchangeCode='XAFR'">
				ALTERNATIVA FRANCE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBLN'">
				BLUENEXT
			</xsl:when>
			<xsl:when test="$exchangeCode='XPAR'">
				EURONEXT - EURONEXT PARIS
			</xsl:when>
			<xsl:when test="$exchangeCode='ALXP'">
				EURONEXT - ALTERNEXT PARIS
			</xsl:when>
			<xsl:when test="$exchangeCode='MTCH'">
				BONDMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAT'">
				EURONEXT PARIS MATIF
			</xsl:when>
			<xsl:when test="$exchangeCode='XMLI'">
				EURONEXT - MARCHE LIBRE PARIS
			</xsl:when>
			<xsl:when test="$exchangeCode='XMON'">
				EURONEXT PARIS MONEP
			</xsl:when>
			<xsl:when test="$exchangeCode='XSPM'">
				EURONEXT STRUCTURED PRODUCTS MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XPOW'">
				POWERNEXT
			</xsl:when>
			<xsl:when test="$exchangeCode='XPSF'">
				POWERNEXT - GAS SPOT AND FUTURES
			</xsl:when>
			<xsl:when test="$exchangeCode='XPOT'">
				POWERNEXT - OTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XGSE'">
				GEORGIA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='360T'">
				360T
			</xsl:when>
			<xsl:when test="$exchangeCode='CATS'">
				CATS
			</xsl:when>
			<xsl:when test="$exchangeCode='DBOX'">
				DEUTSCHE BANK OFF EXCHANGE TRADING
			</xsl:when>
			<xsl:when test="$exchangeCode='AUTO'">
				AUTOBAHN FX
			</xsl:when>
			<xsl:when test="$exchangeCode='ECAG'">
				EUREX CLEARING AG
			</xsl:when>
			<xsl:when test="$exchangeCode='FICX'">
				FINANCIAL INFORMATION CONTRIBUTORS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='TGAT'">
				TRADEGATE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XGAT'">
				TRADEGATE EXCHANGE - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='XGRM'">
				TRADEGATE EXCHANGE - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='XBER'">
				BOERSE BERLIN
			</xsl:when>
			<xsl:when test="$exchangeCode='BERA'">
				BOERSE BERLIN - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='BERB'">
				BOERSE BERLIN - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='BERC'">
				BOERSE BERLIN - BERLIN SECOND REGULATED MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='EQTA'">
				BOERSE BERLIN EQUIDUCT TRADING - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='EQTB'">
				BOERSE BERLIN EQUIDUCT TRADING - BERLIN SECOND REGULATED MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='EQTC'">
				BOERSE BERLIN EQUIDUCT TRADING - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='EQTD'">
				BOERSE BERLIN EQUIDUCT TRADING - OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='XEQT'">
				BOERSE BERLIN EQUIDUCT TRADING
			</xsl:when>
			<xsl:when test="$exchangeCode='ZOBX'">
				ZOBEX
			</xsl:when>
			<xsl:when test="$exchangeCode='XDUS'">
				BOERSE DUESSELDORF
			</xsl:when>
			<xsl:when test="$exchangeCode='DUSA'">
				BOERSE DUESSELDORF - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='DUSB'">
				BOERSE DUESSELDORF - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='DUSC'">
				BOERSE DUESSELDORF - QUOTRIX - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='DUSD'">
				BOERSE DUESSELDORF - QUOTRIX MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XQTX'">
				BOERSE DUESSELDORF - QUOTRIX
			</xsl:when>
			<xsl:when test="$exchangeCode='XECB'">
				ECB EXCHANGE RATES
			</xsl:when>
			<xsl:when test="$exchangeCode='XECC'">
				EUROPEAN COMMODITY CLEARING AG
			</xsl:when>
			<xsl:when test="$exchangeCode='XEEE'">
				EUROPEAN ENERGY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XEEO'">
				EUROPEAN ENERGY EXCHANGE - NON-MTF MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XEER'">
				EUROPEAN ENERGY EXCHANGE - REGULATED MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XETR'">
				XETRA
			</xsl:when>
			<xsl:when test="$exchangeCode='XEUB'">
				EUREX BONDS
			</xsl:when>
			<xsl:when test="$exchangeCode='XETA'">
				XETRA - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='XETB'">
				XETRA - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='XEUP'">
				EUREX REPO GMBH
			</xsl:when>
			<xsl:when test="$exchangeCode='XEUM'">
				EUREX REPO SECLEND MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XERE'">
				EUREX REPO - FUNDING AND FINANCING PRODUCTS
			</xsl:when>
			<xsl:when test="$exchangeCode='XERT'">
				EUREX REPO - TRIPARTY
			</xsl:when>
			<xsl:when test="$exchangeCode='XEUR'">
				EUREX DEUTSCHLAND
			</xsl:when>
			<xsl:when test="$exchangeCode='XFRA'">
				DEUTSCHE BOERSE AG
			</xsl:when>
			<xsl:when test="$exchangeCode='FRAA'">
				BOERSE FRANKFURT - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='FRAB'">
				BOERSE FRANKFURT - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='XDBC'">
				DEUTSCHE BOERSE AG - CUSTOMIZED INDICES
			</xsl:when>
			<xsl:when test="$exchangeCode='XDBV'">
				DEUTSCHE BOERSE AG - VOLATILITY INDICES
			</xsl:when>
			<xsl:when test="$exchangeCode='XDBX'">
				DEUTSCHE BOERSE AG - INDICES
			</xsl:when>
			<xsl:when test="$exchangeCode='XHAM'">
				HANSEATISCHE WERTPAPIERBOERSE HAMBURG
			</xsl:when>
			<xsl:when test="$exchangeCode='HAMA'">
				BOERSE HAMBURG - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='HAMB'">
				BOERSE HAMBURG - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='HAML'">
				BOERSE HAMBURG - LANG AND SCHWARZ EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='HAMM'">
				BOERSE HAMBURG - LANG AND SCHWARZ EXCHANGE - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='HAMN'">
				BOERSE HAMBURG - LANG AND SCHWARZ EXCHANGE - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='XHAN'">
				NIEDERSAECHSISCHE BOERSE ZU HANNOVER
			</xsl:when>
			<xsl:when test="$exchangeCode='HANA'">
				BOERSE HANNOVER - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='HANB'">
				BOERSE HANNOVER - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='XINV'">
				INVESTRO
			</xsl:when>
			<xsl:when test="$exchangeCode='XMUN'">
				BOERSE MUENCHEN
			</xsl:when>
			<xsl:when test="$exchangeCode='MUNA'">
				BOERSE MUENCHEN - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='MUNB'">
				BOERSE MUENCHEN - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='MUNC'">
				BOERSE MUENCHEN - MARKET MAKER MUNICH - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='MUND'">
				BOERSE MUENCHEN - MARKET MAKER MUNICH - FREIVERKEHR MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='XSCO'">
				BOERSE FRANKFURT WARRANTS TECHNICAL
			</xsl:when>
			<xsl:when test="$exchangeCode='XSC1'">
				BOERSE FRANKFURT WARRANTS TECHNICAL 1
			</xsl:when>
			<xsl:when test="$exchangeCode='XSC2'">
				BOERSE FRANKFURT WARRANTS TECHNICAL 2
			</xsl:when>
			<xsl:when test="$exchangeCode='XSC3'">
				BOERSE FRANKFURT WARRANTS TECHNICAL 3
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTU'">
				BOERSE STUTTGART
			</xsl:when>
			<xsl:when test="$exchangeCode='EUWX'">
				EUWAX
			</xsl:when>
			<xsl:when test="$exchangeCode='STUA'">
				BOERSE STUTTGART - REGULIERTER MARKT
			</xsl:when>
			<xsl:when test="$exchangeCode='STUB'">
				BOERSE STUTTGART - FREIVERKEHR
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTF'">
				BOERSE STUTTGART - TECHNICAL PLATFORM 2
			</xsl:when>
			<xsl:when test="$exchangeCode='STUC'">
				BOERSE STUTTGART - REGULIERTER MARKT - TECHNICAL PLATFORM 2
			</xsl:when>
			<xsl:when test="$exchangeCode='STUD'">
				BOERSE STUTTGART - FREIVERKEHR - TECHNICAL PLATFORM 2
			</xsl:when>
			<xsl:when test="$exchangeCode='XXSC'">
				FRANKFURT CEF SC
			</xsl:when>
			<xsl:when test="$exchangeCode='XGHA'">
				GHANA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='GSXL'">
				THE GIBRALTAR STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ASEX'">
				ATHENS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ENAX'">
				ATHENS EXCHANGE ALTERNATIVE MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='HOTC'">
				HELLENIC EXCHANGE OTC MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XADE'">
				ATHENS EXCHANGE S.A. DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XATH'">
				ATHENS EXCHANGE S.A. CASH MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XIPO'">
				HELEX ELECTRONIC BOOK BUILDING
			</xsl:when>
			<xsl:when test="$exchangeCode='HDAT'">
				ELECTRONIC SECONDARY SECURITIES MARKET (HDAT)
			</xsl:when>
			<xsl:when test="$exchangeCode='HEMO'">
				LAGIE - OPERATOR OF THE ENERGY MARKET S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XGTG'">
				BOLSA DE VALORES NACIONAL SA
			</xsl:when>
			<xsl:when test="$exchangeCode='XCIE'">
				CHANNEL ISLANDS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='GSCI'">
				THE GUYANA ASSOCIATION OF SECURITIES COMPANIES AND INTERMEDIARIES INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='XBCV'">
				BOLSA CENTROAMERICANA DE VALORES S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='CGMH'">
				CITI MATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='CLHK'">
				CLSA HONG KONG - DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='CSHK'">
				CREDIT SUISSE SECURITIES (HONG KONG) LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='CFHK'">
				CROSSFINDER HONG KONG
			</xsl:when>
			<xsl:when test="$exchangeCode='DBHK'">
				DEUTSCHE BANK HONG KONG ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='EOTC'">
				E-OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='GSXH'">
				GSX HONG KONG
			</xsl:when>
			<xsl:when test="$exchangeCode='HSXA'">
				HSBC-X HONG KONG
			</xsl:when>
			<xsl:when test="$exchangeCode='JPMI'">
				JP MORGAN - JPMI MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='MAQH'">
				MACQUARIE INTERNAL MARKETS (HONG KONG)
			</xsl:when>
			<xsl:when test="$exchangeCode='SIGH'">
				SIGMA X HONG KONG
			</xsl:when>
			<xsl:when test="$exchangeCode='TOCP'">
				TORA CROSSPOINT
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSX'">
				UBS CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='XCGS'">
				CHINESE GOLD &amp; SILVER EXCHANGE SOCIETY
			</xsl:when>
			<xsl:when test="$exchangeCode='XHKF'">
				HONG KONG FUTURES EXCHANGE LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='XHKG'">
				HONG KONG EXCHANGES AND CLEARING LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XGEM'">
				HONG KONG GROWTH ENTERPRISES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='SHSC'">
				STOCK EXCHANGE OF HONG KONG LIMITED - SHANGHAI - HONG KONG STOCK
				CONNECT
			</xsl:when>
			<xsl:when test="$exchangeCode='SZSC'">
				STOCK EXCHANGE OF HONG KONG LIMITED - SHENZHEN - HONG KONG STOCK
				CONNECT
			</xsl:when>
			<xsl:when test="$exchangeCode='XIHK'">
				INSTINET PACIFIC LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XPST'">
				POSIT - ASIA PACIFIC
			</xsl:when>
			<xsl:when test="$exchangeCode='BETA'">
				BETA MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='HUPX'">
				HUNGARIAN POWER EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='KCCP'">
				KELER CCP
			</xsl:when>
			<xsl:when test="$exchangeCode='XBUD'">
				BUDAPEST STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XGAS'">
				CENTRAL EASTERN EUROPEAN GAS EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XICE'">
				NASDAQ ICELAND HF.
			</xsl:when>
			<xsl:when test="$exchangeCode='DICE'">
				NASDAQ ICELAND HF. - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='FNIS'">
				FIRST NORTH ICELAND
			</xsl:when>
			<xsl:when test="$exchangeCode='DNIS'">
				FIRST NORTH ICELAND - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='MICE'">
				NASDAQ ICELAND HF. – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='MNIS'">
				FIRST NORTH ICELAND – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='ACEX'">
				ACE DERIVATIVES &amp; COMMODITY EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='CDSL'">
				CLEARCORP DEALING SYSTEMS (INDIA) LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='FXCL'">
				CLEARCORP DEALING SYSTEMS INDIA LIMITED – FX-CLEAR
			</xsl:when>
			<xsl:when test="$exchangeCode='FXSW'">
				CLEARCORP DEALING SYSTEMS INDIA LIMITED – FX-SWAP
			</xsl:when>
			<xsl:when test="$exchangeCode='ASTR'">
				CLEARCORP DEALING SYSTEMS INDIA LIMITED – ASTROID
			</xsl:when>
			<xsl:when test="$exchangeCode='ICXL'">
				INDIAN COMMODITY EXCHANGE LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='ISEX'">
				INTER-CONNECTED STOCK EXCHANGE OF INDIA LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='MCXX'">
				MCX STOCK EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='NBOT'">
				NATIONAL BOARD OF TRADE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='NMCE'">
				NATIONAL MULTI-COMMODITY EXCHANGE OF INDIA
			</xsl:when>
			<xsl:when test="$exchangeCode='OTCX'">
				OTC EXCHANGE OF INDIA
			</xsl:when>
			<xsl:when test="$exchangeCode='PXIL'">
				POWER EXCHANGE INDIA LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='XBAN'">
				BANGALORE STOCK EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XBOM'">
				BSE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='BSME'">
				BSE SME
			</xsl:when>
			<xsl:when test="$exchangeCode='XCAL'">
				CALCUTTA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XDES'">
				DELHI STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XIMC'">
				MULTI COMMODITY EXCHANGE OF INDIA LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='XMDS'">
				MADRAS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNCD'">
				NATIONAL COMMODITY &amp; DERIVATIVES EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XNSE'">
				NATIONAL STOCK EXCHANGE OF INDIA
			</xsl:when>
			<xsl:when test="$exchangeCode='XUSE'">
				UNITED STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ICDX'">
				INDONESIA COMMODITY AND DERIVATIVES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBBJ'">
				JAKARTA FUTURES EXCHANGE (BURSA BERJANGKA JAKARTA)
			</xsl:when>
			<xsl:when test="$exchangeCode='XIDX'">
				INDONESIA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XJNB'">
				JAKARTA NEGOTIATED BOARD
			</xsl:when>
			<xsl:when test="$exchangeCode='IMEX'">
				IRAN MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTEH'">
				TEHRAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XIQS'">
				IRAQ STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='AREX'">
				AREX - AUTOMATED RECEIVABLES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPOS'">
				POSIT
			</xsl:when>
			<xsl:when test="$exchangeCode='XCDE'">
				BAXTER FINANCIAL SERVICES
			</xsl:when>
			<xsl:when test="$exchangeCode='XDUB'">
				IRISH STOCK EXCHANGE - ALL MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XEYE'">
				IRISH STOCK EXCHANGE - GEM - XETRA
			</xsl:when>
			<xsl:when test="$exchangeCode='XESM'">
				DUBLIN - IRISH STOCK EXCHANGE - ENTREPRISE SECURITIES MARKET (ESM)-
				ISE XETRA
			</xsl:when>
			<xsl:when test="$exchangeCode='XMSM'">
				DUBLIN - IRISH STOCK EXCHANGE - MAIN SECURITIES MARKET (MSM)- ISE
				XETRA
			</xsl:when>
			<xsl:when test="$exchangeCode='XATL'">
				ATLANTIC SECURITIES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XEBI'">
				ENERGY BROKING IRELAND GAS TRADING PLATFORM
			</xsl:when>
			<xsl:when test="$exchangeCode='XTAE'">
				TEL AVIV STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='CGIT'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA
			</xsl:when>
			<xsl:when test="$exchangeCode='CGQT'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - EQUITY CCP SERVICE
			</xsl:when>
			<xsl:when test="$exchangeCode='CGDB'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - BONDS CCP SERVICE
			</xsl:when>
			<xsl:when test="$exchangeCode='CGEB'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - EURO BONDS CCP SERVICE
			</xsl:when>
			<xsl:when test="$exchangeCode='CGTR'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - TRIPARTY REPO CCP SERVICE
			</xsl:when>
			<xsl:when test="$exchangeCode='CGQD'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - CCP EQUITY DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='CGND'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - CCP ENERGY DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='CGGD'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - CCP AGRICULTURAL COMMODITY
				DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='CGCM'">
				CASSA DI COMPENSAZIONE E GARANZIA SPA - COLLATERALIZED MONEY MARKET
				GUARANTEE SERVICE
			</xsl:when>
			<xsl:when test="$exchangeCode='EMID'">
				E-MID
			</xsl:when>
			<xsl:when test="$exchangeCode='EMDR'">
				E-MID - E-MIDER MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='EMIR'">
				E-MID REPO
			</xsl:when>
			<xsl:when test="$exchangeCode='EMIB'">
				E-MID - BANCA D'ITALIA SHARES TRADING MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='ETLX'">
				EUROTLX
			</xsl:when>
			<xsl:when test="$exchangeCode='HMTF'">
				HI-MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='HMOD'">
				HI-MTF ORDER DRIVEN
			</xsl:when>
			<xsl:when test="$exchangeCode='HRFQ'">
				HI-MTF RFQ
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSO'">
				MTS S.P.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='BOND'">
				BONDVISION ITALIA
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSC'">
				MTS ITALIA
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSM'">
				MTS CORPORATE MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='SSOB'">
				BONDVISION ITALIA MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XGME'">
				GESTORE MERCATO ELETTRICO - ITALIAN POWER EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMIL'">
				BORSA ITALIANA S.P.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='MTAH'">
				BORSA ITALIANA EQUITY MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='ETFP'">
				ELECTRONIC OPEN-END FUNDS AND ETC MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='MIVX'">
				MARKET FOR INVESTMENT VEHICLES
			</xsl:when>
			<xsl:when test="$exchangeCode='MOTX'">
				ELECTRONIC BOND MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='MTAA'">
				ELECTRONIC SHARE MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='SEDX'">
				SECURITISED DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XAIM'">
				AIM ITALIA - MERCATO ALTERNATIVO DEL CAPITALE
			</xsl:when>
			<xsl:when test="$exchangeCode='XDMI'">
				ITALIAN DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XMOT'">
				EXTRAMOT
			</xsl:when>
			<xsl:when test="$exchangeCode='XBRV'">
				BOURSE REGIONALE DES VALEURS MOBILIERES
			</xsl:when>
			<xsl:when test="$exchangeCode='XJAM'">
				JAMAICA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BETP'">
				BLOOMBERG TRADEBOOK JAPAN LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='CHIJ'">
				CHI-X JAPAN
			</xsl:when>
			<xsl:when test="$exchangeCode='CHIV'">
				CHI-X JAPAN VWAP CROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='CHIS'">
				CHI-X JAPAN SELECT
			</xsl:when>
			<xsl:when test="$exchangeCode='KAIX'">
				KAI-X
			</xsl:when>
			<xsl:when test="$exchangeCode='CITX'">
				CITI MATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='CITD'">
				CITI DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='CLJP'">
				CLSA JAPAN - DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='CMET'">
				CLEAR MARKETS JAPAN, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='CSJP'">
				CREDIT SUISSE EQUITIES (JAPAN) LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='CFJP'">
				CROSSFINDER JAPAN
			</xsl:when>
			<xsl:when test="$exchangeCode='DRCT'">
				DAIWA DRECT
			</xsl:when>
			<xsl:when test="$exchangeCode='LXJP'">
				BARCLAYS LX JAPAN
			</xsl:when>
			<xsl:when test="$exchangeCode='MAQJ'">
				MACQUARIE INTERNAL MARKETS (JAPAN)
			</xsl:when>
			<xsl:when test="$exchangeCode='MIZX'">
				MIZUHO INTERNAL CROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='MSMS'">
				MORGAN STANLEY MUFG SECURITIES CO., LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='NMRJ'">
				NOMURA SECURITIES CO LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='NXJP'">
				NX JAPAN
			</xsl:when>
			<xsl:when test="$exchangeCode='NXVW'">
				NX VWAP
			</xsl:when>
			<xsl:when test="$exchangeCode='NXSE'">
				NX SELECT JAPAN
			</xsl:when>
			<xsl:when test="$exchangeCode='SBIJ'">
				SBI JAPANNEXT-J-MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSBI'">
				SBI JAPANNEXT - X - MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='SBIV'">
				SBI JAPANNEXT - VWAP CROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='SBIU'">
				SBI JAPANNEXT - U - MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='SIGJ'">
				SIGMA X JAPAN
			</xsl:when>
			<xsl:when test="$exchangeCode='XFKA'">
				FUKUOKA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XIJP'">
				INSTINET JAPAN
			</xsl:when>
			<xsl:when test="$exchangeCode='JASR'">
				JAPANCROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='XJPX'">
				JAPAN EXCHANGE GROUP
			</xsl:when>
			<xsl:when test="$exchangeCode='XJAS'">
				TOKYO STOCK EXCHANGE JASDAQ
			</xsl:when>
			<xsl:when test="$exchangeCode='XOSE'">
				OSAKA EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XOSJ'">
				OSAKA EXCHANGE J-NET
			</xsl:when>
			<xsl:when test="$exchangeCode='XTAM'">
				TOKYO STOCK EXCHANGE-TOKYO PRO MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XTK1'">
				TOKYO STOCK EXCHANGE - TOSTNET-1
			</xsl:when>
			<xsl:when test="$exchangeCode='XTK2'">
				TOKYO STOCK EXCHANGE - TOSTNET-2
			</xsl:when>
			<xsl:when test="$exchangeCode='XTK3'">
				TOKYO STOCK EXCHANGE - TOSTNET-3
			</xsl:when>
			<xsl:when test="$exchangeCode='XTKS'">
				TOKYO STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKAC'">
				OSAKA DOJIMA COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNGO'">
				NAGOYA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNKS'">
				CENTRAL JAPAN COMMODITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSAP'">
				SAPPORO SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTFF'">
				TOKYO FINANCIAL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTKT'">
				TOKYO COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XAMM'">
				AMMAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ETSC'">
				ETS EURASIAN TRADING SYSTEM COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKAZ'">
				KAZAKHSTAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNAI'">
				NAIROBI STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKFB'">
				KOREA FREEBOARD MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XKRX'">
				KOREA EXCHANGE (STOCK MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='XKFE'">
				KOREA EXCHANGE (FUTURES MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='XKOS'">
				KOREA EXCHANGE (KOSDAQ)
			</xsl:when>
			<xsl:when test="$exchangeCode='XKON'">
				KOREA NEW EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKCM'">
				KOREA EXCHANGE COMMODITY MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XKEM'">
				KOREA EXCHANGE EMISSIONS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XKUW'">
				KUWAIT STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKSE'">
				KYRGYZ STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLAO'">
				LAO SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XRIS'">
				NASDAQ RIGA AS
			</xsl:when>
			<xsl:when test="$exchangeCode='FNLV'">
				FIRST NORTH LATVIA
			</xsl:when>
			<xsl:when test="$exchangeCode='XBEY'">
				BOURSE DE BEYROUTH - BEIRUT STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLSM'">
				LIBYAN STOCK MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XLGT'">
				LGT BANK AG - SYSTEMATIC INTERNALISER
			</xsl:when>
			<xsl:when test="$exchangeCode='BAPX'">
				BALTPOOL
			</xsl:when>
			<xsl:when test="$exchangeCode='GETB'">
				LITHUANIAN NATURAL GAS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLIT'">
				AB NASDAQ VILNIUS
			</xsl:when>
			<xsl:when test="$exchangeCode='FNLT'">
				FIRST NORTH LITHUANIA
			</xsl:when>
			<xsl:when test="$exchangeCode='CCLX'">
				FINESTI S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XLUX'">
				LUXEMBOURG STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='EMTF'">
				EURO MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XVES'">
				VESTIMA
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAE'">
				MACEDONIAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMDG'">
				MARCHE INTERBANCAIRE DES DEVISES M.I.D.
			</xsl:when>
			<xsl:when test="$exchangeCode='XMSW'">
				MALAWI STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKLS'">
				BURSA MALAYSIA
			</xsl:when>
			<xsl:when test="$exchangeCode='MESQ'">
				ACE MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XLFX'">
				LABUAN INTERNATIONAL FINANCIAL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XRBM'">
				RINGGIT BOND MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='MALX'">
				MALDIVES STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='EWSM'">
				EUROPEAN WHOLESALE SECURITIES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAL'">
				MALTA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='PROS'">
				PROSPECTS
			</xsl:when>
			<xsl:when test="$exchangeCode='GBOT'">
				BOURSE AFRICA LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='XAFX'">
				AFRICAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAU'">
				STOCK EXCHANGE OF MAURITIUS LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='CGMX'">
				CITI MEXICO RPI (RETAIL PRICE IMPROVEMENT)
			</xsl:when>
			<xsl:when test="$exchangeCode='XEMD'">
				MERCADO MEXICANO DE DERIVADOS
			</xsl:when>
			<xsl:when test="$exchangeCode='XMEX'">
				BOLSA MEXICANA DE VALORES (MEXICAN STOCK EXCHANGE)
			</xsl:when>
			<xsl:when test="$exchangeCode='XMOL'">
				MOLDOVA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XULA'">
				MONGOLIAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMNX'">
				MONTENEGRO STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCAS'">
				CASABLANCA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBVM'">
				MOZAMBIQUE STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNAM'">
				NAMIBIAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNEP'">
				NEPAL STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='NZFX'">
				NEW ZEALAND FUTURES &amp; OPTIONS
			</xsl:when>
			<xsl:when test="$exchangeCode='XNZE'">
				NEW ZEALAND EXCHANGE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAN'">
				BOLSA DE VALORES DE NICARAGUA
			</xsl:when>
			<xsl:when test="$exchangeCode='NASX'">
				NASD OTC MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XNSA'">
				THE NIGERIAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='FISH'">
				FISH POOL ASA
			</xsl:when>
			<xsl:when test="$exchangeCode='FSHX'">
				FISHEX
			</xsl:when>
			<xsl:when test="$exchangeCode='ICAS'">
				ICAP ENERGY AS
			</xsl:when>
			<xsl:when test="$exchangeCode='NEXO'">
				NOREXECO ASA
			</xsl:when>
			<xsl:when test="$exchangeCode='NOPS'">
				NORD POOL SPOT AS
			</xsl:when>
			<xsl:when test="$exchangeCode='NORX'">
				NASDAQ OMX COMMODITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='ELEU'">
				NASDAQ COMMODITIES - EUR POWER/ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='ELSE'">
				NASDAQ COMMODITIES - SEK POWER/ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='ELNO'">
				NASDAQ COMMODITIES - NOK POWER/ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='ELUK'">
				NASDAQ COMMODITIES - GBP POWER/ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='FREI'">
				NASDAQ COMMODITIES - FREIGHT COMMODITY
			</xsl:when>
			<xsl:when test="$exchangeCode='BULK'">
				NASDAQ COMMODITIES - BULK COMMODITY
			</xsl:when>
			<xsl:when test="$exchangeCode='STEE'">
				NASDAQ COMMODITIES - STEEL COMMODITY
			</xsl:when>
			<xsl:when test="$exchangeCode='NOSC'">
				NOS CLEARING ASA
			</xsl:when>
			<xsl:when test="$exchangeCode='NOTC'">
				NORWEGIAN OVER THE COUNTER MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='OSLC'">
				SIX X-CLEAR AG
			</xsl:when>
			<xsl:when test="$exchangeCode='XIMA'">
				INTERNATIONAL MARTIME EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XOSL'">
				OSLO BORS ASA
			</xsl:when>
			<xsl:when test="$exchangeCode='XOAM'">
				NORDIC ALTERNATIVE BOND MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XOAS'">
				OSLO AXESS
			</xsl:when>
			<xsl:when test="$exchangeCode='XOSC'">
				OSLO CONNECT
			</xsl:when>
			<xsl:when test="$exchangeCode='NIBR'">
				NORWEGIAN INTER BANK OFFERED RATE
			</xsl:when>
			<xsl:when test="$exchangeCode='XOAD'">
				OSLO AXESS NORTH SEA - DARK POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='XOSD'">
				OSLO BORS NORTH SEA - DARK POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='MERD'">
				MERKUR MARKET - DARK POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='MERK'">
				MERKUR MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XMUS'">
				MUSCAT SECURITIES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='NCEL'">
				PAKISTAN MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKAR'">
				THE PAKISTAN STOCK EXCHANGE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='XPAE'">
				PALESTINE SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPTY'">
				BOLSA DE VALORES DE PANAMA, S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XPOM'">
				PORT MORESBY STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XVPA'">
				BOLSA DE VALORES Y PRODUCTOS DE ASUNCION SA
			</xsl:when>
			<xsl:when test="$exchangeCode='XLIM'">
				BOLSA DE VALORES DE LIMA
			</xsl:when>
			<xsl:when test="$exchangeCode='CLPH'">
				CLSA PHILIPPINES - DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='PDEX'">
				PHILIPPINE DEALING AND EXCHANGE CORP
			</xsl:when>
			<xsl:when test="$exchangeCode='XPHS'">
				PHILIPPINE STOCK EXCHANGE, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='IENG'">
				INFOENGINE OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='KDPW'">
				KDPW_CCP
			</xsl:when>
			<xsl:when test="$exchangeCode='PTPG'">
				POLISH TRADING POINT
			</xsl:when>
			<xsl:when test="$exchangeCode='XWAR'">
				WARSAW STOCK EXCHANGE/EQUITIES/MAIN MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='PLPX'">
				WARSAW STOCK EXCHANGE/COMMODITIES/POLISH POWER EXCHANGE/ENERGY MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='BOSP'">
				WARSAW STOCK EXCHANGE/BONDS/CATALYST/BONDSPOT/MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='RPWC'">
				WARSAW STOCK EXCHANGE/BONDS/CATALYST/BONDSPOT/REGULATED MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='TBSP'">
				WARSAW STOCK EXCHANGE/BONDS/BONDSPOT/TREASURY BOND MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XNCO'">
				WARSAW STOCK EXCHANGE/ EQUITIES/NEW CONNECT-MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='WBON'">
				WARSAW STOCK EXCHANGE/ BONDS/CATALYST/MAIN MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='WDER'">
				WARSAW STOCK EXCHANGE/FINANCIAL DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='WETP'">
				WARSAW STOCK EXCHANGE/ ETPS
			</xsl:when>
			<xsl:when test="$exchangeCode='WGAS'">
				WARSAW STOCK EXCHANGE/COMMODITIES/POLISH POWER EXCHANGE/GAS
			</xsl:when>
			<xsl:when test="$exchangeCode='WIND'">
				WARSAW STOCK EXCHANGE/INDICES
			</xsl:when>
			<xsl:when test="$exchangeCode='WMTF'">
				WARSAW STOCK EXCHANGE/BONDS/CATALYST/MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='WBCL'">
				WARSAW STOCK EXCHANGE/BONDS/CATALYST/LISTING
			</xsl:when>
			<xsl:when test="$exchangeCode='PLPD'">
				WARSAW STOCK EXCHANGE/COMMODITIES/POLISH POWER EXCHANGE/COMMODITY
				DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='OMIC'">
				THE IBERIAN ENERGY CLEARING HOUSE
			</xsl:when>
			<xsl:when test="$exchangeCode='OPEX'">
				PEX-PRIVATE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLIS'">
				EURONEXT - EURONEXT LISBON
			</xsl:when>
			<xsl:when test="$exchangeCode='ALXL'">
				EURONEXT - ALTERNEXT LISBON
			</xsl:when>
			<xsl:when test="$exchangeCode='ENXL'">
				EURONEXT - EASYNEXT LISBON
			</xsl:when>
			<xsl:when test="$exchangeCode='MFOX'">
				EURONEXT - MERCADO DE FUTUROS E OPÇÕES
			</xsl:when>
			<xsl:when test="$exchangeCode='OMIP'">
				OPERADOR DE MERCADO IBERICO DE ENERGIA - PORTUGAL
			</xsl:when>
			<xsl:when test="$exchangeCode='WQXL'">
				EURONEXT - MARKET WITHOUT QUOTATIONS LISBON
			</xsl:when>
			<xsl:when test="$exchangeCode='DSMD'">
				QATAR EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='TRPX'">
				TROP-X
			</xsl:when>
			<xsl:when test="$exchangeCode='BMFX'">
				SIBIU MONETARY- FINANCIAL AND COMMODITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BMFA'">
				BMFMS-ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='BMFM'">
				DERIVATIVES REGULATED MARKET - BMFMS
			</xsl:when>
			<xsl:when test="$exchangeCode='SBMF'">
				SPOT REGULATED MARKET - BMFMS
			</xsl:when>
			<xsl:when test="$exchangeCode='XBRM'">
				ROMANIAN COMMODITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBSE'">
				SPOT REGULATED MARKET - BVB
			</xsl:when>
			<xsl:when test="$exchangeCode='XBSD'">
				DERIVATIVES REGULATED MARKET - BVB
			</xsl:when>
			<xsl:when test="$exchangeCode='XCAN'">
				CAN-ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='XRAS'">
				RASDAQ
			</xsl:when>
			<xsl:when test="$exchangeCode='XRPM'">
				ROMANIAN POWER MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='MISX'">
				MOSCOW EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='RTSX'">
				MOSCOW EXCHANGE-DERIVATIVES AND CLASSICA MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='NAMX'">
				NATIONAL MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='RPDX'">
				MOSCOW ENERGY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='RUSX'">
				NON-PROFIT PARTNERSHIP FOR THE DEVELOPMENT OF FINANCIAL MARKET RTS
			</xsl:when>
			<xsl:when test="$exchangeCode='SPIM'">
				ST. PETERSBURG INTERNATIONAL MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMOS'">
				MOSCOW STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPET'">
				SAINT PETERSBURG EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPIC'">
				SAINT-PETERSBURG CURRENCY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XRUS'">
				INTERNET DIRECT-ACCESS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSAM'">
				SAMARA CURRENCY INTERBANK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSIB'">
				SIBERIAN EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ROTC'">
				RWANDA OTC MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='RSEX'">
				RWANDA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XECS'">
				EASTERN CARIBBEAN SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSAU'">
				SAUDI STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBEL'">
				BELGRADE STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='CLTD'">
				CLEARTRADE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ECAL'">
				EUREX CLEARING ASIA PTE. LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='EEAL'">
				EUREX EXCHANGE ASIA PTE. LTD.
			</xsl:when>
			<xsl:when test="$exchangeCode='IFSG'">
				ICE FUTURES SINGAPORE
			</xsl:when>
			<xsl:when test="$exchangeCode='JADX'">
				JOINT ASIAN DERIVATIVES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='SMEX'">
				SINGAPORE MERCANTILE EXCHANGE PTE LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='TFSA'">
				TFS GREEN AUSTRALIAN GREEN MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='XSES'">
				SINGAPORE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSCE'">
				SINGAPORE COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSCA'">
				SINGAPORE CATALIST MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSIM'">
				SINGAPORE EXCHANGE DERIVATIVES CLEARING LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='SPXE'">
				SPX
			</xsl:when>
			<xsl:when test="$exchangeCode='XBRA'">
				BRATISLAVA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='EBRA'">
				BRATISLAVA STOCK EXCHANGE-MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XLJU'">
				LJUBLJANA STOCK EXCHANGE (OFFICIAL MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='XLJM'">
				SI ENTER
			</xsl:when>
			<xsl:when test="$exchangeCode='XSOP'">
				BSP REGIONAL ENERGY EXCHANGE - SOUTH POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='XJSE'">
				JOHANNESBURG STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ALTX'">
				JSE ALTERNATE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBES'">
				JSE CASH BOND MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSAF'">
				JSE EQUITY DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSFA'">
				JSE COMMODITY DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='YLDX'">
				JSE INTEREST RATE DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='BMEX'">
				BME - BOLSAS Y MERCADOS ESPANOLES
			</xsl:when>
			<xsl:when test="$exchangeCode='MABX'">
				MERCADO ALTERNATIVO BURSATIL
			</xsl:when>
			<xsl:when test="$exchangeCode='SEND'">
				SEND - SISTEMA ELECTRONICO DE NEGOCIACION DE DEUDA
			</xsl:when>
			<xsl:when test="$exchangeCode='XBAR'">
				BOLSA DE BARCELONA
			</xsl:when>
			<xsl:when test="$exchangeCode='XBIL'">
				BOLSA DE VALORES DE BILBAO
			</xsl:when>
			<xsl:when test="$exchangeCode='XDRF'">
				AIAF - MERCADO DE RENTA FIJA
			</xsl:when>
			<xsl:when test="$exchangeCode='XLAT'">
				LATIBEX
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAD'">
				BOLSA DE MADRID
			</xsl:when>
			<xsl:when test="$exchangeCode='XMCE'">
				MERCADO CONTINUO ESPANOL - CONTINUOUS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XMRV'">
				MEFF FINANCIAL DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='XVAL'">
				BOLSA DE VALENCIA
			</xsl:when>
			<xsl:when test="$exchangeCode='MERF'">
				MERCADO ELECTRONICO DE RENTA FIJA
			</xsl:when>
			<xsl:when test="$exchangeCode='MARF'">
				MERCADO ALTERNATIVO DE RENTA FIJA
			</xsl:when>
			<xsl:when test="$exchangeCode='BMCL'">
				BME CLEARING S.A.
			</xsl:when>
			<xsl:when test="$exchangeCode='XMPW'">
				MEFF POWER DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='SBAR'">
				BOLSA DE BARCELONA RENTA FIJA
			</xsl:when>
			<xsl:when test="$exchangeCode='SBIL'">
				BOLSA DE BILBAO RENTA FIJA
			</xsl:when>
			<xsl:when test="$exchangeCode='IBGH'">
				IBERIAN GAS HUB
			</xsl:when>
			<xsl:when test="$exchangeCode='MIBG'">
				MERCADO ORGANIZADO DEL GAS
			</xsl:when>
			<xsl:when test="$exchangeCode='OMEL'">
				OMI POLO ESPANOL S.A. (OMIE)
			</xsl:when>
			<xsl:when test="$exchangeCode='PAVE'">
				ALTERNATIVE PLATFORM FOR SPANISH SECURITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='XDPA'">
				CADE - MERCADO DE DEUDA PUBLICA ANOTADA
			</xsl:when>
			<xsl:when test="$exchangeCode='XNAF'">
				SISTEMA ESPANOL DE NEGOCIACION DE ACTIVOS FINANCIEROS
			</xsl:when>
			<xsl:when test="$exchangeCode='XCOL'">
				COLOMBO STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKHA'">
				KHARTOUM STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSWA'">
				SWAZILAND STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='CRYD'">
				CRYEX - FX AND DIGITAL CURRENCIES
			</xsl:when>
			<xsl:when test="$exchangeCode='CRYX'">
				CRYEX
			</xsl:when>
			<xsl:when test="$exchangeCode='SEBX'">
				SEB - LIQUIDITY POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='ENSX'">
				SEB ENSKILDA
			</xsl:when>
			<xsl:when test="$exchangeCode='XNGM'">
				NORDIC GROWTH MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='NMTF'">
				NORDIC MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='XNDX'">
				NORDIC DERIVATIVES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNMR'">
				NORDIC MTF REPORTING
			</xsl:when>
			<xsl:when test="$exchangeCode='XSAT'">
				AKTIETORGET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTO'">
				NASDAQ STOCKHOLM AB
			</xsl:when>
			<xsl:when test="$exchangeCode='FNSE'">
				FIRST NORTH SWEDEN
			</xsl:when>
			<xsl:when test="$exchangeCode='XOPV'">
				OTC PUBLICATION VENUE
			</xsl:when>
			<xsl:when test="$exchangeCode='CSTO'">
				NASDAQ CLEARING AB
			</xsl:when>
			<xsl:when test="$exchangeCode='DSTO'">
				NASDAQ STOCKHOLM AB - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='DNSE'">
				FIRST NORTH SWEDEN - NORDIC@MID
			</xsl:when>
			<xsl:when test="$exchangeCode='MSTO'">
				NASDAQ STOCKHOLM AB – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='MNSE'">
				FIRST NORTH SWEDEN – AUCTION ON DEMAND
			</xsl:when>
			<xsl:when test="$exchangeCode='DKED'">
				NASDAQ STOCKHOLM AB - DANISH EQ DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='FIED'">
				NASDAQ STOCKHOLM AB - FINNISH EQ DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='NOED'">
				NASDAQ STOCKHOLM AB - NORWEGIAN EQ DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='SEED'">
				NASDAQ STOCKHOLM AB - SWEDISH EQ DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='PNED'">
				NASDAQ STOCKHOLM AB - PAN-NORDIC EQ DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='EUWB'">
				NASDAQ STOCKHOLM AB - EUR WB EQ DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='USWB'">
				NASDAQ STOCKHOLM AB - USD WB EQ DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='DKFI'">
				NASDAQ STOCKHOLM AB - DANISH FI DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='EBON'">
				NASDAQ STOCKHOLM AB - EUR FI DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='NOFI'">
				NASDAQ STOCKHOLM AB - NORWEGIAN FI DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='AIXE'">
				AIXECUTE
			</xsl:when>
			<xsl:when test="$exchangeCode='DOTS'">
				SWISS DOTS BY CATS
			</xsl:when>
			<xsl:when test="$exchangeCode='EUCH'">
				EUREX ZURICH
			</xsl:when>
			<xsl:when test="$exchangeCode='EUSP'">
				EUREX OTC SPOT MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='EURM'">
				EUREX REPO MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='EUSC'">
				EUREX CH SECLEND MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='S3FM'">
				SOCIETY3 FUNDERSMART
			</xsl:when>
			<xsl:when test="$exchangeCode='STOX'">
				STOXX LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='XSCU'">
				STOXX LIMITED - CUSTOMIZED INDICES
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTV'">
				STOXX LIMITED - VOLATILITY INDICES
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTX'">
				STOXX LIMITED - INDICES
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSG'">
				UBS TRADING
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSF'">
				UBS FX
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSC'">
				UBS PIN-FX
			</xsl:when>
			<xsl:when test="$exchangeCode='VLEX'">
				VONTOBEL LIQUIDITY EXTENDER
			</xsl:when>
			<xsl:when test="$exchangeCode='XBRN'">
				BX SWISS AG
			</xsl:when>
			<xsl:when test="$exchangeCode='XSWX'">
				SIX SWISS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XQMH'">
				SIX SWISS EXCHANGE – STRUCTURED PRODUCTS
			</xsl:when>
			<xsl:when test="$exchangeCode='XVTX'">
				SIX SWISS EXCHANGE - BLUE CHIPS SEGMENT
			</xsl:when>
			<xsl:when test="$exchangeCode='XBTR'">
				SIX SWISS BILATERAL TRADING PLATFORM FOR STRUCTURED OTC PRODUCTS
			</xsl:when>
			<xsl:when test="$exchangeCode='XICB'">
				SIX CORPORATE BONDS AG
			</xsl:when>
			<xsl:when test="$exchangeCode='XSWM'">
				SIX SWISS EXCHANGE - SIX SWISS EXCHANGE AT MIDPOINT
			</xsl:when>
			<xsl:when test="$exchangeCode='XSLS'">
				SIX SWISS EXCHANGE - SLS
			</xsl:when>
			<xsl:when test="$exchangeCode='ZKBX'">
				ZURCHER KANTONALBANK SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='KMUX'">
				ZURCHER KANTONALBANK - EKMU-X
			</xsl:when>
			<xsl:when test="$exchangeCode='XDSE'">
				DAMASCUS SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ROCO'">
				TAIPEI EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTAF'">
				TAIWAN FUTURES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTAI'">
				TAIWAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XDAR'">
				DAR ES SALAAM STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='AFET'">
				AGRICULTURAL FUTURES EXCHANGE OF THAILAND
			</xsl:when>
			<xsl:when test="$exchangeCode='BEEX'">
				BOND ELECTRONIC EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='TFEX'">
				THAILAND FUTURES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBKK'">
				STOCK EXCHANGE OF THAILAND
			</xsl:when>
			<xsl:when test="$exchangeCode='XBKF'">
				STOCK EXCHANGE OF THAILAND - FOREIGN BOARD
			</xsl:when>
			<xsl:when test="$exchangeCode='XMAI'">
				MARKET FOR ALTERNATIVE INVESTMENT
			</xsl:when>
			<xsl:when test="$exchangeCode='CLMX'">
				CLIMEX
			</xsl:when>
			<xsl:when test="$exchangeCode='HCHC'">
				ICE CLEAR NETHERLANDS B.V.
			</xsl:when>
			<xsl:when test="$exchangeCode='NDEX'">
				ICE ENDEX DERIVATIVES B.V.
			</xsl:when>
			<xsl:when test="$exchangeCode='IMEQ'">
				ICE MARKETS EQUITY
			</xsl:when>
			<xsl:when test="$exchangeCode='NDXS'">
				ICE ENDEX GAS B.V.
			</xsl:when>
			<xsl:when test="$exchangeCode='NLPX'">
				APX POWER NL
			</xsl:when>
			<xsl:when test="$exchangeCode='TOMX'">
				TOM MTF CASH MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='TOMD'">
				TOM MTF DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XAMS'">
				EURONEXT - EURONEXT AMSTERDAM
			</xsl:when>
			<xsl:when test="$exchangeCode='ALXA'">
				EURONEXT - ALTERNEXT AMSTERDAM
			</xsl:when>
			<xsl:when test="$exchangeCode='TNLA'">
				EURONEXT - TRADED BUT NOT LISTED AMSTERDAM
			</xsl:when>
			<xsl:when test="$exchangeCode='XEUC'">
				EURONEXT COM, COMMODITIES FUTURES AND OPTIONS
			</xsl:when>
			<xsl:when test="$exchangeCode='XEUE'">
				EURONEXT EQF, EQUITIES AND INDICES DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='XEUI'">
				EURONEXT IRF, INTEREST RATE FUTURE AND OPTIONS
			</xsl:when>
			<xsl:when test="$exchangeCode='XEMS'">
				EMS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNXC'">
				NXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTRN'">
				TRINIDAD AND TOBAGO STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XTUN'">
				BOURSE DE TUNIS
			</xsl:when>
			<xsl:when test="$exchangeCode='EXTR'">
				ENERGY EXCHANGE ISTANBUL
			</xsl:when>
			<xsl:when test="$exchangeCode='XEID'">
				ELECTRICITY INTRA-DAY MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XEDA'">
				ELECTRICITY DAY-AHEAD MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XIST'">
				BORSA ISTANBUL
			</xsl:when>
			<xsl:when test="$exchangeCode='XFNO'">
				BORSA ISTANBUL - FUTURES AND OPTIONS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XEQY'">
				BORSA ISTANBUL - EQUITY MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XDSM'">
				BORSA ISTANBUL - DEBT SECURITIES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XPMS'">
				BORSA ISTANBUL - PRECIOUS METALS AND DIAMONDS MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='ULTX'">
				ALT XCHANGE (U)
			</xsl:when>
			<xsl:when test="$exchangeCode='XUGA'">
				UGANDA SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='EESE'">
				EAST EUROPEAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='PFTS'">
				PFTS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='PFTQ'">
				PFTS QUOTE DRIVEN
			</xsl:when>
			<xsl:when test="$exchangeCode='SEPE'">
				STOCK EXCHANGE PERSPECTIVA
			</xsl:when>
			<xsl:when test="$exchangeCode='UKEX'">
				UKRAINIAN EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XDFB'">
				JOINT-STOCK COMPANY “STOCK EXCHANGE INNEX”
			</xsl:when>
			<xsl:when test="$exchangeCode='XKHR'">
				KHARKOV COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKIE'">
				KIEV UNIVERSAL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKIS'">
				KIEV INTERNATIONAL STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XODE'">
				ODESSA COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPRI'">
				PRIDNEPROVSK COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XUAX'">
				UKRAINIAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XUKR'">
				UKRAINIAN UNIVERSAL COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='DGCX'">
				DUBAI GOLD &amp; COMMODITIES EXCHANGE DMCC
			</xsl:when>
			<xsl:when test="$exchangeCode='DIFX'">
				NASDAQ DUBAI
			</xsl:when>
			<xsl:when test="$exchangeCode='DUMX'">
				DUBAI MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XADS'">
				ABU DHABI SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XDFM'">
				DUBAI FINANCIAL MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='AFDL'">
				ABIDE FINANCIAL DRSP LIMITED APA
			</xsl:when>
			<xsl:when test="$exchangeCode='AQXE'">
				AQUIS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='ARAX'">
				ARAX COMMODITIES LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='ATLB'">
				ATLANTIC BROKERS LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='AUTX'">
				AUTILLA
			</xsl:when>
			<xsl:when test="$exchangeCode='AUTP'">
				AUTILLA - PRECIOUS METALS
			</xsl:when>
			<xsl:when test="$exchangeCode='AUTB'">
				AUTILLA - BASE METALS
			</xsl:when>
			<xsl:when test="$exchangeCode='BALT'">
				THE BALTIC EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='BLTX'">
				BALTEX - FREIGHT DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='BCXE'">
				BATS EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='BATE'">
				BATS EUROPE -BXE ORDER BOOKS
			</xsl:when>
			<xsl:when test="$exchangeCode='CHIX'">
				BATS EUROPE - CXE ORDER BOOKS
			</xsl:when>
			<xsl:when test="$exchangeCode='BATD'">
				BATS EUROPE -BXE DARK ORDER BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='CHID'">
				BATS EUROPE - CXE DARK ORDER BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='BATF'">
				BATS EUROPE – BATS OFF-BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='CHIO'">
				BATS EUROPE - CXE - OFF-BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='BOTC'">
				OFF EXCHANGE IDENTIFIER FOR OTC TRADES REPORTED TO BATS EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='BATP'">
				BATS EUROPE - BXE PERIODIC
			</xsl:when>
			<xsl:when test="$exchangeCode='BARO'">
				BATS EUROPE - REGULATED MARKET OFF BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='BARK'">
				BATS EUROPE - REGULATED MARKET DARK BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='BART'">
				BATS EUROPE - REGULATED MARKET INTEGRATED BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='LISX'">
				BATS EUROPE - LIS SERVICE
			</xsl:when>
			<xsl:when test="$exchangeCode='BGCI'">
				BGC BROKERS LP
			</xsl:when>
			<xsl:when test="$exchangeCode='BGCB'">
				BGC BROKERS LP - TRAYPORT
			</xsl:when>
			<xsl:when test="$exchangeCode='BLOX'">
				BLOCKMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='BMTF'">
				BLOOMBERG TRADING FACILITY LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='BOAT'">
				CINNOBER BOAT
			</xsl:when>
			<xsl:when test="$exchangeCode='BOSC'">
				BONDSCAPE
			</xsl:when>
			<xsl:when test="$exchangeCode='BRNX'">
				BERNSTEIN CROSS (BERN-X)
			</xsl:when>
			<xsl:when test="$exchangeCode='BTEE'">
				BROKERTEC EU MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='EBSX'">
				EBS MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='CCO2'">
				CANTORCO2E.COM LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='CGME'">
				CITI MATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='CHEV'">
				CA CHEUVREUX
			</xsl:when>
			<xsl:when test="$exchangeCode='BLNK'">
				BLINK MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='CMEE'">
				CME EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='CMEC'">
				CME CLEARING EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='CMED'">
				CME EUROPE - DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='CMMT'">
				CLEAR MARKETS EUROPE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='CRYP'">
				CRYPTO FACILITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='CSEU'">
				CREDIT SUISSE (EUROPE)
			</xsl:when>
			<xsl:when test="$exchangeCode='CSCF'">
				CREDIT SUISSE AES CROSSFINDER EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='CSBX'">
				CREDIT SUISSE AES EUROPE BENCHMARK CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='DBIX'">
				DEUTSCHE BANK INTERNALISATION
			</xsl:when>
			<xsl:when test="$exchangeCode='DBDC'">
				DEUTSCHE BANK - DIRECT CAPITAL ACCESS
			</xsl:when>
			<xsl:when test="$exchangeCode='DBCX'">
				DEUTSCHE BANK - CLOSE CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='DBCR'">
				DEUTSCHE BANK - CENTRAL RISK BOOK
			</xsl:when>
			<xsl:when test="$exchangeCode='DBMO'">
				DEUTSCHE BANK - MANUAL OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='DBSE'">
				DEUTSCHE BANK - SUPERX EU
			</xsl:when>
			<xsl:when test="$exchangeCode='EMBX'">
				EMERGING MARKETS BOND EXCHANGE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='ENCL'">
				ENCLEAR
			</xsl:when>
			<xsl:when test="$exchangeCode='EQLD'">
				EQUILEND EUROPE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='EXEU'">
				EXANE BNP PARIBAS
			</xsl:when>
			<xsl:when test="$exchangeCode='EXMP'">
				EXANE BNP PARIBAS - MID POINT
			</xsl:when>
			<xsl:when test="$exchangeCode='EXOR'">
				EXANE BNP PARIBAS - CHILD ORDER CROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='EXVP'">
				EXANE BNP PARIBAS - VOLUME PROFILE CROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='EXBO'">
				EXANE BNP PARIBAS - BID-OFFER CROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='EXSI'">
				EXANE BNP PARIBAS - SYSTEMATIC INTERNALISER
			</xsl:when>
			<xsl:when test="$exchangeCode='EXCP'">
				EXANE BNP PARIBAS - CLOSING PRICE
			</xsl:when>
			<xsl:when test="$exchangeCode='EXLP'">
				EXANE BNP PARIBAS - LIQUIDITY PROVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='EXDC'">
				EXANE BNP PARIBAS - DIRECT CAPITAL ACCESS
			</xsl:when>
			<xsl:when test="$exchangeCode='FAIR'">
				CANTOR SPREADFAIR
			</xsl:when>
			<xsl:when test="$exchangeCode='GEMX'">
				GEMMA (GILT EDGED MARKET MAKERS’ASSOCIATION)
			</xsl:when>
			<xsl:when test="$exchangeCode='GFIC'">
				GFI CREDITMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='GFIF'">
				GFI FOREXMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='GFIN'">
				GFI ENERGYMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='GFIR'">
				GFI RATESMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='GMEG'">
				GMEX EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLDX'">
				LONDON DERIVATIVES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XGDX'">
				GLOBAL DERIVATIVES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XGSX'">
				GLOBAL SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XGCX'">
				GLOBAL COMMODITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='GRIF'">
				GRIFFIN MARKETS LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='GRIO'">
				GRIFFIN MARKETS LIMITED - OTF
			</xsl:when>
			<xsl:when test="$exchangeCode='GRSE'">
				THE GREEN STOCK EXCHANGE - ACB IMPACT MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='GSIL'">
				GOLDMAN SACHS INTERNATIONAL
			</xsl:when>
			<xsl:when test="$exchangeCode='GSSI'">
				GOLDMAN SACHS INTERNATIONAL - SYSTEMATIC INTERNALISER
			</xsl:when>
			<xsl:when test="$exchangeCode='GSBX'">
				GOLDMAN SACHS INTERNATIONAL - SIGMA BCN
			</xsl:when>
			<xsl:when test="$exchangeCode='HPCS'">
				HPC SA
			</xsl:when>
			<xsl:when test="$exchangeCode='HSXE'">
				HSBC-X UNITED KINGDOM
			</xsl:when>
			<xsl:when test="$exchangeCode='IBAL'">
				ICE BENCHMARK ADMINISTRATION
			</xsl:when>
			<xsl:when test="$exchangeCode='ICAP'">
				ICAP EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='ICAH'">
				TRAYPORT
			</xsl:when>
			<xsl:when test="$exchangeCode='ICEN'">
				ICAP ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='ICSE'">
				ICAP SECURITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='ICTQ'">
				ICAP TRUEQUOTE
			</xsl:when>
			<xsl:when test="$exchangeCode='WCLK'">
				ICAP WCLK
			</xsl:when>
			<xsl:when test="$exchangeCode='ISDX'">
				ICAP SECURITIES &amp; DERIVATIVES EXCHANGE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='IGDL'">
				ICAP GLOBAL DERIVATIVES LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='IFEU'">
				ICE FUTURES EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='CXRT'">
				CREDITEX BROKERAGE LLP - MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='IMCO'">
				ICE MARKETS COMMODITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='IFLO'">
				ICE FUTURES EUROPE - EQUITY PRODUCTS DIVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='IFLL'">
				ICE FUTURES EUROPE - FINANCIAL PRODUCTS DIVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='IFUT'">
				ICE FUTURES EUROPE - EUROPEAN UTILITIES DIVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='IFLX'">
				ICE FUTURES EUROPE - AGRICULTURAL PRODUCTS DIVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='IFEN'">
				ICE FUTURES EUROPE - OIL AND REFINED PRODUCTS DIVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='CXOT'">
				CREDITEX BROKERAGE LLP - OTF
			</xsl:when>
			<xsl:when test="$exchangeCode='ISWA'">
				I-SWAP
			</xsl:when>
			<xsl:when test="$exchangeCode='JPSI'">
				J.P. MORGAN SECURITIES PLC
			</xsl:when>
			<xsl:when test="$exchangeCode='KLEU'">
				KNIGHT LINK EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='LCUR'">
				CURRENEX LDFX
			</xsl:when>
			<xsl:when test="$exchangeCode='LIQU'">
				LIQUIDNET SYSTEMS
			</xsl:when>
			<xsl:when test="$exchangeCode='LIQH'">
				LIQUIDNET H20
			</xsl:when>
			<xsl:when test="$exchangeCode='LIQF'">
				LIQUIDNET EUROPE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='LMAX'">
				LMAX
			</xsl:when>
			<xsl:when test="$exchangeCode='LMAD'">
				LMAX - DERIVATIVES
			</xsl:when>
			<xsl:when test="$exchangeCode='LMAE'">
				LMAX - EQUITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='LMAF'">
				LMAX - FX
			</xsl:when>
			<xsl:when test="$exchangeCode='LMAO'">
				LMAX - INDICES/RATES/COMMODITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='LMEC'">
				LME CLEAR
			</xsl:when>
			<xsl:when test="$exchangeCode='LOTC'">
				OTC MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='PLDX'">
				PLUS DERIVATIVES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='LPPM'">
				LONDON PLATINUM AND PALLADIUM MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='MAEL'">
				MARKETAXESS EUROPE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='MFGL'">
				MF GLOBAL ENERGY MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='MLXN'">
				BANK OF AMERICA - MERRILL LYNCH INSTINCT X - EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='MLAX'">
				BANK OF AMERICA - MERRILL LYNCH AUCTION CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='MLEU'">
				BANK OF AMERICA - MERRILL LYNCH OTC - EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='MLVE'">
				BANK OF AMERICA - MERRILL LYNCH VWAP CROSS - EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='MSIP'">
				MORGAN STANLEY AND CO. INTERNATIONAL PLC
			</xsl:when>
			<xsl:when test="$exchangeCode='MYTR'">
				MYTREASURY
			</xsl:when>
			<xsl:when test="$exchangeCode='N2EX'">
				N2EX
			</xsl:when>
			<xsl:when test="$exchangeCode='NDCM'">
				ICE ENDEX GAS SPOT LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='NEXS'">
				NEX SEF
			</xsl:when>
			<xsl:when test="$exchangeCode='NOFF'">
				NOMURA OTC TRADES
			</xsl:when>
			<xsl:when test="$exchangeCode='NOSI'">
				NOMURA SYSTEMATIC INTERNALISER
			</xsl:when>
			<xsl:when test="$exchangeCode='NURO'">
				NASDAQ OMX EUROPE
			</xsl:when>
			<xsl:when test="$exchangeCode='XNLX'">
				NASDAQ OMX NLX
			</xsl:when>
			<xsl:when test="$exchangeCode='NURD'">
				NASDAQ EUROPE (NURO) DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='NXEU'">
				NX
			</xsl:when>
			<xsl:when test="$exchangeCode='OTCE'">
				OTCEX
			</xsl:when>
			<xsl:when test="$exchangeCode='PEEL'">
				PEEL HUNT LLP UK
			</xsl:when>
			<xsl:when test="$exchangeCode='XRSP'">
				PEEL HUNT RETAIL
			</xsl:when>
			<xsl:when test="$exchangeCode='XPHX'">
				PEEL HUNT CROSSING
			</xsl:when>
			<xsl:when test="$exchangeCode='PIEU'">
				ARITAS FINANCIAL LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='PIRM'">
				PIRUM
			</xsl:when>
			<xsl:when test="$exchangeCode='QWIX'">
				Q-WIXX PLATFORM
			</xsl:when>
			<xsl:when test="$exchangeCode='RBCE'">
				RBC EUROPE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='RBSX'">
				RBS CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='RTSL'">
				REUTERS TRANSACTION SERVICES LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='TRFW'">
				REUTERS TRANSACTION SERVICES LIMITED - FORWARDS MATCHING
			</xsl:when>
			<xsl:when test="$exchangeCode='TRAL'">
				REUTERS TRANSACTION SERVICES LIMITED - FXALL RFQ
			</xsl:when>
			<xsl:when test="$exchangeCode='SECF'">
				SECFINEX
			</xsl:when>
			<xsl:when test="$exchangeCode='SGMX'">
				SIGMA X MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='SHAR'">
				ASSET MATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='SPEC'">
				SPECTRONLIVE
			</xsl:when>
			<xsl:when test="$exchangeCode='SPRZ'">
				SPREADZERO
			</xsl:when>
			<xsl:when test="$exchangeCode='SSEX'">
				SOCIAL STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='SWAP'">
				SWAPSTREAM
			</xsl:when>
			<xsl:when test="$exchangeCode='TFSV'">
				VOLBROKER
			</xsl:when>
			<xsl:when test="$exchangeCode='FXOP'">
				TRADITION-NEX OTF
			</xsl:when>
			<xsl:when test="$exchangeCode='TPIE'">
				THE PROPERTY INVESTMENT EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='TRDE'">
				TRADITION ELECTRONIC TRADING PLATFORM
			</xsl:when>
			<xsl:when test="$exchangeCode='NAVE'">
				NAVESIS-MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='TCDS'">
				TRADITION CDS
			</xsl:when>
			<xsl:when test="$exchangeCode='TRDX'">
				TRAD-X
			</xsl:when>
			<xsl:when test="$exchangeCode='VOLA'">
				TRADITION - VOLATIS
			</xsl:when>
			<xsl:when test="$exchangeCode='TFSG'">
				TRADITION ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='PARX'">
				PARFX
			</xsl:when>
			<xsl:when test="$exchangeCode='ELIX'">
				ELIXIUM
			</xsl:when>
			<xsl:when test="$exchangeCode='EMCH'">
				FINACOR EMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='TREU'">
				TRADEWEB EUROPE LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='TREA'">
				TRADEWEB EUROPE LIMITED - APA
			</xsl:when>
			<xsl:when test="$exchangeCode='TREO'">
				TRADEWEB EUROPE LIMITED - OTF
			</xsl:when>
			<xsl:when test="$exchangeCode='TRQX'">
				TURQUOISE
			</xsl:when>
			<xsl:when test="$exchangeCode='TRQM'">
				TURQUOISE DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSL'">
				UBS EMEA EQUITIES TRADING
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSE'">
				UBS PIN (EMEA)
			</xsl:when>
			<xsl:when test="$exchangeCode='UKPX'">
				APX POWER UK
			</xsl:when>
			<xsl:when test="$exchangeCode='VEGA'">
				VEGA-CHI
			</xsl:when>
			<xsl:when test="$exchangeCode='WINS'">
				WINTERFLOOD SECURITIES LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='XALT'">
				ALTEX-ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='XCOR'">
				ICMA
			</xsl:when>
			<xsl:when test="$exchangeCode='XGCL'">
				GLOBAL COAL LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='XLBM'">
				LONDON BULLION MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XLCH'">
				LCH.CLEARNET LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='XLDN'">
				EURONEXT - EURONEXT LONDON
			</xsl:when>
			<xsl:when test="$exchangeCode='XLME'">
				LONDON METAL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLON'">
				LONDON STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLOD'">
				LONDON STOCK EXCHANGE - DERIVATIVES MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XMTS'">
				EUROMTS LTD
			</xsl:when>
			<xsl:when test="$exchangeCode='HUNG'">
				MTS HUNGARY
			</xsl:when>
			<xsl:when test="$exchangeCode='UKGD'">
				UK GILTS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='AMTS'">
				MTS NETHERLANDS
			</xsl:when>
			<xsl:when test="$exchangeCode='EMTS'">
				EUROMTS
			</xsl:when>
			<xsl:when test="$exchangeCode='GMTS'">
				MTS GERMANY
			</xsl:when>
			<xsl:when test="$exchangeCode='IMTS'">
				MTS IRELAND
			</xsl:when>
			<xsl:when test="$exchangeCode='MCZK'">
				MTS CZECH REPUBLIC
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSA'">
				MTS AUSTRIA
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSG'">
				MTS GREECE
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSS'">
				MTS INTERDEALER SWAPS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='RMTS'">
				MTS ISRAEL
			</xsl:when>
			<xsl:when test="$exchangeCode='SMTS'">
				MTS SPAIN
			</xsl:when>
			<xsl:when test="$exchangeCode='VMTS'">
				MTS SLOVENIA
			</xsl:when>
			<xsl:when test="$exchangeCode='BVUK'">
				BONDVISION UK
			</xsl:when>
			<xsl:when test="$exchangeCode='PORT'">
				MTS PORTUGAL
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSW'">
				MTS SWAP MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XSGA'">
				ALPHA Y
			</xsl:when>
			<xsl:when test="$exchangeCode='XSMP'">
				SMARTPOOL
			</xsl:when>
			<xsl:when test="$exchangeCode='XSWB'">
				SWX SWISS BLOCK
			</xsl:when>
			<xsl:when test="$exchangeCode='XTUP'">
				TULLETT PREBON PLC
			</xsl:when>
			<xsl:when test="$exchangeCode='TPEQ'">
				TULLETT PREBON PLC - TP EQUITYTRADE
			</xsl:when>
			<xsl:when test="$exchangeCode='TBEN'">
				TULLETT PREBON PLC - TP ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='TBLA'">
				TULLETT PREBON PLC - TP TRADEBLADE
			</xsl:when>
			<xsl:when test="$exchangeCode='TPCD'">
				TULLETT PREBON PLC - TP CREDITDEAL
			</xsl:when>
			<xsl:when test="$exchangeCode='TPFD'">
				TULLETT PREBON PLC - TP FORWARDDEAL
			</xsl:when>
			<xsl:when test="$exchangeCode='TPRE'">
				TULLETT PREBON PLC - TP REPO
			</xsl:when>
			<xsl:when test="$exchangeCode='TPSD'">
				TULLETT PREBON PLC - TP SWAPDEAL
			</xsl:when>
			<xsl:when test="$exchangeCode='XTPE'">
				TULLETT PREBON PLC - TP ENERGYTRADE
			</xsl:when>
			<xsl:when test="$exchangeCode='TPEL'">
				TULLETT PREBON PLC – TULLETT PREBON (EUROPE) LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='TPSL'">
				TULLETT PREBON PLC – TULLETT PREBON (SECURITIES) LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='XUBS'">
				UBS MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='AATS'">
				ASSENT ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='AQUA'">
				AQUA EQUITIES L.P.
			</xsl:when>
			<xsl:when test="$exchangeCode='ATDF'">
				AUTOMATED TRADING DESK FINANCIAL SERVICES, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='CORE'">
				ATD - CITIGROUP AGENCY OPTION AND EQUITIES ROUTING ENGINE
			</xsl:when>
			<xsl:when test="$exchangeCode='BAML'">
				BANK OF AMERICA - MERRILL LYNCH INSTINCT X ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='MLVX'">
				BANK OF AMERICA - MERRILL LYNCH VWAP CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='MLCO'">
				BANK OF AMERICA - MERRILL LYNCH OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='BARX'">
				BARCLAYS ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='BARD'">
				BARCLAYS FX – TRADING
			</xsl:when>
			<xsl:when test="$exchangeCode='BARL'">
				BARCLAYS LIQUID MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='BCDX'">
				BARCLAYS DIRECT EX ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='BATO'">
				BZX OPTIONS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='BATY'">
				BATS Y-EXCHANGE, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='BZXD'">
				BATS Z-EXCHANGE DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='BYXD'">
				BATS Y-EXCHANGE DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='BBSF'">
				BLOOMBERG SEF LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='BGCF'">
				BGC FINANCIAL INC
			</xsl:when>
			<xsl:when test="$exchangeCode='BGCD'">
				BGC DERIVATIVE MARKETS L.P.
			</xsl:when>
			<xsl:when test="$exchangeCode='BHSF'">
				BATS HOTSPOT SEF LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='BIDS'">
				BIDS TRADING L.P.
			</xsl:when>
			<xsl:when test="$exchangeCode='BLTD'">
				BLOOMBERG TRADEBOOK LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='BPOL'">
				BLOOMBERG BPOOL
			</xsl:when>
			<xsl:when test="$exchangeCode='BNYC'">
				CONVERGEX
			</xsl:when>
			<xsl:when test="$exchangeCode='VTEX'">
				VORTEX
			</xsl:when>
			<xsl:when test="$exchangeCode='NYFX'">
				MILLENNIUM
			</xsl:when>
			<xsl:when test="$exchangeCode='BTEC'">
				ICAP ELECTRONIC BROKING (US)
			</xsl:when>
			<xsl:when test="$exchangeCode='ICSU'">
				ICAP SEF (US) LLC.
			</xsl:when>
			<xsl:when test="$exchangeCode='CDED'">
				CITADEL SECURITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='CGMI'">
				CITIGROUP GLOBAL MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='CICX'">
				CITI CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='LQFI'">
				CITI LIQUIFI
			</xsl:when>
			<xsl:when test="$exchangeCode='CBLC'">
				CITIBLOC
			</xsl:when>
			<xsl:when test="$exchangeCode='CMSF'">
				CLEAR MARKETS NORTH AMERICA, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='CRED'">
				CREDIT SUISSE (US)
			</xsl:when>
			<xsl:when test="$exchangeCode='CAES'">
				CREDIT SUISSE AES CROSSFINDER
			</xsl:when>
			<xsl:when test="$exchangeCode='CSLP'">
				CREDIT SUISSE LIGHT POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='DBSX'">
				DEUTSCHE BANK SUPER X
			</xsl:when>
			<xsl:when test="$exchangeCode='DEAL'">
				DCX (DERIVATIVES CURRENCY EXCHANGE)
			</xsl:when>
			<xsl:when test="$exchangeCode='EDGE'">
				BATS DIRECT EDGE
			</xsl:when>
			<xsl:when test="$exchangeCode='EDDP'">
				EDGX EXCHANGE DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='EDGA'">
				EDGA EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='EDGD'">
				EDGA EXCHANGE DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='EDGX'">
				EDGX EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='EDGO'">
				EDGX OPTIONS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='EGMT'">
				EG MARKET TECHNOLOGIES
			</xsl:when>
			<xsl:when test="$exchangeCode='ERIS'">
				ERIS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='FAST'">
				FASTMATCH
			</xsl:when>
			<xsl:when test="$exchangeCode='FINR'">
				FINRA
			</xsl:when>
			<xsl:when test="$exchangeCode='FINN'">
				FINRA/NASDAQ TRF(TRADE REPORTING FACILITY)
			</xsl:when>
			<xsl:when test="$exchangeCode='FINO'">
				FINRA ORF (TRADE REPORTING FACILITY)
			</xsl:when>
			<xsl:when test="$exchangeCode='FINY'">
				FINRA/NYSE TRF (TRADE REPORTING FACILITY)
			</xsl:when>
			<xsl:when test="$exchangeCode='XADF'">
				FINRA ALTERNATIVE DISPLAY FACILITY (ADF)
			</xsl:when>
			<xsl:when test="$exchangeCode='OOTC'">
				OTHER OTC
			</xsl:when>
			<xsl:when test="$exchangeCode='FSEF'">
				FTSEF LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='FXAL'">
				FXALL
			</xsl:when>
			<xsl:when test="$exchangeCode='FXCM'">
				FXCM
			</xsl:when>
			<xsl:when test="$exchangeCode='G1XX'">
				G1 EXECUTION SERVICES
			</xsl:when>
			<xsl:when test="$exchangeCode='GLLC'">
				GATE US LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='GLPS'">
				ESSEX RADEZ, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='GLPX'">
				ACS EXECUTION SERVICES, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='GOVX'">
				GOVEX
			</xsl:when>
			<xsl:when test="$exchangeCode='GREE'">
				THE GREEN EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='GSEF'">
				GFI SWAPS EXCHANGE, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='GTCO'">
				KCG AMERICAS LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='GTSX'">
				GTSX
			</xsl:when>
			<xsl:when test="$exchangeCode='GTXS'">
				GTX SEF, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='HEGX'">
				NADEX
			</xsl:when>
			<xsl:when test="$exchangeCode='HPPO'">
				POTAMUS TRADING LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='HSFX'">
				HOTSPOT FX
			</xsl:when>
			<xsl:when test="$exchangeCode='ICEL'">
				ISLAND ECN LTD, THE
			</xsl:when>
			<xsl:when test="$exchangeCode='IEXG'">
				INVESTORS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='IFUS'">
				ICE FUTURES U.S.
			</xsl:when>
			<xsl:when test="$exchangeCode='IEPA'">
				INTERCONTINENTAL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='IMFX'">
				ICE MARKETS FOREIGN EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='IMAG'">
				ICE MARKETS AGRICULTURE
			</xsl:when>
			<xsl:when test="$exchangeCode='IMBD'">
				ICE MARKETS BONDS
			</xsl:when>
			<xsl:when test="$exchangeCode='IMCR'">
				ICE MARKETS CREDIT
			</xsl:when>
			<xsl:when test="$exchangeCode='IMEN'">
				ICE MARKETS ENERGY
			</xsl:when>
			<xsl:when test="$exchangeCode='IMIR'">
				ICE MARKETS RATES
			</xsl:when>
			<xsl:when test="$exchangeCode='IFED'">
				ICE FUTURES U.S. ENERGY DIVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='IMCG'">
				CREDITEX LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='IMCC'">
				CREDITEX SECURITIES CORPORATION
			</xsl:when>
			<xsl:when test="$exchangeCode='ICES'">
				ICE SWAP TRADE LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='ISDA'">
				ISDAFIX
			</xsl:when>
			<xsl:when test="$exchangeCode='ITGI'">
				ITG - POSIT
			</xsl:when>
			<xsl:when test="$exchangeCode='JEFX'">
				JETX
			</xsl:when>
			<xsl:when test="$exchangeCode='JPBX'">
				JPBX
			</xsl:when>
			<xsl:when test="$exchangeCode='JPMX'">
				JPMX
			</xsl:when>
			<xsl:when test="$exchangeCode='JSES'">
				JANE STREET EXECUTION SERVICES LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='JSJX'">
				JANE STREET JX
			</xsl:when>
			<xsl:when test="$exchangeCode='KNIG'">
				KNIGHT
			</xsl:when>
			<xsl:when test="$exchangeCode='KNCM'">
				KNIGHT CAPITAL MARKETS LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='KNEM'">
				KNIGHT EQUITY MARKETS LP
			</xsl:when>
			<xsl:when test="$exchangeCode='KNLI'">
				KNIGHT LINK
			</xsl:when>
			<xsl:when test="$exchangeCode='KNMX'">
				KNIGHT MATCH ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='ACKF'">
				KCG ACKNOWLEDGE FI
			</xsl:when>
			<xsl:when test="$exchangeCode='LASF'">
				LATAM SEF
			</xsl:when>
			<xsl:when test="$exchangeCode='LEVL'">
				LEVEL ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='LIUS'">
				LIQUIDNET, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='LIUH'">
				LIQUIDNET, INC. H2O ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='LIFI'">
				LIQUIDNET, INC. FIXED INCOME ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='LQED'">
				LIQUIDITYEDGE
			</xsl:when>
			<xsl:when test="$exchangeCode='LTAA'">
				LUMINEX TRADING &amp; ANALYTICS LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='LMNX'">
				LUMINEX TRADING &amp; ANALYTICS LLC - ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='MIHI'">
				MIAMI INTERNATIONAL HOLDINGS, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='XMIO'">
				MIAMI INTERNATIONAL SECURITIES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='MPRL'">
				MIAX PEARL, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='MSCO'">
				MORGAN STANLEY AND CO. LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='MSPL'">
				MS POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='MSRP'">
				MS RETAIL POOL
			</xsl:when>
			<xsl:when test="$exchangeCode='MSTX'">
				MS TRAJECTORY CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='MSLP'">
				MORGAN STANLEY AUTOMATED LIQUIDITY PROVISION
			</xsl:when>
			<xsl:when test="$exchangeCode='MTUS'">
				MTS US
			</xsl:when>
			<xsl:when test="$exchangeCode='BVUS'">
				BONDVISION US
			</xsl:when>
			<xsl:when test="$exchangeCode='MTSB'">
				MTS BONDS.COM
			</xsl:when>
			<xsl:when test="$exchangeCode='MTXX'">
				MARKETAXESS CORPORATION
			</xsl:when>
			<xsl:when test="$exchangeCode='MTXM'">
				MARKETAXESS CORPORATION MID-X TRADING SYSTEM
			</xsl:when>
			<xsl:when test="$exchangeCode='MTXC'">
				MARKETAXESS CORPORATION SINGLE-NAME CDS CENTRAL LIMIT ORDER
			</xsl:when>
			<xsl:when test="$exchangeCode='MTXS'">
				MARKETAXESS SEF CORPORATION
			</xsl:when>
			<xsl:when test="$exchangeCode='MTXA'">
				MARKETAXESS CANADA COMPANY
			</xsl:when>
			<xsl:when test="$exchangeCode='NBLX'">
				NOBLE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='NFSC'">
				NATIONAL FINANCIAL SERVICES, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='NFSA'">
				FIDELITY CROSSSTREAM
			</xsl:when>
			<xsl:when test="$exchangeCode='NFSD'">
				FIDELITY DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTM'">
				FIDELITY CROSSSTREAM ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='NMRA'">
				NOMURA SECURITIES INTERNATIONAL
			</xsl:when>
			<xsl:when test="$exchangeCode='NODX'">
				NODAL EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='NXUS'">
				NX ATS - CROSSING PLATFORM
			</xsl:when>
			<xsl:when test="$exchangeCode='NYPC'">
				NEW YORK PORTFOLIO CLEARING
			</xsl:when>
			<xsl:when test="$exchangeCode='OLLC'">
				OTCEX LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='OPRA'">
				OPTIONS PRICE REPORTING AUTHORITY
			</xsl:when>
			<xsl:when test="$exchangeCode='OTCM'">
				OTC MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='OTCB'">
				OTCQB MARKETPLACE
			</xsl:when>
			<xsl:when test="$exchangeCode='OTCQ'">
				OTCQX MARKETPLACE
			</xsl:when>
			<xsl:when test="$exchangeCode='PINC'">
				OTC PINK CURRENT
			</xsl:when>
			<xsl:when test="$exchangeCode='PINI'">
				OTC PINK NO INFORMATION
			</xsl:when>
			<xsl:when test="$exchangeCode='PINL'">
				OTC PINK LIMITED
			</xsl:when>
			<xsl:when test="$exchangeCode='PINX'">
				OTC PINK MARKETPLACE
			</xsl:when>
			<xsl:when test="$exchangeCode='PSGM'">
				OTC GREY MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='CAVE'">
				CAVEAT EMPTOR
			</xsl:when>
			<xsl:when test="$exchangeCode='PDQX'">
				CODA MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='PDQD'">
				CODA MARKETS ATS DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='PIPE'">
				ARITAS SECURITIES LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='PRSE'">
				PRAGMA ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='PULX'">
				BLOCKCROSS ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='RICX'">
				RIVERCROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='RICD'">
				RIVERCROSS DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='SCXS'">
				SEED SEF LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='SGMA'">
				GOLDMAN SACH MTF
			</xsl:when>
			<xsl:when test="$exchangeCode='SGMT'">
				SIGMA X2
			</xsl:when>
			<xsl:when test="$exchangeCode='SHAW'">
				D.E. SHAW
			</xsl:when>
			<xsl:when test="$exchangeCode='SHAD'">
				D.E. SHAW DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='SOHO'">
				TWO SIGMA SECURITIES, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='SSTX'">
				E-EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='TERA'">
				TERAEXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='TFSU'">
				TFS GREEN UNITED STATES GREEN MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='THRE'">
				THOMSON REUTERS (SEF) LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='TMID'">
				TRUMID ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='TPSE'">
				TP SEF, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='TRCK'">
				TRACK ECN
			</xsl:when>
			<xsl:when test="$exchangeCode='TRUX'">
				TRUEEX LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='TRU1'">
				TRUEEX LLC - DESIGNATED CONTRACT MARKET (DMC)
			</xsl:when>
			<xsl:when test="$exchangeCode='TRU2'">
				TRUEEX LLC - SEF (SWAP EXECUTION FACILITY)
			</xsl:when>
			<xsl:when test="$exchangeCode='TRWB'">
				TRADEWEB LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='BNDD'">
				TRADEWEB DIRECT LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='TWSF'">
				TW SEF LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='DWSF'">
				DW SEF LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='TSAD'">
				TRADITION SECURITIES AND DERIVATIVES INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='TSBX'">
				TRIPLESHOT
			</xsl:when>
			<xsl:when test="$exchangeCode='TSEF'">
				TRADITION SEF
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSA'">
				UBS ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='UBSP'">
				UBS PIN (UBS PRICE IMPROVEMENT NETWORK)
			</xsl:when>
			<xsl:when test="$exchangeCode='VFCM'">
				VIRTU FINANCIAL CAPITAL MARKETS LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='VIRT'">
				VIRTU FINANCIAL BD
			</xsl:when>
			<xsl:when test="$exchangeCode='WEED'">
				WEEDEN AND CO MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='XWEE'">
				WEEDEN ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='WELX'">
				WELLS FARGO LIQUIDITY CROSS ATS
			</xsl:when>
			<xsl:when test="$exchangeCode='WSAG'">
				WALL STREET ACCESS
			</xsl:when>
			<xsl:when test="$exchangeCode='XAQS'">
				AUTOMATED EQUITY FINANCE MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='XBOX'">
				BOSTON OPTIONS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCBO'">
				CHICAGO BOARD OPTIONS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='C2OX'">
				C2 OPTIONS EXCHANGE INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='CBSX'">
				CBOE STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCBF'">
				CBOE FUTURES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCBT'">
				CHICAGO BOARD OF TRADE
			</xsl:when>
			<xsl:when test="$exchangeCode='FCBT'">
				CHICAGO BOARD OF TRADE (FLOOR)
			</xsl:when>
			<xsl:when test="$exchangeCode='XKBT'">
				KANSAS CITY BOARD OF TRADE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCFF'">
				CANTOR FINANCIAL FUTURES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCHI'">
				CHICAGO STOCK EXCHANGE, INC
			</xsl:when>
			<xsl:when test="$exchangeCode='XCIS'">
				NATIONAL STOCK EXCHANGE, INC.
			</xsl:when>
			<xsl:when test="$exchangeCode='XCME'">
				CHICAGO MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='FCME'">
				CHICAGO MERCANTILE EXCHANGE (FLOOR)
			</xsl:when>
			<xsl:when test="$exchangeCode='GLBX'">
				CME GLOBEX
			</xsl:when>
			<xsl:when test="$exchangeCode='XIMM'">
				INTERNATIONAL MONETARY MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XIOM'">
				INDEX AND OPTIONS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='CMES'">
				CME SWAPS MARKETS (CME)
			</xsl:when>
			<xsl:when test="$exchangeCode='CBTS'">
				CME SWAPS MARKETS (CBOT)
			</xsl:when>
			<xsl:when test="$exchangeCode='CECS'">
				CME SWAPS MARKETS (COMEX)
			</xsl:when>
			<xsl:when test="$exchangeCode='NYMS'">
				CME SWAPS MARKETS (NYMEX)
			</xsl:when>
			<xsl:when test="$exchangeCode='XCUR'">
				CURRENEX
			</xsl:when>
			<xsl:when test="$exchangeCode='XELX'">
				ELX
			</xsl:when>
			<xsl:when test="$exchangeCode='XFCI'">
				FINANCIALCONTENT INDEXES
			</xsl:when>
			<xsl:when test="$exchangeCode='XGMX'">
				GLOBALCLEAR MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XINS'">
				INSTINET
			</xsl:when>
			<xsl:when test="$exchangeCode='IBLX'">
				INSTINET BLX
			</xsl:when>
			<xsl:when test="$exchangeCode='ICBX'">
				INSTINET CBX (US)
			</xsl:when>
			<xsl:when test="$exchangeCode='ICRO'">
				INSTINET VWAP CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='IIDX'">
				INSTINET IDX
			</xsl:when>
			<xsl:when test="$exchangeCode='RCBX'">
				INSTINET RETAIL CBX
			</xsl:when>
			<xsl:when test="$exchangeCode='MOCX'">
				MOC CROSS
			</xsl:when>
			<xsl:when test="$exchangeCode='XISX'">
				INTERNATIONAL SECURITIES EXCHANGE, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='XISA'">
				INTERNATIONAL SECURITIES EXCHANGE, LLC - ALTERNATIVE MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='XISE'">
				INTERNATIONAL SECURITIES EXCHANGE, LLC - EQUITIES
			</xsl:when>
			<xsl:when test="$exchangeCode='GMNI'">
				ISE GEMINI EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='MCRY'">
				ISE MERCURY, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='XMER'">
				MERCHANTS' EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XMGE'">
				MINNEAPOLIS GRAIN EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XBXO'">
				NASDAQ OMX BX OPTIONS
			</xsl:when>
			<xsl:when test="$exchangeCode='BOSD'">
				NASDAQ OMX BX DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='NASD'">
				NSDQ DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='XBRT'">
				BRUT ECN
			</xsl:when>
			<xsl:when test="$exchangeCode='XNCM'">
				NASDAQ CAPITAL MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XNDQ'">
				NASDAQ OPTIONS MARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XNGS'">
				NASDAQ/NGS (GLOBAL SELECT MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='XNIM'">
				NASDAQ INTERMARKET
			</xsl:when>
			<xsl:when test="$exchangeCode='XNMS'">
				NASDAQ/NMS (GLOBAL MARKET)
			</xsl:when>
			<xsl:when test="$exchangeCode='XPBT'">
				NASDAQ OMX FUTURES EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPHL'">
				NASDAQ OMX PHLX
			</xsl:when>
			<xsl:when test="$exchangeCode='XPHO'">
				PHILADELPHIA OPTIONS EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XPOR'">
				PORTAL
			</xsl:when>
			<xsl:when test="$exchangeCode='XPSX'">
				NASDAQ OMX PSX
			</xsl:when>
			<xsl:when test="$exchangeCode='XBOS'">
				NASDAQ OMX BX
			</xsl:when>
			<xsl:when test="$exchangeCode='ESPD'">
				NASDAQ OMX ESPEED
			</xsl:when>
			<xsl:when test="$exchangeCode='XNYM'">
				NEW YORK MERCANTILE EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCEC'">
				COMMODITIES EXCHANGE CENTER
			</xsl:when>
			<xsl:when test="$exchangeCode='XNYE'">
				NEW YORK MERCANTILE EXCHANGE - OTC MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='XNYL'">
				NEW YORK MERCANTILE EXCHANGE - ENERGY MARKETS
			</xsl:when>
			<xsl:when test="$exchangeCode='ALDP'">
				NYSE ALTERNEXT DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='AMXO'">
				NYSE AMEX OPTIONS
			</xsl:when>
			<xsl:when test="$exchangeCode='ARCD'">
				ARCA DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='ARCO'">
				NYSE ARCA OPTIONS
			</xsl:when>
			<xsl:when test="$exchangeCode='ARCX'">
				NYSE ARCA
			</xsl:when>
			<xsl:when test="$exchangeCode='NYSD'">
				NYSE DARK
			</xsl:when>
			<xsl:when test="$exchangeCode='XASE'">
				NYSE MKT LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='XNLI'">
				NYSE LIFFE
			</xsl:when>
			<xsl:when test="$exchangeCode='XOCH'">
				ONECHICAGO, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='XOTC'">
				OTCBB
			</xsl:when>
			<xsl:when test="$exchangeCode='XSEF'">
				SWAPEX, LLC
			</xsl:when>
			<xsl:when test="$exchangeCode='BVUR'">
				BOLSA ELECTRONICA DE VALORES DEL URUGUAY
			</xsl:when>
			<xsl:when test="$exchangeCode='UFEX'">
				UFEX
			</xsl:when>
			<xsl:when test="$exchangeCode='XMNT'">
				BOLSA DE VALORES DE MONTEVIDEO
			</xsl:when>
			<xsl:when test="$exchangeCode='XCET'">
				UZBEK COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XCUE'">
				UZBEKISTAN REPUBLICAN CURRENCY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XKCE'">
				KHOREZM INTERREGION COMMODITY EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTE'">
				REPUBLICAN STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XUNI'">
				UNIVERSAL BROKER'S EXCHANGE 'TASHKENT'
			</xsl:when>
			<xsl:when test="$exchangeCode='GXMA'">
				GX MARKETCENTER
			</xsl:when>
			<xsl:when test="$exchangeCode='BVCA'">
				CARACAS STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='HSTC'">
				HANOI STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XHNX'">
				HANOI STOCK EXCHANGE (UNLISTED PUBLIC COMPANY TRADING PLATFORM)
			</xsl:when>
			<xsl:when test="$exchangeCode='XSTC'">
				HOCHIMINH STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XLUS'">
				LUSAKA STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XZIM'">
				ZIMBABWE STOCK EXCHANGE
			</xsl:when>
			<xsl:when test="$exchangeCode='XOFF'">
				OFF-EXCHANGE TRANSACTIONS - LISTED INSTRUMENTS
			</xsl:when>
			<xsl:when test="$exchangeCode='XXXX'">
				NO MARKET (E.G. UNLISTED)
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:value-of select="$exchangeCode" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>