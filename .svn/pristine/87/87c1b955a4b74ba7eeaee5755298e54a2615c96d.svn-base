package daewooInfo.mobile.onetouch.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import daewooInfo.admin.onetouch.bean.EmpOnetouchSmsVO;
import daewooInfo.admin.onetouch.dao.EmpOnetouchSmsDAO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.mobile.com.dao.MobileCommonDAO;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;
import daewooInfo.mobile.onetouch.service.MobileOnetouchService;
import daewooInfo.waterpollution.bean.WaterPollutionStepVO;
import daewooInfo.waterpollution.bean.WaterPollutionVO;
import daewooInfo.waterpollution.dao.WaterPollutionDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
* <pre>
* 1. 패키지명 : wpcs.sub02_warn.service.impl
* 2. 타입명 : TWarnDataServiceImpl.java
* 3. 작성일 : 2014. 8. 25. 오후 5:15:36
* 4. 작성자 : kys
* 5. 설명 : 경보조치
* </pre>
*/
@Service("MobileOnetouchService")
public class MobileOnetouchServiceImpl extends AbstractServiceImpl implements MobileOnetouchService {

	/**
	 * 수질오염 DAO
	 */
	@Resource(name="WaterPollutionDAO")
	private WaterPollutionDAO waterPollutionDAO;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	/**
	 * 공통 DAO
	 */
	@Resource(name="MobileCommonDAO")
	private MobileCommonDAO mobileCommonDAO;
	

	/**
	 * 원터치 담당자 알아오기
	 */
	@Resource(name="EmpOnetouchSmsDAO")
	EmpOnetouchSmsDAO empOnetouchSmsDAO;
	

	/**
	 * 알림서비스
	 */
	@Resource(name = "alrimService")
	private AlrimService alrimService;         
	
	/**
	 * 문자 발송
	 */
	@Resource(name = "alertDAO")
	private AlertDAO alertDAO;
	/**
	* <pre>
	* 1. 메소드명 : selectWarnList
	* 2. 작성일 : 2014. 8. 25. 오후 5:15:08
	* 3. 작성자 : kys
	* 4. 설명 : 경보조치 리스트
	* </pre>
	*/
    public void InsertOnetouchStatement (WaterPollutionVO waterPollutionVO, WaterPollutionStepVO waterPollutionStepVO, HttpServletRequest request, MultipartHttpServletRequest multiRequest)	throws Exception{

    	List<EmpOnetouchSmsVO> empOnetouchSmsVO = empOnetouchSmsDAO.selectEmpOnetouchSmsList(new EmpOnetouchSmsVO());
		waterPollutionVO.setReportDate(ObjectUtil.getTimeString("yyyyMMddHHmm"));
		waterPollutionVO.setReceiveDate(ObjectUtil.getTimeString("yyyyMMddHHmm"));		
		
		String tempWpCode = waterPollutionDAO.getWaterPollutionCode();
		String wpCode = "WP" + tempWpCode;
		waterPollutionVO.setWpCode(wpCode);
		waterPollutionVO.setWpKind("PD");
		waterPollutionVO.setReceiverId(empOnetouchSmsVO.get(0).getMember_id());
    	waterPollutionDAO.inserttWaterPollutionInfo(waterPollutionVO);
		
		waterPollutionStepVO.setWpCode(wpCode);
		waterPollutionStepVO.setWpsCode("1");
		waterPollutionStepVO.setWpsStep("STA");
		waterPollutionStepVO.setWpsStepDate(ObjectUtil.getTimeString("yyyyMMdd"));
		waterPollutionStepVO.setWpsContent("원터치 사고신고");
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		List<FileVO> result = fileUtil.parseWpStepFileInf(files, "wpStep_", 0, "", "");
		if (result.size() >0 ) {
			String atchFileId	= waterPollutionDAO.insertAlertFileInfs(result);
			
			waterPollutionStepVO.setWpsImg(atchFileId); //
		}
		
		waterPollutionDAO.inserttWaterPollutionStepInfo(waterPollutionStepVO);

		//알림서비스 입력
		AlrimVO alrimVO = new AlrimVO();
		AlertDataVO alertDataVO;
		for(EmpOnetouchSmsVO empOnetouchSms: empOnetouchSmsVO)
		{
			alrimVO.setAlrimGubun("P");			
			alrimVO.setAlrimTitle("사고가 신고 되었습니다.");			
			alrimVO.setAlrimLink("/waterpollution/waterPollutionRegist.do?wpCode="+wpCode);			
			alrimVO.setAlrimMenuId(32120);			
			alrimVO.setAlrimWriterId(empOnetouchSms.getMember_id()); // 작성자는 익명이나 필수값이기에 담당자로 지정			
			alrimVO.setAlrimApprovalId(empOnetouchSms.getMember_id()); // 결제자 또한 담당자로 지정
			
			alertDataVO = new AlertDataVO();
			alertDataVO.setCallBack(waterPollutionVO.getReporterTelNo().replaceAll("-", "")); //보내는사람 전화번호
			alertDataVO.setSubject("원터치 사고 신고");
			String message = "["+ waterPollutionVO.getWpContent() +"]\\r\\n";
			message += "위도 : "+ waterPollutionVO.getLongituded();
			message += "경도 : "+ waterPollutionVO.getLatiude();
			message += " "+ waterPollutionVO.getAddress();
			alertDataVO.setSmsMsg(message);
	    	alertDataVO.setDestInfo(empOnetouchSms.getMember_name() + "^" + empOnetouchSms.getMobile_no() );  //받는사람 전화번호
	    	alertDAO.insertSmsSend(alertDataVO);
		}

		alrimService.insertAlrim(alrimVO);
	}
}
