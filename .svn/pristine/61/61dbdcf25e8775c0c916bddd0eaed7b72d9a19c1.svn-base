package daewooInfo.admin.menu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.admin.menu.bean.ProgrmManageDtlVO;
import daewooInfo.admin.menu.bean.ProgrmManageVO;
import daewooInfo.admin.menu.dao.ProgrmManageDAO;
import daewooInfo.admin.menu.service.EgovProgrmManageService;
import daewooInfo.cmmn.bean.ComDefaultVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/** 
 * 프로그램목록관리 및 프로그램변경관리에 관한 비즈니스 구현 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 * 수정일	 		수정자			수정내용
 * -------		--------	---------------------------
 * 2009.03.20	이  용			최초 생성
 * 
 * </pre>
 */
@Service("progrmManageService")
public class EgovProgrmManageServiceImpl extends AbstractServiceImpl implements EgovProgrmManageService {

	/**
	 * @uml.property  name="progrmManageDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="progrmManageDAO")
	private ProgrmManageDAO progrmManageDAO;


	/**
	 * 프로그램 상세정보를 조회
	 * @param vo ComDefaultVO
	 * @return ProgrmManageVO 
	 * @exception Exception
	 */
	public ProgrmManageVO selectProgrm(ComDefaultVO vo) throws Exception{
			return progrmManageDAO.selectProgrm(vo);
	}
	/**
	 * 프로그램 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List 
	 * @exception Exception
	 */
	public List selectProgrmList(ComDefaultVO vo) throws Exception {
		return progrmManageDAO.selectProgrmList(vo);
	}
	/**
	 * 프로그램목록 총건수를 조회한다.
	 * @param vo  ComDefaultVO
	 * @return Integer
	 * @exception Exception
	 */
	public int selectProgrmListTotCnt(ComDefaultVO vo) throws Exception {
		return progrmManageDAO.selectProgrmListTotCnt(vo);
	}
	/**
	 * 프로그램 정보를 등록
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void insertProgrm(ProgrmManageVO vo) throws Exception {
		progrmManageDAO.insertProgrm(vo);
	}

	/**
	 * 프로그램 정보를 수정
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void updateProgrm(ProgrmManageVO vo) throws Exception {
		progrmManageDAO.updateProgrm(vo);
	}

	/**
	 * 프로그램 정보를 삭제
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void deleteProgrm(ProgrmManageVO vo) throws Exception {
		progrmManageDAO.deleteProgrm(vo);
	}

	/**
	 * 프로그램 파일 존재여부를 조회
	 * @param vo ComDefaultVO
	 * @return int  
	 * @exception Exception
	 */
	public int selectProgrmNMTotCnt(ComDefaultVO vo) throws Exception{
		return progrmManageDAO.selectProgrmNMTotCnt(vo);
	}	
	
	/**
	 * 프로그램변경요청 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 * @exception Exception
	 */
	public ProgrmManageDtlVO selectProgrmChangeRequst(ProgrmManageDtlVO vo) throws Exception{
		return progrmManageDAO.selectProgrmChangeRequst(vo);
	}

	/**
	 * 프로그램변경요청 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List selectProgrmChangeRequstList(ComDefaultVO vo) throws Exception {
		return progrmManageDAO.selectProgrmChangeRequstList(vo);
	}

	/**
	 * 프로그램변경요청목록 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
	public int selectProgrmChangeRequstListTotCnt(ComDefaultVO vo) throws Exception {
		return progrmManageDAO.selectProgrmChangeRequstListTotCnt(vo);
	}	

	/**
	 * 프로그램변경요청을 등록
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void insertProgrmChangeRequst(ProgrmManageDtlVO vo) throws Exception {
		progrmManageDAO.insertProgrmChangeRequst(vo);
	}

	/**
	 * 프로그램변경요청을 수정
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void updateProgrmChangeRequst(ProgrmManageDtlVO vo) throws Exception {
		progrmManageDAO.updateProgrmChangeRequst(vo);
	}

	/**
	 * 프로그램변경요청을 삭제
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void deleteProgrmChangeRequst(ProgrmManageDtlVO vo) throws Exception {
		progrmManageDAO.deleteProgrmChangeRequst(vo);
	}

	/**
	 * 프로그램변경요청 요청번호MAX 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 * @exception Exception
	 */
	public ProgrmManageDtlVO selectProgrmChangeRequstNo(ProgrmManageDtlVO vo) throws Exception {
		return progrmManageDAO.selectProgrmChangeRequstNo(vo);
	}

