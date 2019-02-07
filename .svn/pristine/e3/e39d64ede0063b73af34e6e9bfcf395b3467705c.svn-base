package daewooInfo.edu.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.edu.bean.EduSearchVO;
import daewooInfo.warehouse.bean.ItemCalcSearchVO;
import daewooInfo.warehouse.bean.ItemCodeSearchVO;
import daewooInfo.warehouse.bean.ItemCodeVO;
import daewooInfo.warehouse.bean.SearchVO;
import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.warehouse.bean.WareHouseVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 교육 및 교육 신청에 대한 데이터 접근 클래스를 정의한다
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
@Repository("EduManageDAO")
public class EduManageDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(EduManageDAO.class);
	
    /**
     * 교육 데이터 목록 전체 (페이징 없음)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<EduSearchVO> eduDataListAll(EduSearchVO vo) throws Exception {
    	return list("EduManageDAO.eduDataListAll", vo);
    }
    
    /**
     * 교육 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<EduSearchVO> eduDataList(EduSearchVO vo) throws Exception {
    	return list("EduManageDAO.eduDataList", vo);
    }
    
    /**
     * 교육 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int eduDataListCnt(EduSearchVO vo) throws Exception {
    	return (Integer)selectByPk("EduManageDAO.eduDataListCnt", vo);
    }
    
    /**
     * 교육 삭제
     * @param vo
     * @return
     * @throws Exception
     */
    public int deleteEdu(EduSearchVO vo) throws Exception {
    	int memberCnt = delete("EduManageDAO.deleteEduMemberAll", vo);
    	int eduCnt = delete("EduManageDAO.deleteEdu", vo);
    	return (Integer)(memberCnt+eduCnt);
    }
    
    /**
     * 교육 데이터 mergeinto
     * @param vo
     * @return
     * @throws Exception
     */
    public int mergeEdu(EduSearchVO vo) throws Exception {
    	return (Integer)update("EduManageDAO.mergeEdu", vo);
    }
    
    /**
     * 교육 신청자 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<EduSearchVO> eduMemberDataList(EduSearchVO vo) throws Exception {
    	return list("EduManageDAO.eduMemberDataList", vo);
    }
    
    /**
     * 교육 신청자 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int eduMemberDataListCnt(EduSearchVO vo) throws Exception {
    	return (Integer)selectByPk("EduManageDAO.eduMemberDataListCnt", vo);
    }
    
    /**
     * 교육 신청자 삭제
     * @param vo
     * @return
     * @throws Exception
     */
    public int deleteEduMember(EduSearchVO vo) throws Exception {
    	return (Integer)delete("EduManageDAO.deleteEduMember", vo);
    }
    
    /**
     * 교육 신청자 merge into
     * @param vo
     * @return
     * @throws Exception
     */
    public int insertEduMember(EduSearchVO vo) throws Exception {
    	return (Integer)update("EduManageDAO.insertEduMember", vo);
    }
    
    /**
     * 정원 초과 체크
     * @param vo
     * @return
     * @throws Exception
     */
    public int isOverCapacityCnt(EduSearchVO vo) throws Exception {
    	return (Integer)selectByPk("EduManageDAO.isOverCapacityCnt", vo);
    }
    
    /**
     * 교육이 신청되어 있는지 체크
     * @param vo
     * @return
     * @throws Exception
     */
    public int isEduRigisterCnt(EduSearchVO vo) throws Exception {
    	return (Integer)selectByPk("EduManageDAO.isEduRigisterCnt", vo);
    }
    
    /**
     * 나의 신청한 교육 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<EduSearchVO> myEduDataList(EduSearchVO vo) throws Exception {
    	return list("EduManageDAO.myEduDataList", vo);
    }
    
    /**
     * 나의 신청한 교육 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int myEduDataListCnt(EduSearchVO vo) throws Exception {
    	return (Integer)selectByPk("EduManageDAO.myEduDataListCnt", vo);
    }
}
