package daewooInfo.cmmn.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.cmmn.bean.MainweatherAreaVO;
import daewooInfo.cmmn.dao.TmsComUtlDAO;
import daewooInfo.cmmn.service.TmsComUtlService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("TmsComUtlService")
public class TmsComUtlServiceImpl extends AbstractServiceImpl implements TmsComUtlService {

    /**
	 * @uml.property  name="tmsComUtlDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "tmsComUtlDAO")
    private TmsComUtlDAO tmsComUtlDAO;

	public List<Map<String,String>> todayAccident() throws Exception {
		return tmsComUtlDAO.todayAccident();
	}
	
	public List<MainweatherAreaVO> weatherAreaInfo(String river_id) throws Exception {
		return tmsComUtlDAO.weatherAreaInfo(river_id);
	}	

	public List<Map<String, String>> getCode(String code_id) throws Exception {
		return tmsComUtlDAO.getCode(code_id);
	}

	public List<DeptVO> deptTree() throws Exception {
		return tmsComUtlDAO.deptTree();
	}
}
