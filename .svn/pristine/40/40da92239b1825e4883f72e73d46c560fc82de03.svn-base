package daewooInfo.cmmn.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import daewooInfo.cmmn.bean.CmnLogCounterVO;
import daewooInfo.cmmn.bean.ReportVO;
import daewooInfo.cmmn.dao.CmnLogCounterDAO;
import daewooInfo.cmmn.service.CmnLogCounterService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("CmnLogCounterService")
public class CmnLogCounterServiceImpl extends AbstractServiceImpl implements CmnLogCounterService {
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * @uml.property  name="cmnLogCounterDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "cmnLogCounterDAO")
    private CmnLogCounterDAO cmnLogCounterDAO;

	public void addLogCount(CmnLogCounterVO vo) throws Exception {
		log.debug(vo);
		cmnLogCounterDAO.addLog(vo);
	}

	public List getLogCount(Map map) throws Exception {
		log.debug(map);
		return cmnLogCounterDAO.getLogCount(map);
	}

	public List getLogList(Map map) throws Exception {
		log.debug(map);
		return cmnLogCounterDAO.getLogList(map);
	}

	public List getTotalLogCounter() throws Exception {
		return cmnLogCounterDAO.getTotalLogCounter();
	}
	public List getAvgPage(Map map) throws Exception {
		log.debug(map);
		return cmnLogCounterDAO.getAvgPage(map);
	}
	
	public int saveWeblogReport(ReportVO reportVO) throws Exception {
		return cmnLogCounterDAO.saveWeblogReport(reportVO);
	}
	
	public List getWeblogReportList(ReportVO reportVO) throws Exception {
		return cmnLogCounterDAO.getWeblogReportList(reportVO);
	}	

	public List getLoginCountChart(CmnLogCounterVO cmnLogCounterVO) {
		return cmnLogCounterDAO.getLoginCountChart(cmnLogCounterVO);
	}
}