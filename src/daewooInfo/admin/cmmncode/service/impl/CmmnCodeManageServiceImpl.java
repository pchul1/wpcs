package daewooInfo.admin.cmmncode.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.admin.cmmncode.bean.CmmnCode;
import daewooInfo.admin.cmmncode.bean.CmmnCodeVO;
import daewooInfo.admin.cmmncode.dao.CmmnCodeManageDAO;
import daewooInfo.admin.cmmncode.service.CmmnCodeManageService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 
 * 공통코드에 대한 서비스 구현클래스를 정의한다
 * @author kisspa
 * @since 2010.06.18
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.06.18  kisspa          최초 생성
 *
 * </pre>
 */
@Service("CmmnCodeManageService")
public class CmmnCodeManageServiceImpl extends AbstractServiceImpl implements CmmnCodeManageService {

    /**
	 * @uml.property  name="cmmnCodeManageDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="CmmnCodeManageDAO")
    private CmmnCodeManageDAO cmmnCodeManageDAO;
    
	/**
	 * 공통코드를 삭제한다.
	 */
	public void deleteCmmnCode(CmmnCode cmmnCode) throws Exception {
		cmmnCodeManageDAO.deleteCmmnCode(cmmnCode);
	}

	/**
	 * 공통코드를 등록한다.
	 */
	public void insertCmmnCode(CmmnCode cmmnCode) throws Exception {
    	cmmnCodeManageDAO.insertCmmnCode(cmmnCode);
	}

	/**
	 * 공통코드 상세항목을 조회한다.
	 */
	public List selectCmmnCodeDetail(CmmnCode cmmnCode) throws Exception {
		return cmmnCodeManageDAO.selectCmmnCodeDetail(cmmnCode);
	}

	/**
	 * 공통코드 목록을 조회한다.
	 */
	public List selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception {
        return cmmnCodeManageDAO.selectCmmnCodeList(searchVO);
	}

	/**
	 * 공통코드 총 갯수를 조회한다.
	 */
	public int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO) throws Exception {
        return cmmnCodeManageDAO.selectCmmnCodeListTotCnt(searchVO);
	}

	/**
	 * 공통코드를 수정한다.
	 */
	public void updateCmmnCode(CmmnCode cmmnCode) throws Exception {
		cmmnCodeManageDAO.updateCmmnCode(cmmnCode);
	}
	
	/**
	 * 공통상세코드를 수정한다.
	 */
	public int updateCmmnDetailCode(CmmnCode cmmnCode) throws Exception {
		return cmmnCodeManageDAO.updateCmmnDetailCode(cmmnCode);
	}
	
	/**
	 * 공통코드를 중복체크 한다.
	 */
	public int dupCmnCode(CmmnCode cmmnCode) throws Exception {
		return cmmnCodeManageDAO.dupCmnCode(cmmnCode);
	}

}
