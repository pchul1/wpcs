package daewooInfo.operate.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.operate.bean.OperateFlowVO;
import daewooInfo.operate.bean.OperateObservatoryVO;
import daewooInfo.operate.bean.OperatePointVO;
import daewooInfo.operate.bean.OperateSectionVO;
import daewooInfo.operate.service.OperateService;

/**
 * 운영관리를 위한 컨트롤러  클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 * </pre>
 */
@Controller
public class OperateController {
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(OperateController.class);
	
    /**
	 * @uml.property  name="operateService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "operateService")
    private OperateService operateService;	

    /**
     * 구간관리 화면을 보여준다.
     * 
     * @return
     * @throws Exception
     */
    @RequestMapping("/operate/sectionList.do")
    public String sectionList() throws Exception{
    	return "operate/sectionList";
    }  
    
	/**
	 * 구간 목록을 가져온다.
	 * 
	 * @param riverId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/getSectionList.do")
	public ModelAndView getSectionList(
			@RequestParam(value="riverId", required=false) String riverId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperateSectionVO vo = new OperateSectionVO();
		vo.setRiverId(riverId);
		
		List<OperateSectionVO> sectionList = operateService.getSectionList(vo);

        modelAndView.addObject("sectionList", sectionList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}	    
	
	/**
	 * 해당하는 구간을 가져온다.
	 * 
	 * @param sectionId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/getSection.do")
	public ModelAndView getSection(
			@RequestParam(value="sectionId", required=false) String sectionId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperateSectionVO vo = new OperateSectionVO();
		vo.setSectionId(sectionId);
		
		List<OperateSectionVO> section = operateService.getSection(vo);
		
        modelAndView.addObject("section", section);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}	    
	
	/**
	 * 해당 구간을 갱신한다.
	 * 
	 * @param sectionId
	 * @param riverId
	 * @param startSectionName
	 * @param endSectionName
	 * @param orderNum
	 * @param way
	 * @param startLatitude
	 * @param startLongtitude
	 * @param endLatitude
	 * @param endLongtitude
	 * @param etc
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/updateSection.do")
	public ModelAndView updateSection(
			@RequestParam(value="sectionId", required=false) String sectionId
			,@RequestParam(value="riverId", required=false) String riverId
			,@RequestParam(value="startSectionName", required=false) String startSectionName			
			,@RequestParam(value="endSectionName", required=false) String endSectionName
			,@RequestParam(value="orderNum", required=false) String orderNum
			,@RequestParam(value="way", required=false) String way
			,@RequestParam(value="startLatitude", required=false) String startLatitude
			,@RequestParam(value="startLongtitude", required=false) String startLongtitude	
			,@RequestParam(value="endLatitude", required=false) String endLatitude	
			,@RequestParam(value="endLongtitude", required=false) String endLongtitude	
			,@RequestParam(value="etc", required=false) String etc												
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperateSectionVO vo = new OperateSectionVO();
		vo.setSectionId(sectionId);
		vo.setRiverId(riverId);
		vo.setStartSectionName(startSectionName);
		vo.setEndSectionName(endSectionName);
		vo.setOrderNum(orderNum);
		vo.setWay(way);
		vo.setStartLatitude(startLatitude);
		vo.setStartLongtitude(startLongtitude);
		vo.setEndLatitude(endLatitude);
		vo.setEndLongtitude(endLongtitude);
		vo.setEtc(etc);			
		
		operateService.updateSection(vo);
		
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}		
	
	/**
	 * 해당 구간을 삭제한다.
	 * 
	 * @param sectionId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/deleteSection.do")
	public ModelAndView deleteSection(
			@RequestParam(value="sectionId", required=false) String sectionId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();		
		OperateSectionVO vo = new OperateSectionVO();

		vo.setSectionId(sectionId);
			
		operateService.deleteSection(vo);

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}		
    
    /**
     * 유량관리 화면을 보여준다.
     * 
     * @return
     * @throws Exception
     */
    @RequestMapping("/operate/sectionSpeed.do")
    public String sectionSpeed() throws Exception{
    	return "operate/sectionSpeed";
    }
    
