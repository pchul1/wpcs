package daewooInfo.operate.service;

import java.util.List;

import daewooInfo.operate.bean.OperateFlowVO;
import daewooInfo.operate.bean.OperateObservatoryVO;
import daewooInfo.operate.bean.OperatePointVO;
import daewooInfo.operate.bean.OperateSectionVO;

/**
 * 운영관리를 위한 서비스 인터페이스 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
public interface OperateService {
	
    /**
     * 구간 목록을 가져온다.
     * 
     * @param OperateSectionVO
     */		
	List<OperateSectionVO> getSectionList(OperateSectionVO vo) throws Exception;
	
    /**
     * 해당하는 구간을 가져온다.
     * 
     * @param OperateSectionVO
     */			
    List<OperateSectionVO> getSection(OperateSectionVO vo) throws Exception;
    
    /**
     * 해당 구간을 갱신한다.
     * 
     * @param OperateSectionVO
     */		    
    void updateSection(OperateSectionVO vo) throws Exception;
    
    /**
     * 해당 구간을 삭제한다.
     * 
     * @param OperateSectionVO
     */		    
    void deleteSection(OperateSectionVO vo) throws Exception;
    
    /**
     * 구간에 해당하는 유량목록을 가져온다.
     * 
     * @param OperateFlowVO
     */		    
    List<OperateFlowVO> getSectionSpeedList(OperateFlowVO vo) throws Exception;
    
    /**
     * 해당 유량을 갱신한다.
     * 
     * @param OperateFlowVO
     */	    
    void updateSectionSpeed(OperateFlowVO vo) throws Exception;
    
    /**
     * 해당 유량을 삭제한다.
     * 
     * @param OperateFlowVO
     */	    
    void deleteSectionSpeed(OperateFlowVO vo) throws Exception;    
    
    /**
     * 구간에 해당하는 주요지점을 가져온다.
     * 
     * @param OperatePointVO
     */	    
    List<OperatePointVO> getSectionPointList(OperatePointVO vo) throws Exception;
    
    /**
     * 해당 주요지점을 가져온다.
     * 
     * @param OperatePointVO
     */	    
    List<OperatePointVO> getSectionPoint(OperatePointVO vo) throws Exception;		    
    
    /**
     * 해당 주요지점을 갱신한다.
     * 
     * @param OperatePointVO
     */	     
    void updateSectionPoint(OperatePointVO vo) throws Exception;
    
    /**
     * 해당 주요지점을 삭제한다.
     * 
     * @param OperatePointVO
     */	     
    void deleteSectionPoint(OperatePointVO vo) throws Exception;	
    
    /**
     * 구간에 해당하는 관측소 목록을 가져온다.
     * 
     * @param OperateObservatoryVO
     */	     
    List<OperateObservatoryVO> getSectionObservatoryList(OperateObservatoryVO vo) throws Exception;
    
    /**
     * 해당 관측소를 가져온다.
     * 
     * @param OperateObservatoryVO
     */    
    List<OperateObservatoryVO> getSectionObservatory(OperateObservatoryVO vo) throws Exception;		    
    
    /**
     * 해당 관측소를 갱신한다.
     * 
     * @param OperateObservatoryVO
     */    
    void updateSectionObservatory(OperateObservatoryVO vo) throws Exception;
    
    /**
     * 해당 관측소를 삭제한다.
     * 
     * @param OperateObservatoryVO
     */    
    void deleteSectionObservatory(OperateObservatoryVO vo) throws Exception;	    
}
