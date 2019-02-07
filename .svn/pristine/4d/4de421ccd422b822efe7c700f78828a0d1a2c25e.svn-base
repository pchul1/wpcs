/*********************************************************************************************************
 * 파일명   : SendSmsNoRecvData.java
 * 작성자   : 최회섭
 * 작성일자 : 2012. 12. 26
 *
 * 클래스 개요: 지점별 미수신된 USN 데이터에 대해 공통수신자 및 지점별 수신대상자에 SMS 발송
 * =======================================================================================================
 * 수정내역
 * NO   수정일자         수정자     수정내역  
 * 001. 2012. 12. 26     최회섭     최초작성
 * =======================================================================================================
 */

package kr.or.waterkorea.batch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertMakeDAO;

public class SendSmsNoRecvData_old {

	private static String ITEM_CODE_TUR00 = "TUR00";
	private static String ITEM_CODE_PHY00 = "PHY00";
	private static String ITEM_CODE_CON00 = "CON00";
	private static String ITEM_CODE_DOW00 = "DOW00";
		
	
	private static Connection oraConn = null;	// 오라클 connection
	private static Connection  myConn = null;	// MySql  connection

	private static String ORACLE_DRIVER  = "oracle.jdbc.driver.OracleDriver";
	private static String ORACLE_URL 	 = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.101.164.221)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=WPCS)(SERVER=DEDICATED)))";
	private static String ORACLE_USER	 = "wpcs";
	private static String ORACLE_PASS	 = "wpcs";
	
	private static String MYSQL_DRIVER   = "com.mysql.jdbc.Driver";
	private static String MYSQL_URL 	 = "jdbc:mysql://10.101.160.176:3306/tms?characterEncoding=euckr";
	private static String MYSQL_USER	 = "tms";
	private static String MYSQL_PASS	 = "tms";
	
	public static void main(String[] args) throws SQLException, Exception {
		SendSmsNoRecvData_old ssnrd = new SendSmsNoRecvData_old();
		ssnrd.execute();
	}

	/**
	 * 배치 실행 메소드
	 * @throws Exception
	 * @throws SQLException
	 */
	private void execute() throws Exception, SQLException {
		/**********************************************************************************
		 * 1. IP-USN 미수신 측정소 조회 후 SMS 발송
		 **********************************************************************************/
		try {
			// WPCS DB 연결
			//System.out.println("########## SendSmsNoRecvData 오라클 DB Connection START ##########");
			
			Class.forName(ORACLE_DRIVER);
			oraConn = DriverManager.getConnection(ORACLE_URL, ORACLE_USER, ORACLE_PASS);
			
			// MySQL DB 연결
			Class.forName(MYSQL_DRIVER);
			myConn = DriverManager.getConnection(MYSQL_URL, MYSQL_USER, MYSQL_PASS);
			
			// 1. IP-USN 미수신 측정소 체크
			ipusnNorecvSend(oraConn, myConn);
			
			/*
			// 탁수 및 IP-USN
			// 새로 들어온 측정 자료를 조회한다.
			AlertMakeDAO alertMakeDAO = new AlertMakeDAO();
			List<AlertMinVO> alertMinList = (List<AlertMinVO>)alertMakeDAO.getMinList();
			if( alertMinList.size() > 0 )
			{
				for(int i=0; i < alertMinList.size(); i++)
				{
					AlertMinVO alertMinVO = (AlertMinVO)alertMinList.get(i);
					String system = alertMinVO.getFactCode().substring(2,3);

					//log.debug("factCode ======= " + alertMinVO.getFactCode());
					System.out.println("factCode ======= " + alertMinVO.getFactCode());
					if ("T".equals(system)){						
						//alertMakeT(alertMinVO);
					} else if ("U".equals(system)) {
						//alertMakeU(alertMinVO);
					}
	
				}//end for(int i=0; i < alertMinList.size(); i++)
				
				// 판단 대상에서 제외되도록 값 업데이트 min_dcd = '0'으로 만들기			
				//alertMakeDAO.updateMin();
			}//end if( alertMinList.size() > 0 )
			
			*/
		} catch(Exception e) {
			e.printStackTrace();
			//System.out.println(" SendSmsNoRecvData 스케줄러 executeInternal() 에러 : " + e.getMessage());
		} finally {
			try {
                if(oraConn != null) oraConn.close();
                if(myConn  != null) myConn.close();
            } catch(SQLException se) {
                se.printStackTrace();
            }
		}
	}
	
	
	/**
	 * IP-USN 미수신 측정소 SMS전송
	 */
	private void ipusnNorecvSend(Connection oraConn, Connection myConn) {
		Statement noRecvStmt = null;
		ResultSet noRecvRs 	 = null;
		
		try {
			
			/**********************************************************************************
			 * 1. DB 연결(oracle)
			 * 2. ARS 테이블의 SEND_YN = 'N'(MySQL의 SMS 테이블에 저장되지 않은) select
			 * 3. xroshot DB 연결(mysql)
			 * 4. 2의 갯수만큼 Looping 하면서 x_main 테이블에 데이터 저장
			 * 5. ARS 테이블의 SEND_YN = 'Y' 로 업데이트
			 **********************************************************************************/
			
			StringBuffer noRecvSb = new StringBuffer();
			
			noRecvSb.append("SELECT  factCode, \n")
					.append("        factName, \n")
					.append("        branchNo, \n")
					.append("        branchName, \n")
					.append("        minTime, \n")
					.append("        riverDiv, \n")
					.append("        CASE \n")
					.append("            WHEN gapTime >= 60 THEN TRUNC(gapTime/60) || 'H 이상' \n")
					.append("            WHEN gapTime < 30  THEN '' \n")
					.append("            ELSE '30M 이상'  \n")
					.append("        END gapTime, \n")
					.append("        CASE \n")
					.append("            WHEN gapTime <= 30 THEN 'Y' \n")
					.append("            WHEN TRUNC(gapTime/60) IN (1, 3, 6, 12, 24)  THEN 'Y' \n")
					.append("            WHEN TRUNC(gapTime/60) > 24 AND MOD(MOD(TRUNC(gapTime/60),24),3) = 0 THEN 'Y' \n")
					.append("            ELSE 'N'  \n")
					.append("        END sendYn1, \n")
					.append("        CASE \n")
					.append("            WHEN notSend > 0 THEN 'N' \n")
					.append("            ELSE 'Y'  \n")
					.append("        END sendYn2 \n")
					.append("  FROM	 ( \n")
					.append("SELECT  FACT_CODE_REAL factCode, \n")
					.append("        FACT_NAME factName, \n")
					.append("        A1.BRANCH_NO branchNo, \n")
					.append("        BRANCH_NAME branchName, \n")
					.append("        TO_CHAR(TO_DATE(MIN_TIME, 'YYYYMMDDHH24MI'), 'MM/DD HH24:MI') minTime, \n")
					.append("        RIVER_NAME riverDiv, \n")
					.append("        TRUNC(TO_NUMBER(((SYSDATE - 60/24/60/60 * FN_GET_CHK_DELAY(104, FACT_CODE_REAL, A1.BRANCH_NO)) - TO_DATE(MIN_TIME,'YYYYMMDDHH24MISS')))*24*60) gapTime, \n")
					.append("        (SELECT INSTR(NOT_SEND,TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))) FROM T_SMS_BRANCH_CONF WHERE DET_CODE = 104 AND FACT_CODE = FACT_CODE_REAL AND BRANCH_NO = A1.BRANCH_NO) notSend \n")
					.append("    FROM (  \n")
					.append("    SELECT FACT_CODE, BRANCH_NO, MIN_TIME \n")
					.append("  FROM  ( \n")
					.append("            SELECT  FACT_CODE \n")
					.append("                    ,BRANCH_NO \n")
					.append("                    ,( \n")
					.append("                        SELECT  MAX(MIN_TIME)  \n")
					.append("                          FROM  T_MIN_DATA  \n")
					.append("                         WHERE  FACT_CODE = BI.FACT_CODE  \n")
					.append("                           AND  BRANCH_NO = BI.BRANCH_NO  \n")
					.append("                           AND  MIN_TIME < TO_CHAR(SYSDATE - 60/24/60/60 * FN_GET_CHK_DELAY(104, BI.FACT_CODE, BI.BRANCH_NO), 'YYYYMMDDHH24MI') \n")
					.append("                    ) MIN_TIME \n")
					.append("              FROM  T_FACT_BRANCH_INFO BI \n") //리얼반영시 주석을 해제하고 아래줄을 주석처리
//					.append("              FROM  T_FACT_BRANCH_INFO_TEST BI \n")
					.append("             WHERE  FACT_CODE IN \n")
					.append("                    ( \n")
					.append("                        SELECT  FACT_CODE \n")
					.append("                          FROM  T_FACT_INFO \n")
					.append("                         WHERE  SYS_KIND = 'U' \n")
					.append("                           AND  FACT_USE_FLAG = 'Y' \n")
					.append("                    ) \n")
					.append("               AND  BRANCH_USE_FLAG = 'Y' \n")
					.append("        ) TBL \n")
					.append(" ) N1,  \n")
					.append("    ( \n")
					.append("    SELECT F1.FACT_CODE FACT_CODE_REAL, \n")
					.append("        D1.FACT_CODE, \n")
					.append("        AREA.REG_NAME AS FACT_NAME, \n")
					.append("        D2.BRANCH_NO, \n")
					.append("        D2.BRANCH_NAME || '-' || D2.BRANCH_NO BRANCH_NAME, \n")
					.append("        F1.FACT_MGR, \n")
					.append("        F1.FACT_TEL_NO, \n")
					.append("        F1.FACT_ADDR, \n")
					.append("        F1.RIVER_DIV, \n")
					.append("        DECODE(SUBSTR(F1.RIVER_DIV, 3, 1), \n")
					.append("               '1', \n")
					.append("               '한강', \n")
					.append("               '2', \n")
					.append("               '낙동강', \n")
					.append("               '3', \n")
					.append("               '금강', \n")
					.append("               '4', \n")
					.append("               '영산강') AS RIVER_NAME, \n")
					.append("        F1.SYS_KIND \n")
					.append("    FROM T_FACT_INFO F1, \n")
					.append("        T_FACT_BRANCH_INFO D2, \n") //리얼반영시 주석을 해제하고 아래줄을 주석처리
//					.append("        T_FACT_BRANCH_INFO_TEST D2, \n")
					.append("        ( \n")
					.append("          SELECT FACT_CODE, BRANCH_NO, MIN_TIME \n")
					.append("          FROM \n")
					.append("             ( \n")
					.append("              SELECT A.FACT_CODE, \n")
					.append("                     A.BRANCH_NO, \n")
					.append("                     (SELECT /*+ INDEX_DESC(B  IX_MIN_DATA_03 ) */ \n")
					.append("                             MIN_TIME \n")
					.append("                      FROM T_MIN_DATA B \n")
					.append("                      WHERE B.ITEM_CODE = A.ITEM_CODE \n")
					.append("                        AND B.FACT_CODE = A.FACT_CODE \n")
					.append("                        AND B.BRANCH_NO = A.BRANCH_NO \n")
					.append("                        AND MIN_TIME >= \n")
					.append("                            (SELECT CASE \n")
					.append("                                      WHEN SUBSTR(TO_CHAR(SYSDATE - 60/24/60/60 * FN_GET_CHK_DELAY(104, A.FACT_CODE, A.BRANCH_NO), \n")
					.append("                                                          'YYYYMMDDHH24MI'), \n")
					.append("                                                  12, \n")
					.append("                                                  1) < 5 THEN \n")
					.append("                                       SUBSTR(TO_CHAR(SYSDATE - 60/24/60/60 * FN_GET_CHK_DELAY(104, A.FACT_CODE, A.BRANCH_NO), \n")
					.append("                                                      'YYYYMMDDHH24MI'), \n")
					.append("                                              1, \n")
					.append("                                              11) || '0' \n")
					.append("                                      ELSE \n")
					.append("                                       SUBSTR(TO_CHAR(SYSDATE - 60/24/60/60 * FN_GET_CHK_DELAY(104, A.FACT_CODE, A.BRANCH_NO), \n")
					.append("                                                      'YYYYMMDDHH24MI'), \n")
					.append("                                              1, \n")
					.append("                                              11) || '5' \n")
					.append("                                    END NOW \n")
					.append("                               FROM DUAL) \n")
					.append("                          AND ROWNUM = 1) MIN_TIME \n")
					.append("              FROM  T_FACT_MEASU_ITEM A \n")
					.append("              WHERE ITEM_USE_FLAG = 'Y' \n")
					.append("              ) \n")
					.append("          WHERE MIN_TIME IS NOT NULL \n")
					.append("        ) D1, \n")
					.append("        T_WEATHER_AREA AREA \n")
					.append("    WHERE D2.FACT_CODE = D1.FACT_CODE(+) \n")
					.append("    AND D2.BRANCH_NO = D1.BRANCH_NO(+) \n")
					.append("    AND D2.FACT_CODE = AREA.FACT_CODE(+) \n")
					.append("    AND D2.BRANCH_NO = AREA.BRANCH_NO(+) \n")
					.append("    AND F1.FACT_CODE = D2.FACT_CODE \n")
					.append("    AND D2.BRANCH_USE_FLAG = 'Y' \n")
					.append("    AND F1.FACT_USE_FLAG = 'Y' \n")
					.append("    AND F1.SYS_KIND = 'U') A1 \n")
					.append("    WHERE A1.FACT_CODE IS NULL \n")
					.append("    AND A1.FACT_CODE_REAL = N1.FACT_CODE(+) \n")
					.append("    AND A1.BRANCH_NO = N1.BRANCH_NO(+) \n")
					.append("  	     ) TBL \n")
					.append(" WHERE  GAPTIME > 0 \n")
			        .append(" ORDER BY FACTCODE, BRANCHNO ");
			
			noRecvStmt = oraConn.createStatement();
			
			noRecvRs = noRecvStmt.executeQuery(noRecvSb.toString());
			
			while(noRecvRs.next()) {
				
				// SMS 보낼수 있는 시간일 경우에만 SMS 전송한다.
				if("Y".equals(noRecvRs.getString("sendYn1")) && "Y".equals(noRecvRs.getString("sendYn2"))) {
				
					String smsMsg = "[USN 미수신] " + noRecvRs.getString("branchName") + "지점 " + noRecvRs.getString("gapTime") + " 데이터 미수신. 최종수신시각 " + noRecvRs.getString("minTime");
					
					Map<String, String> smsMap = new HashMap<String, String>();
					
					// SMS 변수 셋팅
					smsMap.put("factCode",   noRecvRs.getString("factCode"));
					smsMap.put("factName",   noRecvRs.getString("factName"));
					smsMap.put("branchNo",   noRecvRs.getString("branchNo"));
					smsMap.put("branchName", noRecvRs.getString("branchName"));
					smsMap.put("minTime",    noRecvRs.getString("minTime"));
					smsMap.put("riverDiv", 	 noRecvRs.getString("riverDiv"));
					smsMap.put("gapTime", 	 noRecvRs.getString("gapTime"));
					
					// SMS 발송 : MySQL 테이블에 등록처리
					insertSmsMessage(smsMap, smsMsg, oraConn, myConn);
					
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			//System.out.println("SendSmsNoRecvData 스케줄러 ipusnNorecvSend() 에러 : " + e.getMessage());
		} finally {
			try{
				if(noRecvStmt != null) noRecvStmt.close();
                if(noRecvRs   != null) noRecvRs.close();
            }catch(SQLException se){
                se.printStackTrace();
            }
		}
	}
	
	/**
	 * IP-USN 미수신 측정지점 SMS발송
	 * @param params
	 * @param smsMsg
	 */
	private void insertSmsMessage(Map<String, String> params, String smsMsg, Connection oraConn, Connection myConn){
		//System.out.println(">>>>>>>>>>>>>>>> insertSmsMessage START <<<<<<<<<<<<<<<<<<<<<<<<<");
		PreparedStatement pstmt    = null;
		PreparedStatement pstmt2    = null;
		ResultSet 		  targetRs = null;
		
		try {
			// SMS 추가 변수 설정
			params.put("itemCode", "NRECV");
			params.put("subject",  "미수신측정소전파");
			params.put("callBack", "1666-0128");
			params.put("smsMsg",   smsMsg);

			StringBuffer targetSql = new StringBuffer();
			targetSql.append("SELECT  ( \n")
			         .append("           SELECT   TRIM (SUBSTR (MAX (SYS_CONNECT_BY_PATH (DEPT_NAME, ' > ')), 4)) \n")
			         .append("             FROM   T_DEPT_INFO  \n")
			         .append("            WHERE   DEPT_CODE = M.DEPT_CODE \n")
			         .append("            START   WITH UPPER_DEPT_CODE = '0' \n")
			         .append("          CONNECT   BY PRIOR DEPT_CODE = UPPER_DEPT_CODE \n")
			         .append("        ) AS atPart \n")
			         .append("        ,(SELECT DECODE(UPPER_DEPT_CODE, 8000, 1, 0) FROM T_DEPT_INFO WHERE DEPT_CODE = M.DEPT_CODE) as atPartGubun \n")
			         .append("        ,M.MEMBER_NAME AS atName \n")
			         .append("        ,M.MOBILE_NO   AS atSmsTele \n")
			         .append("  FROM  T_MEMBER M \n")
			         .append("        ,T_SMS_TARGET S \n")
			         .append(" WHERE  1 = 1 \n")
			         .append("   AND  M.MEMBER_ID = S.MEMBER_ID \n")
			         .append("   AND  S.DET_CODE  = 104  \n")
			         .append("   AND  S.RECV_TYPE = 'C'          \n")
			         .append("   AND  S.USE_FLAG  = 'Y' \n")
			         .append(" UNION  ALL \n")
			         .append("SELECT  ( \n")
			         .append("           SELECT   TRIM (SUBSTR (MAX (SYS_CONNECT_BY_PATH (DEPT_NAME, ' > ')), 4)) \n")
			         .append("             FROM   T_DEPT_INFO  \n")
			         .append("            WHERE   DEPT_CODE = M.DEPT_CODE \n")
			         .append("            START   WITH UPPER_DEPT_CODE = '0' \n")
			         .append("          CONNECT   BY PRIOR DEPT_CODE = UPPER_DEPT_CODE \n")
			         .append("        ) AS atPart \n")
			         .append("        ,(SELECT DECODE(UPPER_DEPT_CODE, 8000, 1, 0) FROM T_DEPT_INFO WHERE DEPT_CODE = M.DEPT_CODE) as atPartGubun \n")
			         .append("        ,M.MEMBER_NAME \n")
			         .append("        ,M.MOBILE_NO \n")
			         .append("  FROM  T_MEMBER M \n")
			         .append("        ,T_SMS_TARGET S \n")
			         .append(" WHERE  1 = 1 \n")
			         .append("   AND  M.MEMBER_ID = S.MEMBER_ID \n")
			         .append("   AND  S.DET_CODE  = 104          \n")
			         .append("   AND  S.FACT_CODE = ? \n")
			         .append("   AND  S.BRANCH_NO = ? \n")
			         .append("   AND  S.RECV_TYPE = 'B' \n")
			         .append("   AND  S.USE_FLAG  = 'Y' ");
			
			pstmt = oraConn.prepareStatement(targetSql.toString());
			pstmt.setString(1, ""+params.get("factCode"));
			pstmt.setInt   (2, Integer.parseInt(""+params.get("branchNo")));
			
			targetRs = pstmt.executeQuery();
			
			// MySQL SMS 발송 쿼리
			StringBuffer smsSql = new StringBuffer();
			smsSql.append("INSERT INTO SDK_SMS_SEND \n")
			      .append("	( USER_ID \n")
			      .append("	, SCHEDULE_TYPE \n")
			      .append("	, SUBJECT \n")
			      .append("	, NOW_DATE \n")
			      .append("	, SEND_DATE \n")
			      .append("	, CALLBACK \n")
			      .append("	, DEST_INFO \n")
			      .append("	, SMS_MSG \n")
			      .append("	, RESERVED1 \n")
			      .append("	, RESERVED2 \n")
			      .append("	, RESERVED3 \n")
			      .append("	, RESERVED4  \n")
			      .append("	, RESERVED5  \n")
			      .append("	, RESERVED6 \n")
			      .append("	) \n")
			      .append("VALUES \n")
			      .append("	( 'waterControl' \n")
			      .append("	, '0' \n")
			      .append("	, ? \n")
			      .append("	, DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') \n")
			      .append("	, DATE_FORMAT(DATE_ADD(NOW(),INTERVAL 1 SECOND),'%Y%m%d%H%i%s') \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, CONCAT('R0',substring(?,4,1)) \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
				  .append("	) ");
			
			pstmt2 = myConn.prepareStatement(smsSql.toString());
			
			
			while(targetRs.next()) {
				pstmt2.setString(1,  ""+params.get("subject"));
				pstmt2.setString(2,  ""+params.get("callBack"));
				pstmt2.setString(3,  targetRs.getString("atName") + "^" + targetRs.getString("atSmsTele"));
				pstmt2.setString(4,  ""+params.get("smsMsg"));
				pstmt2.setString(5,  ""+params.get("factCode"));
				pstmt2.setString(6,  targetRs.getString("atPart"));
				pstmt2.setString(7,  ""+params.get("factCode"));
				pstmt2.setString(8,  ""+params.get("branchNo"));
				pstmt2.setString(9,  ""+params.get("minTime"));
				pstmt2.setString(10, ""+params.get("itemCode"));
				
				pstmt2.executeUpdate();
				
			}
			
			// SMS 발송이력 남기기
			/*
			StringBuffer smsHis = new StringBuffer();
			smsSql.append("INSERT INTO SDK_SMS_SEND \n")
			      .append("	( USER_ID \n")
			      .append("	, SCHEDULE_TYPE \n")
			      .append("	, SUBJECT \n")
			      .append("	, NOW_DATE \n")
			      .append("	, SEND_DATE \n")
			      .append("	, CALLBACK \n")
			      .append("	, DEST_INFO \n")
			      .append("	, SMS_MSG \n")
			      .append("	, RESERVED1 \n")
			      .append("	, RESERVED2 \n")
			      .append("	, RESERVED3 \n")
			      .append("	, RESERVED4  \n")
			      .append("	, RESERVED5  \n")
			      .append("	, RESERVED6 \n")
			      .append("	) \n")
			      .append("VALUES \n")
			      .append("	( 'waterControl' \n")
			      .append("	, '0' \n")
			      .append("	, ? \n")
			      .append("	, DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') \n")
			      .append("	, DATE_FORMAT(DATE_ADD(NOW(),INTERVAL 1 SECOND),'%Y%m%d%H%i%s') \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, CONCAT('R0',substring(?,4,1)) \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
			      .append("	, ? \n")
				  .append("	) ");
			
			pstmt = oraConn.prepareStatement(smsHis.toString());
			
			
			while(targetRs.next()) {
				pstmt2.setString(1,  ""+params.get("subject"));
				pstmt2.setString(2,  ""+params.get("callBack"));
				pstmt2.setString(3,  targetRs.getString("atName") + "^" + targetRs.getString("atSmsTele"));
				pstmt2.setString(4,  ""+params.get("smsMsg"));
				pstmt2.setString(5,  ""+params.get("factCode"));
				pstmt2.setString(6,  targetRs.getString("atPart"));
				pstmt2.setString(7,  ""+params.get("factCode"));
				pstmt2.setString(8,  ""+params.get("branchNo"));
				pstmt2.setString(9,  ""+params.get("minTime"));
				pstmt2.setString(10, ""+params.get("itemCode"));
				
				pstmt2.executeUpdate();
				
			}
			*/
		} catch(Exception e){
			e.printStackTrace();
			//System.out.println(" SendSmsNoRecvData 스케줄러 insertSmsMessage() 에러 : " + e.getMessage());
		} finally {
			try{
				if(targetRs != null) targetRs.close();
				if(pstmt    != null) pstmt.close();
				if(pstmt2   != null) pstmt2.close();
            }catch(SQLException se){
                se.printStackTrace();
            }
		}
	}
	

	/**
	 * IP-USN 경보 발생
	 * 
	 * @param alertMinVO
	 */
	@SuppressWarnings("unchecked")
	private void alertMakeU(AlertMinVO alertMinVO) {
//		System.out.println("Start Alert by Scheduler IP-USN!");
//		
//		try {
//			
//			String itemCodePhy	= ITEM_CODE_PHY00; //pH 수소이온농도
//            String itemCodeDow	= ITEM_CODE_DOW00; //DO 용존산소
//            String itemCodeCon	= ITEM_CODE_CON00; //EC 전기전도도
//			
//			String factCode	= alertMinVO.getFactCode();
//			int branchNo	= alertMinVO.getBranchNo();
//			String minTime	= alertMinVO.getMinTime();
//            Float phy		= alertMinVO.getPhy(); //pH 수소이온농도
//            Float dow		= alertMinVO.getDow(); //DO 용존산소
//            Float con		= alertMinVO.getCon(); //EC 전기전도도
//            String riverId = "R0"+factCode.substring(3, 4);
//                        
//            int alertFlag 	= 0;
//            String minOr 	= "0";
//
//            int flagCon = 0;
//            int flagDow = 0;
//            int flagPhy = 0;
//            Float minVl		= 0.0f;
//            Float minVl1	= 0.0f;
//            Float minVl2 	= 0.0f;
//            String factName = "";
//            String branchName = "";
//            String itemCode = "";
//            String itemCode1 = "";
//			String itemName = "";
//			String itemName1 = "";
//			String itemCode2 = "";
//			String itemName2 = "";
//			
//			String alertSms = "";
//            String alertAcs = "";
//            int alertTerm = 0;
//           	
//            // 사고조치관리를 위하여
//            AlertStepVO alertStepVO = new AlertStepVO();
//            alertStepVO.setFactCode(factCode);
//			alertStepVO.setBranchNo(branchNo);
//			alertStepVO.setMinTime(minTime);
//			alertStepVO.setAlertTest("0");//테스트나 훈련이 아님; 실제 경보
//			alertStepVO.setRiverId(riverId);
//			
//			// 경보 메시지를 위하여
//			AlertDataVO alertDataVO = new AlertDataVO();				
//			alertDataVO.setFactCode(factCode);
//			alertDataVO.setBranchNo(branchNo);
//			alertDataVO.setMinTime(minTime);
//			
//            // 검색조건 세팅
//			AlertSearchVO alertSearchVO = new AlertSearchVO();
//			alertSearchVO.setFactCode(factCode);
//			alertSearchVO.setBranchNo(branchNo);
//
//			
//			// 경보 기준을 가져와서 판단 한다. 
//			AlertLawVO alertLawVO = alertMakeDAO.getLaw(alertSearchVO);
//						
//			if (alertLawVO != null) { 
//				
//				Float phyHVal 	= alertLawVO.getPhyHVal();
//				Float phyLVal 	= alertLawVO.getPhyLVal();
//				Float conHVal 	= alertLawVO.getConHVal();
//				Float dowLVal 	= alertLawVO.getDowLVal();
//				
//				
//				/***
//				 *  경계 : 전기전도도가 3배 이상 초과시
//				 *  주의 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 2배 이상 초과시
//				 *  		(단;수소이온농도 pH(phy)는 5 이하 또는 11 이상)
//				 *  관심 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 기준 초과시
//				 ***/		
//				int lawCount = 0;
//				if (con >= (conHVal*3)) {
//					itemCode = itemCodeCon;
//					minVl = con;
//					minOr = "3";
//				} else {
//					log.debug("###dow="+dow+"&dowLVal/2="+dowLVal/2 );
//					
//					if (con >= (conHVal*2)) {flagCon = 1;lawCount++;}
//					if (dow < (dowLVal/2)) {flagDow = 1;lawCount++;}
//					if (phy < 5 || phy > 11){flagPhy = 1;lawCount++;}
//				
//					if (lawCount > 1) {
//						minOr = "2";
//						lawCount = 0;
//					} else {
//						if (con >= conHVal) {flagCon = 1;lawCount++;}
//						if (dow < dowLVal) {flagDow = 1;lawCount++;}
//						if (phy < phyLVal || phy > phyHVal){flagPhy = 1;lawCount++;}
//						if (lawCount > 1) {minOr = "1";
//						} else {minOr = "0";}
//					}
//				}			
//				log.debug("#####################################");	            
//				log.debug("phy === " + phy);
//				log.debug("dow === " + dow);
//				log.debug("con === " + con);
//				log.debug("#####################################");	
//				log.debug("#############설정값####################");	   
//				log.debug("phyHVal === " + phyHVal);
//				log.debug("phyLVal === " + phyLVal);
//				log.debug("conHVal === " + conHVal);
//				log.debug("dowLVal === " + dowLVal); 
//				log.debug("#############설정값###################");	   
//				
//				log.debug("flagPhy === " + flagPhy);
//				log.debug("flagDow === " + flagDow);
//				log.debug("flagCon === " + flagCon);
//				
//				if ( "1".equals(minOr) || "2".equals(minOr) ){
//					if(flagPhy == 1 && flagDow == 1 && flagCon == 1)
//					{
//						itemCode = itemCodePhy;
//						itemCode1 = itemCodeDow;
//						itemCode2 = itemCodeCon;
//						minVl = phy;
//						minVl1 = dow;
//						minVl2 = con;
//					}
//					if (flagPhy == 1 && flagDow == 1) {
//						itemCode = itemCodePhy;
//						itemCode1 = itemCodeDow;
//						minVl = phy;
//						minVl1 = dow;
//					} else if (flagPhy == 1 && flagCon == 1){
//						itemCode = itemCodePhy;
//						itemCode1 = itemCodeCon;
//						minVl = phy;
//						minVl1 = con;
//					} else if (flagDow == 1 && flagCon == 1){
//						log.debug("CALL!!! ");
//						itemCode = itemCodeDow;
//						itemCode1 = itemCodeCon;
//						minVl = dow;
//						minVl1 = con;
//					}else{
//						minOr = "0";
//					}
//					alertSearchVO.setItemCode(itemCode1);
//					itemName1 = alertMakeDAO.getItemName(alertSearchVO);
//					
//					alertStepVO.setExcessItemCode(itemCode1); 
//					alertStepVO.setExcessMinVl(minVl1); 
//
//					if(!"".equals(itemCode2))
//					{
//						alertSearchVO.setItemCode(itemCode2);
//						itemName2 = alertMakeDAO.getItemName(alertSearchVO);
//						
//						alertStepVO.setExcessItemCode_2(itemCode2);
//						alertStepVO.setExcessMinVl_2(minVl2);
//					}
//					
//				}
//			
//				//사고 조치 테이블 인서트용
//				alertStepVO.setItemCode(itemCode);
//				alertStepVO.setMinVl(minVl);
//				
//				factName = alertMakeDAO.getFactName(alertSearchVO);
//				branchName = alertMakeDAO.getBranchName(alertSearchVO);
//				
//				alertSearchVO.setItemCode(itemCode);
//				itemName = alertMakeDAO.getItemName(alertSearchVO);
//			 
//			} else {
//				minOr = "0";
//				log.debug(" alertLawVO === null 이다");
//				alertStepVO.setAlertStepText("상황전파불가능 : 수질 기준 설정이 존재하지 않습니다.");
//			} 
//			
//			
//			
//			boolean continueFlag = true;
//			
//			
//			// 기준초과 이상일 때
//			if (Integer.parseInt(minOr) > 0)
//			{
//				// update table min_real set minOr
//				HashMap updateMap = new HashMap();
//				updateMap.put("minOr", minOr);
//				updateMap.put("factCode", factCode);
//				updateMap.put("branchNo", branchNo);
//				updateMap.put("itemCode", itemCode);
//				updateMap.put("minTime", minTime);
//				
//				alertMakeDAO.updateMinOr(updateMap);
//					
//				if(!"".equals(itemCode1))
//				{
//					updateMap.put("itemCode", itemCode1);
//					alertMakeDAO.updateMinOr(updateMap);
//				}
//				else if(!"".equals(itemCode2))
//				{
//					updateMap.put("itemCode", itemCode2);
//					alertMakeDAO.updateMinOr(updateMap);
//				}
//				
//				
//				
//				alertStepVO.setMinOr(minOr);
//				
//				AlertConfigVO alertConfigVO = alertMakeDAO.getConfig(alertSearchVO);
//				
//				if (alertConfigVO != null)
//				{
//					alertSms = alertConfigVO.getSmsFlag();
//					alertAcs = alertConfigVO.getArsFlag();
//					alertTerm = alertConfigVO.getAlertTerm();
//					
//					if (alertSms != null || alertAcs != null)
//					{ 
//						alertFlag = 1; 
//					}
//				}
//												
//				// 경보 발령 대상자의 단계별 추출을 위하여
//				alertSearchVO.setMinOr(minOr);								
//				
//				
//
//				
//				continueFlag = true;
//				
//				//현재 데이터 이전 30분의 데이터를 가져와서 기준 초과 여부를 체크한다.	
//				if (alertLawVO != null)
//				{ 			
//					
//					Float phyHVal 	= alertLawVO.getPhyHVal();
//					Float phyLVal 	= alertLawVO.getPhyLVal();
//					Float conHVal 	= alertLawVO.getConHVal();
//					Float dowLVal 	= alertLawVO.getDowLVal();
//				
//					List<AlertMinVO> preList = alertMakeDAO.getMinPreUsnList(alertStepVO);
//					
//					log.debug("USN PRE LIST SIZE - " + preList.size());
//					
//					for(AlertMinVO preVo : preList) {
//						
//						int preFlag = 0;								
//			            Float prePhy		= preVo.getPhy(); //pH 수소이온농도
//			            Float preDow		= preVo.getDow(); //DO 용존산소
//			            Float preCon		= preVo.getCon(); //EC 전기전도도			            
//					
//						/***
//						 *  경계 : 전기전도도가 3배 이상 초과시
//						 *  주의 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 2배 이상 초과시
//						 *  		(단;수소이온농도 pH(phy)는 5 이하 또는 11 이상)
//						 *  관심 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 기준 초과시
//						 ***/		
//						int lawCount = 0;
//						if (preCon >= (conHVal*3))
//						{
//							preFlag = 3;
//						} else 
//						{
//							if (preCon >= (conHVal*2)) {lawCount++;}
//							if (preDow < (dowLVal/2)) {lawCount++;}
//							if (prePhy < 5 || prePhy > 11){lawCount++;}
//							if (lawCount > 1) 
//							{
//								preFlag = 2;
//							} 
//							else 
//							{
//								if (preCon >= conHVal) {lawCount++;}
//								if (preDow < dowLVal) {lawCount++;}
//								if (prePhy < phyLVal ||prePhy > phyHVal){lawCount++;}
//								if (lawCount > 1) {
//									preFlag = 1;
//								}
//							}
//						}
//						
//						if(preFlag == 0) {
//							//30분동안 지속되지 않음
//							continueFlag = false;
//							//alertFlag = 0;
//							break;
//						}
//					}
//				}	
//
//								
//				// 해당 공구 아이템의 완료되지 않은 마지막 전파 내용 (alert_step = 1)
//				AlertStepLastVO alertStepLastVO = alertStepDAO.getLastAlert(alertStepVO);				
//			
//				
//				if (alertFlag == 1 && alertStepLastVO != null){
//					
//					String alertTime = alertStepLastVO.getAlertTime();
//					
//					int year = Integer.valueOf(alertTime.substring(0,4));
//					int month = Integer.valueOf(alertTime.substring(4,6));
//					int day = Integer.valueOf(alertTime.substring(6,8));
//					int hour = Integer.valueOf(alertTime.substring(8,10));
//					int min = Integer.valueOf(alertTime.substring(10,12));
//					
//									
//					Date currentDate = new Date(System.currentTimeMillis());
//	
//					//지난 경보발령시간
//			        Calendar beforeAlertTime = Calendar.getInstance(); 			       
//			        //현재시간
//			        Calendar current = Calendar.getInstance(); 
//
//			        beforeAlertTime.set(year, month, day, hour, min);
//			        beforeAlertTime.add(Calendar.MINUTE, 30); //지난 경보발령시간에 30분 추가
//			        current.setTime(currentDate);
//			         
//			        if (beforeAlertTime.before(current) || beforeAlertTime.equals(current)) //지난 경보발령으로부터 30분이 지났음
//			        { 
//			        	alertFlag = 1;
//			        } 
//			        else //30분이 지나지 않았으면 전파하지 않음
//			        {
//			        	alertFlag = 0;
//			        }
//				}
//				
//				
//				
//			}// end if (Integer.parseInt(minOr) > 0)
//			
//			log.debug("alertFlag ====== " + alertFlag);
//								
//			// 경보 발송
//			if (alertFlag > 0) {
//				
//				// 경보 메시지를 만든다.
//				String subject = "";
//				StringBuffer smsMsg = new StringBuffer();
//				StringBuffer smsMsgMinVl = new StringBuffer();
//				
//				if (alertSms != null) {
//					
//					if ("1".equals(minOr) ){						
//						subject = subject+" 관심";
//						smsMsg.append("USN(관심");
//					} else if ("2".equals(minOr) ){
//						subject = subject+" 주의";
//						smsMsg.append("USN(주의");
//					} else if ("3".equals(minOr) ){
//						subject = subject+" 경계";
//						smsMsg.append("USN(경계");
//					} 
//					
//					if (continueFlag) {
//						smsMsg.append(" 지속) ");
//					} else {
//						smsMsg.append(") ");
//					}
//					
//					smsMsg.append(factName).append("-").append(branchName)
//					.append(" ").append(minTime.substring(2, 4))
//					.append("").append(minTime.substring(4, 6))
//					.append("").append(minTime.substring(6, 8))
//					.append(" ").append(minTime.substring(8, 10))
//					.append(":").append(minTime.substring(10, 12));
//					
//					smsMsgMinVl.append(" ").append(itemName).append(" ").append(minVl);
//				
//					if (!"".equals(itemName1)) smsMsgMinVl.append(" ").append(itemName1).append(" ");
//					if (minVl1 > 0) smsMsgMinVl.append(minVl1);
//								
//					if (!"".equals(itemName2)) smsMsgMinVl.append(" ").append(itemName2).append(" ");
//					if (minVl2 > 0) smsMsgMinVl.append(minVl2);
//					
//					alertDataVO.setSubject(subject);
//					//데이터 검증
//					//alertData(alertDataVO.getFactCode(),alertSearchVO.getBranchNo(),alertSearchVO.getItemCode(),alertDataVO.getMinTime(),"S",smsMsg.toString(),smsMsgMinVl.toString(),alertFlag);
//					
//					
//					
//					//사전조치 통계를 내기위해 T_WARNING_SEND_DATA 테이블에 넣어줌
//					AlertSendDataVO 	send = new AlertSendDataVO();
//					send.setFactCode(factCode);
//					send.setRiverId("R0"+factCode.substring(3, 4)); 
//					send.setFactName(factName);
//					send.setBranchNo(branchNo); 
//					send.setItemCode(itemCode);	
//					send.setMinTime(minTime);
//					send.setAlertValue(minVl);
//					send.setAlertStandard(minVl); 
//					send.setSendFlag("Y"); // Y를 넣어서 스케쥴러에서 mysql인서트를 하지 않게함
//					send.setAlertMsg("");
//					send.setMsgKind("SMS");
//					send.setAlertType("IPUSN"); 
//					send.setMsg("");				
//					send.setMinOr(minOr);				
//					alertSmsSendData(send, null);
//					
//					
//					
//					// sms발송
//					alertSendSms(alertSearchVO, alertDataVO, alertStepVO, alertFlag, smsMsg.toString(), smsMsgMinVl.toString());
//				} // if (alertSms != null) 
//				
//				if (alertAcs != null) {
//								
//					smsMsg.append("안녕하십니까? 한국환경공단 방제센터입니다...");
//					
//					if ("1".equals(minOr) ){						
//						subject = subject+" 관심";
//						smsMsg.append("USN 관심");
//					} else if ("2".equals(minOr) ){
//						subject = subject+" 주의";
//						smsMsg.append("USN 주의");
//					} else if ("3".equals(minOr) ){
//						subject = subject+" 경계";
//						smsMsg.append("USN 경계");
//					} 
//					
//					if (continueFlag) {
//						smsMsg.append(" 지속 ");
//					} else {
//						smsMsg.append(" 발생 ");
//					}
//					
//					smsMsg.append(factName).append(" ").append(branchNo)
//					.append("번 측정소에서").append(minTime.substring(0, 4))
//					.append("년").append(minTime.substring(4, 6))
//					.append("월").append(minTime.substring(6, 8))
//					.append("일").append(minTime.substring(8, 10))
//					.append("시").append(minTime.substring(10, 12))
//					.append("분에").append(subject).append(" 경보가 발령되었습니다.");
//					
//					smsMsgMinVl.append("측정치는 ").append(itemName).append(" ").append(minVl);
//					
//					if (!"".equals(itemName1)) smsMsgMinVl.append(" ").append(itemName1).append(" ");
//					if (minVl1 > 0) smsMsgMinVl.append(minVl1);
//								
//					if (!"".equals(itemName2)) smsMsgMinVl.append(" ").append(itemName2).append(" ");
//					if (minVl2 > 0) smsMsgMinVl.append(minVl2);
//					
//					
//					smsMsgMinVl.append("입니다.");
//																								
//					alertDataVO.setSubject(subject);
//					
//					//DATA검증 
//					
//					//사전조치 통계를 내기위해 T_WARNING_SEND_DATA 테이블에 넣어줌
//					AlertSendDataVO 	send = new AlertSendDataVO();
//					send.setFactCode(factCode);
//					send.setRiverId("R0"+factCode.substring(3, 4)); 
//					send.setFactName(factName);
//					send.setBranchNo(branchNo); 
//					send.setItemCode(itemCode);	
//					send.setMinTime(minTime);
//					send.setAlertValue(minVl);
//					send.setAlertStandard(minVl); 
//					send.setSendFlag("Y"); // Y를 넣어서 스케쥴러에서 mysql인서트를 하지 않게함
//					send.setAlertMsg("");
//					send.setMsgKind("ARS");
//					send.setAlertType("IPUSN"); 
//					send.setMsg("");				
//					send.setMinOr(minOr);				
//					alertVmsSendData(send, null);
//					
//					// ACS발송
//					alertSendVms (alertSearchVO, alertDataVO,alertStepVO, alertFlag, smsMsg.toString(), smsMsgMinVl.toString());
//					
//				} // end if (alertAcs != null)
//				
//				//유하속도예측하여예경보날릴때 쓸 메쏘드
//				//alertMakeForecast(alertSearchVO, alertDataVO, alertStepVO, smsMsg.toString(), smsMsgMinVl.toString());
//				
//			}//end if (alertFlag > 0)
//		}catch(Exception e){
//			e.printStackTrace();
//			log.error(" AlertBySchdlrImpl 스케줄러 alertMakeU() 에러 : " + e.getMessage());
//		}
	}	
	
}
