package daewooInfo.admin.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.admin.bbs.dao.BBSAttributeManageDAO;
import daewooInfo.admin.bbs.service.EgovBBSAttributeManageService;
import daewooInfo.bbs.bean.BoardMaster;
import daewooInfo.bbs.bean.BoardMasterVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 게시판 속성관리를 위한 서비스 구현 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.24  이삼섭          최초 생성
 *   2009.06.26	한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@Service("EgovBBSAttributeManageService")
public class EgovBBSAttributeManageServiceImpl extends AbstractServiceImpl implements EgovBBSAttributeManageService {

    /**
	 * @uml.property  name="attrbMngDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "BBSAttributeManageDAO")
    private BBSAttributeManageDAO attrbMngDAO;

    /**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "egovBBSMstrIdGnrService")
    private EgovIdGnrService idgenService;
    
    /**
     * 등록된 게시판 속성정보를 삭제한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#deleteBBSMasterInf(daewooInfo.bbs.bean.com.cop.bbs.brd.service.BoardMaster)
     */
    public void deleteBBSMasterInf(BoardMaster boardMaster) throws Exception {
    	attrbMngDAO.deleteBBSMasterInf(boardMaster);
    }

    /**
     * 신규 게시판 속성정보를 생성한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#insertBBSMastetInf(daewooInfo.bbs.bean.com.cop.bbs.brd.service.BoardMaster)
     */
    public String insertBBSMastetInf(BoardMaster boardMaster) throws Exception {
		String bbsId = idgenService.getNextStringId();
		
		boardMaster.setBbsId(bbsId);
		attrbMngDAO.insertBBSMasterInf(boardMaster);
		
		return bbsId;
    }

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#selectAllBBSMasteInf(daewooInfo.bbs.bean.com.cop.bbs.brd.service.BoardMasterVO)
     */
    public List<BoardMasterVO> selectAllBBSMasteInf(BoardMasterVO vo) throws Exception {
	return attrbMngDAO.selectAllBBSMasteInf(vo);
    }

    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#selectBBSMasterInf(daewooInfo.bbs.bean.com.cop.bbs.brd.service.BoardMasterVO)
     */
    public BoardMasterVO selectBBSMasterInf(BoardMaster searchVO) throws Exception {
    	return attrbMngDAO.selectBBSMasterInf(searchVO);
    }

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#selectBBSMasterInfs(daewooInfo.bbs.bean.com.cop.bbs.brd.service.BoardMasterVO)
     */
    public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO) throws Exception {
	List<BoardMasterVO> result = attrbMngDAO.selectBBSMasterInfs(searchVO);
	int cnt = attrbMngDAO.selectBBSMasterInfsCnt(searchVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 게시판 속성정보를 수정한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#updateBBSMasterInf(daewooInfo.bbs.bean.com.cop.bbs.brd.service.BoardMaster)
     */
    public void updateBBSMasterInf(BoardMaster boardMaster) throws Exception {
    	
    	attrbMngDAO.updateBBSMasterInf(boardMaster);
	
    }

    /**
     * 템플릿의 유효여부를 점검한다.
     * 
     * @see egovframework.com.cop.bbs.brd.service.EgovBBSAttributeManageService#validateTemplate(daewooInfo.bbs.bean.com.cop.bbs.brd.service.BoardMasterVO)
     */
    public void validateTemplate(BoardMasterVO searchVO) throws Exception {
	log.debug("validateTemplate method ignored...");
    }

    /**
     * 사용중인 게시판 속성 정보의 목록을 조회 한다.
     */
    public Map<String, Object> selectBdMstrListByTrget(BoardMasterVO vo) throws Exception {
	List<BoardMasterVO> result = attrbMngDAO.selectBdMstrListByTrget(vo);
	int cnt = attrbMngDAO.selectBdMstrListCntByTrget(vo);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 커뮤니티, 동호회에서 사용중인 게시판 속성 정보의 목록을 전체조회 한다.
     */
    public List<BoardMasterVO> selectAllBdMstrByTrget(BoardMasterVO vo) throws Exception {
	return attrbMngDAO.selectAllBdMstrByTrget(vo);
    }

    /**
     * 사용중이지 않은 게시판 속성 정보의 목록을 조회 한다.
     */
    public Map<String, Object> selectNotUsedBdMstrList(BoardMasterVO searchVO) throws Exception {
	List<BoardMasterVO> result = attrbMngDAO.selectNotUsedBdMstrList(searchVO);
	int cnt = attrbMngDAO.selectNotUsedBdMstrListCnt(searchVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }
}