	/**
	 * 구간에 해당하는 유량목록을 가져온다.
	 * 
	 * @param sectionId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/getSectionSpeedList.do")
	public ModelAndView getSectionSpeedList(
			@RequestParam(value="sectionId", required=false) String sectionId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperateFlowVO vo = new OperateFlowVO();
		vo.setSectionId(sectionId);
		
		List<OperateFlowVO> sectionSpeedList = operateService.getSectionSpeedList(vo);
		
        modelAndView.addObject("sectionSpeedList", sectionSpeedList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}	        
	
	/**
	 * 해당 유량을 갱신한다.
	 * 
	 * @param flowId
	 * @param sectionId
	 * @param flow
	 * @param endTime
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/updateSectionSpeed.do")
	public ModelAndView updateSectionSpeed(
			@RequestParam(value="flowId", required=false) String[] flowId
			,@RequestParam(value="sectionId", required=false) String[] sectionId
			,@RequestParam(value="flow", required=false) String[] flow			
			,@RequestParam(value="endTime", required=false) String[] endTime						
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		OperateFlowVO vo = new OperateFlowVO();
		
		for(int i=0; i<flowId.length; i++) {
			vo = new OperateFlowVO();
			vo.setFlowId(flowId[i]);
			vo.setSectionId(sectionId[i]);
			vo.setFlow(flow[i]);
			vo.setEndTime(endTime[i]);
			
			operateService.updateSectionSpeed(vo);
		}
		
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}			
	
	/**
	 * 해당 유량을 삭제한다.
	 * 
	 * @param flowArr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/deleteSectionSpeed.do")
	public ModelAndView deleteSectionSpeed(
			@RequestParam(value="flowArr", required=false) String[] flowArr
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();		
		OperateFlowVO vo = new OperateFlowVO();

		for(int i=0; i<flowArr.length; i++) {
			vo = new OperateFlowVO();
			vo.setFlowId(flowArr[i]);
			
			operateService.deleteSectionSpeed(vo);
		}		

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}			
    
    /**
     * 주요지점 관리 화면을 보여준다.
     * 
     * @return
     * @throws Exception
     */
    @RequestMapping("/operate/sectionPoint.do")
    public String sectionPoint() throws Exception{
    	return "operate/sectionPoint";
    }  
    
	/**
	 * 구간에 해당하는 주요지점을 가져온다.
	 * 
	 * @param sectionId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/getSectionPointList.do")
	public ModelAndView getSectionPointList(
			@RequestParam(value="sectionId", required=false) String sectionId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperatePointVO vo = new OperatePointVO();
		vo.setSectionId(sectionId);
		
		List<OperatePointVO> sectionPointList = operateService.getSectionPointList(vo);
		
        modelAndView.addObject("sectionPointList", sectionPointList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}	      
    
	/**
	 * 해당 주요지점을 가져온다.
	 * 
	 * @param pointId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/getSectionPoint.do")
	public ModelAndView getSectionPoint(
			@RequestParam(value="pointId", required=false) String pointId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperatePointVO vo = new OperatePointVO();
		vo.setPointId(pointId);
		
		List<OperatePointVO> sectionPoint = operateService.getSectionPoint(vo);
		
        modelAndView.addObject("sectionPoint", sectionPoint);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}	       
	
	/**
	 * 해당 주요지점을 갱신한다.
	 * 
	 * @param pointId
	 * @param sectionId
	 * @param pointName
	 * @param orderNum
	 * @param way
	 * @param latitude
	 * @param longtitude
	 * @param etc
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/updateSectionPoint.do")
	public ModelAndView updateSectionPoint(
			@RequestParam(value="pointId", required=false) String pointId
			,@RequestParam(value="sectionId", required=false) String sectionId
			,@RequestParam(value="pointName", required=false) String pointName			
			,@RequestParam(value="orderNum", required=false) String orderNum	
			,@RequestParam(value="way", required=false) String way		
			,@RequestParam(value="latitude", required=false) String latitude		
			,@RequestParam(value="longtitude", required=false) String longtitude		
			,@RequestParam(value="etc", required=false) String etc					
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperatePointVO vo = new OperatePointVO();
		vo.setPointId(pointId);
		vo.setSectionId(sectionId);
		vo.setPointName(pointName);
		vo.setOrderNum(orderNum);
		vo.setWay(way);
		vo.setLatitude(latitude);
		vo.setLongtitude(longtitude);
		vo.setEtc(etc);
		
		operateService.updateSectionPoint(vo);
		
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}		
	
	/**
	 * 해당 주요지점을 삭제한다.
	 * 
	 * @param pointId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/deleteSectionPoint.do")
	public ModelAndView deleteSectionPoint(
			@RequestParam(value="pointId", required=false) String pointId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();		
		OperatePointVO vo = new OperatePointVO();

		vo.setPointId(pointId);
			
		operateService.deleteSectionPoint(vo);

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}			
    
    /**
     * 관측소 관리 화면을 보여준다.
     * 
     * @return
     * @throws Exception
     */
    @RequestMapping("/operate/sectionObservatory.do")
    public String sectionObservatory() throws Exception{
    	return "operate/sectionObservatory";
    }
    
