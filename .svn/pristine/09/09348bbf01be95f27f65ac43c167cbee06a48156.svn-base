package daewooInfo.alert.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertTaksuConfigVO;
import daewooInfo.alert.dao.AlertTaksuConfigDAO;
import daewooInfo.alert.service.AlertTaksuConfigService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("alertTakSuConfigService")
public class AlertTaksuConfigServiceImpl extends AbstractServiceImpl  implements AlertTaksuConfigService{
	
	/**
	 * @uml.property  name="alertTaksuConfigDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertTaksuConfigDAO")
    private AlertTaksuConfigDAO alertTaksuConfigDAO;	

	public List<AlertTaksuConfigVO> getAlertTaksuConfig() throws Exception {
		return alertTaksuConfigDAO.getAlertTaksuConfig();
	}

	public int mergeAlertTaksuConfig(AlertTaksuConfigVO vo) throws Exception {
		return alertTaksuConfigDAO.mergeAlertTaksuConfig(vo);
	}

	public List<AlertTaksuConfigVO> getAlertTaksuConfigHist(AlertSearchVO vo)
			throws Exception {
		return alertTaksuConfigDAO.getAlertTaksuConfigHist(vo);
	}

	public int insertAlertTaksuConfigHist(AlertTaksuConfigVO vo)
			throws Exception {
		return alertTaksuConfigDAO.insertAlertTaksuConfigHist(vo);
	}

}
