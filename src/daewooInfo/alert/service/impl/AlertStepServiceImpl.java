package daewooInfo.alert.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.alert.dao.AlertStepDAO;
import daewooInfo.alert.service.AlertStepService;
import daewooInfo.cmmn.bean.FileVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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

@Service("alertStepService")
public class AlertStepServiceImpl extends AbstractServiceImpl implements AlertStepService {
	
	/**
	 * @uml.property  name="alertStepDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertStepDAO")
	private AlertStepDAO alertStepDAO;	
	
	/**
	 * @uml.property  name="alertSchDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertSchDAO")
	private AlertSchDAO alertSchDAO;
	
	/**
	 * @uml.property  name="alertMakeDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertMakeDAO")
	private AlertMakeDAO alertMakeDAO;

	public int insertAlertStep(AlertStepVO vo) throws Exception{
		return alertStepDAO.insertAlertStep(vo);
	}
	
	public int insertAlertStepSub(AlertStepVO vo) throws Exception{
		return alertStepDAO.insertAlertStepSub(vo);
	}
	
	public int updateAlertStep(AlertStepVO vo) throws Exception{
		return alertStepDAO.updateAlertStep(vo);
	}
	
	public String getMaxAsId() throws Exception {
		return alertStepDAO.getMaxAsId();
	}
	
	public List<AlertStepVO> getAlertStepList(AlertStepVO vo) throws Exception{
		return alertStepDAO.getAlertStepList(vo);
	}
	
	public List<AlertStepVO> getAlertStepSubList(AlertStepVO vo) throws Exception{
		return alertStepDAO.getAlertStepSubList(vo);
	}
	
	public AlertStepVO getAlertStep(AlertStepVO vo) throws Exception{
		return alertStepDAO.getAlertStep(vo);
	}

	public int getAlertStepListCount(AlertStepVO vo) throws Exception { 
		return alertStepDAO.getAlertStepListCount(vo);
	}
    
	@SuppressWarnings("unchecked")
    public String insertAlertFileInfs(List fvoList) throws Exception {
	String atchFileId = "";
	
	if (fvoList.size() != 0) {
	    atchFileId = alertStepDAO.insertAlertFileInfs(fvoList);
	} 
	return atchFileId;
    }

	/* 파일에 대한 상세정보를 조회한다.
	 * @see daewooInfo.alert.service.AlertStepService#selectAlertFileInf(daewooInfo.cmmn.bean.FileVO)
	 */
	public FileVO selectAlertFileInf(FileVO fvo) throws Exception { 
		return alertStepDAO.selectAlertFileInf(fvo);
	} 
	
	
	/**
	 * 경보발령 문자 발송
	 * @return
	 */
	public boolean sendSMS(AlertStepVO alertStepVO) throws Exception
	{
		boolean result = true;
		
		AlertSendDataVO sendData = new AlertSendDataVO();
		AlertSearchVO alertSearchVO = new AlertSearchVO();

		alertSearchVO.setFactCode(alertStepVO.getFactCode());
		alertSearchVO.setBranchNo(alertStepVO.getBranchNo());
		alertSearchVO.setItemCode(alertStepVO.getItemCode());
		
		sendData.setFactCode(alertStepVO.getFactCode());
		sendData.setBranchNo(alertStepVO.getBranchNo());
		sendData.setItemCode(alertStepVO.getItemCode());
		sendData.setMinOr(alertStepVO.getMinOrNum());
	
	
		AlertDataLawVo alertLawVO =alertSchDAO.getFactLaw(alertSearchVO); 
		
		if(alertLawVO.getSmsFlag() != null)
		{
			sendData.setMsgKind("SMS");
			sendData.setAlertType("WARNN"); 
			sendData.setMsg(alertStepVO.getItemName());
			sendData.setAlertMsg("경보발령");
			sendData.setAlertStep(alertStepVO.getAlertCount());	//전파 프로세스 단계
			sendData.setSendFlag("N");
			this.alertSmsSendData(sendData);
		}
		
		if(alertLawVO.getArsFlag() != null)
		{
			sendData.setMsgKind("ARS");
			sendData.setAlertType("WARNN"); 
			sendData.setMsg("안녕하십니까? 한국환경공단 방제센터입니다...");
			sendData.setAlertMsg("경보발령");
			sendData.setAlertStep(alertStepVO.getAlertCount());	//전파 프로세스 단계
			sendData.setSendFlag("N");
			this.alertArsSendData(sendData);
		}
		
		return result;
	}
	
	
	/**
	 * 추가상황전파
	 * @return
	 */
	public boolean addSendSMS(AlertStepVO alertStepVO, String[] members, String msg) throws Exception
	{
		boolean result = true;
		
		AlertSendDataVO sendData = new AlertSendDataVO();
		AlertSearchVO alertSearchVO = new AlertSearchVO();

		alertSearchVO.setFactCode(alertStepVO.getFactCode());
		alertSearchVO.setBranchNo(alertStepVO.getBranchNo());
		alertSearchVO.setItemCode(alertStepVO.getItemCode());
		
		sendData.setFactCode(alertStepVO.getFactCode());
		sendData.setBranchNo(alertStepVO.getBranchNo());
		sendData.setItemCode(alertStepVO.getItemCode());
		sendData.setMinOr(alertStepVO.getMinOrNum());
	
	
		AlertDataLawVo alertLawVO =alertSchDAO.getFactLaw(alertSearchVO); 
		
		if(alertLawVO.getSmsFlag() != null)
		{
			sendData.setMsgKind("SMS");
			sendData.setAlertType("WARN2"); //추가상황전파
			sendData.setMsg(msg);
			sendData.setAlertMsg("");
			sendData.setAlertStep(alertStepVO.getAlertCount());	//전파 프로세스 단계
			sendData.setSendFlag("N");
			this.sendManualSms(sendData, members);
		}
		
		if(alertLawVO.getArsFlag() != null)
		{
			sendData.setMsgKind("ARS");
			sendData.setAlertType("WARN2");  //추가상황전파
			sendData.setMsg(msg);
			sendData.setAlertMsg("");
			sendData.setAlertStep(alertStepVO.getAlertCount());	//전파 프로세스 단계
			sendData.setSendFlag("N");
			this.sendManualSms(sendData, members);
		}
		
		return result;
	}
	
	
	/**
	 * SMS 전송
	 */
	public int alertSmsSendData(AlertSendDataVO sendData){ 
		// sms 보내는 담당자 번호  1666-0128  
		int result = 0;
		try {
			
			//경보 발령 대상자를 추출한다.
			List<AlertTargetVO> alertTargetList =alertSchDAO.getTargetList(sendData); 
			log.debug("##### 경보 발령 대상자 ="+alertTargetList.size()); 
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) { 
					
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j); 
					String atPart 		= alertTargetVO.getAtPart();
					String atPartGubun  = alertTargetVO.getAtPartGubun();
					String atName 		= alertTargetVO.getAtName(); 
					String atSmsTele 	= alertTargetVO.getAtSmsTele(); 
					
					if(alertTargetVO.getAtSmsTele() !=null && alertTargetVO.getAtSms().equals("S")){ 
						sendData.setPart(atPart); 
						sendData.setSendName("방제정보시스템");
						sendData.setSendTel("1666-0128");
						sendData.setReceiveName(atName);
						sendData.setReceiveTel(atSmsTele);
						sendData.setAlertKind("S");
						result =alertSchDAO.insertAlertSendData(sendData); 
					} 
				}
			}else{
				result = -1; //대상이 없음.
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(" SMS SEND ERROR 에러 : " + e.getMessage());
		}
		return result; 
	} 
	
	/**
	 * ARS 전송
	 */
	public int alertArsSendData(AlertSendDataVO sendData){ 
		// sms 보내는 담당자 번호  1666-0128  
		int result = 0;
		try {
			
			//경보 발령 대상자를 추출한다.
			List<AlertTargetVO> alertTargetList =alertSchDAO.getTargetList(sendData); 
			log.debug("##### 경보 발령 대상자 ="+alertTargetList.size()); 
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) { 
					
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j); 
					String atPart 		= alertTargetVO.getAtPart();
					String atPartGubun  = alertTargetVO.getAtPartGubun();
					String atName 		= alertTargetVO.getAtName(); 
					String atSmsTele 	= alertTargetVO.getAtSmsTele(); 
					String atAcs 		= alertTargetVO.getAtArs();
					
					if(atAcs!=null ){ 
						//현재는 SMS의 핸드폰번호로 발송하도록 함.
						sendData.setPart(atPart); 
						sendData.setSendName("방제정보시스템");
						sendData.setSendTel("1666-0128");
						sendData.setReceiveName(atName);
						sendData.setReceiveTel(atSmsTele);
						sendData.setAlertKind("A");
						result =alertSchDAO.insertAlertSendData(sendData); 
					} 
				}
			}else{
				result = -1; //대상이 없음.
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(" SMS SEND ERROR 에러 : " + e.getMessage());
		}
		return result; 
	} 
	
	/**
	 * 경보발령 단계에서 전송된SMS/ARS리스트를 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	 public List<AlertSendDataVO> getSendWarningMsg(AlertStepVO vo) throws Exception{
		 	return alertStepDAO.getSendWarningMsg(vo);
	  }
	 
	 
	 public int sendManualSms(AlertSendDataVO sendData, String[] memberId) throws Exception {		
		 
		 	// sms 보내는 담당자 번호  1666-0128  
			int result = 0;
					
			try {
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("memberId", memberId);

				List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetManualList(map);
				
				
				if(alertTargetList.size() > 0) {
					for (int j=0; j < alertTargetList.size(); j++) {
						AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
						
						String atPart = alertTargetVO.getAtPart();
						String atName = alertTargetVO.getAtName();
						String atSms = alertTargetVO.getAtSms();
						String atSmsTele = alertTargetVO.getAtSmsTele();
										
							if(alertTargetVO.getAtSmsTele() !=null){ 
								sendData.setPart(atPart); 
								sendData.setSendName("방제정보시스템");
								sendData.setSendTel("1666-0128");
								sendData.setReceiveName(atName);
								sendData.setReceiveTel(atSmsTele);
								sendData.setAlertKind("S");
								result =alertSchDAO.insertAlertSendData(sendData); 
							} 
						
						
						}//end if (atSms != null)
					}//end for (int j=0; j < alertTargetList.size(); j++)
				
			} catch (Exception e) {
				e.printStackTrace();
				log.error(" SMS SEND ERROR 에러 : " + e.getMessage());
			}
			return result; 
			
		}
	
	 
	 public AlertStepVO getRecentAlertReg() throws Exception
	 {
		 return alertStepDAO.getRecentAlertReg();
	 }
	 
	 public AlertStepVO getNewWarring(AlertStepVO vo) throws Exception{
		 return alertStepDAO.getNewWarring(vo);
	 }
	 
	 /**
	  * 사고조치내역의 조치시간을 업뎃시킵니다.
	  * @param vo
	  * @return
	  * @throws Exception
	  */
	 public void updateAlertTime(AlertStepVO vo) throws Exception{
	    	alertStepDAO.updateAlertTime(vo);
	    }
	 

	 /**
	  * 최초 스텝번호 알아오기
	  * @param vo
	  * @return
	  * @throws Exception
	  */
	public String firstAlertStepSeq(AlertStepVO vo) throws Exception{
		return alertStepDAO.firstAlertStepSeq(vo);
	}
	 /**
	  * 이전단계로 진행
	  * @param vo
	  * @return
	  * @throws Exception
	  */
	public int prevAlertStep(AlertStepVO vo) throws Exception{
		//T_IW_HIS_DET 테이블의 step 현재 단계를 삭제
		alertStepDAO.deleteAlertStep(vo); 
		
		//이전번호
		int step_no = Integer.parseInt(vo.getAlertStep());
		if(step_no == 2){
			vo.setAlertStep(alertStepDAO.firstAlertStepSeq(vo));
		}else{
			vo.setAlertStep((step_no -1) + "");
		}
		vo.setAlertTime(null);
		
		//T_IW_HIS 테이블의 step 이전 단계로 수정
		alertStepDAO.updateAlertStep(vo);
		//T_IW_HIS_DET 테이블의 step 이전 단계의 시간 삭제
		alertStepDAO.updateAlertTime(vo);
		return 0;
	}

}
