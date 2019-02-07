package daewooInfo.alert.service;

import java.util.List;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertSearchVO;

/**
 * 경보기준설정을 위한 서비스 인터페이스 클래스
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
public interface AlertLawService {
	/**
	 * 경보기준설정 목록을 가져온다.
	 * 
	 * @param AlertSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertLawVO> getAlertLawList(AlertSearchVO vo) throws Exception;
	
	/**
	 * VOC의 FID항목에 대한 ECD항목의 기준설정값을 가져온다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertLawVO> getAlertLawSubList(AlertSearchVO vo) throws Exception;
	
	
	/**
	 * VOC의 FID항목에 대한 ECD항목의 기준설정값을 가져온다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertLawVO> getAlertLawSubList_empty(AlertSearchVO vo) throws Exception;
		

	/**
	 * 경보기준설정을 추가하거나 갱신한다.
	 * 
	 * @param AlertLawVO
	 * @return
	 * @throws Exception
	 */
	public int mergeAlertLaw(AlertLawVO vo) throws Exception;
	
	/**
	 * 경보기준설정을 추가하거나 갱신한다.
	 * 
	 * @see daewooInfo.alert.service.AlertLawService#mergeAlertLaw(daewooInfo.alert.bean.AlertLawVO)
	 */
	public int mergeAlertLawSub(AlertLawVO vo) throws Exception;
	
	
	/**경보기준설정 수정
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int updateFactLaw(AlertLawVO vo) throws Exception;
	
	
	/**
	 * 경보기준설정을 삭제한다.(미사용)
	 * 
	 * @param AlertLawVO
	 * @return
	 * @throws Exception
	 */
	public int deleteAlertLaw(AlertLawVO vo) throws Exception;
	
	/**
	 * 경보기준을 가져옵니다
	 * @param vo
	 * @return
	 */
	public AlertDataLawVo getFactLaw(AlertSearchVO vo) throws Exception;
}
