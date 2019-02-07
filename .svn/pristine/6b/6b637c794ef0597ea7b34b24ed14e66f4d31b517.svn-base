package daewooInfo.alert.service;

import java.util.List;

import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertSearchVO;

/**
 * 경보환경설정을 위한 서비스 인터페이스 클래스
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
public interface AlertConfigService {
	/**
	 * 경보환경설정 목록을 가져온다.
	 * 
	 * @param AlertSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertConfigVO> getAlertConfigList(AlertSearchVO vo) throws Exception;
	
	/**
	 * 경보환경설정을 추가하거나 갱신한다.
	 * 
	 * @param AlertConfigVO
	 * @return
	 * @throws Exception
	 */
	public int mergeAlertConfig(AlertConfigVO vo) throws Exception;
	
	public int updateAlertConfig(AlertConfigVO vo) throws Exception;
	
	/**
	 * 경보기준을 가져옵니다
	 * @param vo
	 * @return
	 */
	public AlertConfigVO getAlertConfigTimeView() throws Exception;
	
	
	public int mergeAlertConfigTime(AlertConfigVO vo) throws Exception;
}
