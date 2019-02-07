package daewooInfo.dailywork.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.dailywork.bean.RiverMainVO;
import daewooInfo.dailywork.service.RiverMainService;
import daewooInfo.dailywork.dao.RiverMainDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 
 * 4대강주요수계일지 대한 서비스 구현클래스를 정의한다
 * @author yrkim
 * @since 2014.10.10
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.10.10  yrkim          최초 생성
 *
 * </pre>
 */

@Service("RiverMainService")
public class RiverMainServiceImpl extends AbstractServiceImpl implements RiverMainService {
	/**
	 * @uml.property  name="riverMainDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="RiverMainDAO")
    private RiverMainDAO riverMainDAO;
    
    /**
  	 * @uml.property  name="idgenSituationRoomIdService"
  	 * @uml.associationEnd  readOnly="true"
  	 */
      @Resource(name = "riverMainIdService")
      private EgovIdGnrService idgenRiverMainIdService;
    
	/**
     * 4대강주요수계일지 등록
     */
    public void insertRiverMainInfo(RiverMainVO riverMainVO) throws Exception{
    	String rId = idgenRiverMainIdService.getNextStringId();																											//4대강주요수계일지ID
		riverMainVO.setrId(rId);
		
    	riverMainDAO.insertRiverMainInfo(riverMainVO);
    }
    
    /**
     * 4대강주요수계일지 정보 조회
     */
    public RiverMainVO selectRiverMainInfo(String dailyWorkId) throws Exception{
    	return riverMainDAO.selectRiverMainInfo(dailyWorkId);
    }
    
    /**
     * 4대강주요수계일지 수정
     */
    public void updateRiverMainInfo(RiverMainVO riverMainVO) throws Exception{
    	riverMainDAO.updateRiverMainInfo(riverMainVO);
    }
}
