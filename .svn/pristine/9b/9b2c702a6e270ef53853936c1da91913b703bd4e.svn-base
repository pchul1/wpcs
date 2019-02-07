package daewooInfo.alert.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertTargetDAO;
import daewooInfo.alert.service.AlertTargetService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 전파대상관리를 위한 서비스 구현 클래스
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
@Service("alertTargetService")
public class AlertTargetServiceImpl extends AbstractServiceImpl implements AlertTargetService {
	
	/**
	 * @uml.property  name="alertTargetDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertTargetDAO")
	private AlertTargetDAO alertTargetDAO;	

	/**
	 * 전파대상 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#getAlertTargetList(daewooInfo.alert.bean.AlertTargetVO)
	 */
	public List<AlertTargetVO> getAlertTargetList(AlertTargetVO vo) throws Exception{
		return alertTargetDAO.getAlertTargetList(vo);
	}
	
	/**
	 * 해당하는 전파대상을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#getAlertTarget(daewooInfo.alert.bean.AlertTargetVO)
	 */
	public AlertTargetVO getAlertTarget(AlertTargetVO vo) throws Exception{
		return alertTargetDAO.getAlertTarget(vo);
	}

	/**
	 * 전파대상을 추가하거나 갱신한다.
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#mergeAlertTarget(daewooInfo.alert.bean.AlertTargetVO)
	 */
	public int mergeAlertTarget(AlertTargetVO vo) throws Exception {
		return alertTargetDAO.mergeAlertTarget(vo);
	}

	/**
	 * 전파대상을 삭제한다.
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#deleteAlertTarget(daewooInfo.alert.bean.AlertTargetVO)
	 */
	public int deleteAlertTarget(AlertTargetVO vo) throws Exception {
		return alertTargetDAO.deleteAlertTarget(vo);
	}	
	
	/**
	 * 전파대상의 PK를 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#getAlertTargetPk()
	 */
	public int getAlertTargetPk() throws Exception{
		return alertTargetDAO.getAlertTargetPk();
	}	
	
	/**
	 * 전파대상에 추가할 사용자 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#getAlertTargetUser()
	 */
	public List<HashMap<String, String>> getAlertTargetUser() throws Exception{
		return alertTargetDAO.getAlertTargetUser();
	}	

	/**
	 * 이미 추가된 사용자인지 체크한다
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#getAlertTargetUserCheck()
	 */
	public int getAlertTargetUserCheck(AlertTargetVO vo) throws Exception {
		return alertTargetDAO.getAlertTargetUserCheck(vo);
	}
	
	/**
	 * 공구와 측정소에 해당하는 조직 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertTargetService#getGroupList(java.util.HashMap)
	 */
	public List<HashMap<String, String>> getGroupList(HashMap<String, String> map) throws Exception {
		return alertTargetDAO.getGroupList(map);
	}
	
	public List<HashMap<String, String>> getGroupAndMember(AlertTargetVO vo) throws Exception {
		return alertTargetDAO.getGroupAndMember(vo);
	}
	
	public List<HashMap<String, String>> getSmsGroupList() throws Exception {
		return alertTargetDAO.getSmsGroupList();
	}	
	
	public List<HashMap<String, String>> getSmsMemberList(AlertTargetVO alertTargetVO) throws Exception {
		return alertTargetDAO.getSmsMemberList(alertTargetVO);
	}
	
	public List<HashMap<String, String>> getSmsGroupListMobile(AlertTargetVO alertTargetVO) throws Exception {
		return alertTargetDAO.getSmsGroupListMobile(alertTargetVO);
	}
}
