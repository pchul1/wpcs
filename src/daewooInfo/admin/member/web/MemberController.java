package daewooInfo.admin.member.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.admin.member.bean.UserMenuAuthVO;
import daewooInfo.admin.member.service.MemberService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.login.service.LoginService;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.sim.ClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MemberController {

	/**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
	private MemberService memberService;
	
	/**
	 * LoginService
	 * @uml.property  name="loginService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "loginService")
	private LoginService loginService;
	
	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(MemberController.class);
	
	/**
	 * 유저를 삭제한다.
	 * @param loginVO 
	 * @param memberVO
	 * @param model
	 * @return "forward:/admin/member/MemberList.do"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberRemove.do")
	public String deleteMember (@ModelAttribute("loginVO") LoginVO loginVO
			, MemberVO memberVO
			, HttpServletRequest request
			, ModelMap model
			) throws Exception {
		if(request.getRemoteAddr() != null) memberVO.setConnectIp(request.getRemoteAddr());
		memberService.deleteMember(memberVO);
		return "forward:/admin/member/MemberList.do";
	}
	
	/**
	 * 계정의 휴면 상태를 해제한다.
	 * @param loginVO 
	 * @param memberVO
	 * @param model
	 * @return "forward:/admin/member/MemberList.do"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/UnlockDormancy.do")
	public String unlockDormancy (@ModelAttribute("loginVO") LoginVO loginVO
			, MemberVO memberVO
			, HttpServletRequest request
			, ModelMap model
			) throws Exception {
		if(request.getRemoteAddr() != null) memberVO.setConnectIp(request.getRemoteAddr());
		memberService.unlockDormancy(memberVO);
		return "forward:/admin/member/MemberList.do";
	}
	
	/**
	 * 계정의 비밀번호 잠금을 해제한다.
	 * @param loginVO 
	 * @param memberVO
	 * @param model
	 * @return "forward:/admin/member/MemberList.do"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/UnlockPassword.do")
	public String unlockPassword (@ModelAttribute("loginVO") LoginVO loginVO
			, MemberVO memberVO
			, HttpServletRequest request
			, ModelMap model
			) throws Exception {
		if(request.getRemoteAddr() != null) memberVO.setConnectIp(request.getRemoteAddr());
		memberService.unlockPassword(memberVO);
		return "forward:/admin/member/MemberList.do";
	}

	/**
	 * 유저를 등록한다.
	 * @param loginVO 
	 * @param memberVO
	 * @param bindingResult
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberRegist.do")
	public String insertMember (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {	
		
		String returnValue = "forward:/admin/member/MemberList.do";
		
		boolean isPass = true;
		String mode = (String)commandMap.get("mode");

		if (mode == null) mode = "";
		
		if (null != memberVO.getPassword() && null != memberVO.getPassword_confirm()) {
			if (!memberVO.getPassword().equals(memberVO.getPassword_confirm())) {
				// 패스워드가 다릅니다.
				returnValue = "admin/member/MemberRegist";
				isPass = false;
				model.addAttribute("passwordMsg", "패스워드가 다릅니다.");
			}
		}
		
		// ID 중복체크
		if (null != memberVO.getMemberId()) {
			int cnt = loginService.checkID(memberVO.getMemberId());
			if (cnt > 0) {
				// 아이디가 중복됩니다.
				returnValue = "admin/member/MemberRegist";
				model.addAttribute("idMsg", "아이디가 중복됩니다.");
				isPass = false;
			}
		}
		
		// 시/도, 시/군 정보를 가져온다.
		List<CmmnDetailCode> areaDoCode = loginService.getAreaDoCode();
		//List<Map<String,String>> areaCtyCode = loginService.getAreaCtyCode();
		List<CmmnDetailCode> areaCtyCodeAll = loginService.getAreaCtyCodeAll();
		
		// 담당 수계 정보를 가져온다.
		List<CmmnDetailCode> riverIdCode = loginService.getRiverIdCode();
		
		// 수계, 공구 정보를 가져온다.
		List<CmmnDetailCode> factInfoCode = loginService.getFactInfoCode();
		
		// 관련기관 정보를 가져온다.
		List<CmmnDetailCode> organCode = loginService.getOrganCode();
		
		// 부서정보를 가져온다.
		List<DeptVO> deptCode = loginService.getDeptCode("0");
		
		// 그룹정보를 가져온다.
		List<CmmnDetailCode> groupCode = loginService.getGroupCode();
		
		model.addAttribute("riverIdCode", riverIdCode);
		model.addAttribute("areaDoCode", areaDoCode);
		model.addAttribute("areaCtyCodeAll", areaCtyCodeAll);
		model.addAttribute("organCode", organCode);
		model.addAttribute("factInfoCode", factInfoCode);
		model.addAttribute("deptCode", deptCode);
		model.addAttribute("groupCode", groupCode);
		
		returnValue = "admin/member/MemberRegist";
		return returnValue;
	}


	/**
	 * 유저를 등록한다.
	 * @param loginVO 
	 * @param memberVO
	 * @param bindingResult
	 * @param model
	 * @return "/admin/member/MemberRegist"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberRegistProc.do")
	public String insertMemberProc (@ModelAttribute("loginVO") LoginVO loginVO
			, final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {

		
		beanValidator.validate(memberVO, bindingResult);
		if (bindingResult.hasErrors()){
			return "admin/member/MemberRegist";
		} else {
			
			String connectIp = ClntInfo.getClntIP(request);
			memberVO.setConnectIp(connectIp);
			
			if (null == memberVO.getDeptNo() || "".equals(memberVO.getDeptNo())) {
				memberVO.setDeptNo(memberVO.getDeptNoTmp());
			}
			
//			memberVO.setIhidNum(memberVO.getIhidNum()+memberVO.getIhidNum1());
			memberVO.setEmail(memberVO.getEmail()+"@"+memberVO.getEmail1());
			memberVO.setOfficeNo(memberVO.getOfficeNo()+"-"+memberVO.getOfficeNo1()+"-"+memberVO.getOfficeNo2());
			memberVO.setMobileNo(memberVO.getMobileNo()+"-"+memberVO.getMobileNo1()+"-"+memberVO.getMobileNo2());
			memberVO.setFaxNum(memberVO.getFaxNum()+"-"+memberVO.getFaxNum1()+"-"+memberVO.getFaxNum2());
			
			memberVO.setApprovalFlag("Y");
			memberService.insertMember(memberVO,multiRequest);
			
			memberService.updateMemberMgId(memberVO.getMemberId());
			
			return "forward:/admin/member/MemberList.do" ;
		}
	}
			
	/**
	 * 유저의 목록  페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberList.do")
	public String memberList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/admin/member/MemberList";
	}
	
	/**
	 * 유저의 목록을 조회한다.
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/admin/member/MemberDitailList"
	 * @throws Exception
	 */

	@RequestMapping(value="/admin/member/MemberDitailList.do")
	public ModelAndView MemberDitailList (@ModelAttribute("loginVO") LoginVO loginVO

			, @ModelAttribute("searchVO") MemberSearchVO searchVO
			//, ModelMap model
			) throws Exception {
			
		PaginationInfo paginationInfo = new PaginationInfo();


		/** paging */
		searchVO.setPageUnit(100000);

		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	

		List<MemberSearchVO> memberList = memberService.selectMemberList(searchVO);		

		int totCnt = memberService.selectMemberListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);


		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("resultList", memberList);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * 유저의 정보를 수정한다.
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberModify.do")
	public String updateMember (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		String mode = (String)commandMap.get("mode");
		if (mode == null) mode = "";
		
		// 시/도, 시/군 정보를 가져온다.
		List<CmmnDetailCode> areaDoCode = loginService.getAreaDoCode();
		//List<Map<String,String>> areaCtyCode = loginService.getAreaCtyCode();
		List<CmmnDetailCode> areaCtyCodeAll = loginService.getAreaCtyCodeAll();
		
		// 담당 수계 정보를 가져온다.
		List<CmmnDetailCode> riverIdCode = loginService.getRiverIdCode();
		
		// 수계, 공구 정보를 가져온다.
		List<CmmnDetailCode> factInfoCode = loginService.getFactInfoCode();
		
		// 관련기관 정보를 가져온다.
		List<CmmnDetailCode> organCode = loginService.getOrganCode();
		
		// 부서정보를 가져온다.
		List<DeptVO> deptCode = loginService.getDeptCode("0");
		
		// 그룹정보를 가져온다.
		List<CmmnDetailCode> groupCode = loginService.getGroupCode();
		
		model.addAttribute("areaDoCode", areaDoCode);
		model.addAttribute("areaCtyCodeAll", areaCtyCodeAll);
		model.addAttribute("organCode", organCode);
		model.addAttribute("factInfoCode", factInfoCode);
		model.addAttribute("deptCode", deptCode);
		model.addAttribute("groupCode", groupCode);
		model.addAttribute("riverIdCode", riverIdCode);  //수계정보
		
		if(request.getRemoteAddr() != null) memberVO.setConnectIp(request.getRemoteAddr());
		MemberVO vo = memberService.selectMemberDetail(memberVO, true);
		
//			if (vo.getIhidNum() != null && !"".equals(vo.getIhidNum()) && vo.getIhidNum().length() == 13) {
//				
//				String ihid = vo.getIhidNum().substring(0, 6);
//				String ihid1 = vo.getIhidNum().substring(6, 13);
//				
//				vo.setIhidNum(ihid);
//				vo.setIhidNum1(ihid1);
//			}
		
		if (vo.getMobileNo() != null && !"".equals(vo.getMobileNo()) && vo.getMobileNo().split("-").length == 3) {
			String mobile = vo.getMobileNo().split("-")[0];
			String mobile1 = vo.getMobileNo().split("-")[1];
			String mobile2 = vo.getMobileNo().split("-")[2];
			
			vo.setMobileNo(mobile);
			vo.setMobileNo1(mobile1);
			vo.setMobileNo2(mobile2);
		}
		
		if (vo.getFaxNum() != null && !"".equals(vo.getFaxNum()) && vo.getFaxNum().split("-").length == 3) {
			String fax = vo.getFaxNum().split("-")[0];
			String fax1 = vo.getFaxNum().split("-")[1];
			String fax2 = vo.getFaxNum().split("-")[2];
			vo.setFaxNum(fax);
			vo.setFaxNum1(fax1);
			vo.setFaxNum2(fax2);
		}
		
		if (vo.getOfficeNo() != null && !"".equals(vo.getOfficeNo()) && vo.getOfficeNo().split("-").length == 3) {
			String office = vo.getOfficeNo().split("-")[0];
			String office1 = vo.getOfficeNo().split("-")[1];
			String office2 = vo.getOfficeNo().split("-")[2];
			
			vo.setOfficeNo(office);
			vo.setOfficeNo1(office1);
			vo.setOfficeNo2(office2);
		}
		
		if (vo.getEmail() != null && !"".equals(vo.getEmail())) {
			String email = vo.getEmail().split("@")[0];
			String email1 = "";
			if (vo.getEmail().split("@").length > 1) {
				email1 = vo.getEmail().split("@")[1];
			}
			vo.setEmail(email);
			vo.setEmail1(email1);
			vo.setEmail2("");
		}
		
		model.addAttribute("memberVO", vo);

		return "/admin/member/MemberModify";
			
	}
	

	/**
	 * 유저의 정보를 수정한다.
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberModifyProc.do")
	public String MemberModifyProc (@ModelAttribute("loginVO") LoginVO loginVO
			, final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		beanValidator.validate(memberVO, bindingResult);
		if (bindingResult.hasErrors()){
			MemberVO vo = memberService.selectMemberDetail(memberVO, true);
			model.addAttribute("memberVO", vo);

			return "/admin/member/MemberModify";
		} else {
			
			if (null == memberVO.getDeptNo() || "".equals(memberVO.getDeptNo())) {
				memberVO.setDeptNo(memberVO.getDeptNoTmp());
			}
			
//				memberVO.setIhidNum(memberVO.getIhidNum()+memberVO.getIhidNum1());
			memberVO.setEmail(memberVO.getEmail()+"@"+memberVO.getEmail1());
			memberVO.setOfficeNo(memberVO.getOfficeNo()+"-"+memberVO.getOfficeNo1()+"-"+memberVO.getOfficeNo2());
			memberVO.setMobileNo(memberVO.getMobileNo()+"-"+memberVO.getMobileNo1()+"-"+memberVO.getMobileNo2());
			memberVO.setFaxNum(memberVO.getFaxNum()+(!("".equals(memberVO.getFaxNum1())) ? "-" + memberVO.getFaxNum1(): "")+(!("".equals(memberVO.getFaxNum2())) ? "-"+ memberVO.getFaxNum2(): ""));
			
			// 비밀번호를 변경할지 체크
			String passwordChange = (String)commandMap.get("passwordChange");
			if (passwordChange == null) passwordChange = "";
			
			//System.out.println("passwordChange >>>>>> "+passwordChange);
			if ("change".equals(passwordChange)) {
				memberService.changePassword(memberVO);
			}
			
			memberService.updateMember(memberVO, multiRequest);
			
			return "forward:/admin/member/MemberList.do";
		}
	}
	
	/**
	 * 유저의 정보를 수정한다.
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/InfoModify.do")
	public String updateInfo (@ModelAttribute("loginVO") LoginVO loginVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, HttpServletResponse response
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberVO.setMemberId(user.getId());
		
		String mode = (String)commandMap.get("mode");
		if (mode == null) mode = "";
		
		String memberAccess =  request.getSession().getAttribute("memberAccess").toString();
		
		//인증 여부 확인
		if(null != memberAccess || !"OK".equals(memberAccess)){
			
			return "/admin/member/MemberAccess";
		}else{
		
			if (mode.equals("")) {
				
				MemberVO vo = memberService.selectMemberDetail(memberVO);
				
				if (vo.getMobileNo() != null && !"".equals(vo.getMobileNo()) && vo.getMobileNo().split("-").length == 3) {
					String mobile = vo.getMobileNo().split("-")[0];
					String mobile1 = vo.getMobileNo().split("-")[1];
					String mobile2 = vo.getMobileNo().split("-")[2];
					
					vo.setMobileNo(mobile);
					vo.setMobileNo1(mobile1);
					vo.setMobileNo2(mobile2);
				}
				
				if (vo.getFaxNum() != null && !"".equals(vo.getFaxNum()) && vo.getFaxNum().split("-").length == 3) {
					String fax = vo.getFaxNum().split("-")[0];
					String fax1 = vo.getFaxNum().split("-")[1];
					String fax2 = vo.getFaxNum().split("-")[2];
					vo.setFaxNum(fax);
					vo.setFaxNum1(fax1);
					vo.setFaxNum2(fax2);
				}
				
				if (vo.getOfficeNo() != null && !"".equals(vo.getOfficeNo()) && vo.getOfficeNo().split("-").length == 3) {
					String office = vo.getOfficeNo().split("-")[0];
					String office1 = vo.getOfficeNo().split("-")[1];
					String office2 = vo.getOfficeNo().split("-")[2];
					
					vo.setOfficeNo(office);
					vo.setOfficeNo1(office1);
					vo.setOfficeNo2(office2);
				}
				
				if (vo.getEmail() != null && !"".equals(vo.getEmail())) {
					String email = vo.getEmail().split("@")[0];
					String email1 = "";
					if (vo.getEmail().split("@").length > 1) {
						email1 = vo.getEmail().split("@")[1];
					}
					vo.setEmail(email);
					vo.setEmail1(email1);
					vo.setEmail2("");
				}
				
				model.addAttribute("memberVO", vo);
	
				return "/admin/member/InfoModify";
				
			} else if (mode.equals("Modify")) {
				
				memberVO.setEmail(memberVO.getEmail()+"@"+memberVO.getEmail1());
				memberVO.setOfficeNo(memberVO.getOfficeNo()+"-"+memberVO.getOfficeNo1()+"-"+memberVO.getOfficeNo2());
				memberVO.setMobileNo(memberVO.getMobileNo()+"-"+memberVO.getMobileNo1()+"-"+memberVO.getMobileNo2());
				memberVO.setFaxNum(memberVO.getFaxNum()+"-"+memberVO.getFaxNum1()+"-"+memberVO.getFaxNum2());
				
				// 비밀번호를 변경할지 체크
				String passwordChange = (String)commandMap.get("passwordChange");
				if (passwordChange == null) passwordChange = "";
				
				log.debug("passwordChange : "+passwordChange);
	
				if ("change".equals(passwordChange)) {
					memberService.changePassword(memberVO);
				}
				
				memberService.updateInfo(memberVO, multiRequest);
				
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().print("<script>alert('사고가 신고되었습니다.');location.replace('/admin/member/InfoModify.do');</script>"); 
				
				return null;
			} else {
				return "forward:/admin/member/InfoModify.do";
			}
		}
	}
	
	/**
	 * 승인거부
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberAppRefusalProc.do")
	public String MemberAppRefusalProc (@ModelAttribute("loginVO") LoginVO loginVO
			, final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		
		memberVO.setApprovalFlag("N"); //S:대기 N:승인거부 Y:승인 
		
		memberService.updateMemberApp(memberVO, multiRequest);
			
		return "forward:/admin/member/MemberList.do";
	}
	
	/**
	 * 승인
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/member/MemberAppProc.do")
	public String MemberAppProc (@ModelAttribute("loginVO") LoginVO loginVO
			, final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		
		memberVO.setApprovalFlag("Y"); //S:대기 N:승인거부 Y:승인 
		
		memberService.updateMemberApp(memberVO, multiRequest);
		
		//권한처리
		memberService.insertAuthorGroup(memberVO);
			
		return "forward:/admin/member/MemberList.do";
	}
	
	@RequestMapping("/admin/member/getAuthorFactList.do")
	public ModelAndView getAuthorFactList(
			@RequestParam(value="au_syskind") String auth_syskind,
			@RequestParam(value="au_riverdiv") String auth_riverdiv
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("List", memberService.getAuthorFactList(auth_syskind, auth_riverdiv));
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping("/admin/member/InsertMyAuthorFact.do")
	public ModelAndView InsertMyAuthorFact(
			@RequestParam(value="member_id") String member_id,
			@RequestParam(value="auth_syskind") String auth_syskind,
			@RequestParam(value="auth_myFactList") String auth_myFactList
	) throws Exception{
		
		memberService.InsertMyAuthorFact(member_id, auth_syskind, auth_myFactList);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	

	
	@RequestMapping("/admin/member/DeleteMyAuthorFact.do")
	public ModelAndView DeleteMyAuthorFact(
			@RequestParam(value="member_id") String member_id,
			@RequestParam(value="auth_myFactList") String auth_myFactList
	) throws Exception{
		
		memberService.DeleteMyAuthorFact(member_id, auth_myFactList);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	

	
	@RequestMapping("/admin/member/getMemberAuthorFactList.do")
	public ModelAndView getMemberAuthorFactList(
			@RequestParam(value="member_id") String member_id
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("List", memberService.getMemberAuthorFactList(member_id));
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping("/admin/member/getUserMenuAuthorList.do")
	public ModelAndView getUserMenuAuthorList(@ModelAttribute("memberVO") MemberVO mvo
					//, ModelMap model
					) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		List userMenuAuthList = memberService.selectUserMenuAuthList(mvo);
		
		modelAndView.addObject("userMenuAuthList", userMenuAuthList);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	@RequestMapping("/admin/member/getUserAuthorCnt.do")
	public ModelAndView getUserAuthorCnt(@ModelAttribute("userMenuAuthVO") UserMenuAuthVO umav
//			,String MenuId
			) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		int userAuthListCnt = 0;
		userAuthListCnt = memberService.getUserAuthorCnt(umav);
		System.out.println("cnt >>>> " + userAuthListCnt);
		modelAndView.addObject("getUserMenuAuthorCount", userAuthListCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	@RequestMapping("/admin/member/userMenuAuthSaveu.do")
	public ModelAndView userMenuAuthSaveu(@ModelAttribute("userMenuAuthVO") UserMenuAuthVO umav
			) throws Exception {
		memberService.userMenuAuthSaveu(umav);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping("/admin/member/userMenuAuthSavei.do")
	public ModelAndView userMenuAuthSavei(@ModelAttribute("userMenuAuthVO") UserMenuAuthVO umav
			) throws Exception {
		memberService.userMenuAuthSavei(umav);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
}