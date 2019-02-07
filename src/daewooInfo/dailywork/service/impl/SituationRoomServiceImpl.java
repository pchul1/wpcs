package daewooInfo.dailywork.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.dailywork.bean.SituationRoomVO;
import daewooInfo.dailywork.dao.SituationRoomDAO;
import daewooInfo.dailywork.service.SituationRoomService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 
 * 상황실 근무일지 대한 서비스 구현클래스를 정의한다
 * @author yrkim
 * @since 2014.09.24
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.24  yrkim          최초 생성
 *
 * </pre>
 */

@Service("SituationRoomService")
public class SituationRoomServiceImpl extends AbstractServiceImpl implements SituationRoomService {
	
	/**
	 * @uml.property  name="situationRoomDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="SituationRoomDAO")
    private SituationRoomDAO situationRoomDAO;
    
    /**
  	 * @uml.property  name="idgenSituationRoomIdService"
  	 * @uml.associationEnd  readOnly="true"
  	 */
      @Resource(name = "situationRoomIdService")
      private EgovIdGnrService idgenSituationRoomIdService;
    
    /**
  	 * @uml.property  name="idgenSituationRoomIdService"
  	 * @uml.associationEnd  readOnly="true"
  	 */
    @Resource(name = "situationSpreadIdService")
    private EgovIdGnrService idgenSituationSpreadIdService;
    
    /**
     * 상황실 근무일지 등록
     */
    public void insertSituationRoomInfo(SituationRoomVO situationRoomVO) throws Exception{
    	String sId = idgenSituationRoomIdService.getNextStringId();																											//상황실 근무일지ID
		situationRoomVO.setsId(sId);
		
    	situationRoomDAO.insertSituationRoomInfo(situationRoomVO);
    }
    
    
    /**
     * 상황전파 현황 저장
     */
    public void insertSituationSpreadInfo(SituationRoomVO situationRoomVO) throws Exception{
    	
    	String spreadId = "";																																									//상황전파 현황ID
		
		int seq = 0;
			
		spreadId = idgenSituationSpreadIdService.getNextStringId();																											//상황전파 현황ID
		situationRoomVO.setSpreadId(spreadId);
		
		seq = situationRoomDAO.getSituationSpreadSeq(situationRoomVO);																									//seq 
		
		situationRoomVO.setSpreadSeq(seq);
		
		situationRoomDAO.insertSituationSpreadInfo(situationRoomVO);
		
    }
    
    /**
     * 상황전파 현황 삭제
     */
    public int deleteSituationSpreadInfo(String dailyWorkId) throws Exception{
    	int result = 0;
    	
    	situationRoomDAO.deleteSituationSpreadInfo(dailyWorkId);
    	
    	result++;
    	
    	return result;
    }
    
    /**
     * 상황실 근무일지 근무상황
     */
    public SituationRoomVO selectSituationRoomInfo(String dailyWorkId) throws Exception{
    	return situationRoomDAO.selectSituationRoomInfo(dailyWorkId);
    }
    
    /**
     * 상황실 근무일지 수정
     */
    public void updateSituationRoomInfo(SituationRoomVO situationRoomVO) throws Exception{
    	situationRoomDAO.updateSituationRoomInfo(situationRoomVO);
    }
    
    /**
     * 상황실 상황전파 현황
     */
    public List<SituationRoomVO> selectSituationSpreadInfo(SituationRoomVO situationRoomVO) throws Exception {
    	return situationRoomDAO.selectSituationSpreadInfo(situationRoomVO);
    }
}
