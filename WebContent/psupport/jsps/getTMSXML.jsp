<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.* , net.sf.json.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/html; charset=utf-8");
try
{
	Statement stmt=null;
	/* sql = "SELECT FACTCODE AS FACT_CODE, FACTNAME, BRANCHNO AS BRANCH_NO, BRANCH_NAME, MINTIME, STRDATE, STRTIME, MINRTIME, MINDUMP, ";
	sql += "TO_CHAR(SUM(PHY), 'FM999,990.00') PHY, ";
	sql += "TO_CHAR(SUM(BOD), 'FM999,990.00') BOD, ";
	sql += "TO_CHAR(SUM(COD), 'FM999,990.00') COD, ";
	sql += "TO_CHAR(SUM(SUS), 'FM999,990.00') SUS, ";
	sql += "TO_CHAR(SUM(TOP), 'FM999,990.00') TOP, ";
	sql += "TO_CHAR(SUM(TON), 'FM999,990.00') TON, ";
	sql += "TO_CHAR(SUM(FLW), 'FM999,990') FLW, ";
	sql += "SUM(PHY_OR) PHY_OR, ";
	sql += "SUM(BOD_OR) BOD_OR, ";
	sql += "SUM(COD_OR) COD_OR, ";
	sql += "SUM(SUS_OR) SUS_OR, ";
	sql += "SUM(TOP_OR) TOP_OR, ";
	sql += "SUM(TON_OR) TON_OR, ";
	sql += "SUM(FLW_OR) FLW_OR, ";
	sql += "MAX(MINST) MINST, MAX(MINAB) MINAB "; 
	sql += "		,'R'||MAX(AREA_GBN) AS RIVER_DIV ";
	sql += "		,DECODE(MAX(AREA_GBN),'01','수도권','02','충청/강원','03','영남','04','호남') AS RIVER_NAME ";
	sql += "		,'W' AS SYS_KIND ";
	sql += "		,'수질TMS' AS	SYS_KIND_NAME ";
	sql += "		FROM ( SELECT A.ITEM_CODE AS ITEMCODE, ";
	sql += "			B.ITEM_NAME AS ITEMNAME, ";
	sql += "			A.FACT_CODE AS FACTCODE, ";
	sql += "			C.FACT_NAME AS FACTNAME, ";
	sql += "			A.WAST_NO	AS BRANCHNO, ";
	sql += "			A.WAST_NO BRANCH_NAME, ";
	sql += "			A.MIN_TIME	AS MINTIME , ";
	sql += "			TO_CHAR(TO_DATE(A.MIN_TIME,'YYYYMMDDHH24MI'),'YYYY/MM/DD') AS STRDATE, ";
	sql += "			TO_CHAR(TO_DATE(A.MIN_TIME,'YYYYMMDDHH24MI'),'HH24:MI') AS STRTIME, ";
	sql += "			A.MIN_RTIME AS MINRTIME, ";
	sql += "			A.MIN_DUMP	AS MINDUMP , ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'PHY', MIN_VL) PHY, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'BOD', MIN_VL) BOD, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'COD', MIN_VL) COD, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3),'SUS', MIN_VL) SUS, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'TOP', MIN_VL) TOP, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3),'TON', MIN_VL) TON, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'FLW', MIN_VL) FLW, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'PHY', MIN_OR) PHY_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'BOD', MIN_OR) BOD_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'COD', MIN_OR) COD_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'SUS', MIN_OR) SUS_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'TOP', MIN_OR) TOP_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'TON', MIN_OR) TON_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'FLW', MIN_OR) FLW_OR, ";
	sql += "			A.MIN_ST AS MINST, ";
	sql += "			A.MIN_AB AS MINAB, ";
	sql += "			AREA.AREA_GBN ";
	sql += "		FROM WTMSC_MIN_REAL_LAST@TMS A, "; 
	sql += "			 WTMSC_ITEM@TMS B, ";
	sql += "			 WTMSC_FACT@TMS C, ";
	sql += "			 WTMSC_FACT_WAST@TMS D, ";
	sql += "			 WTMSC_AREA@TMS AREA ";
	sql += "		WHERE A.ITEM_CODE = B.ITEM_CODE ";
	sql += "			AND A.FACT_CODE = C.FACT_CODE ";
	sql += "			AND C.FACT_CODE = D.FACT_CODE ";
	sql += "			AND A.WAST_NO = D.WAST_NO ";
	sql += "			AND D.WAST_USED = 'Y' ";
	sql += "			AND C.FACT_USED = 'Y' ";
	sql += "			AND AREA.CTY_CODE = C.CTY_CODE ) ";
	sql += "GROUP BY FACTCODE, FACTNAME, BRANCHNO, BRANCH_NAME, STRDATE, STRTIME, ";
	sql += "		 MINTIME, STRDATE, STRTIME, MINRTIME, MINDUMP ";
	sql += "ORDER BY STRDATE DESC, STRTIME DESC, FACTNAME ASC, BRANCHNO ASC "; */
	//수정전 (기준치 추가)
	
	/* sql =  "SELECT FACT_CODE																																									                                                                            \n";
	sql += "	   ,fact_name as FACTNAME                                                                                                                                                                                                                                   \n";
	sql += "	   , WAST_NO as BRANCH_NO                                                                                                                                                                                                                                   \n";
	sql += "	   , WAST_NO as BRANCH_NAME                                                                                                                                                                                                                                 \n";
	sql += "	   , MIN_TIME  as MINTIME                                                                                                                                                                                                                                   \n";
	sql += "	   , TO_CHAR(TO_DATE(MIN_TIME, 'YYYYMMDDHH24MI'), 'YYYY/MM/DD') AS STRDATE                                                                                                                                                                                  \n";
	sql += "	   , TO_CHAR(TO_DATE(MIN_TIME, 'YYYYMMDDHH24MI'), 'HH24:MI') AS STRTIME                                                                                                                                                                                     \n";
	sql += "	   , MIN_RTIME  as MINRTIME                                                                                                                                                                                                                                 \n";
	sql += "	   , CASE WHEN BLACK > 0 THEN 'M' ELSE CASE WHEN WHITE > 0 THEN 'L' ELSE CASE WHEN RED > 0 THEN '2' ELSE CASE WHEN ORANGE > 0 THEN '4' ELSE CASE WHEN YELLOW > 0 THEN '3' ELSE CASE WHEN BLUE > 0 THEN '1' ELSE 'L' END END END END END END VALUE           \n";
	sql += "	   , PHY                                                                                                                                                                                                                                                    \n";
	sql += "	   , BOD                                                                                                                                                                                                                                                    \n";
	sql += "	   , COD                                                                                                                                                                                                                                                    \n";
	sql += "	   , SUS                                                                                                                                                                                                                                                    \n";
	sql += "	   , TOP                                                                                                                                                                                                                                                    \n";
	sql += "	   , TON                                                                                                                                                                                                                                                    \n";
	sql += "	   , FLW                                                                                                                                                                                                                                                    \n";
	sql += "	   , RIVER_DIV                                                                                                                                                                                                                                              \n";
	sql += "	   , RIVER_NAME                                                                                                                                                                                                                                             \n";
	sql += "	   , 'W' AS SYS_KIND                                                                                                                                                                                                                                        \n";
	sql += "	   , '수질TMS' AS SYS_KIND_NAME                                                                                                                                                                                                                               \n";
	sql += "	FROM (                                                                                                                                                                                                                                                      \n";
	sql += "	     SELECT FACT_CODE                                                                                                                                                                                                                                       \n";
	sql += "	            ,FACT_NAME                                                                                                                                                                                                                                      \n";
	sql += "	          , WAST_NO                                                                                                                                                                                                                                         \n";
	sql += "	          , STAND_TIME                                                                                                                                                                                                                                      \n";
	sql += "	          , MAX(MIN_TIME) AS MIN_TIME                                                                                                                                                                                                                       \n";
	sql += "	          , MAX(MIN_RTIME) AS MIN_RTIME                                                                                                                                                                                                                     \n";
	sql += "	          , NVL(SUM(DECODE(MIN_OR, NULL, 1)), 0) AS BLACK                                                                                                                                                                                                   \n";
	sql += "	          , NVL(SUM(CASE WHEN MIN_ST IN ('05', '15', '06', '16' ) THEN 1 END), 0) AS WHITE                                                                                                                                                                  \n";
	sql += "	          , CASE WHEN MAX(MIN_ST) IN ('00', '02' ) THEN NVL(SUM(DECODE(MIN_OR, '3', 1)), 0) END AS RED                                                                                                                                                      \n";
	sql += "	          , CASE WHEN MAX(MIN_ST) IN ('00', '02' ) THEN NVL(SUM(DECODE(MIN_OR, '2', 1)), 0) END AS ORANGE                                                                                                                                                   \n";
	sql += "	          , CASE WHEN MAX(MIN_ST) IN ('00', '02' ) THEN NVL(SUM(DECODE(MIN_OR, '1', 1)), 0) END AS YELLOW                                                                                                                                                   \n";
	sql += "	          , NVL(SUM(DECODE(MIN_OR, '0', 1)), 0) AS BLUE                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(SUM(PHY), 'FM999,990.00') PHY                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(BOD), 'FM999,990.00') BOD                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(COD), 'FM999,990.00') COD                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(SUS), 'FM999,990.00') SUS                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(TOP), 'FM999,990.00') TOP                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(TON), 'FM999,990.00') TON                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(FLW), 'FM999,990') FLW                                                                                                                                                                                                              \n";
	sql += "	          , 'R'||MAX (AREA_GBN ) AS RIVER_DIV                                                                                                                                                                                                               \n";
	sql += "	          , DECODE(MAX(AREA_GBN), '01', '수도권', '02', '충청/강원', '03', '영남', '04', '호남') AS RIVER_NAME                                                                                                                                                         \n";
	sql += "	       FROM (                                                                                                                                                                                                                                               \n";
	sql += "	            SELECT MA.FACT_CODE                                                                                                                                                                                                                             \n";
	sql += "	                 ,ma.FACT_NAME                                                                                                                                                                                                                              \n";
	sql += "	                 , MA.WAST_NO                                                                                                                                                                                                                               \n";
	sql += "	                 , MA.ITEM_CODE                                                                                                                                                                                                                             \n";
	sql += "	                 , MA.STAND_TIME                                                                                                                                                                                                                            \n";
	sql += "	                 , TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI') AS CUR_TIME                                                                                                                                                                                           \n";
	sql += "	                 , MB.MIN_TIME                                                                                                                                                                                                                              \n";
	sql += "	                 , MB.MIN_VL                                                                                                                                                                                                                                \n";
	sql += "	                 , MB.MIN_RTIME                                                                                                                                                                                                                             \n";
	sql += "	                 , MB.MIN_DUMP                                                                                                                                                                                                                              \n";
	sql += "	                 , MB.MIN_OR                                                                                                                                                                                                                                \n";
	sql += "	                 , MB.MIN_ST                                                                                                                                                                                                                                \n";
	sql += "	                 , MB.MIN_DCD                                                                                                                                                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'PHY', MIN_VL) PHY                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'BOD', MIN_VL) BOD                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'COD', MIN_VL) COD                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'SUS', MIN_VL) SUS                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'TOP', MIN_VL) TOP                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'TON', MIN_VL) TON                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'FLW', MIN_VL) FLW                                                                                                                                                                                    \n";
	sql += "	                 , ma.area_gbn                                                                                                                                                                                                                              \n";
	sql += "	              FROM (                                                                                                                                                                                                                                        \n";
	sql += "	            SELECT A.FACT_CODE                                                                                                                                                                                                                              \n";
	sql += "	            ,c.fact_name                                                                                                                                                                                                                                    \n";
	sql += "	                 , A.WAST_NO                                                                                                                                                                                                                                \n";
	sql += "	                 , A.ITEM_CODE                                                                                                                                                                                                                              \n";
	sql += "	                 , (                                                                                                                                                                                                                                        \n";
	sql += "	                   SELECT CASE WHEN SUBSTR(TO_CHAR(SYSDATE - 30/24/60, 'YYYYMMDDHH24MI'), 12, 1) < 5 THEN SUBSTR(TO_CHAR(SYSDATE - 30/24/60, 'YYYYMMDDHH24MI'), 1, 11) || '0' ELSE SUBSTR(TO_CHAR(SYSDATE - 30/24/60, 'YYYYMMDDHH24MI'), 1, 11) || '5' END	\n";
	sql += "	                     FROM DUAL                                                                                                                                                                                                                              \n";
	sql += "	                 ) AS STAND_TIME                                                                                                                                                                                                                            \n";
	sql += "	                 ,area.area_gbn                                                                                                                                                                                                                             \n";
	sql += "	              FROM WTMSC_FACT_ITEM@tms A                                                                                                                                                                                                                    \n";
	sql += "	                 , WTMSC_ITEM@tms B                                                                                                                                                                                                                         \n";
	sql += "	                 , WTMSC_FACT@tms C                                                                                                                                                                                                                         \n";
	sql += "	                 , WTMSC_FACT_WAST@tms D                                                                                                                                                                                                                    \n";
	sql += "	                 , WTMSC_AREA@TMS AREA                                                                                                                                                                                                                      \n";
	sql += "	             WHERE C.FACT_CODE=D.FACT_CODE                                                                                                                                                                                                                  \n";
	sql += "	               AND A.FACT_CODE = D.FACT_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.WAST_NO = D.WAST_NO                                                                                                                                                                                                                    \n";
	sql += "	               AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.ITEM_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND B.ITEM_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND C.FACT_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND D.WAST_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               and area.CTY_CODE = C.CTY_CODE) MA, (                                                                                                                                                                                                        \n";
	sql += "	SELECT A.FACT_CODE                                                                                                                                                                                                                                          \n";
	sql += "	                 , A.WAST_NO                                                                                                                                                                                                                                \n";
	sql += "	                 , A.ITEM_CODE                                                                                                                                                                                                                              \n";
	sql += "	                 , A.MIN_TIME                                                                                                                                                                                                                               \n";
	sql += "	                 , A.MIN_VL                                                                                                                                                                                                                                 \n";
	sql += "	                 , A.MIN_RTIME                                                                                                                                                                                                                              \n";
	sql += "	                 , A.MIN_DUMP                                                                                                                                                                                                                               \n";
	sql += "	                 , NVL(A.MIN_OR, 0) AS MIN_OR                                                                                                                                                                                                               \n";
	sql += "	                 , A.MIN_ST                                                                                                                                                                                                                                 \n";
	sql += "	                 , A.MIN_DCD                                                                                                                                                                                                                                \n";
	sql += "	              FROM WTMSC_MIN_REAL_LAST@tms A                                                                                                                                                                                                                \n";
	sql += "	                 , WTMSC_ITEM@tms B                                                                                                                                                                                                                         \n";
	sql += "	                 , WTMSC_FACT_ITEM@tms C                                                                                                                                                                                                                    \n";
	sql += "	             WHERE B.ITEM_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.FACT_CODE = C.FACT_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.WAST_NO = C.WAST_NO                                                                                                                                                                                                                    \n";
	sql += "	               AND A.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND C.ITEM_USED='Y' ) MB                                                                                                                                                                                                                     \n";
	sql += "	             WHERE MA.FACT_CODE = MB.FACT_CODE (+)                                                                                                                                                                                                          \n";
	sql += "	               AND MA.WAST_NO = MB.WAST_NO (+)                                                                                                                                                                                                              \n";
	sql += "	               AND MA.ITEM_CODE = MB.ITEM_CODE (+)                                                                                                                                                                                                          \n";
	sql += "	              AND MA.STAND_TIME <= MB.MIN_TIME (+)                                                                                                                                                                                                          \n";
	sql += "	          )                                                                                                                                                                                                                                                 \n";
	sql += "	      GROUP BY FACT_CODE, fact_name, WAST_NO, STAND_TIME, area_gbn                                                                                                                                                                                          \n";
	sql += "	   )                                                                                                                                                                                                                                                        \n";
	sql += "	   ORDER BY STRDATE DESC, STRTIME DESC, FACTNAME ASC, BRANCH_NO ASC                                                                                                                                                                                         "; */
	
	sql =  "SELECT FACT_CODE																																									                                                                            \n";
	sql += "	   ,fact_name as FACTNAME                                                                                                                                                                                                                                   \n";
	sql += "	   , WAST_NO as BRANCH_NO                                                                                                                                                                                                                                   \n";
	sql += "	   , WAST_NO as BRANCH_NAME                                                                                                                                                                                                                                 \n";
	sql += "	   , MIN_TIME  as MINTIME                                                                                                                                                                                                                                   \n";
	sql += "	   , TO_CHAR(TO_DATE(MIN_TIME, 'YYYYMMDDHH24MI'), 'YYYY/MM/DD') AS STRDATE                                                                                                                                                                                  \n";
	sql += "	   , TO_CHAR(TO_DATE(MIN_TIME, 'YYYYMMDDHH24MI'), 'HH24:MI') AS STRTIME                                                                                                                                                                                     \n";
	sql += "	   , MIN_RTIME  as MINRTIME                                                                                                                                                                                                                                 \n";
	sql += "	   , CASE WHEN BLACK > 0 THEN 'M' ELSE CASE WHEN WHITE > 0 THEN 'L' ELSE CASE WHEN RED > 0 THEN '2' ELSE CASE WHEN ORANGE > 0 THEN '4' ELSE CASE WHEN YELLOW > 0 THEN '3' ELSE CASE WHEN BLUE > 0 THEN '1' ELSE 'L' END END END END END END VALUE           \n";
	sql += "	   , PHY                                                                                                                                                                                                                                                    \n";
	sql += "	   , BOD                                                                                                                                                                                                                                                    \n";
	sql += "	   , COD                                                                                                                                                                                                                                                    \n";
	sql += "	   , SUS                                                                                                                                                                                                                                                    \n";
	sql += "	   , TOP                                                                                                                                                                                                                                                    \n";
	sql += "	   , TON                                                                                                                                                                                                                                                    \n";
	sql += "	   , FLW                                                                                                                                                                                                                                                    \n";
	sql += "	   , PHYLAW                                                                                                                                                                                                                                                 \n";
	sql += "	   , BODLAW                                                                                                                                                                                                                                                 \n";
	sql += "	   , CODLAW                                                                                                                                                                                                                                                 \n";
	sql += "	   , SUSLAW                                                                                                                                                                                                                                                 \n";
	sql += "	   , TOPLAW                                                                                                                                                                                                                                                 \n";
	sql += "	   , TONLAW                                                                                                                                                                                                                                                 \n";
	sql += "	   , FLWLAW                                                                                                                                                                                                                                                 \n";
	sql += "	   , RIVER_DIV                                                                                                                                                                                                                                              \n";
	sql += "	   , RIVER_NAME                                                                                                                                                                                                                                             \n";
	sql += "	   , 'W' AS SYS_KIND                                                                                                                                                                                                                                        \n";
	sql += "	   , '수질TMS' AS SYS_KIND_NAME                                                                                                                                                                                                                               \n";
	sql += "	FROM (                                                                                                                                                                                                                                                      \n";
	sql += "	     SELECT FACT_CODE                                                                                                                                                                                                                                       \n";
	sql += "	            ,FACT_NAME                                                                                                                                                                                                                                      \n";
	sql += "	          , WAST_NO                                                                                                                                                                                                                                         \n";
	sql += "	          , STAND_TIME                                                                                                                                                                                                                                      \n";
	sql += "	          , MAX(MIN_TIME) AS MIN_TIME                                                                                                                                                                                                                       \n";
	sql += "	          , MAX(MIN_RTIME) AS MIN_RTIME                                                                                                                                                                                                                     \n";
	sql += "	          , NVL(SUM(DECODE(MIN_OR, NULL, 1)), 0) AS BLACK                                                                                                                                                                                                   \n";
	sql += "	          , NVL(SUM(CASE WHEN MIN_ST IN ('05', '15', '06', '16' ) THEN 1 END), 0) AS WHITE                                                                                                                                                                  \n";
	/* sql += "	          , CASE WHEN MAX(MIN_ST) IN ('00', '02' ) THEN NVL(SUM(DECODE(MIN_OR, '3', 1)), 0) END AS RED                                                                                                                                                      \n";
	sql += "	          , CASE WHEN MAX(MIN_ST) IN ('00', '02' ) THEN NVL(SUM(DECODE(MIN_OR, '2', 1)), 0) END AS ORANGE                                                                                                                                                   \n";
	sql += "	          , CASE WHEN MAX(MIN_ST) IN ('00', '02' ) THEN NVL(SUM(DECODE(MIN_OR, '1', 1)), 0) END AS YELLOW                                                                                                                                                   \n"; */
	sql += "	          , NVL(SUM(DECODE(MIN_OR, '3', 1)), 0) AS RED                                                                                                                                                      												\n";
	sql += "	          , NVL(SUM(DECODE(MIN_OR, '2', 1)), 0) AS ORANGE                                                                                                                                                   												\n";
	sql += "	          , NVL(SUM(DECODE(MIN_OR, '1', 1)), 0) AS YELLOW                                                                                                                                                   												\n";
	sql += "	          , NVL(SUM(DECODE(MIN_OR, '0', 1)), 0) AS BLUE                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(SUM(PHY), 'FM999,990.00') PHY                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(BOD), 'FM999,990.00') BOD                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(COD), 'FM999,990.00') COD                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(SUS), 'FM999,990.00') SUS                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(TOP), 'FM999,990.00') TOP                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(TON), 'FM999,990.00') TON                                                                                                                                                                                                           \n";
	sql += "	          , TO_CHAR(SUM(FLW), 'FM999,990') FLW                                                                                                                                                                                                              \n";
	sql += "	          , TO_CHAR(MAX(PHYLAW)) PHYLAW                                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(MAX(BODLAW)) BODLAW                                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(MAX(CODLAW)) CODLAW                                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(MAX(SUSLAW)) SUSLAW                                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(MAX(TOPLAW)) TOPLAW                                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(MAX(TONLAW)) TONLAW                                                                                                                                                                                                                     \n";
	sql += "	          , TO_CHAR(MAX(FLWLAW)) FLWLAW                                                                                                                                                                                                                     \n";	
	sql += "	          , 'R'||MAX (AREA_GBN ) AS RIVER_DIV                                                                                                                                                                                                               \n";
	sql += "	          , DECODE(MAX(AREA_GBN), '01', '수도권', '02', '충청/강원', '03', '영남', '04', '호남') AS RIVER_NAME                                                                                                                                                        \n";
	sql += "	       FROM (                                                                                                                                                                                                                                               \n";
	sql += "	            SELECT MA.FACT_CODE                                                                                                                                                                                                                             \n";
	sql += "	                 ,ma.FACT_NAME                                                                                                                                                                                                                              \n";
	sql += "	                 , MA.WAST_NO                                                                                                                                                                                                                               \n";
	sql += "	                 , MA.ITEM_CODE                                                                                                                                                                                                                             \n";
	sql += "	                 , MA.STAND_TIME                                                                                                                                                                                                                            \n";
	sql += "	                 , TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI') AS CUR_TIME                                                                                                                                                                                           \n";
	sql += "	                 , MB.MIN_TIME                                                                                                                                                                                                                              \n";
	sql += "	                 , MB.MIN_VL                                                                                                                                                                                                                                \n";
	sql += "	                 , MB.MIN_RTIME                                                                                                                                                                                                                             \n";
	sql += "	                 , MB.MIN_DUMP                                                                                                                                                                                                                              \n";
	sql += "	                 , CASE WHEN MB.MIN_OR > '0' THEN  CASE WHEN MIN_ST IN ('00', '02' ) THEN MIN_OR ELSE '0' END ELSE MIN_OR END AS MIN_OR                                                                                                                     \n";
	sql += "	                 , MB.MIN_ST                                                                                                                                                                                                                                \n";
	sql += "	                 , MB.MIN_DCD                                                                                                                                                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'PHY', MIN_VL) PHY                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'BOD', MIN_VL) BOD                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'COD', MIN_VL) COD                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'SUS', MIN_VL) SUS                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'TOP', MIN_VL) TOP                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'TON', MIN_VL) TON                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'FLW', MIN_VL) FLW                                                                                                                                                                                    \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'PHY', '(' || TO_CHAR(LAW_LVAL,'FM999,990.00') || '~' || TO_CHAR(LAW_HVAL,'FM999,990.00') ||')') PHYLAW                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'BOD', '(' || TO_CHAR(LAW_LVAL,'FM999,990.00') || '~' || TO_CHAR(LAW_HVAL,'FM999,990.00') ||')') BODLAW                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'COD', '(' || TO_CHAR(LAW_LVAL,'FM999,990.00') || '~' || TO_CHAR(LAW_HVAL,'FM999,990.00') ||')') CODLAW                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'SUS', '(' || TO_CHAR(LAW_LVAL,'FM999,990.00') || '~' || TO_CHAR(LAW_HVAL,'FM999,990.00') ||')') SUSLAW                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'TOP', '(' || TO_CHAR(LAW_LVAL,'FM999,990.00') || '~' || TO_CHAR(LAW_HVAL,'FM999,990.00') ||')') TOPLAW                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'TON', '(' || TO_CHAR(LAW_LVAL,'FM999,990.00') || '~' || TO_CHAR(LAW_HVAL,'FM999,990.00') ||')') TONLAW                                                                                               \n";
	sql += "	                 , DECODE(SUBSTR(MB.ITEM_CODE, 0, 3), 'FLW', '(' || TO_CHAR(LAW_LVAL,'FM999,990') || '~' || TO_CHAR(LAW_HVAL,'FM999,990') ||')') FLWLAW                                                                                                     \n";
	sql += "	                 , ma.area_gbn                                                                                                                                                                                                                              \n";
	sql += "	              FROM (                                                                                                                                                                                                                                        \n";
	sql += "	            SELECT A.FACT_CODE                                                                                                                                                                                                                              \n";
	sql += "	            ,c.fact_name                                                                                                                                                                                                                                    \n";
	sql += "	                 , A.WAST_NO                                                                                                                                                                                                                                \n";
	sql += "	                 , A.ITEM_CODE                                                                                                                                                                                                                              \n";
	sql += "	                 , (                                                                                                                                                                                                                                        \n";
	sql += "	                   SELECT CASE WHEN SUBSTR(TO_CHAR(SYSDATE - 30/24/60, 'YYYYMMDDHH24MI'), 12, 1) < 5 THEN SUBSTR(TO_CHAR(SYSDATE - 30/24/60, 'YYYYMMDDHH24MI'), 1, 11) || '0' ELSE SUBSTR(TO_CHAR(SYSDATE - 30/24/60, 'YYYYMMDDHH24MI'), 1, 11) || '5' END	\n";
	sql += "	                     FROM DUAL                                                                                                                                                                                                                              \n";
	sql += "	                 ) AS STAND_TIME                                                                                                                                                                                                                            \n";
	sql += "	                 ,area.area_gbn                                                                                                                                                                                                                             \n";
	sql += "	              FROM WTMSC_FACT_ITEM@tms A                                                                                                                                                                                                                    \n";
	sql += "	                 , WTMSC_ITEM@tms B                                                                                                                                                                                                                         \n";
	sql += "	                 , WTMSC_FACT@tms C                                                                                                                                                                                                                         \n";
	sql += "	                 , WTMSC_FACT_WAST@tms D                                                                                                                                                                                                                    \n";
	sql += "	                 , WTMSC_AREA@TMS AREA                                                                                                                                                                                                                      \n";
	sql += "	             WHERE C.FACT_CODE=D.FACT_CODE                                                                                                                                                                                                                  \n";
	sql += "	               AND A.FACT_CODE = D.FACT_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.WAST_NO = D.WAST_NO                                                                                                                                                                                                                    \n";
	sql += "	               AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.ITEM_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND B.ITEM_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND C.FACT_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND D.WAST_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               and area.CTY_CODE = C.CTY_CODE) MA, (                                                                                                                                                                                                        \n";
	sql += "	SELECT A.FACT_CODE                                                                                                                                                                                                                                          \n";
	sql += "	                 , A.WAST_NO                                                                                                                                                                                                                                \n";
	sql += "	                 , A.ITEM_CODE                                                                                                                                                                                                                              \n";
	sql += "	                 , A.MIN_TIME                                                                                                                                                                                                                               \n";
	sql += "	                 , A.MIN_VL                                                                                                                                                                                                                                 \n";
	sql += "	                 , A.MIN_RTIME                                                                                                                                                                                                                              \n";
	sql += "	                 , A.MIN_DUMP                                                                                                                                                                                                                               \n";
	sql += "	                 , NVL(A.MIN_OR, 0) AS MIN_OR                                                                                                                                                                                                               \n";
	sql += "	                 , A.MIN_ST                                                                                                                                                                                                                                 \n";
	sql += "	                 , A.MIN_DCD                                                                                                                                                                                                                                \n";
	sql += "	                 , D.LAW_LVAL                                                                                                                                                                                                                                \n";
	sql += "	                 , D.LAW_HVAL                                                                                                                                                                                                                                \n";
	sql += "	              FROM WTMSC_MIN_REAL_LAST@tms A                                                                                                                                                                                                                \n";
	sql += "	                 , WTMSC_ITEM@tms B                                                                                                                                                                                                                         \n";
	sql += "	                 , WTMSC_FACT_ITEM@tms C                                                                                                                                                                                                                    \n";
	sql += "	                 , (SELECT * FROM WTMSC_FACT_LAW@TMS WHERE TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN BEGIN_DATE AND END_DATE AND LAW_APPLY = '1') D                                                                                                               \n";
	sql += "	             WHERE B.ITEM_USED = 'Y'                                                                                                                                                                                                                        \n";
	sql += "	               AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.FACT_CODE = C.FACT_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.WAST_NO = C.WAST_NO                                                                                                                                                                                                                    \n";
	sql += "	               AND A.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                                                \n";
	sql += "	               AND A.FACT_CODE = D.FACT_CODE(+)                                                                                                                                                                                                             \n";
	sql += "	               AND A.WAST_NO = D.WAST_NO(+)                                                                                                                                                                                                                 \n";
	sql += "	               AND A.ITEM_CODE = D.ITEM_CODE(+)                                                                                                                                                                                                             \n";
	sql += "	               AND C.ITEM_USED='Y' ) MB                                                                                                                                                                                                                     \n";
	sql += "	             WHERE MA.FACT_CODE = MB.FACT_CODE (+)                                                                                                                                                                                                          \n";
	sql += "	               AND MA.WAST_NO = MB.WAST_NO (+)                                                                                                                                                                                                              \n";
	sql += "	               AND MA.ITEM_CODE = MB.ITEM_CODE (+)                                                                                                                                                                                                          \n";
	sql += "	              AND MA.STAND_TIME <= MB.MIN_TIME (+)                                                                                                                                                                                                          \n";
	sql += "	          )                                                                                                                                                                                                                                                 \n";
	sql += "	      GROUP BY FACT_CODE, fact_name, WAST_NO, STAND_TIME, area_gbn                                                                                                                                                                                          \n";
	sql += "	   )                                                                                                                                                                                                                                                        \n";
	sql += "	   ORDER BY STRDATE DESC, STRTIME DESC, FACTNAME ASC, BRANCH_NO ASC                                                                                                                                                                                         ";
	/* System.out.println("<script>");
	System.out.println("alert('" + sql + "');");
	System.out.println("</script>"); */
	System.out.println("getTMSXML >>>>>>>>>> " + sql);
	
	out.println("[]");
	
	JSONArray reJson = new JSONArray();
	
// 	try
// 	{
// 		stmt=conn.createStatement();
// 		rs=stmt.executeQuery(sql);
// 		while(rs.next())
// 		{
// 		JSONObject jo = new JSONObject();
// 			ResultSetMetaData rmd = rs.getMetaData();
		
// 			for ( int i=1; i<=rmd.getColumnCount(); i++ )
// 			{
// 				jo.put(rmd.getColumnName(i),rs.getString(rmd.getColumnName(i)));
// 			}
// 			reJson.add(jo);
// 		}
// 		out.println(reJson.toString());
// 		closeConn(rs,stmt,conn);
// 	}
// 	catch(SQLException ex)
// 	{
// 		ex.printStackTrace();
// 	}
}
catch(Exception ex)
{
	//System.out.println(ex);
	ex.printStackTrace();
}
%>
<%!
public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
{
	rs.close();
	con.close();
	stmt.close();
}
%>