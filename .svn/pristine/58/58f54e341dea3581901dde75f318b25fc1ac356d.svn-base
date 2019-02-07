package daewooInfo.smsmanage.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.softwarefx.sfxnet.internal.lg;

import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.smsmanage.bean.SmsBranchVO;
import daewooInfo.smsmanage.bean.SmsTargetVO;
import daewooInfo.smsmanage.bean.SmsVO;
import daewooInfo.smsmanage.service.SmsManageCounterService;
import daewooInfo.spotmanage.bean.SpotManageVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : SpotManageController.java
 * @Description : 지점 관리를 위한 Controller
 * @Modification Information @ @ 수정일 수정자 수정내용 @ ------- --------
 *               --------------------------- @
 * @author yong
 * @since 2012.01.25
 * @version 1.0
 * @see
 * 
 */
@Controller
public class SmsManageController {

	/**
	 * @uml.property  name="smsManageCounterService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "SmsManageCounterService")
	private SmsManageCounterService smsManageCounterService;
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());

	/**
	 * SMS 관리 페이지 호출
	 * 
	 * @return 출력페이지정보 "smsmmanage/smsmanage"
	 * @exception Exception
	 */
	@RequestMapping(value = "/smsmanage/smsmanage.do")
	public String smsmanage(ModelMap model, SmsVO smsVo) throws Exception {
		return "smsmanage/smsmanage";
	}
	
	
	
	@RequestMapping(value = "/smsmanage/ListDetailSmsConfig.do")
	public String smsmanageList(ModelMap model, SmsVO smsVo) throws Exception {
		model.addAttribute("List", smsManageCounterService.getSmsConfigList());
		return "jsonView";
	}
	
	@RequestMapping(value = "/smsmanage/DetailSmsConfig.do")
	public String DetailSmsConfig(ModelMap model, SmsVO smsVo) throws Exception {
		model.addAttribute("Detail", smsManageCounterService.getSmsConfigDetail(smsVo));
		return "jsonView";
	}

	@RequestMapping(value = "/smsmanage/InsertSmsConfig.do")
	public String InsertSmsConfig(ModelMap model, SmsVO smsVo) throws Exception {
		smsManageCounterService.MergeSmsConfig(smsVo);
		return "jsonView";
	}
	
	@RequestMapping(value = "/smsmanage/CommonSmsTargetList.do")
	public String CommonSmsTargetList(ModelMap model, SmsTargetVO smsTargetVO) throws Exception {
		model.addAttribute("List", smsManageCounterService.CommonSmsTargetList(smsTargetVO));
		return "jsonView";
	}
	
	@RequestMapping(value = "/smsmanage/InsertSmsTarget.do")
	public String InsertSmsTarget(ModelMap model, SmsTargetVO smsTargetVO) throws Exception {
		smsManageCounterService.InsertSmsTarget(smsTargetVO);
		model.addAttribute("Insert", "OK");
		return "jsonView";
	}
	
	@RequestMapping(value = "/smsmanage/DeleteSmsTarget.do")
	public String DeleteSmsTarget(ModelMap model, SmsTargetVO smsTargetVO) throws Exception {
		// SMS타겟 삭제시 측정소 담당자일경우 삭제 불가
		if(smsManageCounterService.isExistBranchMember(smsTargetVO) > 0){
			model.addAttribute("Delete", "MANAGER");
		}else{
			smsManageCounterService.DeleteSmsTarget(smsTargetVO);
			model.addAttribute("Delete", "OK");
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/smsmanage/DetailSmsBranchConfig.do")
	public String DetailSmsBranchConfig(ModelMap model, SmsBranchVO smsBranchVO) throws Exception {
		model.addAttribute("Detail", smsManageCounterService.DetailSmsBranchConfig(smsBranchVO));
		return "jsonView";
	}

	@RequestMapping(value = "/smsmanage/InsertSmsBranchConfig.do")
	public String InsertSmsBranchConfig(ModelMap model, SmsBranchVO smsBranchVO) throws Exception {
		smsManageCounterService.MergeSmsBranchConfig(smsBranchVO);
		return "jsonView";
	}
}