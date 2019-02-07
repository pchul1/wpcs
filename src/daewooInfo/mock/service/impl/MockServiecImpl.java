package daewooInfo.mock.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.mock.bean.AnalysisVO;
import daewooInfo.mock.bean.ErrorCodeVO;
import daewooInfo.mock.bean.MockVO;
import daewooInfo.mock.dao.MockDAO;
import daewooInfo.mock.service.MockService;

@Service("mockService")
public class MockServiecImpl implements MockService{
	
	/**
	 * @uml.property  name="mockDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "mockDAO")
	private MockDAO mockDAO;
	
	public List<MockVO> getPointList(MockVO vo) {
		return mockDAO.getPointList(vo);
	}
	
	public MockVO getFlow(MockVO vo) {
		return mockDAO.getFlow(vo);
	}	
	
	public MockVO getPointFlow(MockVO vo) {
		return mockDAO.getPointFlow(vo);
	}	
	
	public List<MockVO> getMockTestList(MockVO vo) {
		return mockDAO.getMockTestList(vo);
	}
	
	public MockVO getMockTest(MockVO vo) {
		return mockDAO.getMockTest(vo);
	}
	
	public List<MockVO> getMockSection(MockVO vo) {
		return mockDAO.getMockSection(vo);
	}
	
	public List<MockVO> getMockPoint(MockVO vo) {
		return mockDAO.getMockPoint(vo);
	}

	public int getMockTestCnt(MockVO vo) throws Exception {
		return mockDAO.getMockTestCnt(vo);
	}

	public int getMockTestPk() throws Exception {
		return mockDAO.getMockTestPk();
	}
	
	public int saveMockTest(MockVO vo) throws Exception {
		return mockDAO.saveMockTest(vo);
	}	
	
	public int saveMockSection(MockVO vo) throws Exception {
		return mockDAO.saveMockSection(vo);
	}	
	
	public int saveMockPoint(MockVO vo) throws Exception {
		return mockDAO.saveMockPoint(vo);
	}	
	
	public int delMockTest(MockVO vo) throws Exception {
		return mockDAO.delMockTest(vo);
	}
	
	public int delMockSection(MockVO vo) throws Exception {
		return mockDAO.delMockSection(vo);
	}
	
	public int delMockPoint(MockVO vo) throws Exception {
		return mockDAO.delMockPoint(vo);
	}	
	
	public void insertDayLog(AnalysisVO vo) throws Exception {
		mockDAO.insertDayLog(vo);
	}
	
	public void updateDayLog(AnalysisVO vo) throws Exception {
		mockDAO.updateDayLog(vo);
	}
	
	public List<AnalysisVO> getDayLogList(AnalysisVO vo) throws Exception {
		return mockDAO.getDayLogList(vo);
	}
	
	public Integer getDayLogList_cnt(AnalysisVO vo) throws Exception {
		return mockDAO.getDayLogList_cnt(vo);
	}
	
	public AnalysisVO getDayLogDetail(AnalysisVO vo) throws Exception {
		return mockDAO.getDayLogDetail(vo);
	}
	
	public List<AnalysisVO> getTrans(AnalysisVO vo) throws Exception {
		return mockDAO.getTrans(vo);
	}
	
	public List<AnalysisVO> getRainfall(AnalysisVO vo) throws Exception {
		return mockDAO.getRainfall(vo);
	}
	
	public Integer getTransCnt(AnalysisVO vo) throws Exception {
		return mockDAO.getTransCnt(vo);
	}
	
	public  List<AnalysisVO> getSpread(AnalysisVO vo) throws Exception {
		return mockDAO.getSpread(vo);
	}
	
	public List<ErrorCodeVO> getErrorCode() throws Exception {
		return mockDAO.getErrorCode();
	}
	
	public void saveDaylogDet(AnalysisVO vo) throws Exception {
		mockDAO.saveDaylogDet(vo);
	}
	
	public void deleteDaylogDet(AnalysisVO vo) throws Exception {
		mockDAO.deleteDaylogDet(vo);
	}
	
	public void saveDaylogSpread(AnalysisVO vo) throws Exception{
		mockDAO.saveDaylogSpread(vo);
	}
	
	public void updateDaylogSpread(AnalysisVO vo) throws Exception {
		mockDAO.updateDaylogSpread(vo);
	}
	
	public List<AnalysisVO> getDaylogSpreadList(AnalysisVO vo) throws Exception{
		return mockDAO.getDaylogSpreadList(vo);
	}
	
	public Integer getDaylogSpreadCnt(AnalysisVO vo) throws Exception {
		return mockDAO.getDaylogSpreadCnt(vo);
	}
	
	public void completeDaylog(AnalysisVO vo) throws Exception {
		 mockDAO.completeDaylog(vo);
	}
}
