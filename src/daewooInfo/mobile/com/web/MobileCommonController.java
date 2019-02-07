package daewooInfo.mobile.com.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.mobile.com.bean.MobileCommonCodeVO;
import daewooInfo.mobile.com.bean.MobileCommonVO;
import daewooInfo.mobile.com.service.MobileCommonCodeService;
import daewooInfo.mobile.com.utl.LogInfoUtil;


/**
* <pre>
* 1. 패키지명 : wpcs.com.web
* 2. 타입명 : CommonController.java
* 3. 작성일 : 2014. 8. 20. 오후 5:23:59
* 4. 작성자 : kys
* 5. 설명 :
* </pre>
*/
@Controller
public class MobileCommonController {
	
	/**
	 * 공통 코드 서비스
	 */
    @Resource(name="MobileCommonCodeService")
    private MobileCommonCodeService mobileCommonCodeService;
    
	/**
	* <pre>
	* 1. 메소드명 : LoginView
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:07
	* 3. 작성자 : kys
	* 4. 설명 : 메세지 박스
	* </pre>
	*/
	@RequestMapping(value="/mobile/alert")
	public String LoginView(MobileCommonVO commonVO, ModelMap model) throws Exception {
		model.addAttribute("param_s", commonVO);
		return "mobile/common/alert";
	}

	/**
	* <pre>
	* 1. 메소드명 : selectsystem
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:22
	* 3. 작성자 : kys
	* 4. 설명 : 수계정보 동적 셀렉트 박스 XML
	* </pre>
	*/
	@RequestMapping(value="/mobile/common/system")
	public String selectsystem(MobileCommonCodeVO commonCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SearchRoleCode(commonCodeVO,request);
		
		model.addAttribute("Result",new String[]{"S", "성공"});
		model.addAttribute("List",mobileCommonCodeService.getSystemCodeList(commonCodeVO));
		
		return "jsonView";
	} 


	/**
	* <pre>
	* 1. 메소드명 : selectsugye
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:22
	* 3. 작성자 : kys
	* 4. 설명 : 수계정보 동적 셀렉트 박스 XML
	* </pre>
	*/
	@RequestMapping(value="/mobile/common/sugye")
	public String selectsugye(MobileCommonCodeVO commonCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SearchRoleCode(commonCodeVO,request);
		
		model.addAttribute("Result",new String[]{"S", "성공"});
		model.addAttribute("List",mobileCommonCodeService.getSugyeCodeList(commonCodeVO));
		
		return "jsonView";
	} 

	
	/**
	* <pre>
	* 1. 메소드명 : selectBranch
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:22
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 동적 셀렉트 박스 XML
	* </pre>
	*/
	@RequestMapping(value="/mobile/common/branch")
	public String selectBranch(MobileCommonCodeVO commonCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SearchRoleCode(commonCodeVO,request);
		
		if("".equals(commonCodeVO.getCode_gbn())){
			model.addAttribute("Result",new String[]{"F", "코드구분자를 입력해주세요"});
		}
		else if("".equals(commonCodeVO.getSys())){
			model.addAttribute("Result",new String[]{"F", "시스템을 입력해주세요"});
		}
		else{
			model.addAttribute("Result",new String[]{"S", "성공"});
			model.addAttribute("List",mobileCommonCodeService.getbranch(commonCodeVO));
		}
		return "jsonView";
	} 

	/**
	* <pre>
	* 1. 메소드명 : selectcodelist
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:22
	* 3. 작성자 : kys
	* 4. 설명 : 공통 코드 출력함수
	* </pre>
	*/
	@RequestMapping(value="/mobile/common/codelist")
	public String selectcodelist(MobileCommonCodeVO commonCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SearchRoleCode(commonCodeVO,request);
		
		model.addAttribute("Result",new String[]{"S", "성공"});
		model.addAttribute("List",mobileCommonCodeService.getCodeList(commonCodeVO));
		
		return "jsonView";
	} 

	/**
	* <pre>
	* 1. 메소드명 : selectcodelist
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:22
	* 3. 작성자 : kys
	* 4. 설명 : 공통 코드 출력함수
	* </pre>
	*/
	@RequestMapping(value="/mobile/common/getSido")
	public String getSido(MobileCommonCodeVO commonCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SearchRoleCode(commonCodeVO,request);
		
		model.addAttribute("Result",new String[]{"S", "성공"});
		model.addAttribute("List",mobileCommonCodeService.getSido());
		
		return "jsonView";
	} 
	

	/**
	* <pre>
	* 1. 메소드명 : selectcodelist
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:22
	* 3. 작성자 : kys
	* 4. 설명 : 공통 코드 출력함수
	* </pre>
	*/  
	@RequestMapping(value="/mobile/common/getSigungu")
	public String getSigungu(MobileCommonCodeVO commonCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SearchRoleCode(commonCodeVO,request);
		
		model.addAttribute("Result",new String[]{"S", "성공"});
		model.addAttribute("List",mobileCommonCodeService.getSigungu(commonCodeVO.getCode_gbn()));
		
		return "jsonView";
	} 

	/**
	* <pre>
	* 1. 메소드명 : selectcodelist
	* 2. 작성일 : 2014. 8. 20. 오후 5:24:22
	* 3. 작성자 : kys
	* 4. 설명 : 공통 코드 출력함수
	* </pre>
	*/  
	@RequestMapping(value="/mobile/common/getWarehouse")
	public String getWarehouse(MobileCommonCodeVO commonCodeVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SearchRoleCode(commonCodeVO,request);
		
		model.addAttribute("Result",new String[]{"S", "성공"});
		model.addAttribute("List",mobileCommonCodeService.getWarehouseCode(commonCodeVO.getCode_gbn()));
		
		return "jsonView";
	} 
	
	public void SearchRoleCode(MobileCommonCodeVO commonCodeVO,HttpServletRequest request) throws Exception{
		commonCodeVO.setId(LogInfoUtil.GetSessionLogin().getId());
		commonCodeVO.setRoleCode(LogInfoUtil.GetSessionLogin().getRoleCode());
	}
}