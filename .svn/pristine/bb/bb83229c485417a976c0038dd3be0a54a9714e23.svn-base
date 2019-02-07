package daewooInfo.cmmn.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.cmmn.bean.MainweatherAreaVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("tmsComUtlDAO")
public class TmsComUtlDAO extends EgovAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> todayAccident() throws Exception {
    	return list("TmsComUtlDAO.todayAccident", null);
    }
    
    public List<MainweatherAreaVO> weatherAreaInfo(String river_id) throws Exception {
    	return list("TmsComUtlDAO.weatherAreaInfo", river_id);
    }
    
    public List<Map<String,String>> getCode(String code_id) throws Exception {
    	return list("TmsComUtlDAO.getCode", code_id);
    }
    
    public List<DeptVO> deptTree() throws Exception {
    	return list("TmsComUtlDAO.deptTree", null);
    }
}
