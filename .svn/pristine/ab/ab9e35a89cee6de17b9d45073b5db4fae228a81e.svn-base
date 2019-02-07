package daewooInfo.admin.menu.dao;

import java.util.List;
import java.util.Map;
 
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import daewooInfo.cmmn.bean.ComDefaultVO;
import daewooInfo.admin.menu.bean.ProgrmManageVO;
import daewooInfo.admin.menu.bean.ProgrmManageDtlVO;
/**
 * 프로그램 목록관리및 프로그램변경관리에 대한 DAO 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2013.10.01  이강민          프로그램 관리 등록/수정 폼 프로그램 트리 메뉴 쿼리 추가
 * </pre>
 */

@Repository("progrmManageDAO")
public class ProgrmManageDAO extends EgovAbstractDAO {

	/**
	 * 프로그램 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List 
	 * @exception Exception
	 */

	public List selectProgrmList(ComDefaultVO vo) throws Exception{
		return list("progrmManageDAO.selectProgrmList_D", vo);
	}

    /**
	 * 프로그램목록 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectProgrmListTotCnt(ComDefaultVO vo) {
        return (Integer)getSqlMapClientTemplate().queryForObject("progrmManageDAO.selectProgrmListTotCnt_S", vo);
    }	
	
	/**
	 * 프로그램 기본정보를 조회
	 * @param vo ComDefaultVO
	 * @return ProgrmManageVO 
	 * @exception Exception
	 */
	public ProgrmManageVO selectProgrm(ComDefaultVO vo)throws Exception{
		return (ProgrmManageVO)selectByPk("progrmManageDAO.selectProgrm_D", vo); 
	}

	/**
	 * 프로그램 기본정보 및 URL을 등록
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void insertProgrm(ProgrmManageVO vo){
		insert("progrmManageDAO.insertProgrm_S", vo);
	}

	/**
	 * 프로그램 기본정보 및 URL을 수정
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void updateProgrm(ProgrmManageVO vo){
		update("progrmManageDAO.updateProgrm_S", vo);
	}

	/**
	 * 프로그램 기본정보 및 URL을 삭제
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void deleteProgrm(ProgrmManageVO vo){
		delete("progrmManageDAO.deleteProgrm_S", vo);
	}

	/**
	 * 프로그램 파일 존재여부를 조회
	 * @param vo ProgrmManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectProgrmNMTotCnt(ComDefaultVO vo) throws Exception{
		return (Integer)selectByPk("progrmManageDAO.selectProgrmNMTotCnt", vo);  
	}
	
	
	/**
	 * 프로그램변경요청 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */

	public List selectProgrmChangeRequstList(ComDefaultVO vo) throws Exception{
		return list("progrmManageDAO.selectProgrmChangeRequstList_D", vo);
	}                                

    /**
	 * 프로그램변경요청 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return  int
	 * @exception Exception
	 */
    public int selectProgrmChangeRequstListTotCnt(ComDefaultVO vo) {
        return (Integer)getSqlMapClientTemplate().queryForObject("progrmManageDAO.selectProgrmChangeRequstListTotCnt_S", vo);
    }
	
	/**
	 * 프로그램변경요청 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO 
	 * @exception Exception
	 */
	public ProgrmManageDtlVO selectProgrmChangeRequst(ProgrmManageDtlVO vo)throws Exception{
		return (ProgrmManageDtlVO)selectByPk("progrmManageDAO.selectProgrmChangeRequst_D", vo); 
	}

	/**
	 * 프로그램변경요청을 등록
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void insertProgrmChangeRequst(ProgrmManageDtlVO vo){
		insert("progrmManageDAO.insertProgrmChangeRequst_S", vo);
	}

	/**
	 * 프로그램변경요청을 수정
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void updateProgrmChangeRequst(ProgrmManageDtlVO vo){
		update("progrmManageDAO.updateProgrmChangeRequst_S", vo);
	}

	/**
	 * 프로그램변경요청을 삭제
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void deleteProgrmChangeRequst(ProgrmManageDtlVO vo){
		delete("progrmManageDAO.deleteProgrmChangeRequst_S", vo);
	}

	/**
	 * 프로그램변경요청 요청번호MAX 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 * @exception Exception
	 */
	public ProgrmManageDtlVO selectProgrmChangeRequstNo(ProgrmManageDtlVO vo){
		return (ProgrmManageDtlVO)selectByPk("progrmManageDAO.selectProgrmChangeRequstNo_D", vo);
	}

