package daewooInfo.operate.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.operate.bean.OperateFlowVO;
import daewooInfo.operate.bean.OperateObservatoryVO;
import daewooInfo.operate.bean.OperatePointVO;
import daewooInfo.operate.bean.OperateSectionVO;
import daewooInfo.operate.dao.OperateDAO;
import daewooInfo.operate.service.OperateService;

/**
 * 운영관리를 위한 서비스 구현 클래스
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
@Service("operateService")
public class OperateServiceImpl implements OperateService{
	
	/**
	 * @uml.property  name="operateDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "operateDAO")
	private OperateDAO operateDAO;
	
    /**
     * 구간 목록을 가져온다.
     * 
     * @see daewooInfo.operate.service.OperateService#getSectionList(daewooInfo.operate.bean.OperateSectionVO)
     */
    public List<OperateSectionVO> getSectionList(OperateSectionVO vo) {
        return operateDAO.getSectionList(vo);
    }	
	
    /**
     * 해당하는 구간을 가져온다.
     * 
     * @see daewooInfo.operate.service.OperateService#getSection(daewooInfo.operate.bean.OperateSectionVO)
     */
    public List<OperateSectionVO> getSection(OperateSectionVO vo) {
        return operateDAO.getSection(vo);
    }		    
    
    /**
     * 해당 구간을 갱신한다.
     * 
     * @see daewooInfo.operate.service.OperateService#updateSection(daewooInfo.operate.bean.OperateSectionVO)
     */
    public void updateSection(OperateSectionVO vo) {
        operateDAO.updateSection(vo);
    }	
    
    /**
     * 해당 구간을 삭제한다.
     * 
     * @see daewooInfo.operate.service.OperateService#deleteSection(daewooInfo.operate.bean.OperateSectionVO)
     */
    public void deleteSection(OperateSectionVO vo) {
        operateDAO.deleteSection(vo);
    }	    
    
    /**
     * 구간에 해당하는 유량목록을 가져온다.
     * 
     * @see daewooInfo.operate.service.OperateService#getSectionSpeedList(daewooInfo.operate.bean.OperateFlowVO)
     */
    public List<OperateFlowVO> getSectionSpeedList(OperateFlowVO vo) {
        return operateDAO.getSectionSpeedList(vo);
    }		    
    
    /**
     * 해당 유량을 갱신한다.
     * 
     * @see daewooInfo.operate.service.OperateService#updateSectionSpeed(daewooInfo.operate.bean.OperateFlowVO)
     */
    public void updateSectionSpeed(OperateFlowVO vo) {
        operateDAO.updateSectionSpeed(vo);
    }	
    
    /**
     * 해당 유량을 삭제한다.
     * 
     * @see daewooInfo.operate.service.OperateService#deleteSectionSpeed(daewooInfo.operate.bean.OperateFlowVO)
     */
    public void deleteSectionSpeed(OperateFlowVO vo) {
    	operateDAO.deleteSectionSpeed(vo);
    }	    
    
    /**
     * 구간에 해당하는 주요지점을 가져온다.
     * 
     * @see daewooInfo.operate.service.OperateService#getSectionPointList(daewooInfo.operate.bean.OperatePointVO)
     */
    public List<OperatePointVO> getSectionPointList(OperatePointVO vo) {
        return operateDAO.getSectionPointList(vo);
    }		      
    
    /**
     * 해당 주요지점을 가져온다.
     * 
     * @see daewooInfo.operate.service.OperateService#getSectionPoint(daewooInfo.operate.bean.OperatePointVO)
     */
    public List<OperatePointVO> getSectionPoint(OperatePointVO vo) {
        return operateDAO.getSectionPoint(vo);
    }		    
    
    /**
     * 해당 주요지점을 갱신한다.
     * 
     * @see daewooInfo.operate.service.OperateService#updateSectionPoint(daewooInfo.operate.bean.OperatePointVO)
     */
    public void updateSectionPoint(OperatePointVO vo) {
        operateDAO.updateSectionPoint(vo);
    }	
    
    /**
     * 해당 주요지점을 삭제한다.
     * 
     * @see daewooInfo.operate.service.OperateService#deleteSectionPoint(daewooInfo.operate.bean.OperatePointVO)
     */
    public void deleteSectionPoint(OperatePointVO vo) {
        operateDAO.deleteSectionPoint(vo);
    }	    
    
    /**
     * 구간에 해당하는 관측소 목록을 가져온다.
     * 
     * @see daewooInfo.operate.service.OperateService#getSectionObservatoryList(daewooInfo.operate.bean.OperateObservatoryVO)
     */
    public List<OperateObservatoryVO> getSectionObservatoryList(OperateObservatoryVO vo) {
        return operateDAO.getSectionObservatoryList(vo);
    }		    
    
    /**
     * 해당 관측소를 가져온다.
     * 
     * @see daewooInfo.operate.service.OperateService#getSectionObservatory(daewooInfo.operate.bean.OperateObservatoryVO)
     */
    public List<OperateObservatoryVO> getSectionObservatory(OperateObservatoryVO vo) {
        return operateDAO.getSectionObservatory(vo);
    }		    
    
    /**
     * 해당 관측소를 갱신한다.
     * 
     * @see daewooInfo.operate.service.OperateService#updateSectionObservatory(daewooInfo.operate.bean.OperateObservatoryVO)
     */
    public void updateSectionObservatory(OperateObservatoryVO vo) {
        operateDAO.updateSectionObservatory(vo);
    } 
    
    /**
     * 해당 관측소를 삭제한다.
     * 
     * @see daewooInfo.operate.service.OperateService#deleteSectionObservatory(daewooInfo.operate.bean.OperateObservatoryVO)
     */
    public void deleteSectionObservatory(OperateObservatoryVO vo) {
        operateDAO.deleteSectionObservatory(vo);
    }     
}
