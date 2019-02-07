package daewooInfo.operate.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.operate.bean.OperateFlowVO;
import daewooInfo.operate.bean.OperateObservatoryVO;
import daewooInfo.operate.bean.OperatePointVO;
import daewooInfo.operate.bean.OperateSectionVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 운영관리를 위한 데이터 접근 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.06.28  김태훈          최초 생성
 *
 * </pre>
 */
@Repository("operateDAO")
public class OperateDAO extends EgovAbstractDAO{

    /**
     * 구간 목록을 가져온다.
     * 
     * @param OperateSectionVO
     * @return
     */
    public List<OperateSectionVO> getSectionList(OperateSectionVO vo) {
        return list("operateDAO.getSectionList", vo);
    }	
	
    /**
     * 해당하는 구간을 가져온다.
     * 
     * @param OperateSectionVO
     * @return
     */    
    public List<OperateSectionVO> getSection(OperateSectionVO vo) {
        return list("operateDAO.getSection", vo);
    }
    
    /**
     * 해당 구간을 갱신한다.
     * 
     * @param OperateSectionVO
     * @return
     */        
    public void updateSection(OperateSectionVO vo) {
        update("operateDAO.updateSection", vo);
    }
    
    /**
     * 해당 구간을 삭제한다.
     * 
     * @param OperateSectionVO
     * @return
     */         
    public void deleteSection(OperateSectionVO vo) {
        update("operateDAO.deleteSection", vo);
    }    
    
    /**
     * 구간에 해당하는 유량목록을 가져온다.
     * 
     * @param OperateFlowVO
     * @return
     */       
    public List<OperateFlowVO> getSectionSpeedList(OperateFlowVO vo) {
        return list("operateDAO.getSectionSpeedList", vo);
    }
    
    /**
     * 해당 유량을 갱신한다.
     * 
     * @param OperateFlowVO
     * @return
     */       
    public void updateSectionSpeed(OperateFlowVO vo) {
        update("operateDAO.updateSectionSpeed", vo);
    }
    
    /**
     * 해당 유량을 삭제한다.
     * 
     * @param OperateFlowVO
     * @return
     */       
    public void deleteSectionSpeed(OperateFlowVO vo) {
    	delete("operateDAO.deleteSectionSpeed", vo);
    }
    
    /**
     * 구간에 해당하는 주요지점을 가져온다.
     * 
     * @param OperatePointVO
     * @return
     */       
    public List<OperatePointVO> getSectionPointList(OperatePointVO vo) {
        return list("operateDAO.getSectionPointList", vo);
    }    
    
    /**
     * 해당 주요지점을 가져온다.
     * 
     * @param OperatePointVO
     * @return
     */        
    public List<OperatePointVO> getSectionPoint(OperatePointVO vo) {
        return list("operateDAO.getSectionPoint", vo);
    }
    
    /**
     * 해당 주요지점을 갱신한다.
     * 
     * @param OperatePointVO
     * @return
     */        
    public void updateSectionPoint(OperatePointVO vo) {
        update("operateDAO.updateSectionPoint", vo);
    }
    
    /**
     * 해당 주요지점을 삭제한다.
     * 
     * @param OperatePointVO
     * @return
     */        
    public void deleteSectionPoint(OperatePointVO vo) {
        update("operateDAO.deleteSectionPoint", vo);
    }        
    
    /**
     * 구간에 해당하는 관측소 목록을 가져온다.
     * 
     * @param OperateObservatoryVO
     * @return
     */        
    public List<OperateObservatoryVO> getSectionObservatoryList(OperateObservatoryVO vo) {
        return list("operateDAO.getSectionObservatoryList", vo);
    }    
    
    /**
     * 해당 관측소를 가져온다.
     * 
     * @param OperateObservatoryVO
     * @return
     */   
    public List<OperateObservatoryVO> getSectionObservatory(OperateObservatoryVO vo) {
        return list("operateDAO.getSectionObservatory", vo);
    }
    
    /**
     * 해당 관측소를 갱신한다.
     * 
     * @param OperateObservatoryVO
     * @return
     */   
    public void updateSectionObservatory(OperateObservatoryVO vo) {
        update("operateDAO.updateSectionObservatory", vo);
    }       
    
    /**
     * 해당 관측소를 삭제한다.
     * 
     * @param OperateObservatoryVO
     * @return
     */   
    public void deleteSectionObservatory(OperateObservatoryVO vo) {
        update("operateDAO.deleteSectionObservatory", vo);
    }       
}
