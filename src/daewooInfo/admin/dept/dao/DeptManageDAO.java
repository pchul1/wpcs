package daewooInfo.admin.dept.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.admin.dept.bean.DeptManageVO;
import daewooInfo.cmmn.bean.ComDefaultVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
/**
 * 부서관리에 대한 DAO 클래스를 정의한다.
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

@Repository("deptManageDAO")
public class DeptManageDAO extends EgovAbstractDAO{

	/**
	 * 부서목록 기본정보를 등록
	 * @param vo DeptManage 
	 * @exception Exception
	 */
	public void insertDeptManage(DeptManageVO vo){
		insert("deptManageDAO.insertDeptManage_S", vo);
	}

	/**
	 * 부서목록 기본정보를 수정
	 * @param vo DeptManage 
	 * @exception Exception
	 */
	public void updateDeptManage(DeptManageVO vo){
		update("deptManageDAO.updateDeptManage_S", vo);
	}

	/**
	 * 부서목록 기본정보를 삭제
	 * @param vo DeptManage
	 * @exception Exception
	 */
	public void deleteDeptManage(DeptManageVO vo){
		delete("deptManageDAO.deleteDeptManage_S", vo);
	}

	/**
	 * 부서 전체목록을 조회
	 * @return list  
	 * @exception Exception
	 */
	public List selectDeptList() throws Exception{
		ComDefaultVO vo  = new ComDefaultVO();
		return list("deptManageDAO.selectDeptListT_D", vo);
	}

	
	/**
	 * 부서번호 존재여부를 조회
	 * @param vo DeptManage 
	 * @return int 
	 * @exception Exception
	 */
	public int selectDeptNoByPk(DeptManageVO vo) throws Exception{
		return (Integer)selectByPk("deptManageDAO.selectDeptNoByPk", vo);  
	}
}