	/**
	 * 프로그램변경요청처리 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List selectChangeRequstProcessList(ComDefaultVO vo) throws Exception {
		return progrmManageDAO.selectChangeRequstProcessList(vo);
	}
	
	/**
	 * 프로그램변경요청처리목록 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
	public int selectChangeRequstProcessListTotCnt(ComDefaultVO vo) throws Exception {
		return progrmManageDAO.selectChangeRequstListProcessTotCnt(vo);
	}

	/**
	 * 프로그램변경요청처리를 수정
	 * @param vo ProgrmManageDtlVO
	 * @exception Exception
	 */
	public void updateProgrmChangeRequstProcess(ProgrmManageDtlVO vo) throws Exception {
		progrmManageDAO.updateProgrmChangeRequstProcess(vo);
	}

	/**
	 * 화면에 조회된 메뉴 목록 정보를 데이터베이스에서 삭제
	 * @param checkedProgrmFileNmForDel String
	 * @exception Exception
	 */
	public void deleteProgrmManageList(String checkedProgrmKoreanNmForDel) throws Exception {
		ProgrmManageVO vo = null;
		String [] delProgrmKoreanNm = checkedProgrmKoreanNmForDel.split(",");
		for (int i=0; i<delProgrmKoreanNm.length ; i++){
			vo = new ProgrmManageVO();
			vo.setProgrmKoreanNm(delProgrmKoreanNm[i]);
			progrmManageDAO.deleteProgrm(vo);
		}
	}

	/**
	 * 프로그램변경요청자 Email 정보를 조회
	 * @param vo ProgrmManageDtlVO
	 * @return ProgrmManageDtlVO
	 * @exception Exception
	 */
	public ProgrmManageDtlVO selectRqesterEmail(ProgrmManageDtlVO vo) throws Exception{
		return progrmManageDAO.selectRqesterEmail(vo);
	}
	
	/**
	 * 프로그램 목록 조회...
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectRegistProgramList(int menuNm) throws Exception {
		List list =  progrmManageDAO.selectRegistProgramList(menuNm);
		return list;
	}
	
	public ProgrmManageVO selectRegistProgramList(Object param) throws Exception {
		Object data = null;
		data = progrmManageDAO.selectProgramDetailInfo(param);
		
		return (ProgrmManageVO) data;
	}
	
	/**
	 * 프로그램 정보를 수정, 2013.10.08, 이강민 추가
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	public void updateProgramDetailInfo(ProgrmManageVO vo) throws Exception {
		progrmManageDAO.updateProgramDetailInfo(vo);
	}
	
	/**
	 * 화면에 조회된 프로그램을 삭제, 신규추가, 2013-10-08, 이강민
	 */
	public void deleteProgram(Object param) throws Exception {
		progrmManageDAO.deleteProgram(param);
	}
	
	/**
	 * 프로그램 신규 추가( 신규 추가), 2013-10-08, 이강민
	 */
	public void insertProgrmInfo(ProgrmManageVO vo) throws Exception {
		progrmManageDAO.insertProgrmRegist(vo);
	}
	
	public Object getMaxSequence(Object param) throws Exception {
		Object seq = null;
		seq = progrmManageDAO.getMaxSequence(param);
		return seq;
	}
	
	
}