	/**
	 * 프로그램변경요청 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List selectChangeRequstProcessList(ComDefaultVO vo) throws Exception{
		return list("progrmManageDAO.selectChangeRequstProcessList_D", vo);
	}                                

    /**
	 * 프로그램변경요청 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectChangeRequstListProcessTotCnt(ComDefaultVO vo) {
        return (Integer)getSqlMapClientTemplate().queryForObject("progrmManageDAO.selectChangeRequstProcessListTotCnt_S", vo);
    }	

	/**
	 * 프로그램변경요청 처리 수정
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void updateProgrmChangeRequstProcess(ProgrmManageDtlVO vo){
		update("progrmManageDAO.updateProgrmChangeRequstProcess_S", vo);
	}
    
	
	/**
	 * 프로그램목록 전체삭제 초기화
	 * @return boolean
	 * @exception Exception
	 */
	public boolean deleteAllProgrm(){
		ProgrmManageVO vo = new ProgrmManageVO();
		update("progrmManageDAO.deleteAllProgrm", vo);
		return true;
	}

	/**
	 * 프로그램변경내역 전체삭제 초기화
	 * @return boolean
	 * @exception Exception
	 */
	public boolean deleteAllProgrmDtls(){
		ProgrmManageDtlVO vo = new ProgrmManageDtlVO();
		update("progrmManageDAO.deleteAllProgrmDtls", vo);
		return true;
	}

    /**
	 * 프로그램목록 데이타 존재여부 조회한다.
	 * @return int 
	 * @exception Exception  
	 */
    public int selectProgrmListTotCnt() {
    	ProgrmManageVO vo = new ProgrmManageVO();
        return (Integer)getSqlMapClientTemplate().queryForObject("progrmManageDAO.selectProgrmListTotCnt", vo);
    }	
	
	/**
	 * 프로그램변경요청자 Email 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 * @exception Exception
	 */
	public ProgrmManageDtlVO selectRqesterEmail(ProgrmManageDtlVO vo){
		return (ProgrmManageDtlVO)selectByPk("progrmManageDAO.selectRqesterEmail", vo);
	}
	
	/**
	 * 선택된 메뉴에 등록된 프로그램 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List selectRegistProgramList(int menuNm) throws Exception {
	
		return  getSqlMapClientTemplate().queryForList("progrmManageDAO.selectRegistProgramList", menuNm);
	}
	
	/**
	 * 등록된 프로그램의 상세정보 조회한다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public ProgrmManageVO selectProgramDetailInfo(Object param) throws Exception {
		return (ProgrmManageVO) getSqlMapClientTemplate().queryForObject("progrmManageDAO.selectProgramDetailInfo", param);
	}
	
	/**
	 * 프로그램 기본정보 및 URL을 수정, 신규추가, 2013-10-08, 이강민
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void updateProgramDetailInfo(ProgrmManageVO vo){
		update("progrmManageDAO.updateProgramDetailInfo", vo);
	}
	
	/**
	 * 화면에 조회된 프로그램을 삭제 처리 함, 신규추가, 2013-10-08, 이강민
	 * @param param
	 * @throws Exception
	 */
	public void deleteProgram(Object param) throws Exception {
		getSqlMapClientTemplate().delete("progrmManageDAO.deleteProgramDetailInfo", param);
	}
	
	/***
	 * 신규 프로그램 등록 처리 (신규추가) , 2013-10-08, 이강민
	 * @param vo
	 */
	public void insertProgrmRegist(ProgrmManageVO vo){
		insert("progrmManageDAO.insertProgramDetailInfo", vo);
	}
	
	/***
	 * 신규 등록을 위한 맥스 시퀀스 값을 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Object getMaxSequence(Object param) throws Exception {
		return getSqlMapClientTemplate().queryForObject("progrmManageDAO.selectNewSeq", param);
	}
	
}