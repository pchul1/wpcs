package daewooInfo.stats.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import daewooInfo.stats.bean.ThematicMapSearchVO;
import daewooInfo.stats.bean.ThematicMapVO;
import daewooInfo.stats.dao.ThematicMapDAO;
import daewooInfo.stats.service.ThematicMapService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("thematicMapService")
public class ThematicMapServiceImpl implements ThematicMapService{
	/**
	 * @uml.property  name="thematicMapDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="thematicMapDAO")
    private ThematicMapDAO thematicMapDAO;
	
    /**
  	 * @uml.property  name="idgenMonitoringIdService"
  	 * @uml.associationEnd  readOnly="true"
  	 */
    @Resource(name = "tmBermIdService")
    private EgovIdGnrService idgenTMBermIdService;
      
    /**
	 * 사용자별 범례정보 가져오기
	 */
	public List getBermSettingInfo(ThematicMapSearchVO searchVO) throws Exception {
		return thematicMapDAO.getBermSettingInfo(searchVO);
	}
	
	/**
	 * 사용자별 범례정보 가져오기
	 */
	public List getBermDataList(ThematicMapSearchVO searchVO) throws Exception {
		return thematicMapDAO.getBermDataList(searchVO);
	}
	
	/* 범례정보 저장 */
	public void saveBermSettingInfo(ThematicMapVO thematicMapVO) throws Exception {
		String bermId = idgenTMBermIdService.getNextStringId();				
		
		thematicMapVO.setBermId(bermId);
		thematicMapDAO.saveBermSettingInfo(thematicMapVO);
	}
	
	/**
	 *  확정전,후 데이터 조회
	 */
	public List<ThematicMapVO> getThematicMapDetail(ThematicMapSearchVO searchVO) throws Exception{
		return thematicMapDAO.getThematicMapDetail(searchVO);
	}
	
	/**
	 * FactCode 조회
	 */
	public String getFactCodeValue(String searchSugye) throws Exception{
		return thematicMapDAO.getFactCodeValue(searchSugye);
	}
}
