package daewooInfo.mock.service;

import java.util.List;

import daewooInfo.mock.bean.AnalysisVO;
import daewooInfo.mock.bean.ErrorCodeVO;
import daewooInfo.mock.bean.MockVO;

public interface MockService {
	public List<MockVO> getPointList(MockVO vo) throws Exception;
	
	public MockVO getFlow(MockVO vo) throws Exception;
	
	public MockVO getPointFlow(MockVO vo) throws Exception;
	
	public List<MockVO> getMockTestList(MockVO vo) throws Exception;
	
	public MockVO getMockTest(MockVO vo) throws Exception;
	
	public List<MockVO> getMockSection(MockVO vo) throws Exception;
	
	public List<MockVO> getMockPoint(MockVO vo) throws Exception;
	
	public int getMockTestCnt(MockVO vo) throws Exception;
	
	public int getMockTestPk() throws Exception;
	
	public int saveMockTest(MockVO vo) throws Exception;
	
	public int saveMockSection(MockVO vo) throws Exception;
	
	public int saveMockPoint(MockVO vo) throws Exception;
	
	public int delMockTest(MockVO vo) throws Exception;
	
	public int delMockSection(MockVO vo) throws Exception;

	public int delMockPoint(MockVO vo) throws Exception;
	
	public void insertDayLog(AnalysisVO vo) throws Exception;
	
	public void updateDayLog(AnalysisVO vo) throws Exception;
	
	public List<AnalysisVO> getDayLogList(AnalysisVO vo) throws Exception;
	
	public Integer getDayLogList_cnt(AnalysisVO vo) throws Exception;
	
	public AnalysisVO getDayLogDetail(AnalysisVO vo) throws Exception;
	
	public List<AnalysisVO> getTrans(AnalysisVO vo) throws Exception;

	public List<AnalysisVO> getRainfall(AnalysisVO vo) throws Exception;
	
	public Integer getTransCnt(AnalysisVO vo) throws Exception;
	
	public List<AnalysisVO> getSpread(AnalysisVO vo) throws Exception;
	
	public List<ErrorCodeVO> getErrorCode() throws Exception;
	
	public void saveDaylogDet(AnalysisVO vo) throws Exception;
	
	public void deleteDaylogDet(AnalysisVO vo) throws Exception;
	
	public void saveDaylogSpread(AnalysisVO vo) throws Exception;
	
	public void updateDaylogSpread(AnalysisVO vo) throws Exception;
	
	public List<AnalysisVO> getDaylogSpreadList(AnalysisVO vo) throws Exception;
	
	public Integer getDaylogSpreadCnt(AnalysisVO vo) throws Exception;
	
	public void completeDaylog(AnalysisVO vo) throws Exception;
}

