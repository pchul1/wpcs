package daewooInfo.alert.service;

import java.util.List;

import daewooInfo.alert.bean.AlertDataVO; 
import daewooInfo.alert.bean.AlertSmsListSearchVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.bean.AlertStepVO;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
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

public interface AlertService {
	
	/**
	 * 경보 발령 목록카운트 
	 *  
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public int getSmsListCount(AlertSmsListSearchVO vo) throws Exception; 
	
	/**
	 * 경보 발령 목록을 가져온다.
	 *  
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertSmsListVO> getSmsList(AlertSmsListSearchVO alertSearchVO) throws Exception;
	/**
	 * 경보를 생성한다.
	 * 
	 * @param alertDataVO
	 * @throws Exception
	 */
	public void insertSmsSend (AlertDataVO alertDataVO) throws Exception;
	
}