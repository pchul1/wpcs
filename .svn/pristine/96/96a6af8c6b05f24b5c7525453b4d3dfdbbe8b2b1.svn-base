package daewooInfo.alert.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSmsListSearchVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.service.AlertService;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

import javax.annotation.Resource;

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

@Service("alertService")
public class AlertServiceImpl extends AbstractServiceImpl implements AlertService {
	
	/**
	 * @uml.property  name="alertDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertDAO")
	private AlertDAO alertDAO;
	
	/**
	 * 경보 발송 목록수 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertService#getSmsList(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public int getSmsListCount(AlertSmsListSearchVO vo) throws Exception { 
		return alertDAO.getSmsListCount(vo);
	} 
	/**
	 * 경보 발송 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertService#getSmsList(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public List<AlertSmsListVO> getSmsList(AlertSmsListSearchVO alertSearchVO) throws Exception{
		return alertDAO.getSmsList(alertSearchVO);
	}
		
	/**
	 * 경보를 생성한다.
	 * 
	 * @see daewooInfo.alert.service.AlertService#insertSmsSend(daewooInfo.alert.bean.AlertDataVO)
	 */
	public void insertSmsSend (AlertDataVO alertDataVO) throws Exception{
		alertDAO.insertSmsSend(alertDataVO);
	}

	
}