package daewooInfo.alert.service;

import java.util.HashMap;
import java.util.List;

import daewooInfo.alert.bean.AlertTargetVO;

/**
 * 전파대상관리를 위한 서비스 인터페이스 클래스
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
public interface AlertTargetService {
	
	/**
	 * 전파대상 목록을 가져온다.
	 * 
	 * @param AlertTargetVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertTargetVO> getAlertTargetList(AlertTargetVO vo) throws Exception;
	
	/**
	 * 해당하는 전파대상을 가져온다.
	 * 
	 * @param AlertTargetVO
	 * @return
	 * @throws Exception
	 */
	public AlertTargetVO getAlertTarget(AlertTargetVO vo) throws Exception;
		
	/**
	 * 전파대상을 추가하거나 갱신한다.
	 * 
	 * @param AlertTargetVO
	 * @return
	 * @throws Exception
	 */
	public int mergeAlertTarget(AlertTargetVO vo) throws Exception;
	
	/**
	 * 전파대상을 삭제한다.
	 * 
	 * @param AlertTargetVO
	 * @return
	 * @throws Exception
	 */
	public int deleteAlertTarget(AlertTargetVO vo) throws Exception;
	
	/**
	 * 전파대상의 PK를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getAlertTargetPk() throws Exception;
	
	/**
	 * 전파대상에 추가할 사용자 목록을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String, String>> getAlertTargetUser() throws Exception;	
	
	/**
	 * 이미 추가된 사용자인지 체크한다
	 * 
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getAlertTargetUserCheck(AlertTargetVO vo) throws Exception;
	
	/**
	 * 공구와 측정소에 해당하는 조직 목록을 가져온다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String, String>> getGroupList(HashMap<String, String> map) throws Exception;
	
	public List<HashMap<String, String>> getGroupAndMember(AlertTargetVO vo) throws Exception;
	
	public List<HashMap<String, String>> getSmsGroupList() throws Exception;
	
	public List<HashMap<String, String>> getSmsGroupListMobile(AlertTargetVO vo) throws Exception;
	
	public List<HashMap<String, String>> getSmsMemberList(AlertTargetVO alertTargetVO) throws Exception;
}
