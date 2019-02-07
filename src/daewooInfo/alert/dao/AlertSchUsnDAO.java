package daewooInfo.alert.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("alertSchUsnDAO")
public class AlertSchUsnDAO  extends EgovAbstractDAO{
	
	 
	/** *IP-USN 사업장별 측정값 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertMinVO> getMinList() throws Exception { 
		return list("alertSchUsnDAO.getMinList",null);
	}  
	/** IP-USN 경보기준을 가져온다.
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertLawVO getFactLaw(AlertSearchVO alertSearchVO) throws Exception { 
		return (AlertLawVO)selectByPk("alertSchUsnDAO.getLaw", alertSearchVO); 
	} 
	/**IP-USN 경보 환경
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertConfigVO getConfig(AlertSearchVO alertSearchVO) throws Exception{
		return (AlertConfigVO)selectByPk("alertSchUsnDAO.getConfig", alertSearchVO);
	}
	/** IP-USN 최근데이터
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public AlertStepLastVO getLastIpusnAlert(AlertSearchVO vo) throws Exception {
		return (AlertStepLastVO)selectByPk("alertSchUsnDAO.getLastIpusnAlert", vo);
	}
	/**상태변경
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateStepAlertCount(AlertStepVO vo) throws Exception {
		return update("alertSchUsnDAO.updateStepAlertCount", vo);
	} 
	
	
}