	/**
	 * 구간에 해당하는 관측소 목록을 가져온다.
	 * 
	 * @param sectionId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/getSectionObservatoryList.do")
	public ModelAndView getSectionObservatoryList(
			@RequestParam(value="sectionId", required=false) String sectionId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperateObservatoryVO vo = new OperateObservatoryVO();
		vo.setSectionId(sectionId);
		
		List<OperateObservatoryVO> sectionObservatoryList = operateService.getSectionObservatoryList(vo);
		
        modelAndView.addObject("sectionObservatoryList", sectionObservatoryList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}    
    
	/**
	 * 해당 관측소를 가져온다.
	 * 
	 * @param observatoryId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/getSectionObservatory.do")
	public ModelAndView getSectionObservatory(
			@RequestParam(value="observatoryId", required=false) String observatoryId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperateObservatoryVO vo = new OperateObservatoryVO();
		vo.setObservatoryId(observatoryId);
		
		List<OperateObservatoryVO> sectionObservatory = operateService.getSectionObservatory(vo);
		
        modelAndView.addObject("sectionObservatory", sectionObservatory);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}
	
	/**
	 * 해당 관측소를 갱신한다.
	 * 
	 * @param observatoryId
	 * @param sectionId
	 * @param observatoryName
	 * @param orderNum
	 * @param way
	 * @param latitude
	 * @param longtitude
	 * @param observatoryType
	 * @param stageDischargeCurve1Val1
	 * @param stageDischargeCurve1Val2
	 * @param stageDischargeCurve1Val3
	 * @param stageDischargeCurve1Eq1
	 * @param stageDischargeCurve1Eq2
	 * @param stageDischargeCurve2Val1
	 * @param stageDischargeCurve2Val2
	 * @param stageDischargeCurve2Val3
	 * @param stageDischargeCurve2Eq1
	 * @param stageDischargeCurve2Eq2
	 * @param stageDischargeCurve3Val1
	 * @param stageDischargeCurve3Val2
	 * @param stageDischargeCurve3Val3
	 * @param stageDischargeCurve3Eq1
	 * @param stageDischargeCurve3Eq2
	 * @param etc
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/updateSectionObservatory.do")
	public ModelAndView updateSectionObservatory(
			@RequestParam(value="observatoryId", required=false) String observatoryId
			,@RequestParam(value="sectionId", required=false) String sectionId
			,@RequestParam(value="observatoryName", required=false) String observatoryName			
			,@RequestParam(value="orderNum", required=false) String orderNum	
			,@RequestParam(value="way", required=false) String way		
			,@RequestParam(value="latitude", required=false) String latitude		
			,@RequestParam(value="longtitude", required=false) String longtitude			
			,@RequestParam(value="observatoryType", required=false) String observatoryType
			,@RequestParam(value="stageDischargeCurve1Val1", required=false) String stageDischargeCurve1Val1
			,@RequestParam(value="stageDischargeCurve1Val2", required=false) String stageDischargeCurve1Val2
			,@RequestParam(value="stageDischargeCurve1Val3", required=false) String stageDischargeCurve1Val3
			,@RequestParam(value="stageDischargeCurve1Eq1", required=false) String stageDischargeCurve1Eq1
			,@RequestParam(value="stageDischargeCurve1Eq2", required=false) String stageDischargeCurve1Eq2
			,@RequestParam(value="stageDischargeCurve2Val1", required=false) String stageDischargeCurve2Val1
			,@RequestParam(value="stageDischargeCurve2Val2", required=false) String stageDischargeCurve2Val2
			,@RequestParam(value="stageDischargeCurve2Val3", required=false) String stageDischargeCurve2Val3
			,@RequestParam(value="stageDischargeCurve2Eq1", required=false) String stageDischargeCurve2Eq1
			,@RequestParam(value="stageDischargeCurve2Eq2", required=false) String stageDischargeCurve2Eq2
			,@RequestParam(value="stageDischargeCurve3Val1", required=false) String stageDischargeCurve3Val1
			,@RequestParam(value="stageDischargeCurve3Val2", required=false) String stageDischargeCurve3Val2
			,@RequestParam(value="stageDischargeCurve3Val3", required=false) String stageDischargeCurve3Val3
			,@RequestParam(value="stageDischargeCurve3Eq1", required=false) String stageDischargeCurve3Eq1
			,@RequestParam(value="stageDischargeCurve3Eq2", required=false) String stageDischargeCurve3Eq2
			,@RequestParam(value="etc", required=false) String etc							
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		OperateObservatoryVO vo = new OperateObservatoryVO();
		vo.setObservatoryId(observatoryId);
		vo.setSectionId(sectionId);
		vo.setObservatoryName(observatoryName);
		vo.setOrderNum(orderNum);
		vo.setWay(way);
		vo.setLatitude(latitude);
		vo.setLongtitude(longtitude);
		vo.setObservatoryType(observatoryType);
		vo.setStageDischargeCurve1Val1(stageDischargeCurve1Val1);
		vo.setStageDischargeCurve1Val2(stageDischargeCurve1Val2);
		vo.setStageDischargeCurve1Val3(stageDischargeCurve1Val3);
		vo.setStageDischargeCurve1Eq1(stageDischargeCurve1Eq1);
		vo.setStageDischargeCurve1Eq2(stageDischargeCurve1Eq2);
		vo.setStageDischargeCurve2Val1(stageDischargeCurve2Val1);
		vo.setStageDischargeCurve2Val2(stageDischargeCurve2Val2);
		vo.setStageDischargeCurve2Val3(stageDischargeCurve2Val3);
		vo.setStageDischargeCurve2Eq1(stageDischargeCurve2Eq1);
		vo.setStageDischargeCurve2Eq2(stageDischargeCurve2Eq2);
		vo.setStageDischargeCurve3Val1(stageDischargeCurve3Val1);
		vo.setStageDischargeCurve3Val2(stageDischargeCurve3Val2);
		vo.setStageDischargeCurve3Val3(stageDischargeCurve3Val3);
		vo.setStageDischargeCurve3Eq1(stageDischargeCurve3Eq1);
		vo.setStageDischargeCurve3Eq2(stageDischargeCurve3Eq2);
		vo.setEtc(etc);
		
		operateService.updateSectionObservatory(vo);
		
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}			
	
	/**
	 * 해당 관측소를 삭제한다.
	 * 
	 * @param observatoryId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/operate/deleteSectionObservatory.do")
	public ModelAndView deleteSectionObservatory(
			@RequestParam(value="observatoryId", required=false) String observatoryId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();		
		OperateObservatoryVO vo = new OperateObservatoryVO();

		vo.setObservatoryId(observatoryId);
			
		operateService.deleteSectionObservatory(vo);

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}			
}
