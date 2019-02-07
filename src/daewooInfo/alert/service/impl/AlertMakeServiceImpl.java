package daewooInfo.alert.service.impl;

import java.util.List;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSmsListSearchVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertHourVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.alert.service.AlertMakeService;
import daewooInfo.cmmn.bean.FileVO;
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

@Service("alertMakeService")
public class AlertMakeServiceImpl extends AbstractServiceImpl implements AlertMakeService {
	
	/**
	 * @uml.property  name="alertMakeDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertMakeDAO")
    private AlertMakeDAO alertMakeDAO;
	
	
    /**
     * 새로 들어온 분 데이터를 가져온다.
     * 
     * @see daewooInfo.alert.service.AlertMakeService#getMinList()
     */
    public List<AlertMinVO> getMinList() throws Exception{
        return alertMakeDAO.getMinList();
    }
    
    /**
     * 새로 들어온 시간 데이터를 가져온다. (미사용)
     * 
     * @see daewooInfo.alert.service.AlertMakeService#getHourList()
     */
    public List<AlertHourVO> getHourList() throws Exception{
        return alertMakeDAO.getHourList();
    }
    
    /**
	 * 보내는 사람의 번호를 가져온다. 방제센터 번호
	 * 
     * @see daewooInfo.alert.service.AlertMakeService#getCallBack(daewooInfo.alert.bean.AlertSearchVO)
     */
    public AlertCallBackVO getCallBack(AlertSearchVO alertSearchVO) throws Exception {
		return alertMakeDAO.getCallBack(alertSearchVO);
	}
    
	/**
	 * 경보 기준을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#getLaw(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public AlertLawVO getLaw(AlertSearchVO alertSearchVO) throws Exception{
        return alertMakeDAO.getLaw(alertSearchVO);
    }
	
	/**
	 * 공구,사업장의 이름을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#getFactName(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public String getFactName(AlertSearchVO alertSearchVO) throws Exception{
		return alertMakeDAO.getFactName(alertSearchVO);
	}	
	
	/**
	 * 측정항목의 이름을 가져온다.
	 *
	 * @see daewooInfo.alert.service.AlertMakeService#getItemName(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public String getItemName(AlertSearchVO alertSearchVO) throws Exception{
		return alertMakeDAO.getItemName(alertSearchVO);
	}
	
	/**
	 * 경보 환경 설정을 가져온다.
	 *
	 * @see daewooInfo.alert.service.AlertMakeService#getConfig(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public AlertConfigVO getConfig(AlertSearchVO alertSearchVO) throws Exception{
        return alertMakeDAO.getConfig(alertSearchVO);
    }
	
	/**
	 * 경보 발송 대상자를 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#getTargetList(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public List<AlertTargetVO> getTargetList(AlertSearchVO alertSearchVO) throws Exception{
        return alertMakeDAO.getTargetList(alertSearchVO);
    }
	

	/**
	 * 수동 경보 발송 대상자를 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#getTargetManualList(java.util.HashMap)
	 */
	public List<AlertTargetVO> getTargetManualList(HashMap map) throws Exception{
		return alertMakeDAO.getTargetManualList(map);
	}
	
	/**
	 * 오염 판단이 끝난 자료를 업데이트한다.(min_dcd=0) 
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#updateMin()
	 */
	public int updateMin() throws Exception {
		return alertMakeDAO.updateMin();
	}
	
	/**
	 * 오염 단계를 분자료 테이블에 업데이트한다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#updateMinOr(java.util.HashMap)
	 */
	@SuppressWarnings("unchecked")
	public int updateMinOr(HashMap paramMap) throws Exception {
		return alertMakeDAO.updateMinOr(paramMap);
	}
	
	/**
	 * SMS 발송 메세지 내역을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#getSendSmsMsgList(java.util.HashMap)
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap> getSendSmsMsgList(HashMap map) throws Exception {
		return alertMakeDAO.getSendSmsMsgList(map);
	}	

	/**
	 * SMS 발송 메세지를 저장한다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#saveSmsMsgList(java.util.HashMap)
	 */
	@SuppressWarnings("unchecked")
	public int saveSmsMsgList(HashMap map) throws Exception {
		return alertMakeDAO.saveSmsMsgList(map);
	}
	/**
	 * 사고접수 발송 대상자를 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMakeService#getTargetSmSList(java.util.HashMap)
	 */
	public List<AlertTargetVO> getTargetSmSList(HashMap map) throws Exception {
		return alertMakeDAO.getTargetSmSList(map);
	}

	public String saveSmsMsgHist(HashMap map) throws Exception {
		return alertMakeDAO.saveSmsMsgHist(map);
	}

	public void saveSmsMsgHistDetail(HashMap map) throws Exception {
		alertMakeDAO.saveSmsMsgHistDetail(map);		
	}

	public List<HashMap> getSendSmsMsgMemberList(HashMap map) throws Exception {
		return alertMakeDAO.getSendSmsMsgMemberList(map);
	}

	/* SMS 발송 이력을 가져온다.
	 * (non-Javadoc)
	 * @see daewooInfo.alert.service.AlertMakeService#getSmsDataList(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public List<AlertSmsListVO> getSmsDataList(AlertSmsListSearchVO alertSmsListSearchVO)
			throws Exception{
		return alertMakeDAO.getSmsDataList(alertSmsListSearchVO);
	}

	/* SMS 발송 이력 카운트
	 * (non-Javadoc)
	 * @see daewooInfo.alert.service.AlertMakeService#getSmsDataListCount(daewooInfo.alert.bean.AlertSmsListSearchVO)
	 */
	public int getSmsDataListCount(AlertSmsListSearchVO alertSmsListSearchVO)
			throws Exception {
		return alertMakeDAO.getSmsDataListCount(alertSmsListSearchVO);
	} 
	
	public String getAddressFileSeq(HashMap map)
			throws Exception {
		return alertMakeDAO.getAddressFileSeq(map);
	} 
	
	public void insertAddressFileInfs(List<FileVO> result) throws Exception {
		if (result.size() != 0) {
			alertMakeDAO.insertAddressFileInfs(result);
		} 
	}
}