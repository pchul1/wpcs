package daewooInfo.alert.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertMngVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTestVO;
import daewooInfo.alert.dao.AlertMngDAO;
import daewooInfo.alert.service.AlertMngService;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 상황 접수, 전파 일지 관리를 위한 서비스 구현 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
@Service("alertMngService")
public class AlertMngServiceImpl extends AbstractServiceImpl implements AlertMngService {

	/**
	 * @uml.property  name="alertMngDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertMngDAO")
	private AlertMngDAO alertMngDAO;
	
	/**
	 * 일지 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMngService#getAlertMngList(daewooInfo.alert.bean.AlertMngVO)
	 */
	public List<AlertMngVO> getAlertMngList(AlertMngVO vo) throws Exception{
		return alertMngDAO.getAlertMngList(vo);
	}

	/**
	 * 해당 일지를 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMngService#getAlertMng(daewooInfo.alert.bean.AlertMngVO)
	 */
	public AlertMngVO getAlertMng(AlertMngVO vo) throws Exception{
		return alertMngDAO.getAlertMng(vo);
	}
	
	/**
	 * 해당 일지를 추가하거나 갱신한다.
	 * 
	 * @see daewooInfo.alert.service.AlertMngService#mergeAlertMng(daewooInfo.alert.bean.AlertMngVO)
	 */
	public int mergeAlertMng(AlertMngVO vo) throws Exception{		
		return alertMngDAO.mergeAlertMng(vo);
	}		
	
	/**
	 * 해당 일지를 삭제한다.
	 * 
	 * @see daewooInfo.alert.service.AlertMngService#deleteAlertMng(daewooInfo.alert.bean.AlertMngVO)
	 */
	public int deleteAlertMng(AlertMngVO vo) throws Exception{
		return alertMngDAO.deleteAlertMng(vo);
	}
	
	/**
	 * 일지의 PK를 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMngService#getAlertMngPk()
	 */
	public int getAlertMngPk() throws Exception{
		return alertMngDAO.getAlertMngPk();
	}
	
	/**
	 * 일지의 갯수를 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMngService#getAlertMngCnt()
	 */
	public int getAlertMngCnt() throws Exception{
		return alertMngDAO.getAlertMngCnt();
	}	
	
	/**
	 * 해당일지에서 전파하는 조직 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertMngService#getAlertMngSpreadDept(daewooInfo.alert.bean.AlertMngVO)
	 */
	public String getAlertMngSpreadDept(AlertMngVO vo) throws Exception{
		return alertMngDAO.getAlertMngSpreadDept(vo);
	}
 
	/* (non-Javadoc) 탁수정보 테스트
	 * @see daewooInfo.alert.service.AlertMngService#getTaksuTest(daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO)
	 */
	public List<AlertTestVO> getTaksuTest(AlertTestVO vo) throws Exception { 
		return alertMngDAO.getTaksuTest(vo);
	}

	public int alertMngHistDelete(AlertStepVO alertStepVO) throws Exception {
		return alertMngDAO.alertMngHistDelete(alertStepVO);
	}		
}
