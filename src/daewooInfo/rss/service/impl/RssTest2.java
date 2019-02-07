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

package daewooInfo.rss.service.impl;

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

public class RssTest2 {

	private static Connection oraConn = null;	// 오라클 connection

	private static String ORACLE_DRIVER  = "oracle.jdbc.driver.OracleDriver";
	private static String ORACLE_URL 	 = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.101.164.221)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=WPCS)(SERVER=DEDICATED)))";
	private static String ORACLE_USER	 = "wpcs";
	private static String ORACLE_PASS	 = "wpcs";
	
	
	public static void main(String[] args) throws SQLException, Exception {
		RssTest2 rss = new RssTest2();
		rss.execute();
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
			Class.forName(ORACLE_DRIVER);
			oraConn = DriverManager.getConnection(ORACLE_URL, ORACLE_USER, ORACLE_PASS);
			
			// 1. IP-USN 미수신 측정소 체크
			ipusnNorecvSend(oraConn);
			
		} catch(Exception e) {
			e.printStackTrace();
			//System.out.println(" SendSmsNoRecvData 스케줄러 executeInternal() 에러 : " + e.getMessage());
		} finally {
			try {
                if(oraConn != null) oraConn.close();
            } catch(SQLException se) {
                se.printStackTrace();
            }
		}
	}
	
	
	/**
	 * IP-USN 미수신 측정소 SMS전송
	 */
	private void ipusnNorecvSend(Connection oraConn) {
		Statement noRecvStmt = null;
		ResultSet noRecvRs 	 = null;
		
		try {
			
			StringBuffer noRecvSb = new StringBuffer();
			noRecvSb.append("SELECT  KEYWORD_NM AS keywordNm \n")
					.append("        FROM  T_RSS_KEYWORD \n")
					.append("        WHERE STATUS <> 'D' ");
			
			noRecvStmt = oraConn.createStatement();
			
			noRecvRs = noRecvStmt.executeQuery(noRecvSb.toString());
			
			while(noRecvRs.next()) {
				
					//System.out.println("keyword >> " + noRecvRs.getString("keywordNm"));
					
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
	
}
