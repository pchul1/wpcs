package daewooInfo.edu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.edu.bean.EduSearchVO;
import daewooInfo.edu.dao.EduManageDAO;
import daewooInfo.edu.service.EduManageService;
import daewooInfo.warehouse.bean.ItemCalcSearchVO;
import daewooInfo.warehouse.bean.ItemCodeSearchVO;
import daewooInfo.warehouse.bean.ItemCodeVO;
import daewooInfo.warehouse.bean.SearchVO;
import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.warehouse.bean.WareHouseVO;
import daewooInfo.warehouse.dao.WareHouseManageDAO;
import daewooInfo.warehouse.service.WareHouseManageService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 
 * 교육 및 교육 대상자에 대한 서비스 구현클래스를 정의한다
 * @author kisspa
 * @since 2010.09.02
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.09.02  kisspa          최초 생성
 *
 * </pre>
 */

@Service("EduManageService")
public class EduManageServiceImpl extends AbstractServiceImpl implements EduManageService {

    /**
	 * @uml.property  name="eduManageDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="EduManageDAO")
    private EduManageDAO eduManageDAO;

	public int deleteEdu(EduSearchVO vo) throws Exception {
		return eduManageDAO.deleteEdu(vo);
	}

	public int deleteEduMember(EduSearchVO vo) throws Exception {
		return eduManageDAO.deleteEduMember(vo);
	}

	public List<EduSearchVO> eduDataListAll(EduSearchVO vo) throws Exception {
		return eduManageDAO.eduDataListAll(vo);
	}
	
	public List<EduSearchVO> eduDataList(EduSearchVO vo) throws Exception {
		return eduManageDAO.eduDataList(vo);
	}

	public int eduDataListCnt(EduSearchVO vo) throws Exception {
		return eduManageDAO.eduDataListCnt(vo);
	}

	public List<EduSearchVO> eduMemberDataList(EduSearchVO vo) throws Exception {
		return eduManageDAO.eduMemberDataList(vo);
	}

	public int eduMemberDataListCnt(EduSearchVO vo) throws Exception {
		return eduManageDAO.eduMemberDataListCnt(vo);
	}

	public int mergeEdu(EduSearchVO vo) throws Exception {
		return eduManageDAO.mergeEdu(vo);
	}

	public int insertEduMember(EduSearchVO vo) throws Exception {
		return eduManageDAO.insertEduMember(vo);
	}

	public int isOverCapacityCnt(EduSearchVO vo) throws Exception {
		return eduManageDAO.isOverCapacityCnt(vo);
	}

	public int isEduRigisterCnt(EduSearchVO vo) throws Exception {
		return eduManageDAO.isEduRigisterCnt(vo);
	}

	public List<EduSearchVO> myEduDataList(EduSearchVO vo) throws Exception {
		return eduManageDAO.myEduDataList(vo);
	}

	public int myEduDataListCnt(EduSearchVO vo) throws Exception {
		return eduManageDAO.myEduDataListCnt(vo);
	}

}
