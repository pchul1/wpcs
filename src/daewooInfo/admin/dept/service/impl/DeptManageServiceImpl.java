package daewooInfo.admin.dept.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import daewooInfo.admin.dept.bean.DeptManageVO;
import daewooInfo.admin.dept.dao.DeptManageDAO;
import daewooInfo.admin.dept.service.DeptManageService;
import daewooInfo.cmmn.bean.ComDefaultVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/** 
 * 부서관리를 처리하는 비즈니스 구현 클래스를 정의한다.
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

@Service("deptManageService")
public class DeptManageServiceImpl extends AbstractServiceImpl implements DeptManageService{

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	protected Log log = LogFactory.getLog(this.getClass());
	
	/**
	 * @uml.property  name="deptManageDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="deptManageDAO")
    private DeptManageDAO deptManageDAO;
	
	/**
	 * 부서번호 존재 여부를 조회한다.
	 * @param vo ComDefaultVO 
	 * @return int
	 * @exception Exception
	 */
    public int selectDeptNoByPk(DeptManageVO vo) throws Exception {
        return deptManageDAO.selectDeptNoByPk(vo);
	}
    
	/**
	 * 부서 정보를 등록
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void insertDeptManage(DeptManageVO vo) throws Exception {
		deptManageDAO.insertDeptManage(vo);
	}

	/**
	 * 부서 정보를 수정
	 * @param vo MenuManageVO 
	 * @exception Exception
	 */
	public void updateDeptManage(DeptManageVO vo) throws Exception {
		deptManageDAO.updateDeptManage(vo);
	}

	/**
	 * 부서 정보를 삭제
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void deleteDeptManage(DeptManageVO vo) throws Exception {
		deptManageDAO.deleteDeptManage(vo);
	}

	/**
	 * 부서 목록을 조회
	 * @return List
	 * @exception Exception
	 */
	public List selectDeptList() throws Exception {
   		return deptManageDAO.selectDeptList();
	}
}