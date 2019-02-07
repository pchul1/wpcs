package daewooInfo.alert.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.dao.AlertConfigDAO;
import daewooInfo.alert.service.AlertConfigService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 경보환경설정을 위한 서비스 구현 클래스
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
@Service("alertConfigService")
public class AlertConfigServiceImpl extends AbstractServiceImpl implements AlertConfigService {

	/**
	 * @uml.property  name="alertConfigDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertConfigDAO")
	private AlertConfigDAO alertConfigDAO;	

	/**
	 * 경보환경설정 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertConfigService#getAlertConfigList(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public List<AlertConfigVO> getAlertConfigList(AlertSearchVO vo) throws Exception{
		return alertConfigDAO.getAlertConfigList(vo);
	}

	/**
	 * 경보환경설정을 추가하거나 갱신한다.
	 * 
	 * @see daewooInfo.alert.service.AlertConfigService#mergeAlertConfig(daewooInfo.alert.bean.AlertConfigVO)
	 */
	public int mergeAlertConfig(AlertConfigVO vo) throws Exception {
		return alertConfigDAO.mergeAlertConfig(vo);
	}

	public int updateAlertConfig(AlertConfigVO vo) throws Exception {
		return alertConfigDAO.updateAlertConfig(vo);
	}

	public AlertConfigVO getAlertConfigTimeView() throws Exception{
		return alertConfigDAO.getAlertConfigTimeView();
	}
	
	public int mergeAlertConfigTime(AlertConfigVO vo) throws Exception{
		return alertConfigDAO.mergeAlertConfigTime(vo);
	}
}
