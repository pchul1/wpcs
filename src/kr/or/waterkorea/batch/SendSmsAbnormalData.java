/*********************************************************************************************************
 * 파일명   : SendSmsAbnormalData.java
 * 작성자   : 최회섭
 * 작성일자 : 2013. 2. 19
 *
 * 클래스 개요: 지점별 USN 이상데이터에 대해 공통수신자 및 지점별 수신대상자에 SMS 발송
 * =======================================================================================================
 * 수정내역
 * NO   수정일자		 수정자	 수정내역  
 * 001. 2013. 2. 19	 최회섭	 최초작성
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

public class SendSmsAbnormalData {

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
		SendSmsAbnormalData ssad = new SendSmsAbnormalData();
		ssad.execute();
	}

	/**
	 * 배치 실행 메소드
	 * @throws Exception
	 * @throws SQLException
	 */
	private void execute() throws Exception, SQLException {
		/**********************************************************************************
		 * 1. IP-USN 측정소 조회 후 SMS 발송
		 * 2. IP-USN MIN_DCD=1 업데이트 처리
		 **********************************************************************************/
		try {
			// WPCS DB 연결
			//System.out.println("########## SendSmsAbnormalData 오라클 DB Connection START ##########");
			
			Class.forName(ORACLE_DRIVER);
			oraConn = DriverManager.getConnection(ORACLE_URL, ORACLE_USER, ORACLE_PASS);
			
			// MySQL DB 연결
			Class.forName(MYSQL_DRIVER);
			myConn = DriverManager.getConnection(MYSQL_URL, MYSQL_USER, MYSQL_PASS);
			
			// 1. IP-USN 이상데이터 처리
			ipusnAbnormalDataSend(oraConn, myConn);
			
		} catch(Exception e) {
			e.printStackTrace();
			//System.out.println(" SendSmsAbnormalData 스케줄러 executeInternal() 에러 : " + e.getMessage());
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
	private void ipusnAbnormalDataSend(Connection oraConn, Connection myConn) {
		Statement abnormalStmt = null;
		ResultSet abnormalRs   = null;
		
		try {
			
			StringBuffer abnormalSb = new StringBuffer();
			
			abnormalSb.append("SELECT  T.* \n")
					  .append("		,CASE \n")
					  .append("			WHEN sameYn  = 'Y'  \n")
					  .append("			 AND sameValDurTime/10 <= sameCnt  \n")
					  .append("			 AND sendTimeYn = 'Y'  \n")
					  .append("			THEN 'Y' \n")
					  .append("			WHEN standYn = 'Y'  \n")
					  .append("			 AND gapVl > timeDurVal  \n")
					  .append("			 AND sendTimeYn = 'Y'  \n")
					  .append("			THEN 'Y' \n")
					  .append("			ELSE 'N'  \n")
					  .append("		END AS sendYn \n")
					  .append("		,CASE \n")
					  .append("			WHEN sameYn  = 'Y'  \n")
					  .append("			 AND sameValDurTime/10 <= sameCnt  \n")
					  .append("			 AND sendTimeYn = 'Y'  \n")
					  .append("			THEN '[USN 데이터이상] ' || branchName || '지점 ' || itemName || ' ' || sameCnt*10 || '분 이상 동일값 지속' \n")
					  .append("			WHEN standYn = 'Y'  \n")
					  .append("			 AND gapVl > timeDurVal  \n")
					  .append("			 AND sendTimeYn = 'Y'  \n")
					  .append("			THEN '[USN 데이터이상] ' || branchName || '지점 ' || itemName || ' 이전 데이터 대비 ±' || timeDurVal || '초과(현재:' || minVl || ')' \n")
					  .append("			WHEN sendTimeYn = 'Y' \n")
					  .append("			 AND itemCode = 'PHY00'  \n")
					  .append("			 AND (minVl < stdVl1 OR minVl > stdVl2) \n")
					  .append("			THEN '[USN 데이터이상] ' || branchName || '지점 ' || itemName || ' 경보기준 초과(현재:' || minVl || ')' \n")
					  .append("			WHEN sendTimeYn = 'Y' \n")
					  .append("			 AND itemCode = 'DOW00'  \n")
					  .append("			 AND minVl < stdVl1 \n")
					  .append("			THEN '[USN 데이터이상] ' || branchName || '지점 ' || itemName || ' 경보기준 초과(현재:' || minVl || ')' \n")
					  .append("			WHEN sendTimeYn = 'Y' \n")
					  .append("			 AND itemCode NOT IN ('PHY00', 'DOW00')  \n")
					  .append("			 AND minVl > stdVl1 \n")
					  .append("			THEN '[USN 데이터이상] ' || branchName || '지점 ' || itemName || ' 경보기준 초과(현재:' || minVl || ')' \n")
					  .append("			ELSE ''  \n")
					  .append("		END AS smsMsg \n")
					  .append("  FROM  (   \n")
					  .append("			SELECT  factCode \n")
					  .append("					,branchNo \n")
					  .append("					,branchName \n")
					  .append("					,itemCode \n")
					  .append("					,itemName \n")
					  .append("					,minTime \n")
					  .append("					,minRtime \n")
					  .append("					,minOr \n")
					  .append("					,minDcd \n")
					  .append("					,minVl \n")
					  .append("					,gapVl \n")
					  .append("					,timeDurVal \n")
					  .append("					,sameValDurTime \n")
					  .append("					,standYn \n")
					  .append("					,sameYn \n")
					  .append("					,chkDelay \n")
					  .append("					,sendTimeYn \n")
					  .append("					,STD.SIGN1	  AS sign1 \n")
					  .append("					,STD.STD_VL1	AS stdVl1 \n")
					  .append("					,STD.SIGN2	  AS sign2 \n")
					  .append("					,STD.STD_VL2	AS stdVl2 \n")
					  .append("					,ROW_NUMBER() OVER(PARTITION BY factCode, branchNo, itemCode, part ORDER BY factCode, branchNo, minTime) AS sameCnt \n")
					  .append("			  FROM  ( \n")
					  .append("						SELECT  factCode \n")
					  .append("								,branchNo \n")
					  .append("								,branchName \n")
					  .append("								,T1.itemCode \n")
					  .append("								,itemName \n")
					  .append("								,minTime \n")
					  .append("								,minRtime \n")
					  .append("								,minOr \n")
					  .append("								,minDcd \n")
					  .append("								,minVl \n")
					  .append("								,ABS(preVl-minVl)	   AS gapVl \n")
					  .append("								,T2.TIME_DUR_VAL		AS timeDurVal \n")
					  .append("								,T2.SAME_VAL_DUR_TIME   AS sameValDurTime \n")
					  .append("								,T2.STAND_YN			AS standYn \n")
					  .append("								,T2.SAME_YN			 AS sameYn \n")
					  .append("								,chkDelay \n")
					  .append("								,CASE \n")
					  .append("									WHEN notSend > 0 THEN 'N' \n")
					  .append("									ELSE 'Y' \n")
					  .append("								END AS sendTimeYn \n")
					  .append("								,SUM(LAG_VAL) OVER(PARTITION BY factCode, branchNo, itemCode ORDER BY factCode, branchNo, minTime DESC) AS part \n")
					  .append("						  FROM  (				 \n")
					  .append("									SELECT  FACT_CODE   AS factCode \n")
					  .append("											,BRANCH_NO  AS branchNo \n")
					  .append("											,( \n")
					  .append("												SELECT  BRANCH_NAME \n")
					  .append("												  FROM  T_FACT_BRANCH_INFO \n")
					  .append("												 WHERE  FACT_CODE = T_MIN_DATA.FACT_CODE \n")
					  .append("												   AND  BRANCH_NO = T_MIN_DATA.BRANCH_NO \n")
					  .append("											) AS branchName \n")
					  .append("											,ITEM_CODE  AS itemCode \n")
					  .append("											,( \n")
					  .append("												SELECT  ITEM_NAME  \n")
					  .append("												  FROM  T_ITEM_INFO  \n")
					  .append("												 WHERE  ITEM_CODE = T_MIN_DATA.ITEM_CODE \n")
					  .append("											) AS itemName  \n")
					  .append("											,MIN_TIME   AS minTime \n")
					  .append("											,MIN_RTIME  AS minRtime \n")
					  .append("											,MIN_OR	 AS minOr \n")
					  .append("											,MIN_DCD	AS minDcd \n")
					  .append("											,MIN_VL	 AS minVl \n")
					  .append("											,TO_CHAR(TO_DATE(MIN_RTIME,'YYYYMMDDHH24MI')-60/24/60/60 * FN_GET_CHK_DELAY(105, FACT_CODE, BRANCH_NO), 'YYYYMMDDHH24MI') AS chkDelay \n")
					  .append("											,( \n")
					  .append("												SELECT  INSTR(NOT_SEND,TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))) \n")
					  .append("												  FROM  T_SMS_BRANCH_CONF \n")
					  .append("												 WHERE  DET_CODE  = 105  \n")
					  .append("												   AND  FACT_CODE = T_MIN_DATA.FACT_CODE  \n")
					  .append("												   AND  BRANCH_NO = T_MIN_DATA.BRANCH_NO \n")
					  .append("											) AS notSend \n")
					  .append("											,LAG(MIN_VL) OVER(PARTITION BY FACT_CODE, BRANCH_NO, ITEM_CODE ORDER BY FACT_CODE, BRANCH_NO, MIN_TIME) AS preVl \n")
					  .append("											,DECODE(LAG(MIN_VL) OVER(PARTITION BY FACT_CODE, BRANCH_NO, ITEM_CODE ORDER BY FACT_CODE, BRANCH_NO, MIN_TIME DESC), MIN_VL, 0, 1) LAG_VAL \n")
					  .append("									  FROM  T_MIN_DATA  \n")
					  .append("									 WHERE  FACT_CODE IN (SELECT FACT_CODE FROM T_FACT_INFO WHERE SYS_KIND='U' AND FACT_USE_FLAG = 'Y')  \n")
					  .append("									   AND  ITEM_CODE IN ( \n")
					  .append("															SELECT  ITEM_CODE \n")
					  .append("															  FROM  ( \n")
					  .append("																		SELECT  GROUP_CODE \n")
					  .append("																		  FROM  T_SYSTEM_GROUP \n")
					  .append("																		 WHERE  SYS_CODE IN ( \n")
					  .append("																								SELECT  SYS_CODE \n")
					  .append("																								  FROM  T_SYSTEM \n")
					  .append("																								 WHERE  SYS_TYPE = 'U' \n")
					  .append("																								   AND  SYS_FLAG = 'Y' \n")
					  .append("																							) \n")
					  .append("																	) T1, \n")
					  .append("																	T_FACT_MEASU_GROUP_ITEM T2 \n")
					  .append("															 WHERE  T1.GROUP_CODE = T2.GROUP_CODE \n")
					  .append("														) \n")
					  .append("									   AND  MIN_TIME <= TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI') \n")
					  .append("									   AND  MIN_TIME >= TO_CHAR(SYSDATE-60/24/60*3, 'YYYYMMDDHH24MI')							   \n")
					  .append("									 ORDER  BY FACT_CODE, BRANCH_NO, ITEM_CODE, MIN_TIME DESC \n")
					  .append("								) T1, \n")
					  .append("								T_ITEM_INFO_ADD T2			 \n")
					  .append("						 WHERE  T1.itemCode = T2.ITEM_CODE \n")
					  .append("						   AND  minTime >= chkDelay  \n")
					  .append("					) TBL, \n")
					  .append("					T_BRANCH_ITEM_STANDARD STD \n")
					  .append("			 WHERE  TBL.factCode = STD.FACT_CODE \n")
					  .append("			   AND  TBL.branchNo = STD.BRANCH_NO \n")
					  .append("			   AND  TBL.itemCode = STD.ITEM_CODE	\n")
					  .append("		) T \n")
					  .append(" WHERE  minDcd  = '1' \n")
					  .append(" ORDER  BY factcode, branchno, minTime DESC ");
			
			abnormalStmt = oraConn.createStatement();
			
			abnormalRs = abnormalStmt.executeQuery(abnormalSb.toString());
			
			while(abnormalRs.next()) {
				
				// SMS 보낼수 있는 경우에만 SMS 전송한다.
				if("Y".equals(abnormalRs.getString("sendYn"))) {
					
					Map<String, String> smsMap = new HashMap<String, String>();
					
					// SMS 변수 셋팅
					smsMap.put("factCode",   abnormalRs.getString("factCode"));
					smsMap.put("factName",   abnormalRs.getString("branchName"));
					smsMap.put("branchNo",   abnormalRs.getString("branchNo"));
					smsMap.put("branchName", abnormalRs.getString("branchName"));
					smsMap.put("minTime",	abnormalRs.getString("minTime"));
					smsMap.put("smsMsg", 	 abnormalRs.getString("smsMsg"));
					
					// SMS 발송 : MySQL 테이블에 등록처리
					insertSmsMessage(smsMap, oraConn, myConn);
				}
				
				// MIN_DCD = '0' 로 업데이트 처리
				
					
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			//System.out.println("SendSmsAbnormalData 스케줄러 ipusnAbnormalDataSend() 에러 : " + e.getMessage());
		} finally {
			try{
				if(abnormalStmt != null) abnormalStmt.close();
				if(abnormalRs   != null) abnormalRs.close();
			}catch(SQLException se){
				se.printStackTrace();
			}
		}
	}
	
	/**
	 * SMS발송
	 * @param params
	 * @param smsMsg
	 */
	private void insertSmsMessage(Map<String, String> params, Connection oraConn, Connection myConn){
		//System.out.println(">>>>>>>>>>>>>>>> insertSmsMessage START <<<<<<<<<<<<<<<<<<<<<<<<<");
		PreparedStatement pstmt	= null;
		PreparedStatement pstmt2	= null;
		ResultSet		  targetRs = null;
		
		try {
			// SMS 추가 변수 설정
			params.put("itemCode", "ABNOR");
			params.put("subject",  "이상데이터전파");
			params.put("callBack", "1666-0128");

			StringBuffer targetSql = new StringBuffer();
			targetSql.append("SELECT  ( \n")
					 .append("		   SELECT   TRIM (SUBSTR (MAX (SYS_CONNECT_BY_PATH (DEPT_NAME, ' > ')), 4)) \n")
					 .append("			 FROM   T_DEPT_INFO  \n")
					 .append("			WHERE   DEPT_CODE = M.DEPT_CODE \n")
					 .append("			START   WITH UPPER_DEPT_CODE = '0' \n")
					 .append("		  CONNECT   BY PRIOR DEPT_CODE = UPPER_DEPT_CODE \n")
					 .append("		) AS atPart \n")
					 .append("		,(SELECT DECODE(UPPER_DEPT_CODE, 8000, 1, 0) FROM T_DEPT_INFO WHERE DEPT_CODE = M.DEPT_CODE) as atPartGubun \n")
					 .append("		,M.MEMBER_NAME AS atName \n")
					 .append("		,M.MOBILE_NO   AS atSmsTele \n")
					 .append("  FROM  T_MEMBER M \n")
					 .append("		,T_SMS_TARGET S \n")
					 .append(" WHERE  1 = 1 \n")
					 .append("   AND  M.MEMBER_ID = S.MEMBER_ID \n")
					 .append("   AND  S.DET_CODE  = 105  \n")
					 .append("   AND  S.RECV_TYPE = 'C'		  \n")
					 .append("   AND  S.USE_FLAG  = 'Y' \n")
					 .append(" UNION  ALL \n")
					 .append("SELECT  ( \n")
					 .append("		   SELECT   TRIM (SUBSTR (MAX (SYS_CONNECT_BY_PATH (DEPT_NAME, ' > ')), 4)) \n")
					 .append("			 FROM   T_DEPT_INFO  \n")
					 .append("			WHERE   DEPT_CODE = M.DEPT_CODE \n")
					 .append("			START   WITH UPPER_DEPT_CODE = '0' \n")
					 .append("		  CONNECT   BY PRIOR DEPT_CODE = UPPER_DEPT_CODE \n")
					 .append("		) AS atPart \n")
					 .append("		,(SELECT DECODE(UPPER_DEPT_CODE, 8000, 1, 0) FROM T_DEPT_INFO WHERE DEPT_CODE = M.DEPT_CODE) as atPartGubun \n")
					 .append("		,M.MEMBER_NAME \n")
					 .append("		,M.MOBILE_NO \n")
					 .append("  FROM  T_MEMBER M \n")
					 .append("		,T_SMS_TARGET S \n")
					 .append(" WHERE  1 = 1 \n")
					 .append("   AND  M.MEMBER_ID = S.MEMBER_ID \n")
					 .append("   AND  S.DET_CODE  = 105		  \n")
					 .append("   AND  S.FACT_CODE = ? \n")
					 .append("   AND  S.BRANCH_NO = ? \n")
					 .append("   AND  S.RECV_TYPE = 'B' \n")
					 .append("   AND  S.USE_FLAG  = 'Y' ");
			
			//System.out.println("targetSql >>> " + targetSql.toString());
			
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
			
			//System.out.println("smsSql >>> " + smsSql.toString());
			
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
			//System.out.println(" SendSmsAbnormalData 스케줄러 insertSmsMessage() 에러 : " + e.getMessage());
		} finally {
			try{
				if(targetRs != null) targetRs.close();
				if(pstmt	!= null) pstmt.close();
				if(pstmt2   != null) pstmt2.close();
			}catch(SQLException se){
				se.printStackTrace();
			}
		}
	}
	
}
