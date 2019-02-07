package daewooInfo.alert.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 경보기준설정을 위한 데이터 접근 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.06.28  김태훈          최초 생성
 *
 * </pre>
 */
@Repository("alertLawDAO")
public class AlertLawDAO extends EgovAbstractDAO {

	/**
	 * 경보기준설정 목록을 가져온다.
	 * 
	 * @param AlertSearchVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertLawVO> getFactLawList(AlertSearchVO vo) throws Exception {
		return list("alertLawDAO.getFactLawList", vo);
	}		

	/**
	 * VOC의 FID 항목에 대한 ECD항목의 기준설정값을 가져온다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertLawVO> getAlertLawSubList(AlertSearchVO vo) throws Exception {
		return list("alertLawDAO.getAlertLawSubList", vo);
	}	
	
	/**
	 * VOC의 FID 항목에 대한 ECD항목의 기준설정값을 가져온다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertLawVO> getAlertLawSubList_empty(AlertSearchVO vo) throws Exception {
		return list("alertLawDAO.getAlertLawSubList_empty", vo);
	}	
	
	
	/**
	 * 경보기준설정을 추가하거나 갱신한다.
	 * 
	 * @param AlertLawVO
	 * @return
	 * @throws Exception
	 */
	public int mergeFactLaw(AlertLawVO vo) throws Exception {
		return update("alertLawDAO.mergeFactLaw", vo);
	}
	
	/**
	 * 경보기준설정을 추가하거나 갱신한다.
	 * 
	 * @param AlertLawVO
	 * @return
	 * @throws Exception
	 */
	public int mergeAlertLawSub(AlertLawVO vo) throws Exception {
		return update("alertLawDAO.mergeAlertLawSub", vo);
	}
	
	
	public int updateFactLaw(AlertLawVO vo) throws Exception {
		return update("alertLawDAO.updateFactLaw", vo);
	}
	/**
	 * 경보기준설정을 삭제한다.(미사용)
	 * 
	 * @param AlertLawVO vo
	 * @return
	 * @throws Exception
	 */
	public int deleteFactLaw(AlertLawVO vo) throws Exception {
		return update("alertLawDAO.deleteFactLaw", vo);
	}				
	
	public AlertDataLawVo getFactLaw(AlertSearchVO vo)
	{
		return (AlertDataLawVo)selectByPk("alertSchDAO.getFactLaw", vo);
	}
	
}
