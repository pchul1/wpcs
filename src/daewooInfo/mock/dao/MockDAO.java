package daewooInfo.mock.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.mock.bean.AnalysisVO;
import daewooInfo.mock.bean.ErrorCodeVO;
import daewooInfo.mock.bean.MockVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("mockDAO")
public class MockDAO extends EgovAbstractDAO{

    public List<MockVO> getPointList(MockVO vo) {
        return list("mockDAO.getPointList", vo);
    }	    
    
    public MockVO getFlow(MockVO vo) {
        return (MockVO)selectByPk("mockDAO.getFlow", vo);
    }
    
    public MockVO getPointFlow(MockVO vo) {
    	return (MockVO)selectByPk("mockDAO.getPointFlow", vo);
    }	       
	
    public List<MockVO> getMockTestList(MockVO vo) {
        return list("mockDAO.getMockTestList", vo);
    }	
    
    public MockVO getMockTest(MockVO vo) {
        return (MockVO)selectByPk("mockDAO.getMockTest", vo);
    }	   
    
    public List<MockVO> getMockSection(MockVO vo) {
        return list("mockDAO.getMockSection", vo);
    }	    
    
    public List<MockVO> getMockPoint(MockVO vo) {
        return list("mockDAO.getMockPoint", vo);
    }	      
    
    public int getMockTestCnt(MockVO vo) {
        return (Integer)selectByPk("mockDAO.getMockTestCnt", vo);
    }	  
    
    public int getMockTestPk() {
        return (Integer)selectByPk("mockDAO.getMockTestPk", null);
    }	
    
    public int saveMockTest(MockVO vo) {
        return update("mockDAO.saveMockTest", vo);
    }
    
    public int saveMockSection(MockVO vo) {
    	return update("mockDAO.saveMockSection", vo);
    }
    
    public int saveMockPoint(MockVO vo) {
    	return update("mockDAO.saveMockPoint", vo);
    }
    
    public int delMockTest(MockVO vo) {
    	return update("mockDAO.delMockTest", vo);
    }
    
    public int delMockSection(MockVO vo) {
    	return update("mockDAO.delMockSection", vo);
    }
    
    public int delMockPoint(MockVO vo) {
    	return update("mockDAO.delMockPoint", vo);
    }       
    
    public void insertDayLog(AnalysisVO vo)
    {
    	insert("mockDAO.insertDayLog", vo);
    }
    
    public void updateDayLog(AnalysisVO vo)
    {
    	update("mockDAO.updateDayLog", vo);
    }
    
    public List<AnalysisVO> getDayLogList(AnalysisVO vo)
    {
    	return list("mockDAO.getDayLogList", vo);
    }
    
    public int getDayLogList_cnt(AnalysisVO vo)
    {
    	return (Integer)selectByPk("mockDAO.getDayLogList_cnt", vo);
    }
    
    public AnalysisVO getDayLogDetail(AnalysisVO vo)
    {
    	return (AnalysisVO)selectByPk("mockDAO.getDayLogDetail", vo);
    }
    
    public List<AnalysisVO> getTrans(AnalysisVO vo)
    {
    	return list("mockDAO.getTrans", vo);
    }
    
    public List<AnalysisVO> getRainfall(AnalysisVO vo)
    {
    	return list("mockDAO.getRainfall", vo);
    }
    
    public Integer getTransCnt(AnalysisVO vo)
    {
    	return (Integer)selectByPk("mockDAO.getTransCnt", vo); 
    }
    
    public List<AnalysisVO> getSpread(AnalysisVO vo)
    {
    	return list("mockDAO.getSpread", vo);
    }
    
    public List<ErrorCodeVO> getErrorCode()
    {
    	return list("mockDAO.getErrorCode", null);
    }
    
    public void saveDaylogDet(AnalysisVO vo) throws Exception
    {
    	insert("mockDAO.saveDaylogDet", vo);
    }
    
    public void deleteDaylogDet(AnalysisVO vo) throws Exception
    {
    	delete("mockDAO.deleteDaylogDet", vo);
    }
    
    public void saveDaylogSpread(AnalysisVO vo) throws Exception
    {
    	insert("mockDAO.saveDaylogSpread", vo);
    }
    
    public void updateDaylogSpread(AnalysisVO vo) throws Exception
    {
    	update("mockDAO.updateDaylogSpread", vo);
    }
    
    public List<AnalysisVO> getDaylogSpreadList(AnalysisVO vo) throws Exception
    {
    	return list("mockDAO.getDaylogSpreadList", vo);
    }
    
    public Integer getDaylogSpreadCnt(AnalysisVO vo) throws Exception
    {
    	return (Integer)selectByPk("mockDAO.getDaylogSpreadCnt", vo);
    }
    
    public void completeDaylog(AnalysisVO vo) throws Exception
    {
    	update("mockDAO.completeDaylog", vo);
    }
}
