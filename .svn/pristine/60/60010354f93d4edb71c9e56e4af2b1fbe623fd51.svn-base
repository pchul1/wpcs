package daewooInfo.common.alrim.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import daewooInfo.common.alrim.bean.AlrimVO;

/**
 * 알림 안내 Service 클래스
 * @author 박미영
 * @since 2014.09.04
 * @version 1.0
 * @see
 */
public interface AlrimService {
	/**
	 * 알림 전체 목록을 조회
	 * @param alrimVO
	 * @return List(알림 목록)
	 * @throws Exception
	 */
	List<AlrimVO> selectAlrimList(AlrimVO alrimVO) throws Exception;
	
	int selectAlrimtotList(AlrimVO alrimVO) throws Exception;
	
	/**
	 * 알림 내용을 삽입
	 * 알림 구분    	S : 교육알림 , 
	 * 			D : 결제알림(일지) , 
	 * 			W : 확정알림(데이터 선별), 
	 * 			P : 사고발생
	 * @param alrimVO
	 * @return String(알림 목록)
	 * @throws Exception
	 */
	String insertAlrim(AlrimVO alrimVO) throws Exception;
	
	/**
	 * 알림 내용을 확인
	 * @param alrimVO
	 * @return String(알림 목록)
	 * @throws Exception
	 */
	void updateAlrim(AlrimVO alrimVO) throws Exception;

	/**
	 * 알림 총카운트 조회
	 * @param alrimVO
	 * @return int(알림 총 카운트)
	 * @throws Exception
	 */
	int selectAlrimListTotCount(AlrimVO alrimVO) throws Exception;

	/**
	 * 알림 미확인 목록을 조회
	 * @param alrimVO
	 * @return List(알림 목록)
	 * @throws Exception
	 */
	List<AlrimVO> selectUnConfirmAlrimList(AlrimVO alrimVO) throws Exception;

	/**
	 * 알림 전체 목록을 조회
	 * @param alrimVO
	 * @return List(알림 목록)
	 * @throws Exception
	 */
	List<AlrimVO> selectMobileSeminarAlrimList(AlrimVO alrimVO) throws Exception;
	
	/**
	 * 알림 미확인 카운트 조회
	 * @param alrimVO
	 * @return int(알림 미확인 카운트)
	 * @throws Exception
	 */
	int selectUnConfirmAlrimCount(AlrimVO alrimVO) throws Exception;
	

	/**
	 * 알림 내용을 일괄적으로 확인
	 * @param alrimVO
	 * @return String(알림 목록)
	 * @throws Exception
	 */
	void updateAlrimList(AlrimVO alrimVO,HttpServletRequest request) throws Exception;
	
	/**
	 * 알람 삭제
	 * @param alrimVO
	 * @throws Exception
	 */  
	void deleteAlrim(AlrimVO alrimVO,HttpServletRequest request) throws Exception;
}