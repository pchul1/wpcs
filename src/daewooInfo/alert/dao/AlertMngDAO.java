package daewooInfo.alert.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.alert.bean.AlertMngVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTestVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 상황 접수, 전파 일지 관리를 위한 데이터 접근 클래스
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
@Repository("alertMngDAO")
public class AlertMngDAO extends EgovAbstractDAO {

	
	/**
	 * 일지 목록을 가져온다.
	 * 
	 * @param AlertMngVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertMngVO> getAlertMngList(AlertMngVO vo) throws Exception {
		return list("alertMngDAO.getAlertMngList", vo);		
	}
	
	/**
	 * 해당 일지를 가져온다.
	 * 
	 * @param AlertMngVO
	 * @return
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	public AlertMngVO getAlertMng(AlertMngVO vo) throws Exception {
		return (AlertMngVO)selectByPk("alertMngDAO.getAlertMng", vo);		
	}		
	
	/**
	 * 해당 일지를 추가하거나 갱신한다.
	 * 
	 * @param AlertMngVO
	 * @return
	 * @throws Exception
	 */	
	public int mergeAlertMng(AlertMngVO vo) throws Exception {
		return update("alertMngDAO.mergeAlertMng", vo);
	}
	
	/**
	 * 해당 일지를 삭제한다.
	 * 
	 * @param AlertMngVO
	 * @return
	 * @throws Exception
	 */	
	public int deleteAlertMng(AlertMngVO vo) throws Exception {
		return update("alertMngDAO.deleteAlertMng", vo);
	}			
	
	
	/**
	 * 일지의 PK를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getAlertMngPk() throws Exception {
		return (Integer)selectByPk("alertMngDAO.getAlertMngPk", null);
	}		
	
	/**
	 * 일지의 갯수를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getAlertMngCnt() throws Exception {
		return (Integer)selectByPk("alertMngDAO.getAlertMngCnt", null);
	}		
	
	/**
	 * 해당일지에서 전파하는 조직 목록을 가져온다.
	 * 
	 * @param AlertMngVO
	 * @return
	 * @throws Exception
	 */	
	public String getAlertMngSpreadDept(AlertMngVO vo) throws Exception {
		return (String)selectByPk("alertMngDAO.getAlertMngSpreadDept", vo);
	}	
	public List<AlertTestVO> getTaksuTest(AlertTestVO vo) throws Exception {
		return list("alertSchDAO.getTaksuTest", vo);		
	}

	public int alertMngHistDelete(AlertStepVO alertStepVO) {
		return update("alertMngDAO.alertMngHistDelete", alertStepVO);
	}
}
