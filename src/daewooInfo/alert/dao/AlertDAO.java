package daewooInfo.alert.dao;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSmsListSearchVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.bean.AlertStepVO; 

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. loafzzang.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 3. 26  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

@Repository("alertDAO")
public class AlertDAO {
	
	/**
	 * @uml.property  name="sqlMapClientMySql"
	 * @uml.associationEnd  
	 */
	@Resource(name = "sqlMapClientMySql")
	private SqlMapClient sqlMapClientMySql;

	/**
	 * mySql 사용을 위한 설정
	 * @param  sqlMapClientMySql
	 * @uml.property  name="sqlMapClientMySql"
	 */
	public void setSqlMapClientMySql(SqlMapClient sqlMapClientMySql) {
		this.sqlMapClientMySql = sqlMapClientMySql;
	}
	
	/**
	 * 경보 발령 목록을 가져온다.
	 * 
	 * @param AlertSmsListSearchVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertSmsListVO> getSmsList(AlertSmsListSearchVO alertSearchVO) throws Exception { 
		return sqlMapClientMySql.queryForList("alertDAO.getSmsList", alertSearchVO);
	}
	/**
	 * 경보 발령 목록수를 가져온다.
	 * 
	 * @param AlertSmsListSearchVO
	 * @return
	 * @throws Exception
	 */
	public int getSmsListCount(AlertSmsListSearchVO vo) throws Exception {  
		return ((Integer)sqlMapClientMySql.queryForObject("alertDAO.getSmsListCount", vo)).intValue(); 
	} 
	/**
	 * SMS경보를 생성한다.
	 * 
	 * @param alertDataVO
	 * @throws Exception
	 */
	public void insertSmsSend(AlertDataVO alertDataVO) throws Exception {
		sqlMapClientMySql.insert("alertDAO.insertSmsSend", alertDataVO);
	}
	
	/**
	 * ACS경보를 생성한다.
	 * 
	 * @param alertDataVO
	 * @throws Exception
	 */
	public void insertVmsSend(AlertDataVO alertDataVO) throws Exception {
		sqlMapClientMySql.insert("alertDAO.insertVmsSend", alertDataVO);
	}
	
	
	/**
	 * 
	 * @param alertDataVO
	 * @param atSmsTele
	 * @return
	 * @throws SQLException
	 */
	public int sendSmsCycleCheck(AlertDataVO alertDataVO) throws Exception {
		return ((Integer)sqlMapClientMySql.queryForObject("alertDAO.sendSmsCycleCheck", alertDataVO)).intValue(); 
		
	}
	
}