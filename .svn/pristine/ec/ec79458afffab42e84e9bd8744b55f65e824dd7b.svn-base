package  daewooInfo.admin.dept.service;

import java.util.List;

import daewooInfo.admin.dept.bean.DeptManageVO;
import daewooInfo.cmmn.bean.ComDefaultVO;

/** 
 * 부서관리에 관한 서비스 인터페이스 클래스를 정의한다.
 * @author kisspa
 * @since 2010.07.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 * 2010.07.19  kisspa          최초 생성
 *
 * </pre>
 */

public interface DeptManageService {

	/**
	 * 부서번호 존재 여부를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
	int selectDeptNoByPk(DeptManageVO vo) throws Exception;
	
	/**
	 * 부서 정보를 등록
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	void insertDeptManage(DeptManageVO vo) throws Exception;

	/**
	 * 부서 정보를 수정
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	void updateDeptManage(DeptManageVO vo) throws Exception;

	/**
	 * 부서 정보를 삭제
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	void deleteDeptManage(DeptManageVO vo) throws Exception;

	/**
	 * 부서 목록을 조회
	 * @return List
	 * @exception Exception
	 */
	List selectDeptList() throws Exception;
}