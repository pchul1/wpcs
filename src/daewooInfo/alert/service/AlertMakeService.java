package daewooInfo.alert.service;

import java.util.List;
import java.util.HashMap;

import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertHourVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertSmsListSearchVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.cmmn.bean.FileVO;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 3. 26  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

/**
 * @author Admin
 *
 */
/**
 * @author Admin
 *
 */
public interface AlertMakeService {
	
	/**
	 * 새로 들어온 분 데이터를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<AlertMinVO> getMinList() throws Exception;
	/**
	 * 새로 들어온 시간 데이터를 가져온다. (미사용)
	 *  
	 * @return
	 * @throws Exception
	 */
	public List<AlertHourVO> getHourList() throws Exception;
	/**
	 * 보내는 사람의 번호를 가져온다. 방제센터 번호
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertCallBackVO getCallBack(AlertSearchVO alertSearchVO) throws Exception;
	/**
	 * 경보 기준을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertLawVO getLaw(AlertSearchVO alertSearchVO) throws Exception;
	/**
	 * 공구,사업장의 이름을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public String getFactName(AlertSearchVO alertSearchVO) throws Exception;	
	/**
	 * 측정항목의 이름을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public String getItemName(AlertSearchVO alertSearchVO) throws Exception;
	/**
	 * 경보 환경 설정을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertConfigVO getConfig(AlertSearchVO alertSearchVO) throws Exception;
	/**
	 * 경보 발송 대상자를 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertTargetVO> getTargetList(AlertSearchVO alertSearchVO) throws Exception;
	/**
	 * 수동 경보 발송 대상자를 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertTargetVO> getTargetManualList(HashMap map) throws Exception;
	/**
	 * 신고접수 발송 대상자를 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertTargetVO> getTargetSmSList(HashMap map) throws Exception;
	 
	/**
	 * 오염 판단이 끝난 자료를 업데이트한다.(min_dcd=0) 
	 * 
	 * @return
	 * @throws Exception
	 */
	public int updateMin() throws Exception;
	/**
	 * 오염 단계를 분자료 테이블에 업데이트한다.
	 * 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateMinOr(HashMap paramMap) throws Exception;
	/**
	 * SMS 발송 메세지 내역을 가져온다.
	 * 
	 * @param HashMap
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> getSendSmsMsgList(HashMap map) throws Exception;
	/**
	 * SMS 발송 메세지를 저장한다.
	 * 
	 * @param HashMap
	 * @return
	 * @throws Exception
	 */
	public int saveSmsMsgList(HashMap map) throws Exception;
	
	/**
	 * 이전메세지 조회용 SMS저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String saveSmsMsgHist(HashMap map) throws Exception;
	public void saveSmsMsgHistDetail(HashMap map) throws Exception;
	
	/**
	 * SMS수신인 목록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<HashMap> getSendSmsMsgMemberList(HashMap map) throws Exception;
	
	/**
	 * SMS 발송 이력을 가져온다.
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public List<AlertSmsListVO> getSmsDataList(AlertSmsListSearchVO alertSmsListSearchVO) throws Exception;
	
	/**
	 * SMS 발송 이력 카운트
	 * @param alertSmsListSearchVO
	 * @return
	 * @throws Exception
	 */
	public int getSmsDataListCount(AlertSmsListSearchVO alertSmsListSearchVO) throws Exception;
	
	public String getAddressFileSeq(HashMap map) throws Exception;
	
	public void insertAddressFileInfs(List<FileVO> result) throws Exception;
}