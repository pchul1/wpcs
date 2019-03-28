<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%><%@ include file="dbconn.jsp" %>

<%
response.setContentType("text/html; charset=utf-8");
try
{
	String sys = request.getParameter("sys");
	Statement stmt=null;
// 	sql = "SELECT FN_GET_ALAM_DATA_CHK(FACTCODE,BRANCHNO) AS ALAM, FACTCODE, FACTNAME, BRANCHNO, BRANCH_NAME, MINTIME, STRDATE, STRTIME, MINRTIME, MINDUMP, ";	//모식도를 기반으로 한 루프를 위해 변경
	sql = "SELECT FN_GET_ALAM_DATA_CHK(FACT_CODE,BRANCH_NO) AS ALAM, FACT_CODE, FACTNAME, BRANCH_NO, BRANCH_NAME, STRDATE, STRTIME, BRANCH_MAP_Y, VALUE, ";
	sql += "MAX(LATITUDE) AS LATITUDE,  ";
	sql += "MAX(LONGITUDE) AS LONGITUDE, ";
	/* 일반 항목 (내부) */
	sql += "TO_CHAR(SUM(TUR), 'FM999,990.00') TUR, ";
	sql += "MAX(TURL) TURL, ";
	sql += "TO_CHAR(SUM(DECODE(CON2, NULL, CON, CON2)), 'FM999,990.00') CON, ";
	sql += "MAX(DECODE(CON2L, NULL, CONL, CON2L)) CONL, ";
	sql += "TO_CHAR(SUM(DECODE(DOW2, NULL, DOW, DOW2)), 'FM999,990.00') DOW, ";
	sql += "MAX(DECODE(DOW2L, NULL, DOWL, DOW2L)) DOWL, ";
	sql += "TO_CHAR(SUM(DECODE(TMP2, NULL, TMP, TMP2)), 'FM999,990.00') TMP, ";
	sql += "MAX(DECODE(TMP2L, NULL, TMPL, TMP2L)) TMPL, ";
	sql += "TO_CHAR(SUM(DECODE(PHY2, NULL, PHY, PHY2)), 'FM999,990.00') PHY, ";
	sql += "MAX(DECODE(PHY2L, NULL, PHYL, PHY2L)) PHYL, ";
	sql += "SUM(DECODE(CON2, NULL, CON_OR, CON2_OR)) CON_OR, ";
	sql += "SUM(DECODE(DOW2, NULL, DOW_OR, DOW2_OR)) DOW_OR, ";
	sql += "SUM(DECODE(TMP2, NULL, TMP_OR, TMP2_OR)) TMP_OR, ";
	sql += "SUM(DECODE(PHY2, NULL, PHY_OR, PHY2_OR)) PHY_OR, ";
	sql += "SUM(TUR_OR) TUR_OR, ";
	/* 생물독성(물고기) */
	sql += "TO_CHAR(SUM(IMP), 'FM999,990.00') IMP, ";
	sql += "SUM(IMP_OR) IMP_OR, ";
	/* 생물독성(물벼룩1) */
	sql += "TO_CHAR(SUM(LIM), 'FM999,990.00') LIM, ";
	sql += "TO_CHAR(SUM(RIM), 'FM999,990.00') RIM, ";
	sql += "SUM(LIM_OR) LIM_OR, ";
	sql += "SUM(RIM_OR) RIM_OR, ";
	/* 생물독성(물벼룩2) */
	sql += "TO_CHAR(SUM(LTX), 'FM999,990.00') LTX, ";
	sql += "TO_CHAR(SUM(RTX), 'FM999,990.00') RTX, ";
	sql += "SUM(LTX_OR) LTX_OR, ";
	sql += "SUM(RTX_OR) RTX_OR, ";
	/* 생물독성(미생물) */
	sql += "TO_CHAR(SUM(TOX), 'FM999,990.00') TOX, ";
	sql += "SUM(TOX_OR) TOX_OR, ";
	/* 생물독성(조류) */
	sql += "TO_CHAR(SUM(EVN), 'FM999,990.00') EVN, ";
	sql += "SUM(EVN_OR) EVN_OR, ";
	/* 클로로필-a */
	sql += "TO_CHAR(SUM(TOF), 'FM999,990.00') TOF, ";
	sql += "SUM(TOF_OR) TOF_OR, ";
	/* 휘발성 유기화합물 */
	sql += "TO_CHAR(SUM(VOC1), 'FM999,990.00') VOC1, ";
	sql += "TO_CHAR(SUM(VOC2), 'FM999,990.00') VOC2, ";
	sql += "TO_CHAR(SUM(VOC3), 'FM999,990.00') VOC3, ";
	sql += "TO_CHAR(SUM(VOC4), 'FM999,990.00') VOC4, ";
	sql += "TO_CHAR(SUM(VOC5), 'FM999,990.00') VOC5, ";
	sql += "TO_CHAR(SUM(VOC6), 'FM999,990.00') VOC6, ";
	sql += "TO_CHAR(SUM(VOC7), 'FM999,990.00') VOC7, ";
	sql += "TO_CHAR(SUM(VOC8), 'FM999,990.00') VOC8, ";
	sql += "TO_CHAR(SUM(VOC9), 'FM999,990.00') VOC9, ";
	sql += "TO_CHAR(SUM(VOC10), 'FM999,990.00') VOC10, ";
	sql += "TO_CHAR(SUM(VOC11), 'FM999,990.00') VOC11, ";
	sql += "TO_CHAR(SUM(VOC12), 'FM999,990.00') VOC12, ";
	sql += "TO_CHAR(SUM(VOC13), 'FM999,990.00') VOC13, ";
	sql += "TO_CHAR(SUM(VOC14), 'FM999,990.00') VOC14, ";
	sql += "TO_CHAR(SUM(VOC15), 'FM999,990.00') VOC15, ";
	sql += "SUM(VOC1_OR) VOC1_OR, ";
	sql += "SUM(VOC2_OR) VOC2_OR, ";
	sql += "SUM(VOC3_OR) VOC3_OR, ";
	sql += "SUM(VOC4_OR) VOC4_OR, ";
	sql += "SUM(VOC5_OR) VOC5_OR, ";
	sql += "SUM(VOC6_OR) VOC6_OR, ";
	sql += "SUM(VOC7_OR) VOC7_OR, ";
	sql += "SUM(VOC8_OR) VOC8_OR, ";
	sql += "SUM(VOC9_OR) VOC9_OR, ";
	sql += "SUM(VOC10_OR) VOC10_OR, ";
	sql += "SUM(VOC11_OR) VOC11_OR, ";
	sql += "SUM(VOC12_OR) VOC12_OR, ";
	sql += "SUM(VOC13_OR) VOC13_OR, ";
	sql += "SUM(VOC14_OR) VOC14_OR, ";
	sql += "SUM(VOC15_OR) VOC15_OR, ";
	/* 중금속 */
	sql += "TO_CHAR(SUM(COP), 'FM999,990.00') COP, ";
	sql += "TO_CHAR(SUM(PLU), 'FM999,990.00') PLU, ";
	sql += "TO_CHAR(SUM(ZIN), 'FM999,990.00') ZIN, ";
	sql += "TO_CHAR(SUM(CAD), 'FM999,990.00') CAD, ";
	sql += "SUM(COP_OR) COP_OR, ";
	sql += "SUM(PLU_OR) PLU_OR, ";
	sql += "SUM(ZIN_OR) ZIN_OR, ";
	sql += "SUM(CAD_OR) CAD_OR, ";
	/* 페놀 */
	sql += "TO_CHAR(SUM(PHE), 'FM999,990.00') PHE, ";
	sql += "TO_CHAR(SUM(PHL), 'FM999,990.00') PHL, ";
	sql += "SUM(PHE_OR) PHE_OR, ";
	sql += "SUM(PHL_OR) PHL_OR, ";
	/* 유기물질 */
	sql += "TO_CHAR(SUM(TOC), 'FM999,990.00') TOC, ";
	sql += "SUM(TOC_OR) TOC_OR, ";
	/* 영양염류 */
	sql += "TO_CHAR(SUM(TON), 'FM999,990.00') TON, ";
	sql += "TO_CHAR(SUM(TOP), 'FM999,990.00') TOP, ";
	sql += "TO_CHAR(SUM(NH4), 'FM999,990.00') NH4, ";
	sql += "TO_CHAR(SUM(NO3), 'FM999,990.00') NO3, ";
	sql += "TO_CHAR(SUM(PO4), 'FM999,990.00') PO4, ";
	sql += "SUM(TON_OR) TON_OR, ";
	sql += "SUM(TOP_OR) TOP_OR, ";
	sql += "SUM(NH4_OR) NH4_OR, ";
	sql += "SUM(NO3_OR) NO3_OR, ";
	sql += "SUM(PO4_OR) PO4_OR, ";
		/* 강수량계 */
	sql += "TO_CHAR(SUM(RIN), 'FM999,990.00') RIN, ";
	sql += "SUM(RIN_OR) RIN_OR, ";
	sql += "MAX(MINST) MINST, '' MINAB, RIVER_DIV, ";
	sql += "RIVER_NAME, SYS_KIND, SYS_KIND_NAME ";
	sql += "FROM ( SELECT DISTINCT ";
	sql += "A.ITEM_CODE AS ITEMCODE, ";
	sql += "B.ITEM_NAME AS ITEMNAME, ";
	sql += "C.FACT_CODE AS FACT_CODE, ";
// 	sql += "AREA.REG_NAME AS FACTNAME, ";
	sql += "C.FACT_NAME AS FACTNAME, ";
	sql += "D.BRANCH_NO   AS BRANCH_NO, ";
	sql += "D.BRANCH_NAME||'-'||A.BRANCH_NO BRANCH_NAME, ";
	sql += "D.BRANCH_MAP_Y AS BRANCH_MAP_Y, ";	//모식도를 기반으로 한 루프를 위해 추가
	sql += "A.MIN_TIME AS MINTIME , ";
	sql += "TO_CHAR(TO_DATE(A.MIN_TIME,'YYYYMMDDHH24MI'),'YYYY/MM/DD') AS STRDATE, ";
	sql += "TO_CHAR(TO_DATE(A.MIN_TIME,'YYYYMMDDHH24MI'),'HH24:MI') AS STRTIME, ";
	sql += "A.MIN_RTIME AS MINRTIME, ";
	sql += "A.MIN_DUMP  AS MINDUMP , ";
	/* 일반항목 내부 */
	sql += "DECODE(A.ITEM_CODE, 'CON00', MIN_VL) CON, ";
	sql += "DECODE(A.ITEM_CODE, 'CON00', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) CONL, ";
	sql += "DECODE(A.ITEM_CODE, 'DOW00', MIN_VL) DOW, ";
	sql += "DECODE(A.ITEM_CODE, 'DOW00', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) DOWL, ";
	sql += "DECODE(A.ITEM_CODE, 'TMP00', MIN_VL) TMP, ";
	sql += "DECODE(A.ITEM_CODE, 'TMP00', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) TMPL, ";
	sql += "DECODE(A.ITEM_CODE, 'PHY00', MIN_VL) PHY, ";
	sql += "DECODE(A.ITEM_CODE, 'PHY00', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) PHYL, ";
	sql += "DECODE(A.ITEM_CODE, 'CON00', MIN_OR) CON_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'DOW00', MIN_OR) DOW_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'TMP00', MIN_OR)TMP_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'PHY00', MIN_OR) PHY_OR, ";
	/* 일반 항목 외부 */
	sql += "DECODE(A.ITEM_CODE, 'TMP01', MIN_VL) TMP2, ";
	sql += "DECODE(A.ITEM_CODE, 'TMP01', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) TMP2L, ";
	sql += "DECODE(A.ITEM_CODE, 'PHY01', MIN_VL) PHY2, ";
	sql += "DECODE(A.ITEM_CODE, 'PHY01', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) PHY2L, ";
	sql += "DECODE(A.ITEM_CODE, 'DOW01', MIN_VL) DOW2, ";
	sql += "DECODE(A.ITEM_CODE, 'DOW01', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) DOW2L, ";
	sql += "DECODE(A.ITEM_CODE, 'CON01', MIN_VL) CON2, ";
	sql += "DECODE(A.ITEM_CODE, 'CON01', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) CON2L, ";
	sql += "DECODE(A.ITEM_CODE, 'TMP01', MIN_OR) TMP2_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'PHY01', MIN_OR) PHY2_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'DOW01', MIN_OR) DOW2_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'CON01', MIN_OR) CON2_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'TUR00', MIN_OR) TUR_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'TUR00', MIN_VL) TUR, ";
	sql += "DECODE(A.ITEM_CODE, 'TUR00', FN_GET_AUTO_LAW(A.FACT_CODE, A.ITEM_CODE, D.BRANCH_NO)) TURL, ";
	/* 생물 독성 (물고기)*/
	sql += "DECODE(A.ITEM_CODE, 'IMP00', MIN_VL) IMP, ";
	sql += "DECODE(A.ITEM_CODE, 'IMP00', MIN_OR) IMP_OR, ";
	/* 생물 독성 (물벼룩1) */
	sql += "DECODE(A.ITEM_CODE, 'LIM00', MIN_VL) LIM, ";
	sql += "DECODE(A.ITEM_CODE, 'RIM00', MIN_VL) RIM, ";
	sql += "DECODE(A.ITEM_CODE, 'LIM00', MIN_OR) LIM_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'RIM00', MIN_OR) RIM_OR, ";
	/* 생물 독성 (물벼룩2) */
	sql += "DECODE(A.ITEM_CODE, 'LTX00', MIN_VL) LTX, ";
	sql += "DECODE(A.ITEM_CODE, 'RTX00', MIN_VL) RTX, ";
	sql += "DECODE(A.ITEM_CODE, 'LTX00', MIN_OR) LTX_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'RTX00', MIN_OR) RTX_OR, ";
	/* 생물 독성 (미생물) */
	sql += "DECODE(A.ITEM_CODE, 'TOX00', MIN_VL) TOX, ";
	sql += "DECODE(A.ITEM_CODE, 'TOX00', MIN_OR) TOX_OR, ";
	/* 생물 독성 (조류) */
	sql += "DECODE(A.ITEM_CODE, 'EVN00', MIN_VL) EVN, ";
	sql += "DECODE(A.ITEM_CODE, 'EVN00', MIN_OR) EVN_OR, ";
	/* 클로로필-a */
	sql += "DECODE(A.ITEM_CODE, 'TOF00', MIN_VL) TOF, ";
	sql += "DECODE(A.ITEM_CODE, 'TOF00', MIN_OR) TOF_OR, ";
	/* 휘발성 유기화합물 */
	sql += "DECODE(A.ITEM_CODE, 'VOC01', MIN_VL) VOC1, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC02', MIN_VL) VOC2, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC03', MIN_VL) VOC3, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC04', MIN_VL) VOC4, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC05', MIN_VL) VOC5, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC06', MIN_VL) VOC6, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC07', MIN_VL) VOC7, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC08', MIN_VL) VOC8, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC09', MIN_VL) VOC9, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC10', MIN_VL) VOC10, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC11', MIN_VL) VOC11, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC12', MIN_VL) VOC12, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC13', MIN_VL) VOC13, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC14', MIN_VL) VOC14, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC15', MIN_VL) VOC15, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC01', MIN_OR) VOC1_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC02', MIN_OR) VOC2_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC03', MIN_OR) VOC3_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC04', MIN_OR) VOC4_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC05', MIN_OR) VOC5_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC06', MIN_OR) VOC6_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC07', MIN_OR) VOC7_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC08', MIN_OR) VOC8_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC09', MIN_OR) VOC9_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC10', MIN_OR) VOC10_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC11', MIN_OR) VOC11_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC12', MIN_OR) VOC12_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC13', MIN_OR) VOC13_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC14', MIN_OR) VOC14_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'VOC15', MIN_OR) VOC15_OR, ";
	/* 중금속 */
	sql += "DECODE(A.ITEM_CODE, 'COP00', MIN_VL) COP, ";
	sql += "DECODE(A.ITEM_CODE, 'PLU00', MIN_VL) PLU, ";
	sql += "DECODE(A.ITEM_CODE, 'ZIN00', MIN_VL) ZIN, ";
	sql += "DECODE(A.ITEM_CODE, 'CAD00', MIN_VL) CAD, ";
	sql += "DECODE(A.ITEM_CODE, 'COP00', MIN_OR) COP_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'PLU00', MIN_OR) PLU_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'ZIN00', MIN_OR) ZIN_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'CAD00', MIN_OR) CAD_OR, ";
/* 페놀 */
	sql += "DECODE(A.ITEM_CODE, 'PHE00', MIN_VL) PHE, ";
	sql += "DECODE(A.ITEM_CODE, 'PHL00', MIN_VL) PHL, ";
	sql += "DECODE(A.ITEM_CODE, 'PHE00', MIN_OR) PHE_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'PHL00', MIN_OR) PHL_OR, ";
	/* 유기물질 */
	sql += "DECODE(A.ITEM_CODE, 'TOC00', MIN_VL) TOC, ";
	sql += "DECODE(A.ITEM_CODE, 'TOC00', MIN_OR) TOC_OR, ";
	/* 영양염류 */
	sql += "DECODE(A.ITEM_CODE, 'TON00', MIN_VL) TON, ";
	sql += "DECODE(A.ITEM_CODE, 'TOP00', MIN_VL) TOP, ";
	sql += "DECODE(A.ITEM_CODE, 'NH400', MIN_VL) NH4, ";
	sql += "DECODE(A.ITEM_CODE, 'NO300', MIN_VL) NO3, ";
	sql += "DECODE(A.ITEM_CODE, 'PO400', MIN_VL) PO4, ";
	sql += "DECODE(A.ITEM_CODE, 'TON00', MIN_OR) TON_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'TOP00', MIN_OR) TOP_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'NH400', MIN_OR) NH4_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'NO300', MIN_OR) NO3_OR, ";
	sql += "DECODE(A.ITEM_CODE, 'PO400', MIN_OR) PO4_OR, ";
	/* 강수량계 */
	sql += "DECODE(A.ITEM_CODE, 'RIN00', MIN_VL) RIN, ";
	sql += "DECODE(A.ITEM_CODE, 'RIN00', MIN_OR) RIN_OR, ";
	sql += "NVL(D.LATITUDE,0) AS LATITUDE,  ";
	sql += "NVL(D.LONGITUDE,0) AS LONGITUDE,";
	sql += "A.MIN_ST AS MINST, ";
	sql += "'' AS MINAB, ";
	sql += "C.RIVER_DIV, ";
	sql += "DECODE(C.RIVER_DIV,'R01','한강','R02','낙동강','R03','금강','R04','영산강') AS RIVER_NAME, ";
	sql += "C.SYS_KIND, ";
	sql += "( SELECT SYS_KIND_NAME ";
	sql += "FROM T_SYS_KIND ";
	sql += "WHERE SYS_KIND = C.SYS_KIND ";
	sql += ") SYS_KIND_NAME, ";
	sql += "NVL((SELECT /*+INDEX_DESC(T_ALERT_INFO_PK)*/ ALERT_LEVEL FROM T_ALERT_INFO WHERE FACT_CODE = A.FACT_CODE AND BRANCH_NO = A.BRANCH_NO AND ROWNUM = 1),'S') AS VALUE ";
	sql += "FROM T_FACT_INFO C ";
	sql += "    INNER JOIN T_FACT_BRANCH_INFO D ";
	sql += "        ON C.FACT_CODE = D.FACT_CODE ";
	sql += "        AND D.BRANCH_USE_FLAG = 'Y' ";
	sql += "    LEFT OUTER JOIN ";
	sql += "        (SELECT A.* ";
	sql += "          FROM T_MIN_DATA A, ";
	sql += "               T_FACT_BRANCH_INFO C ";
	sql += "         WHERE A.FACT_CODE = C.FACT_CODE ";
	sql += "               AND A.FACT_CODE = C.FACT_CODE ";
	sql += "               AND C.BRANCH_USE_FLAG = 'Y' ";
	sql += "               AND A.MIN_TIME = ";
	sql += "               (SELECT ";
	sql += "                      /*+INDEX_DESC(CC IX_MIN_DATA_04)*/ ";
	sql += "                      min_time ";
	sql += "                 FROM T_MIN_DATA CC ";
	sql += "                WHERE CC.FACT_CODE = C.FACT_CODE ";
	sql += "                      AND CC.BRANCH_NO= C.BRANCH_NO ";
	sql += "                      AND CC.MIN_VL IS NOT NULL ";
	sql += "                      AND CC.MIN_DCD = '0' ";
	sql += "                      AND ROWNUM =1 ";
	sql += "               )";
	sql += "        ) A ";
	sql += "        ON A.FACT_CODE = C.FACT_CODE ";
	sql += "        AND A.BRANCH_NO = D.BRANCH_NO ";
	sql += "    LEFT OUTER JOIN T_ITEM_INFO B ";
	sql += "        ON A.ITEM_CODE = B.ITEM_CODE ";
	sql += "    LEFT OUTER JOIN T_FACT_MEASU_ITEM I ";
	sql += "        ON I.ITEM_CODE = A.ITEM_CODE ";
	sql += "        AND I.FACT_CODE = A.FACT_CODE ";
	sql += "        AND I.BRANCH_NO = A.BRANCH_NO ";
	sql += "    LEFT OUTER JOIN T_WQA_ITEM M ";
	sql += "        ON M.ITEM_CODE = A.ITEM_CODE ";
	sql += "  WHERE C.FACT_USE_FLAG = 'Y' ";
  	sql += "AND C.SYS_KIND  = '"+sys+"' "; 
	sql += ") ";
	sql += "GROUP BY FACT_CODE, FACTNAME, BRANCH_NO, BRANCH_NAME, STRDATE, STRTIME,";
// 	sql += "GROUP BY FACT_CODE, FACTNAME, BRANCH_NO, BRANCH_NAME, STRDATE, STRTIME, ";
// 	sql += "MINTIME, STRDATE, STRTIME, MINRTIME, MINDUMP, ";
// 	sql += "RIVER_DIV, RIVER_NAME, SYS_KIND, SYS_KIND_NAME ";	//모식도를 기반으로 한 루프를 위해 변경
	sql += "RIVER_DIV, RIVER_NAME, SYS_KIND, SYS_KIND_NAME, BRANCH_MAP_Y, VALUE ";
// 	sql += "ORDER BY STRDATE DESC, STRTIME DESC, FACTNAME ASC, BRANCHNO ASC ";
// 	sql += "ORDER BY RIVER_DIV ASC, BRANCH_MAP_Y ASC, STRDATE DESC, STRTIME DESC, FACTNAME ASC, BRANCH_NO ASC ";	//모식도를 기반으로 한 루프를 위해 변경(수계와 모식도 기준)
	sql += "ORDER BY RIVER_DIV ASC, BRANCH_MAP_Y ASC, FACTNAME ASC, BRANCH_NO ASC ";	//모식도를 기반으로 한 루프를 위해 변경(수계와 모식도 기준)

	System.out.println("getAutoXML sql : "+sql);
	JSONArray reJson = new JSONArray();
	try
	{ 
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		while(rs.next())
		{
			JSONObject jo = new JSONObject();
			ResultSetMetaData rmd = rs.getMetaData();
	
			for ( int i=1; i<=rmd.getColumnCount(); i++ )
			{
				jo.put(rmd.getColumnName(i),rs.getString(rmd.getColumnName(i)));
			}
			reJson.add(jo);
		}
		out.println(reJson.toString());
		
		closeConn(rs,stmt,conn);
	}
	catch(SQLException ex)
	{
		//System.out.println(ex);
		ex.printStackTrace();
	}
}
catch(Exception ex)
{
	//System.out.println(ex);
	ex.printStackTrace();
}
%>
