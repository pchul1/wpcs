package daewooInfo.cmmn.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import daewooInfo.cmmn.bean.CmnLogCounterVO;
import daewooInfo.cmmn.bean.ReportVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("cmnLogCounterDAO")
public class CmnLogCounterDAO extends EgovAbstractDAO {
	
	@SuppressWarnings("unchecked")
    public void addLog(CmnLogCounterVO vo) throws Exception {
		insert("CmnLogCounterDAO.insertCmnLog", vo);
    }
	
	@SuppressWarnings("unchecked")
    public List getLogCount(Map map) throws Exception {
		return list("CmnLogCounterDAO.selectCmnLogCount", map);
    }
	
	@SuppressWarnings("unchecked")
    public List getLogList(Map map) throws Exception {
		return list("CmnLogCounterDAO.selectCmnLogList", map);
    }
	@SuppressWarnings("unchecked")
	public List getTotalLogCounter() throws Exception {
		Map map = null;
		return list("CmnLogCounterDAO.selectCmnLogCount",map);
	}
	@SuppressWarnings("unchecked")
	public List getAvgPage(Map map) throws Exception {
		return list("CmnLogCounterDAO.getAvgPage",map);
	}
	
	@SuppressWarnings("unchecked")
	public int saveWeblogReport(ReportVO reportVO) throws Exception {
		return update("CmnLogCounterDAO.saveWeblogReportCmnLog",reportVO);
	}
	@SuppressWarnings("unchecked")
	public List getWeblogReportList(ReportVO reportVO) throws Exception {
		return list("CmnLogCounterDAO.getWeblogReportListCmnLog",reportVO);
	}	

	@SuppressWarnings("unchecked")
	public List getLoginCountChart(CmnLogCounterVO cmnLogCounterVO) {
		return list("CmnLogCounterDAO.getLoginCountChart",cmnLogCounterVO);
	}
}
