package daewooInfo.alert.service;

import java.util.List;

import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertTaksuConfigVO;

/**
 * 탁수 경보전파설정을 위한 서비스 인터페이스 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
public interface AlertTaksuConfigService {
	
	/**
	 * 탁수 경보전파설정 목록을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<AlertTaksuConfigVO> getAlertTaksuConfig() throws Exception;
	
	/**
	 * 탁수 경보전파설정을 한다
	 * 
	 * @return
	 * @throws Exception
	 */
	public int mergeAlertTaksuConfig(AlertTaksuConfigVO vo) throws Exception;	
	
	/**
	 * 탁수 경보전파설정 로그 목록을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<AlertTaksuConfigVO> getAlertTaksuConfigHist(AlertSearchVO vo) throws Exception;
	
	/**
	 * 탁수 경보전파설정 로그를 저장 한다
	 * 
	 * @return
	 * @throws Exception
	 */
	public int insertAlertTaksuConfigHist(AlertTaksuConfigVO vo) throws Exception;	
}
