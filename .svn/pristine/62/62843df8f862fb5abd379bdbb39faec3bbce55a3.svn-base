package daewooInfo.cmmn.service;

import java.util.List;
import java.util.Map;

import daewooInfo.cmmn.bean.CmnLogCounterVO;
import daewooInfo.cmmn.bean.ReportVO;

/**
 * @author  hyun
 */
public interface CmnLogCounterService {
	public void addLogCount(CmnLogCounterVO vo) throws Exception;
	public List getLogCount(Map map) throws Exception;
	public List getLogList(Map map) throws Exception;
	/**
	 * @uml.property  name="totalLogCounter"
	 */
	public List getTotalLogCounter() throws Exception;
	public List getAvgPage(Map map) throws Exception;
	public int saveWeblogReport(ReportVO reportVO) throws Exception;
	public List getWeblogReportList(ReportVO reportVO) throws Exception;
	public List getLoginCountChart(CmnLogCounterVO cmnLogCounterVO);
}
