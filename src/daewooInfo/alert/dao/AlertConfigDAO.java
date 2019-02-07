package daewooInfo.alert.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 경보환경설정을 위한 데이터 접근 클래스
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
@Repository("alertConfigDAO")
public class AlertConfigDAO extends EgovAbstractDAO {
	
	/**
	 * 경보환경설정 목록을 가져온다.
	 * 
	 * @param AlertSearchVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertConfigVO> getAlertConfigList(AlertSearchVO vo) throws Exception {
		return list("alertConfigDAO.getAlertConfigList", vo);
	}		
	
	/**
	 * 경보환경설정을 추가하거나 갱신한다.
	 * 
	 * @param AlertConfigVO
	 * @return
	 * @throws Exception
	 */
	public int mergeAlertConfig(AlertConfigVO vo) throws Exception {
		return update("alertConfigDAO.mergeAlertConfig", vo);
	}	
	public int updateAlertConfig(AlertConfigVO vo) throws Exception {
		return update("alertConfigDAO.updateAlertConfig", vo);
	}

	public AlertConfigVO getAlertConfigTimeView() throws Exception {
		return  (AlertConfigVO)selectByPk("alertConfigDAO.getAlertConfigTimeView", null);
	}
	
	public int mergeAlertConfigTime(AlertConfigVO vo) throws Exception {
		return update("alertConfigDAO.mergeAlertConfigTime", vo);
	}	
}
