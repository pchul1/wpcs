package daewooInfo.waterpolmnt.waterinfo.web;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.member.service.MemberService;
import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.service.AlertLawService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.ComDefaultCodeVO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovCmmUseService;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.cmmn.service.TmsComUtlService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.warehouse.bean.WareHouseVO;
import daewooInfo.waterpolmnt.airmntmng.service.AirService;
import daewooInfo.waterpolmnt.algasmng.service.AlgasService;
import daewooInfo.waterpolmnt.waterinfo.bean.AirMntDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AlgaCastDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AreaDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.BasinViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.BoSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.BoViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.CmnSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DamDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DamViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.EcompanyDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.EcompayOwnItemDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.ExcelModelingVO;
import daewooInfo.waterpolmnt.waterinfo.bean.FactoryIndustViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.FlowDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LimitDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LimitViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LocationVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RelateOfficeDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SelectDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SumViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.TaksuVO;
import daewooInfo.waterpolmnt.waterinfo.bean.WaterDcViewVO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;
import daewooInfo.weather.bean.HourRainfallVO;
import daewooInfo.weather.bean.WarningDataVO;
import daewooInfo.weather.bean.WeatherInfoVO;
import daewooInfo.weather.service.WeatherService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * @author DaeWoo Information Systems Co., Ltd. Technical Expert Team.
 *		 loafzzang.
 * @version 1.0
 * @Class Name : MonitoringController.java
 * @Description : monitoring Controller Class
 * @Modification Information @ @ Modify Date author Modify Contents @
 *				-------------- ------------ ------------------------------- @
 *				2010. 1. 21 loafzzang new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right
 *	  reserved.
 * @since 2010. 1. 21
 */

@Controller
public class WaterinfoController{
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(WaterinfoController.class);
	
	 /**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * @uml.property  name="waterinfoService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "waterinfoService")
	private WaterinfoService waterinfoService;
	
	/**
	 * @uml.property  name="tmsComUtlService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "TmsComUtlService")
	private TmsComUtlService tmsComUtlService;
	
	/**
	 * @uml.property  name="airService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "airService")
	private AirService airService;
	
	/**
	 * @uml.property  name="algasService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "algasService")
	private AlgasService algasService;
	
	/**
	 * @uml.property  name="weatherService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "weatherService")
	private WeatherService weatherService;
	
	/**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
	private MemberService memberService;
	
	/**
	 * @uml.property  name="cmmUseService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	/**
	 * @uml.property  name="alertLawService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertLawService")
	private AlertLawService alertLawService;
	
	/**
	 * @uml.property  name="fileMngService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	/**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	// 시스템 권한 조회
	@RequestMapping("/waterpolmnt/waterinfo/getSystemList.do")
	public ModelAndView getSystemList(
			HttpServletRequest request
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("List", waterinfoService.getSystemList(request));
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 수계 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getSugyeList.do")
	public ModelAndView getSugyeList(@RequestParam(value="system", required=false) String system ,HttpServletRequest request) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("List", waterinfoService.getSugyeList(request, system));
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
		
	// 공구 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getGongkuList.do")
	public ModelAndView getGongkuList(
			@RequestParam(value="sugye") String sugye
			,@RequestParam(value="system", required=false) String system
			,HttpServletRequest request
	) throws Exception{
		
		if(system == null || system.equals("")) {
//			system = "T";
			system = "U";
		}
		
		List gongku = waterinfoService.getGongkuList(request, system, sugye);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("gongku", gongku);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/getGongkuListNew.do")
	public ModelAndView getGongkuListNew(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="sugye") String sugye
	) throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		String userGubun = user.getRoleCode();
		
		if(system == null || system.equals("")) {
//			system = "T";
			system = "U";
		}
		
		List gongku = waterinfoService.getGongkuList(system, sugye, userGubun, user.getId());
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("gongku", gongku);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}


	// 방류수질 측정소 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getTMSList.do")
	public ModelAndView getTMSList(
			@RequestParam(value="sugye") String sugye
			,HttpServletRequest request
	) throws Exception{
		
		List tms = waterinfoService.getTMSList(request, sugye);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("tms", tms);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 과학원 측정소 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getFlowFact.do")
	public ModelAndView getGongkuList(
			@RequestParam(value="sugye") String sugye
	) throws Exception{
		
		List gongku = waterinfoService.getFlowFact(sugye);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("gongku", gongku);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
 // 과학원 측정소 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getWLFact.do")
	public ModelAndView getWLFact(
			@RequestParam(value="sugye") String sugye
	) throws Exception{
		
		List gongku = waterinfoService.getWLFact(sugye);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("gongku", gongku);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 과학원 댐 측정소 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getDamFact.do")
	public ModelAndView getDamFact(
			@RequestParam(value="sugye") String sugye
	) throws Exception{
		
		List gongku = waterinfoService.getDamFact(sugye);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("gongku", gongku);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	// 측정소 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getBranchList.do")
	public ModelAndView getBranchList(
			@RequestParam(value="factCode") String factCode
	) throws Exception{
		
		List branch = waterinfoService.getBranchList(factCode);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("branch", branch);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 측정소 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getBranchListNew.do")
	public ModelAndView getBranchListNew(
			@RequestParam(value="factCode") String factCode
	) throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		List branch = waterinfoService.getBranchListNew(factCode, user.getId());
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("branch", branch);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	// 측정소 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getFactBranchCnt.do")
	public ModelAndView getFactBranchCnt(
			@RequestParam(value="factCode") String factCode
	) throws Exception{
		
		String branch = waterinfoService.getFactBranchCnt(factCode);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("branch", branch);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	// 측정항목 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getItemList.do")
	public ModelAndView getItemList(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="sugye", required=false) String sugye
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="branchNo", required=false) String branchNo
	) throws Exception{
		if(system == null || system.equals("")) {
			system = "T";
		}
		
		List item = waterinfoService.getItemList(system, sugye, factCode, branchNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("item", item);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}	
	
 // 측정항목 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getItemList2.do")
	public ModelAndView getItemList2(
			@RequestParam(value="itemKind", required=false) String itemKind
	) throws Exception{		

		List item = waterinfoService.getItemList2(itemKind);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("item", item);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}	
	
	@RequestMapping("/waterpolmnt/waterinfo/getTMSListNew.do")
	public ModelAndView getTMSListNew(
			@RequestParam(value="sugye") String sugye
	) throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		String userGubun = user.getRoleCode();
		
		List tms = waterinfoService.getTMSListNew(sugye, user.getId(), userGubun);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("tms", tms);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 방류수질 측정소 목록 조회
		@RequestMapping("/waterpolmnt/waterinfo/getTMSList2.do")
		public ModelAndView getTMSList2(
				@RequestParam(value="sugye") String sugye
			   ,@RequestParam(value="tmsCtyCode") String tmsCtyCode
		) throws Exception{
			
			List tms = waterinfoService.getTMSList2(sugye, tmsCtyCode);
			
			ModelAndView modelAndView = new ModelAndView();
			
			modelAndView.addObject("tms", tms);
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		}
	
	
	// 폐수 지천 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getTMSRiverD1List.do")
	public ModelAndView getTMSRiverList() throws Exception{
		
		List tms = waterinfoService.getTMSRiverD1List();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("tms", tms);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	// 폐수 지천 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getTMSRiverD2List.do")
	public ModelAndView getTMSRiverD2List(
			@RequestParam(value="sugye") String sugye
	) throws Exception{
		
		List tms = waterinfoService.getTMSRiverD2List(sugye);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("tms", tms);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	//방류수질 방류구 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getWastList.do")
	public ModelAndView getWastlist(
			@RequestParam(value="factCode") String factCode
	) throws Exception {

		List wast = waterinfoService.getWastList(factCode);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("wast", wast);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	
	}
	
	
	// 하천수질조회(IPUSN)
	@RequestMapping("/waterpolmnt/waterinfo/goDetailRIVER_U.do")
	public ModelAndView goDetailRIVER_U() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater_u");
		
		return modelAndView;
	}
	
	// 하천수질조회(측정망)
	@RequestMapping("/waterpolmnt/waterinfo/goDetailRIVER_A.do")
	public ModelAndView goDetailRIVER_A() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater_a");
		
		return modelAndView;
	}
	
	// 하천수질조회(금호강)
	@RequestMapping("/waterpolmnt/waterinfo/goDetailRIVER_KR.do")
	public ModelAndView goDetailRIVER_KR() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater_kr");
		
		return modelAndView;
	}	
	
	// 하천수질조회(금호강)
	@RequestMapping("/waterpolmnt/waterinfo/goDetailRIVER_KM.do")
	public ModelAndView goDetailRIVER_KM() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater_km");
		
		return modelAndView;
	}
	
	// 하천수질조회
	@RequestMapping("/waterpolmnt/waterinfo/goDetailRIVER.do")
	public ModelAndView goDetailRIVER() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater");
		
		return modelAndView;
	}

	// 하천수질조회
	@RequestMapping("/waterpolmnt/waterinfo/getDetailViewRIVER.do")
	public ModelAndView getDetailViewRIVER(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		searchTaksuVO.setUserId(user.getId());
		searchTaksuVO.setRoleCode(user.getRoleCode());
		if("ROLE_ADMIN".equals(user.getRoleCode())){
			searchTaksuVO.setUserGubun("ROLE_ADMIN");
		}
		
		
		ModelAndView modelAndView = new ModelAndView();
		
		
		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		boolean flag = false;
		String ftime = searchTaksuVO.getFrTime();
		
		if(ftime.length() == 2)
			searchTaksuVO.setFrTime(ftime+"00");
		else
		{
			flag = true;
			searchTaksuVO.setLastFlag("O");
		}
		
		String totime = searchTaksuVO.getToTime();
		if(totime.length() == 2)
			searchTaksuVO.setToTime(totime+"59");
		
		/** paging */
//		if(!flag)
//			//searchTaksuVO.setPageUnit(20);
//			searchTaksuVO.setPageUnit(100000);
//		else 
//		//searchTaksuVO.setPageUnit(10000);
		
		searchTaksuVO.setPageUnit(20);
		
		if(null != searchTaksuVO.getMainPageUnit()){
			searchTaksuVO.setPageUnit(Integer.parseInt(searchTaksuVO.getMainPageUnit()));
		}
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());
	
		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		
		
		List<DetailViewVO> refreshData =  waterinfoService.getDetailViewRIVER(searchTaksuVO);
		
		int totCnt = 0;
		if(!flag )
			totCnt = waterinfoService.getTotCntRiver(searchTaksuVO);
//		System.out.println("totCnt : "+String.valueOf(totCnt));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
	
//		for(DetailViewVO detailData : refreshData)
//		{
//			String factCode = detailData.getFactcode();
//			String branchNo = detailData.getBranchno();
//			SearchTaksuVO sData = new SearchTaksuVO();
//			sData.setGongku(factCode);
//			sData.setChukjeongso(branchNo);	
//
//			
//			//IP-USN 일때 위치 조회
//			if("U".equals(searchTaksuVO.getSys()))
//			{
//				LocationVO loc = waterinfoService.getFactLocation(sData);
//				
//				detailData.setLatitude(loc.getLatitude());
//				detailData.setLongitude(loc.getLongitude());
//			}
//			else if("T".equals(searchTaksuVO.getSys())){
//				
//				String date = detailData.getStrdate().replaceAll("[-]", "");
//				String time = detailData.getStrtime().split("[:]")[0];
//				
//				sData.setFrDate(date);
//				sData.setFrTime(time);
//				
//				HourRainfallVO hrf = weatherService.getFactHourRainfall(sData);
//				
//				if(hrf != null)
//					detailData.setHour_rainfall(hrf.getHour_rainfall());
//				else 
//					detailData.setHour_rainfall("-");
//			}
//			else
//			{
//				break;
//			}
//		}
	
		
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
//		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater");
		return modelAndView;
	}
	
	// 하천수질조회(엑셀)
	@RequestMapping("/waterpolmnt/waterinfo/getExcelDetalViewRIVER.do")
	public ModelAndView selectCategoryList(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO,
			@RequestParam(value="item", required=false) String item
			)
			throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		searchTaksuVO.setUserId(user.getId());
		searchTaksuVO.setRoleCode(user.getRoleCode());
		
		if("ROLE_ADMIN".equals(user.getRoleCode())){
			searchTaksuVO.setUserGubun("ROLE_ADMIN");
		}
		
		String ftime = searchTaksuVO.getFrTime();
		
		if(ftime.length() == 2) searchTaksuVO.setFrTime(ftime+"00");
		else{
			searchTaksuVO.setLastFlag("O");
		}
		
		String totime = searchTaksuVO.getToTime();
		if(totime.length() == 2) searchTaksuVO.setToTime(totime+"59");
		
		if(item != null)
		{
			searchTaksuVO.setItem(item);
		}
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		int totCnt = waterinfoService.getTotCntRiver(searchTaksuVO);
		List<DetailViewVO> refreshData =  waterinfoService.getDetailViewRIVER(searchTaksuVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("searchTaksuVO", searchTaksuVO);
		
		ModelAndView modelAndView = null;
		if(searchTaksuVO.getSys().equals("A"))
			modelAndView = new ModelAndView("ExcelViewTaksu2", "chartMap", map);
		else
			modelAndView = new ModelAndView("ExcelViewTaksu", "chartMap", map);
		
		return modelAndView;
	}

	//하천수질조회(차트팝업 이동~)
	@RequestMapping("/waterpolmnt/waterinfo/goChartDetailRIVER.do")
	public ModelAndView getChartDetailViewRIVER(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "chukjeongso", required = false) String chukjeongso,
			@RequestParam(value = "dataType", required = false) String dataType,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="userGubun", required=false) String userGubun,
			@RequestParam(value="minor", required=false) String minor,
			@RequestParam(value="valid", required=false) String valid,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		searchTaksuVO.setUserId(user.getId());
	
		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 2: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setChukjeongso(chukjeongso);
		searchTaksuVO.setDataType(dataType);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setSys(sys);
		searchTaksuVO.setUserGubun(userGubun);

		searchTaksuVO.setMinor(minor);
		searchTaksuVO.setValid(valid);
		
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.setViewName("/waterpolmnt/waterinfo/riverwater_chart");
		
		return modelAndView;
	}
	
	//하천수질조회(차트)
	@RequestMapping("/waterpolmnt/waterinfo/getChartDetalViewRIVER.do")
	public ModelAndView getChartDetalViewRIVER(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "chukjeongso", required = false) String chukjeongso,
			@RequestParam(value = "dataType", required = false) String dataType,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value = "minTime", required = false) String minTime, //상황처리단계 상황종료에서 그래프 표시할때 시작시간
			@RequestParam(value = "endTime", required = false) String endTime, //상황처리단계 상황종료에서 그래프 표시할 때 상황종료 시간
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="minor", required=false) String minor,
			@RequestParam(value="valid", required=false) String valid,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height,
			@RequestParam(value="item", required=false) String item,
			@RequestParam(value="wLine", required=false) String wLine,
			@RequestParam(value="image", required=false) String image,
			@RequestParam(value="item2", required=false) String item2,
			@RequestParam(value="item3", required=false) String item3
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();
	
		searchTaksuVO.setSugye(sugye);

		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setChukjeongso(chukjeongso);
		searchTaksuVO.setDataType(dataType);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setSys(sys);
		searchTaksuVO.setMinTime(minTime);
		searchTaksuVO.setEndTime(endTime);
		
		searchTaksuVO.setMinor(minor);
		searchTaksuVO.setValid(valid);
		
		searchTaksuVO.setItem(item);
		
		if(item2 != null) 
		{
			searchTaksuVO.setItem02(item2); 
		}
		else 
		{
			searchTaksuVO.setItem02("XXX");
			
			item2 = "xxx";
		}
		if(item3 != null) 
			searchTaksuVO.setItem03(item3); 
		else 
		{
			searchTaksuVO.setItem03("XXX");
			
			item3 = "xxx";
		}
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		
		//측정망 대항목에 따른 세부항목 코드 분류!!?!?!?!
		Map<String, String[]> codeList = new HashMap();
		codeList.put("COM1", new String[] {"TUR00", "PHY00", "DOW00","CON00","TMP00"});
		codeList.put("COM2", new String[] {"PHY01", "DOW01","CON01","TMP01"});
		codeList.put("BIO1", new String[] {"IMP00"});
		codeList.put("BIO2", new String[] {"LIM00", "RIM00"});
		codeList.put("BIO3", new String[] {"LTX00", "RTX00"});
		codeList.put("BIO4", new String[] {"TOX00"});
		codeList.put("BIO5", new String[] {"EVN00"});
		codeList.put("CHLA", new String[] {"TOF00"});
		codeList.put("VOCS", new String[] {"VOC01", "VOC02","VOC03","VOC04","VOC05","VOC06","VOC07","VOC08","VOC09","VOC10","VOC11","VOC12","VOC13","VOC14","VOC15"});
		codeList.put("METL", new String[] {"CAD00", "PLU00", "COP00", "ZIN00"});
		codeList.put("PHEN", new String[] {"PHE00", "PHL00"});
		codeList.put("ORGA", new String[] {"TOC00"});
		codeList.put("NUTR", new String[] {"TON00", "TOP00", "NH400", "NO300", "PO400"});
		codeList.put("RAIN", new String[] {"RIN00"});
		
		//측정망 대항목에 따른 세부항목 이름
		Map<String, String[]> nameList = new HashMap();
		nameList.put("COM1", new String[] {"탁도", "pH1", "DO1","EC1","수온1"});
		nameList.put("COM2", new String[] {"pH2", "DO2","EC2","수온2", "탁도"});
		nameList.put("BIO1", new String[] {"임펄스"});
		nameList.put("BIO2", new String[] {"임펄스(좌)", "임펄스(우)"});
		nameList.put("BIO3", new String[] {"독성지수(좌)", "독성지수(우)"});
		nameList.put("BIO4", new String[] {"미생물 독성지수"});
		nameList.put("BIO5", new String[] {"조류 독성지수"});
		nameList.put("CHLA", new String[] {"클로로필-a"});
		nameList.put("VOCS", new String[] {"염화메틸렌", "1.1.1-트리클로로에테인","벤젠","사염화탄소","트리클로로에틸렌","톨루엔","테트라클로로에티렌","에틸벤젠","m,p-자일렌","o-자일렌","[ECD]염화메틸렌","[ECD]1.1.1-트리클로로에테인","[ECD]사염화탄소","[ECD]트리클로로에틸렌","[ECD]테트라클로로에티렌"});
		nameList.put("METL", new String[] {"카드뮴", "납", "구리", "아연"});
		nameList.put("PHEN", new String[] {"페놀1", "페놀2"});
		nameList.put("ORGA", new String[] {"총유기탄소"});
		nameList.put("NUTR", new String[] {"총질소", "총인", "암모니아성질소", "질산성질소", "인산염인"});
		nameList.put("RAIN", new String[] {"강수량"});
		
		if(!sys.equals("A"))
		{
			itemCodeList.add("TUR");
			itemCodeList.add("DOW");
			itemCodeList.add("TMP");
			itemCodeList.add("PHY");
			itemCodeList.add("CON");
			
			 if(sys.equals("U"))
				itemCodeList.add("TOF");
		}
		else if(sys.equals("A"))
		{
			//선택된 대항목에 따른 코드 
			String[] list = codeList.get(item);
			
			for(String cd : list)
			{
				itemCodeList.add(cd);
			}
		}
	
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
	
		//getData
		List<DetailViewVO> graphDataList = waterinfoService.getRiverGraph(searchTaksuVO);
	
		int voCount = 0;
		
		String tmpDate = "";
		
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		
		if(!sys.equals("A"))
		{
			itemNameList.add("탁도");
			itemNameList.add("DO");
			itemNameList.add("수온");
			itemNameList.add("pH");
			itemNameList.add("전기전도도");
			
			 if(sys.equals("U"))
				 itemNameList.add("Chl-a");
		}
		else 
		{
			//선택된 대항목에 따른 세부항목 명칭 
			String[] list = nameList.get(item);
			
			for(String cd : list)
			{
				itemNameList.add(cd);
			}
			//if(graphDataList.size() > 0)
			//	itemNameList.add(graphDataList.get(0).getItemName());
		}
				
		if(sys.equals("A"))
		{
			if(graphDataList.size() == 0)
			{
				String[] list = codeList.get(item);
				
				itemNameList = new ArrayList<String>();
				itemCodeList = new ArrayList<String>();
				
				itemNameList.add("조회결과가 없습니다");
				itemCodeList.add(list[0]);
				
				for(int i = 0 ; i < 20 ; i++)
				{
					List data = dataMap.get(list[0]);
					
					Map valMap = new HashMap();
					valMap.put("x",  "");
					valMap.put("y", "0.00");
					data.add(valMap);
					dataMap.put(item, data);
					
					voCount ++;
				}
			}
		}
		else
		{
			if(graphDataList.size() == 0)
			{
				itemNameList = new ArrayList<String>();
				itemCodeList = new ArrayList<String>();
				
				itemNameList.add("조회결과가 없습니다");
				itemCodeList.add("TUR");
				
				for(int i = 0 ; i < 20 ; i++)
				{
					List data = dataMap.get("TUR");
					
					Map valMap = new HashMap();
					valMap.put("x",  "");
					valMap.put("y", "0.00");
					data.add(valMap);
					dataMap.put("TUR", data);
					
					voCount ++;
				}
			}
		}
		
		int turCnt = 0;
		int dowCnt = 0;
		int tmpCnt = 0;
		int phyCnt = 0;
		int conCnt = 0;
		int tofCnt = 0;

		for(DetailViewVO detailData : graphDataList) {
			
			String date = "";
			
			//일자는 처음에만 표시... 
			if(detailData != null)
			{
				//if(tmpDate.equals(detailData.getStrDate()))
				//	date = detailData.getStrTime();
				//else
				date = detailData.getStrdate() + " " + detailData.getStrtime();
					
				//tmpDate = detailData.getStrDate();
			}
	
			
			if(!sys.equals("A"))
			{
				
				if("all".equals(item) || "TUR00".equals(item) || "TUR00".equals(item2) || "TUR00".equals(item3))
				{
						List data =  dataMap.get("TUR");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTur());
							data.add(valMap);
						dataMap.put("TUR", data);
						
						if(detailData.getTur() != null)
							turCnt++;
				}
				
				if("all".equals(item) || "DOW00".equals(item) || "DOW00".equals(item2) || "DOW00".equals(item3))
				{
						List data =  dataMap.get("DOW");
						Map valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getDow());
						data.add(valMap);
						dataMap.put("DOW", data);
						
						if(detailData.getDow() != null)
							dowCnt++;
				}
				
				if("all".equals(item) || "TMP00".equals(item) || "TMP00".equals(item2) || "TMP00".equals(item3))
				{
						List data =  dataMap.get("TMP");
						Map valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTmp());
						data.add(valMap);
						dataMap.put("TMP", data);
						
						if(detailData.getTmp() != null)
							tmpCnt++;
				}
				
				if("all".equals(item) || "PHY00".equals(item) || "PHY00".equals(item2) || "PHY00".equals(item3))
				{
						List data =  dataMap.get("PHY");
						Map valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getPhy());
						data.add(valMap);
						dataMap.put("PHY", data);
						
						if(detailData.getPhy() != null)
							phyCnt++;
				}
				
				if("all".equals(item) || "CON00".equals(item) || "CON00".equals(item2) || "CON00".equals(item3))
				{
						List data =  dataMap.get("CON");
						Map valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getCon());
						data.add(valMap);
						dataMap.put("CON", data);
						
						if(detailData.getCon() != null)
							conCnt++;
				}
				
				//클로로필 A
				if("U".equals(sys))
				{
					if("all".equals(item) || "TOF00".equals(item) || "TOF00".equals(item2) || "TOF00".equals(item3))
					{
							List data =  dataMap.get("TOF");
							Map valMap = new HashMap();
							valMap.put("x", date);
							valMap.put("y", detailData.getTof());
							data.add(valMap);
							dataMap.put("TOF", data);
							
							if(detailData.getTof() != null)
								tofCnt++;
					}
				}
			}
			else if(sys.equals("A"))
			{
				//일반항목 그래프 표시
				if("COM1".equals(item))
				{
						List data =  dataMap.get("TUR00");
						Map valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTur());
						data.add(valMap);
						dataMap.put("TUR00", data);
						
						voCount++;

					
						data =  dataMap.get("PHY00");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getPhy());
							data.add(valMap);
						dataMap.put("PHY00", data);
						
						voCount ++;
					
						data =  dataMap.get("DOW00");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getDow());
						data.add(valMap);
						dataMap.put("DOW00", data);
						
						voCount ++;

						data =  dataMap.get("CON00");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getCon());
						data.add(valMap);
						dataMap.put("CON00", data);
						
						voCount ++;

						data =  dataMap.get("TMP00");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTmp());
						data.add(valMap);
						dataMap.put("TMP00", data);
						voCount++;
				}
				else if("BIO1".equals(item))	//생물독성(물고기)
				{
						List data =  dataMap.get("IMP00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getImp());
							data.add(valMap);
						dataMap.put("IMP00", data);
						voCount++;
				}
				else if("BIO2".equals(item))	//생물독성(물벼룩1)
				{
						List data =  dataMap.get("LIM00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getLim());
							data.add(valMap);
						dataMap.put("LIM00", data);
						voCount++;

						data =  dataMap.get("RIM00");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getRim());
							data.add(valMap);
						dataMap.put("RIM00", data);
						voCount++;
				}
				else if("BIO3".equals(item))	//생물독성(물벼룩2)
				{
						List data =  dataMap.get("LTX00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getLtx());
							data.add(valMap);
						dataMap.put("LTX00", data);
						voCount++;
				
						data =  dataMap.get("RTX00");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getRtx());
							data.add(valMap);
						dataMap.put("RTX00", data);
						voCount++;
				}
				else if("BIO4".equals(item))	//생물독성(미생물)
				{
						List data =  dataMap.get("TOX00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTox());
							data.add(valMap);
						dataMap.put("TOX00", data);
						voCount++;
				}
				else if("BIO5".equals(item))	//생물독성(조류 독성지수)
				{
						List data =  dataMap.get("EVN00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getEvn());
							data.add(valMap);
						dataMap.put("EVN00", data);
						voCount++;
				}
				else if("CHLA".equals(item))	//생물독성(조류 독성지수)
				{
						List data =  dataMap.get("TOF00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTof());
							data.add(valMap);
						dataMap.put("TOF00", data);
						voCount++;
				}
				else if("VOCS".equals(item))	//휘발성 유기화합물	
				{
						List data =  dataMap.get("VOC01");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc1());
							data.add(valMap);
						dataMap.put("VOC01", data);
						voCount++;

						data =  dataMap.get("VOC02");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc2());
							data.add(valMap);
						dataMap.put("VOC02", data);
						voCount++;

						data =  dataMap.get("VOC03");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc3());
							data.add(valMap);
						dataMap.put("VOC03", data);
						voCount++;

						data =  dataMap.get("VOC04");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc4());
							data.add(valMap);
						dataMap.put("VOC04", data);
						voCount++;

						data =  dataMap.get("VOC05");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc5());
							data.add(valMap);
						dataMap.put("VOC05", data);
						voCount++;

						data =  dataMap.get("VOC06");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc6());
							data.add(valMap);
						dataMap.put("VOC06", data);
						voCount++;

						data =  dataMap.get("VOC07");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc7());
							data.add(valMap);
						dataMap.put("VOC07", data);
						voCount++;

						data =  dataMap.get("VOC08");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc8());
							data.add(valMap);
						dataMap.put("VOC08", data);
						voCount++;

						data =  dataMap.get("VOC09");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc9());
							data.add(valMap);
						dataMap.put("VOC09", data);
						voCount++;

						data =  dataMap.get("VOC10");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc10());
							data.add(valMap);
						dataMap.put("VOC10", data);
						voCount++;

						data =  dataMap.get("VOC11");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc11());
							data.add(valMap);
						dataMap.put("VOC11", data);
						voCount++;

						data =  dataMap.get("VOC12");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc12());
							data.add(valMap);
						dataMap.put("VOC12", data);
						voCount++;

						data =  dataMap.get("VOC13");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc13());
							data.add(valMap);
						dataMap.put("VOC13", data);
						voCount++;

						data =  dataMap.get("VOC14");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc14());
							data.add(valMap);
						dataMap.put("VOC14", data);
						voCount++;

						data =  dataMap.get("VOC15");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getVoc15());
							data.add(valMap);
						dataMap.put("VOC15", data);
						voCount++;
				}
				if("METL".equals(item)) //중금속
				{
						List data =  dataMap.get("CAD00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getCad());
							data.add(valMap);
						dataMap.put("CAD00", data);
						voCount++;

						data =  dataMap.get("PLU00");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getPlu());
						data.add(valMap);
						dataMap.put("PLU00", data);
						voCount++;

						data =  dataMap.get("COP00");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getCop());
						data.add(valMap);
						dataMap.put("COP00", data);
						voCount++;

						data =  dataMap.get("ZIN00");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getZin());
						data.add(valMap);
						dataMap.put("ZIN00", data);
						voCount++;
				}
				else if("PHEN".equals(item))	//페놀
				{

						List data =  dataMap.get("PHE00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getPhe());
							data.add(valMap);
						dataMap.put("PHE00", data);
						voCount++;

						data =  dataMap.get("PHL00");
						valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getPhl());
							data.add(valMap);
						dataMap.put("PHL00", data);
						voCount++;
				}
				else if("ORGA".equals(item))	//유기물질
				{
						List data =  dataMap.get("TOC00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getToc());
							data.add(valMap);
						dataMap.put("TOC00", data);
						voCount++;
				}
				else if("NUTR".equals(item))	//영양염류
				{
						List data =  dataMap.get("TON00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTon());
							data.add(valMap);
						dataMap.put("TON00", data);
						voCount++;

						data =  dataMap.get("TOP00");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getTop());
						data.add(valMap);
						dataMap.put("TOP00", data);
						voCount++;

						data =  dataMap.get("NH400");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getNh4());
						data.add(valMap);
						dataMap.put("NH400", data);
						voCount++;

						data =  dataMap.get("NO300");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getNo3());
						data.add(valMap);
						dataMap.put("NO300", data);
						voCount++;

						data =  dataMap.get("PO400");
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getPo4());
						data.add(valMap);
						dataMap.put("PO400", data);
						voCount++;
				}
				else if("RAIN".equals(item))	//유기물질
				{
						List data =  dataMap.get("RIN00");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", date);
						valMap.put("y", detailData.getRin());
							data.add(valMap);
						dataMap.put("RIN00", data);
						voCount++;
				}
			}
		}
		
		if(!"A".equals(sys))
		{
			if(turCnt == 0)
			{
				itemNameList.remove("탁도");
				itemCodeList.remove("TUR");
			}
			if(phyCnt == 0)
			{
				itemNameList.remove("pH");
				itemCodeList.remove("PHY");
			}
			if(dowCnt == 0)
			{
				itemNameList.remove("DO");
				itemCodeList.remove("DOW");
			}
			if(conCnt == 0)
			{
				itemNameList.remove("전기전도도");
				itemCodeList.remove("CON");
			}
			if(tmpCnt == 0)
			{
				itemNameList.remove("수온");
				itemCodeList.remove("TMP");
			}
			if("U".equals(sys) && tofCnt == 0)
			{
				itemNameList.remove("Chl-a");
				itemCodeList.remove("TOF");
			}
		}
		

		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");
	
		try
		{
			Double lawVl = null;
			if("T".equals(sys))
			{
				if(itemCodeList.size() == 1 && "TUR".equals(itemCodeList.get(0)))
				{
					AlertSearchVO vo = new AlertSearchVO();
					vo.setFactCode(gongku);
					vo.setBranchNo(Integer.parseInt(chukjeongso));
					vo.setItemCode("TUR00");
					
					AlertDataLawVo lawData = alertLawService.getFactLaw(vo);
					
					modelAndView.addObject("lawVl", lawData.getLawHValue());
				}
			}
		}
		catch(Exception ex)
		{
			
		}
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "Y");
		modelAndView.addObject("wLine", wLine);
		modelAndView.addObject("sys", sys);
		if(image != null)
			modelAndView.addObject("image", "Y");
		else
			modelAndView.addObject("image", "N");
		
		modelAndView.setViewName("chartDetailViewRIVER");
		return modelAndView;
	}	
	
	
		
	//방류수질조회  
	@RequestMapping("/waterpolmnt/waterinfo/goDetailDISCHARGE.do")
	public ModelAndView goDetailDISCHARGE() throws Exception{
	
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/dischargewater");
		
		return modelAndView;
	}
	
	// 방류수질조회
	@RequestMapping("/waterpolmnt/waterinfo/getDetailViewDISCHARGE.do")
	public ModelAndView getDetailViewDISCHARGE(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	)
	throws Exception{
	
		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		boolean flag = false;
		String ftime = searchTaksuVO.getFrTime();
		
		if(ftime.length() == 2)
			searchTaksuVO.setFrTime(ftime+"00");
		else
		{
			flag = true;
			searchTaksuVO.setLastFlag("O");
		}
		
		String totime = searchTaksuVO.getToTime();
		if(totime.length() == 2)
			searchTaksuVO.setToTime(totime+"59");
		
		/** paging */
		searchTaksuVO.setPageUnit(20);
		
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());

		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<DetailViewVO> refreshData =  waterinfoService.getDetailViewDISCHARGE(searchTaksuVO);
		
		int totCnt = waterinfoService.getTotCntDischarge(searchTaksuVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.setViewName("jsonView");
		//modelAndView.setViewName("waterpolmnt/waterinfo/dischargewater");
		
		return modelAndView;
	}
	
	//방류수 수질조회(차트팝업 이동~)
	@RequestMapping("/waterpolmnt/waterinfo/goChartDischarge.do")
	public ModelAndView getChartDischarge(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "bangryu", required = false) String bangryu,
			@RequestParam(value = "dataType", required = false) String dataType,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="minor", required=false) String minor,
			@RequestParam(value="valid", required=false) String valid,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();
	
		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 4: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setBangryu(bangryu);
		searchTaksuVO.setDataType(dataType);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setSys(sys);

		searchTaksuVO.setMinor(minor);
		searchTaksuVO.setValid(valid);
		
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.setViewName("/waterpolmnt/waterinfo/discharge_chart");
		
		return modelAndView;
	}
	
	//방류수질 조회(차트)
	@RequestMapping("/waterpolmnt/waterinfo/getChartDetalViewDISCHARGE.do")
	public ModelAndView getChartDetalViewDISCHARGE(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "bangryu", required = false) String bangryu,
			@RequestParam(value = "dataType", required = false) String dataType,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="item01", required=false) String item01,
			@RequestParam(value="item02", required=false) String item02,
			@RequestParam(value="item03", required=false) String item03,
			@RequestParam(value="item04", required=false) String item04,
			@RequestParam(value="item05", required=false) String item05,
			@RequestParam(value="item06", required=false) String item06,
			@RequestParam(value="item07", required=false) String item07,
			@RequestParam(value="item", required=false) String item,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 5: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setBangryu(bangryu);
		searchTaksuVO.setChukjeongso(bangryu);
		searchTaksuVO.setDataType(dataType);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setItem01(item01);
		searchTaksuVO.setItem02(item02);
		searchTaksuVO.setItem03(item03);
		searchTaksuVO.setItem04(item04);
		searchTaksuVO.setItem05(item05);
		searchTaksuVO.setItem06(item06);
		searchTaksuVO.setItem07(item07);
		
		searchTaksuVO.setItem(item);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("PHY");
		itemCodeList.add("BOD");
		itemCodeList.add("COD");
		itemCodeList.add("SUS");
		itemCodeList.add("TON");
		itemCodeList.add("TOP");
		itemCodeList.add("FLW");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("pH");
		itemNameList.add("BOD");
		itemNameList.add("COD");
		itemNameList.add("SS");
		itemNameList.add("T-N");
		itemNameList.add("T-P");
		itemNameList.add("FLW");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<TaksuVO> graphDataList = waterinfoService.getDischargeGraph(searchTaksuVO);

		int voCount = 0;
		
		
		if(graphDataList.size() == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("PHY");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("PHY");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0.00");
				data.add(valMap);
				dataMap.put("PHY", data);
				
				voCount ++;
			}
		}
		
		
		for(TaksuVO detailData : graphDataList) {
			
				List data =  dataMap.get("PHY");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getStrDate() + " " + detailData.getStrTime());
				valMap.put("y", detailData.getPhy());
					data.add(valMap);
				dataMap.put("PHY", data);
				
				voCount++;
			

				data =  dataMap.get("BOD");
				valMap = new HashMap();
				valMap.put("x", detailData.getStrDate() + " " + detailData.getStrTime());
				valMap.put("y", detailData.getBod());
				data.add(valMap);
				dataMap.put("BOD", data);
				
				voCount++;
			
				data =  dataMap.get("COD");
				valMap = new HashMap();
				valMap.put("x", detailData.getStrDate() + " " + detailData.getStrTime());
				valMap.put("y", detailData.getCod());
				data.add(valMap);
				dataMap.put("COD", data);
				
				voCount++;
	
				data =  dataMap.get("SUS");
				valMap = new HashMap();
				valMap.put("x", detailData.getStrDate() + " " + detailData.getStrTime());
				valMap.put("y", detailData.getSus());
				data.add(valMap);
				dataMap.put("SUS", data);
				
				voCount++;

				data =  dataMap.get("TON");
				valMap = new HashMap();
				valMap.put("x", detailData.getStrDate() + " " + detailData.getStrTime());
				valMap.put("y", detailData.getTon());
				data.add(valMap);
				dataMap.put("TON", data);
				
				voCount++;

		
				data =  dataMap.get("TOP");
				valMap = new HashMap();
				valMap.put("x", detailData.getStrDate() + " " + detailData.getStrTime());
				valMap.put("y", detailData.getTop());
				data.add(valMap);
				dataMap.put("TOP", data);
				
				voCount++;
			
				
				data =  dataMap.get("FLW");
				valMap = new HashMap();
				valMap.put("x", detailData.getStrDate() + " " + detailData.getStrTime());
				valMap.put("y", detailData.getFlw());
				data.add(valMap);
				dataMap.put("FLW", data);
 
				voCount++;
		}
			
		
		if(dataMap.get("PHY").size() == 0)
		{
			itemNameList.remove("pH");
			itemCodeList.remove("PHY");
		}
		if(dataMap.get("BOD").size() == 0)
		{
			itemNameList.remove("BOD");
			itemCodeList.remove("BOD");
		}
		if(dataMap.get("COD").size() == 0)
		{
			itemNameList.remove("COD");
			itemCodeList.remove("COD");
		}
		if(dataMap.get("SUS").size() == 0)
		{
			itemNameList.remove("SS");
			itemCodeList.remove("SUS");
		}
		if(dataMap.get("TON").size() == 0)
		{
			itemNameList.remove("T-N");
			itemCodeList.remove("TON");
		}
		if(dataMap.get("TOP").size() == 0)
		{
			itemNameList.remove("T-P");
			itemCodeList.remove("TOP");
		}
		if(dataMap.get("FLW").size() == 0)
		{
			itemNameList.remove("FLW");
			itemCodeList.remove("FLW");
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("chartDetailViewDISCHARGE");
		return modelAndView;
	}

	// 방류수 수질조회(엑셀)
	@RequestMapping("/waterpolmnt/waterinfo/getExcelDetalViewDISCHARGE.do")
	public ModelAndView getExcelDetalViewDISCHARGE(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
			)
			throws Exception {

		String ftime = searchTaksuVO.getFrTime();
		searchTaksuVO.setChukjeongso(searchTaksuVO.getBangryu());
		
		if(ftime.length() == 2)
			searchTaksuVO.setFrTime(ftime+"00");
		else
		{
			searchTaksuVO.setLastFlag("O");
		}
		
		String totime = searchTaksuVO.getToTime();
		if(totime.length() == 2)
			searchTaksuVO.setToTime(totime+"59");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		// getData
		List<DetailViewVO> refreshData =  waterinfoService.getDetailViewDISCHARGE(searchTaksuVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("searchTaksuVO", searchTaksuVO);

		return new ModelAndView("ExcelViewDISCHARGE", "chartMap", map);
	}
	
	
	/**
	 * 유량 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goDetailFLUX.do")
	public ModelAndView goDetailFLUX() throws Exception{
	
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/waterlvlflux");
		
		return modelAndView;
	}
		
	/**
	 * 유량 조회_목록조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getFlowData.do")
	public ModelAndView getFlowData(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
			) throws Exception{
		PaginationInfo paginationInfo = new PaginationInfo();
		
		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		searchTaksuVO.setOrderby_time("desc");
		
		/** paging */
		//2014-10-22 mypark 페이징 처리
		//searchTaksuVO.setPageUnit(100000);
		searchTaksuVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());
		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		//System.out.println("공구값 : " + searchTaksuVO.getGongku());
		
		List<FlowDataVO> refreshData = waterinfoService.getFlowData(searchTaksuVO);
		//System.out.println("공구값 1: " + searchTaksuVO.getGongku());
		
		int totCnt = waterinfoService.getFlowData_cnt(searchTaksuVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		//modelAndView.setViewName("waterpolmnt/waterinfo/waterlvlflux");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	/**
	 * 유량 조회 - 차트
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getFlowChart.do")
	public ModelAndView getFlowChart(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height,
			@RequestParam(value="frDate") String frDate,
			@RequestParam(value="toDate") String toDate,
			@RequestParam(value="frTime") String frTime,
			@RequestParam(value="toTime") String toTime
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 7: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setOrderby_time("asc");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("WLV");
		itemCodeList.add("FLW");
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("수위");
		itemNameList.add("유량");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<FlowDataVO> graphDataList = waterinfoService.getFlowData_chart(searchTaksuVO);

		int voCount = 0;
		
		boolean isLegend = false;
		
		if(graphDataList.size() != 0)
		{
			for(FlowDataVO detailData : graphDataList) {
				
				String date = detailData.getRcv_date();
				String[] dateTime = date.split(" ");
				date = dateTime[0].substring(2) + "\n" + dateTime[1];
				
				
				if(detailData.getWl() != null)
				{
					List data =  dataMap.get("WLV");
					Map valMap = new HashMap();
					valMap = new HashMap();
					if(detailData.getRcv_date().split(" ").length > 1)
					{
						valMap.put("x", date);
						valMap.put("y", detailData.getWl());
							data.add(valMap);
						dataMap.put("WLV", data);
					}
				}
				
				
				if(detailData.getFw() != null)
				{
					List data =  dataMap.get("FLW");
					Map valMap = new HashMap();
					valMap = new HashMap();
					if(detailData.getRcv_date().split(" ").length > 1)
					{
						valMap.put("x", date);
						valMap.put("y", detailData.getFw());
							data.add(valMap);
						dataMap.put("FLW", data);
					}
				}
			
				voCount++;
			}
			
			isLegend = true;
		}
		else
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회 결과가 없습니다");
			itemCodeList.add("FLW");
			
			for(int i = 0 ; i < 3 ; i++)
			{
				List data = dataMap.get("FLW");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0.00");
				data.add(valMap);
				dataMap.put("FLW", data);
	
				voCount++;
			}
			
			isLegend = true;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", isLegend ? "Y" : "N");
		
		modelAndView.setViewName("chartDetailViewFlux");
		return modelAndView;
	}
	
	
	/**
	 * 유량 조회 - 차트팝업
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goFluxChart_popup.do")
	public ModelAndView goFluxChart_popup(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 8: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setOrderby_time("asc");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.setViewName("/waterpolmnt/waterinfo/waterlvflux_chart");
		
	
		return modelAndView;
	}
	
	/**
	 * 유량 조회 - 차트팝업
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getFluxChart_popup.do")
	public ModelAndView getFluxChart_popup(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 9: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setOrderby_time("asc");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("WLV");
		itemCodeList.add("FLW");
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("수위");
		itemNameList.add("유량");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<FlowDataVO> graphDataList = waterinfoService.getFlowData_chartpopup(searchTaksuVO);

		int voCount = 0;
		
		
		if(graphDataList.size() > 0)
		{
			for(FlowDataVO detailData : graphDataList) {
				
				if(detailData.getWl() != null)
				{
					List data =  dataMap.get("WLV");
					Map valMap = new HashMap();
					valMap = new HashMap();
					valMap.put("x", detailData.getRcv_date());
					valMap.put("y", detailData.getWl());
						data.add(valMap);
					dataMap.put("WLV", data);
				}
				
				if(detailData.getFw() != null)
				{
					List data =  dataMap.get("FLW");
					Map valMap = new HashMap();
					valMap = new HashMap();
					valMap.put("x", detailData.getRcv_date());
					valMap.put("y", detailData.getFw());
						data.add(valMap);
					dataMap.put("FLW", data);
				}
			
				voCount++;
			}
		}
		else
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회 결과가 없습니다");
			itemCodeList.add("FLW");
			
			for(int i = 0 ; i < 3 ; i++)
			{
				List data = dataMap.get("FLW");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0.00");
				data.add(valMap);
				dataMap.put("FLW", data);
	
				voCount++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("chartDetailViewFlux");
		return modelAndView;
	}
	
	
		/**
		 *  유량 조회 - 엑셀
		 */
	@RequestMapping("/waterpolmnt/waterinfo/getFluxExcel.do")
	public ModelAndView getFluxExcel(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime
		)
		throws Exception {

		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 10: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);

		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		// getData
		//List<FlowDataVO> refreshData =  waterinfoService.getFlowData_chartpopup(searchTaksuVO);
		List<FlowDataVO> refreshData = waterinfoService.getFlowData(searchTaksuVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("item", "유량");
		map.put("searchTaksuVO", searchTaksuVO);

		return new ModelAndView("ExcelViewFlux", "chartMap", map);
	}
	
	/**
	 * 유량 조회 - 측정소 좌표 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getFlowFactLocation.do")
	public ModelAndView getFlowMapLocation(
			@RequestParam(value="fact_code") String fact_code
	) throws Exception {
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();
		//System.out.println("DEBUG 11: "+fact_code);
		searchTaksuVO.setGongku(fact_code);
		
		LocationVO location = waterinfoService.getFlowFactLocation(searchTaksuVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		try
		{
		
			String strLat = location.getLatitude();
			String strLon = location.getLongitude();
			
			//"도-분-초" 방식의 위도경도 표시방식에서 도, 분, 초를 잘라냄
			String[] arrLat = strLat.split("-");
			String[] arrLon = strLon.split("-");
			
			double lat1 = Double.parseDouble(arrLat[0]);
			double lat2 = Double.parseDouble(arrLat[1]);
			double lat3 = Double.parseDouble(arrLat[2]);
			
			double lon1 = Double.parseDouble(arrLon[0]);
			double lon2 = Double.parseDouble(arrLon[1]);
			double lon3 = Double.parseDouble(arrLon[2]);
			
			//도, 분, 초 단위로 되어있는 위도경도를 소수점으로 변환
			double latitude = (lat1) + (lat2 / 60D) + (lat3 / 3600D);
			double longitude = (lon1) + (lon2 / 60D) + (lon3 / 3600D);
			
		  
			location.setLatitude(latitude+"");
			location.setLongitude(longitude+"");
		}
		catch(Exception e)
		{
			logger.info(e.getMessage());
			
			location = null;
		}
	  
		modelAndView.addObject("location", location);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 점오영원 목록 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/factoryIndustList.do")
	public ModelAndView factoryIndustList() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/factoryIndustList");
		
		return modelAndView;
	}
	
	/**
	 * 점오염원 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getFactoryIndustList.do")
	public ModelAndView getFactoryIndustList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();

		if(cmnSearchVO.getPageIndex() == 0)
			cmnSearchVO.setPageIndex(1);
		
		/** paging */
		cmnSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(cmnSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmnSearchVO.getPageUnit());
		paginationInfo.setPageSize(cmnSearchVO.getPageSize());
		
		cmnSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmnSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmnSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<FactoryIndustViewVO> list = waterinfoService.getFactoryIndustList(cmnSearchVO);
		int totCnt = waterinfoService.getFactoryIndustListCnt(cmnSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultlist", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 단일 점오염원 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getFactoryIndustIdList.do")
	public ModelAndView getFactoryIndustIdList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<FactoryIndustViewVO> list = waterinfoService.getFactoryIndustIdList(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultlist", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 점오염원 사업장 규모별 및 오염물질별 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getFactoryIndustSizeSpecList.do")
	public ModelAndView getFactoryIndustSizeSpecList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<FactoryIndustViewVO> list = new ArrayList();
		
		if("size".equals(cmnSearchVO.getSearchType())) {
			list = waterinfoService.getFactoryIndustSizeList(cmnSearchVO);
		} else {
			list = waterinfoService.getFactoryIndustSpecList(cmnSearchVO);
		}
//		List<FactoryIndustViewVO> list1 = waterinfoService.getFactoryIndustSizeSpecCnt(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("resultlist", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 유역 대권역 정보조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getBasinLargeList.do")
	public ModelAndView getBasinLargeList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<BasinViewVO> list = waterinfoService.getBasinLargeList(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultlist", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 유역 중권역 정보조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getBasinMiddleList.do")
	public ModelAndView getBasinMiddleList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<BasinViewVO> list = waterinfoService.getBasinMiddleList(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultlist", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 점오염원 사업소, size, spec, cnt 등록
	 * @param factoryIndustViewVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/insertFactoryIndust.do")
	public ModelAndView insertFactoryIndust(
			@ModelAttribute("factoryIndustViewVO") FactoryIndustViewVO factoryIndustViewVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int duplicateCnt = waterinfoService.duplicateFacId(factoryIndustViewVO);
		//System.out.println("duplicateCnt======>" + duplicateCnt);
		
		if (duplicateCnt > 0) {
			modelAndView.addObject("duplicateCnt", duplicateCnt);
		} else {
			waterinfoService.insertFactoryIndust(factoryIndustViewVO);
			waterinfoService.insertFactoryIndustSize(factoryIndustViewVO);
			waterinfoService.insertFactoryIndustSpec(factoryIndustViewVO);
			waterinfoService.insertFactoryIndustCnt(factoryIndustViewVO);
			
			modelAndView.addObject("updateCnt", true);
		}
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 점오염원 사업소 수정
	 * @param factoryIndustViewVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/updatFactoryIndust.do")
	public ModelAndView updatFactoryIndust(
			@ModelAttribute("factoryIndustViewVO") FactoryIndustViewVO factoryIndustViewVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.updatFactoryIndust(factoryIndustViewVO);
		
		modelAndView.addObject("updateCnt", true);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 점오염원 사업소 삭제
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/deleteFactoryIndust.do")
	public ModelAndView deleteFactoryIndust(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		int updateCnt = waterinfoService.deleteFactoryIndust(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 점오염원  사업소별 size 측정값 수정
	 * @param factoryIndustViewVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/updateFactoryIndustSize.do")
	public ModelAndView updateFactoryIndustSize(
			@ModelAttribute("factoryIndustViewVO") FactoryIndustViewVO factoryIndustViewVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.updateFactoryIndustSize(factoryIndustViewVO);
		
		modelAndView.addObject("updateCnt", true);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	 
	/**
	 * 점오염원  오염물질별 spec 측정값 수정
	 * @param factoryIndustViewVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/updateFactoryIndustSpec.do")
	public ModelAndView updateFactoryIndustSpec(
			@ModelAttribute("factoryIndustViewVO") FactoryIndustViewVO factoryIndustViewVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.updateFactoryIndustSpec(factoryIndustViewVO);
		
		modelAndView.addObject("updateCnt", true);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 점오염원  사업소별 cnt 측정값 수정
	 * @param factoryIndustViewVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/updateFactoryIndustCnt.do")
	public ModelAndView updateFactoryIndustCnt(
			@ModelAttribute("factoryIndustViewVO") FactoryIndustViewVO factoryIndustViewVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.updateFactoryIndustCnt(factoryIndustViewVO);
		
		modelAndView.addObject("updateCnt", true);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 취정수장 목록 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/waterDcCenterList.do")
	public ModelAndView waterDcCenterList() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/waterDcCenterList");
		
		return modelAndView;
	}
	
	/**
	 * 취정수장 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getWaterDcCenterList.do")
	public ModelAndView getWaterDcCenterList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();

		if(cmnSearchVO.getPageIndex() == 0)
			cmnSearchVO.setPageIndex(1);
		
		/** paging */
		cmnSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(cmnSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmnSearchVO.getPageUnit());
		paginationInfo.setPageSize(cmnSearchVO.getPageSize());

		
		cmnSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmnSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmnSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<WaterDcViewVO> refreshData =  waterinfoService.getWaterDcCenterList(cmnSearchVO);
		int totCnt = waterinfoService.getWaterDcCenterListCnt(cmnSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("cmnSearchVO", cmnSearchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 보 목록 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/boObsInfoList.do")
	public ModelAndView boObsInfoList() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/boObsInfoList");
		
		return modelAndView;
	}
	
	/**
	 * 보 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getBoObsInfoList.do")
	public ModelAndView getBoObsInfoList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();

		if(cmnSearchVO.getPageIndex() == 0)
			cmnSearchVO.setPageIndex(1);
		
		/** paging */
		cmnSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(cmnSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmnSearchVO.getPageUnit());
		paginationInfo.setPageSize(cmnSearchVO.getPageSize());

		
		cmnSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmnSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmnSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<BoViewVO> refreshData =  waterinfoService.getBoObsInfoList(cmnSearchVO);
		int totCnt = waterinfoService.getBoObsInfoListCnt(cmnSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("cmnSearchVO", cmnSearchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultList", refreshData);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 댐 목록 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/damList.do")
	public ModelAndView damList() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/damList");
		
		return modelAndView;
	}
	
	/**
	 * 댐 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getDamList.do")
	public ModelAndView getDamList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();

		if(cmnSearchVO.getPageIndex() == 0)
			cmnSearchVO.setPageIndex(1);
		
		/** paging */
		cmnSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(cmnSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmnSearchVO.getPageUnit());
		paginationInfo.setPageSize(cmnSearchVO.getPageSize());

		
		cmnSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmnSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmnSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<DamViewVO> refreshData =  waterinfoService.getDamList(cmnSearchVO);
		int totCnt = waterinfoService.getDamListCnt(cmnSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("cmnSearchVO", cmnSearchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 유관기관 목록
	 */
	@RequestMapping("/waterpolmnt/waterinfo/relateOfficeList.do")
	public ModelAndView relateOfficeList() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/relateOfficeList");
		
		return modelAndView;
	}
	
	// 유관기관 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getRelOffList.do")
	public ModelAndView getRelOffList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();

		if(cmnSearchVO.getPageIndex() == 0)
			cmnSearchVO.setPageIndex(1);
		
		/** paging */
//		cmnSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(cmnSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmnSearchVO.getPageUnit());
		paginationInfo.setPageSize(cmnSearchVO.getPageSize());

		
		cmnSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmnSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmnSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<RelateOfficeDataVO> list =  waterinfoService.getRelOffList(cmnSearchVO);
		int totCnt = waterinfoService.getRelOffListCnt(cmnSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("cmnSearchVO", cmnSearchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 단일 유관기관 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getRelOffDetailList.do")
	public ModelAndView getRelOffDetailList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<RelateOfficeDataVO> list = waterinfoService.getRelOffDetailList(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 유관기관 등록
	@RequestMapping("/waterpolmnt/waterinfo/insertRelOff.do")
	public ModelAndView insertRelOff(
			@ModelAttribute("relateOfficeDataVO") RelateOfficeDataVO relateOfficeDataVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int duplicateCnt = waterinfoService.duplicateRelOffId(relateOfficeDataVO);
		
		if (duplicateCnt > 0) {
			modelAndView.addObject("duplicateCnt", duplicateCnt);
		} else {
			waterinfoService.insertRelOff(relateOfficeDataVO);
			
			modelAndView.addObject("updateCnt", true);
		}
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 유관기관 수정
	@RequestMapping("/waterpolmnt/waterinfo/updatRelOff.do")
	public ModelAndView updatRelOff(
			@ModelAttribute("relateOfficeDataVO") RelateOfficeDataVO relateOfficeDataVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.updatRelOff(relateOfficeDataVO);
		
		modelAndView.addObject("updateCnt", true);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 유관기관 삭제
	@RequestMapping("/waterpolmnt/waterinfo/deleteRelOff.do")
	public ModelAndView deleteRelOff(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		int updateCnt = waterinfoService.deleteRelOff(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 특별시/동 조회
	@RequestMapping("/waterpolmnt/waterinfo/getDoCodeList.do")
	public ModelAndView getDoCodeList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<AreaDataVO> list =  waterinfoService.getDoCodeList(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
//	// 시군구 조회
	@RequestMapping("/waterpolmnt/waterinfo/getCtyCodeList.do")
	public ModelAndView getCtyCodeList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<AreaDataVO> list =  waterinfoService.getCtyCodeList(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 방제업체관리 목록
	 */
	@RequestMapping("/waterpolmnt/waterinfo/ecompanyList.do")
	public ModelAndView ecompanyList() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/ecompanyList");
		
		return modelAndView;
	}
	
	// 방제업체 관리 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getEcompanyList.do")
	public ModelAndView getEcompanyList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();

		if(cmnSearchVO.getPageIndex() == 0)
			cmnSearchVO.setPageIndex(1);
		
		/** paging */
		cmnSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(cmnSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cmnSearchVO.getPageUnit());
		paginationInfo.setPageSize(cmnSearchVO.getPageSize());

		
		cmnSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cmnSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cmnSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<EcompanyDataVO> list =  waterinfoService.getEcompanyList(cmnSearchVO);
		int totCnt = waterinfoService.getEcompanyListCnt(cmnSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("cmnSearchVO", cmnSearchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 단일방제업체 상세조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getEcompanyDetailList.do")
	public ModelAndView getEcompanyDetailList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<EcompanyDataVO> list = waterinfoService.getEcompanyDetailList(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 방제업체 등록
	@RequestMapping("/waterpolmnt/waterinfo/insertEcompany.do")
	public ModelAndView insertEcompany(
			@ModelAttribute("ecompanyDataVO") EcompanyDataVO ecompanyDataVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int duplicateCnt = waterinfoService.duplicateEcoId(ecompanyDataVO);
		//System.out.println("duplicateCnt======>" + duplicateCnt);
		
		if (duplicateCnt > 0) {
			modelAndView.addObject("duplicateCnt", duplicateCnt);
		} else {
			waterinfoService.insertEcompany(ecompanyDataVO);
			modelAndView.addObject("updateCnt", true);
		}
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 방제업체 수정
	@RequestMapping("/waterpolmnt/waterinfo/updatEcompany.do")
	public ModelAndView updatEcompany(
			@ModelAttribute("factoryIndustViewVO") EcompanyDataVO ecompanyDataVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.updatEcompany(ecompanyDataVO);
		
		modelAndView.addObject("updateCnt", true);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 방제업체 삭제
	@RequestMapping("/waterpolmnt/waterinfo/deleteEcompany.do")
	public ModelAndView deleteEcompany(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		int updateCnt = waterinfoService.deleteEcompany(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 방제물품 조회
	@RequestMapping("/waterpolmnt/waterinfo/getEcompanyOwnItemList.do")
	public ModelAndView getEcompanyOwnItemList(
			@ModelAttribute("cmnSearchVO") CmnSearchVO cmnSearchVO
	) throws Exception
	{
		List<EcompayOwnItemDataVO> list =  waterinfoService.getEcompanyOwnItemList(cmnSearchVO);
//		int totCnt = waterinfoService.getEcompanyOwnItemListCnt(cmnSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("cmnSearchVO", cmnSearchVO);
//		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 방제물품 추가
	@RequestMapping("/waterpolmnt/waterinfo/insertEcompanyOwnItem.do")
	public ModelAndView insertEcompanyOwnItem(
			@ModelAttribute("ecompayOwnItemDataVO") EcompayOwnItemDataVO ecompayOwnItemDataVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
//		int duplicateCnt = waterinfoService.duplicateEcoOwnId(ecompayOwnItemDataVO);
//		System.out.println("duplicateCnt======>" + duplicateCnt);
//		
//		if (duplicateCnt > 0) {
//			modelAndView.addObject("duplicateCnt", duplicateCnt);
//		} else {
			waterinfoService.insertEcompanyOwnItem(ecompayOwnItemDataVO);
			
			modelAndView.addObject("updateCnt", true);
//		}
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 방제물품 삭제
	@RequestMapping("/waterpolmnt/waterinfo/deleteEcompanyOwnItem.do")
	public ModelAndView deleteEcompanyOwnItem(
			@ModelAttribute("cmnSearchVO") EcompayOwnItemDataVO ecompayOwnItemDataVO
//			, Map<String, Object> commandMap
			) throws Exception {
		
		int updateCnt = waterinfoService.deleteEcompanyOwnItem(ecompayOwnItemDataVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 댐수위방류량 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goDetailDam.do")
	public ModelAndView goDetailDam() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/daminfo");
		
		return modelAndView;
	}
		
	/**
	 * 댐수위방류량 조회_목록조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getDamData.do")
	public ModelAndView getDamData(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		
		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		searchTaksuVO.setOrderby_time("desc");
		
		/** paging */
		//2014-10-22 mypark 페이징 처리
		searchTaksuVO.setPageUnit(20);
		//searchTaksuVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());
		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<DamDataVO> refreshData =  waterinfoService.getDamData(searchTaksuVO);
		
		int totCnt = waterinfoService.getDamData_cnt(searchTaksuVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 댐수위방류량 조회 - 차트
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getDamChart.do")
	public ModelAndView getDamChart(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height,
			@RequestParam(value="frDate") String frDate,
			@RequestParam(value="toDate") String toDate,
			@RequestParam(value="frTime") String frTime,
			@RequestParam(value="toTime") String toTime
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();
		
		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 12: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setOrderby_time("asc");
		
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("SWL");
		itemCodeList.add("SFW");
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("수위");
		itemNameList.add("방류량");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		//getData
		List<DamDataVO> graphDataList = waterinfoService.getDamData_chart(searchTaksuVO);
		
		int voCount = 0;
		
		boolean isLegend = false;
		
		if(graphDataList.size() != 0)
		{
			for(DamDataVO detailData : graphDataList) {
				
				String date = detailData.getRcv_date();
				String[] dateTime = date.split(" ");
				date = dateTime[0].substring(2) + "\n" + dateTime[1];
				
				if(detailData.getSWL() != null)
				{
					List data =  dataMap.get("SWL");
					Map valMap = new HashMap();
					valMap = new HashMap();
					if(detailData.getRcv_date().split(" ").length > 1)
					{
						valMap.put("x", date);
						valMap.put("y", detailData.getSWL());
							data.add(valMap);
						dataMap.put("SWL", data);
					}
				}
				
				if(detailData.getSFW() != null)
				{
					List data =  dataMap.get("SFW");
					Map valMap = new HashMap();
					valMap = new HashMap();
					if(detailData.getRcv_date().split(" ").length > 1)
					{
						valMap.put("x", date);
						valMap.put("y", detailData.getSFW());
							data.add(valMap);
						dataMap.put("SFW", data);
					}
				}
			
				voCount++;
			}
			
			isLegend = true;
		}
		else
		{
			itemNameList.set(0, "조회 결과가 없습니다");
			itemNameList.set(1, "조회 결과가 없습니다");
			
			for(int i = 0 ; i < 3 ; i++)
			{
				List data = dataMap.get("SWL");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0.00");
				data.add(valMap);
				dataMap.put("SWL", data);
	
				voCount++;
			}
			
			isLegend = true;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", isLegend ? "Y" : "N");
		
		modelAndView.setViewName("chartDetailViewFlux");
		return modelAndView;
	}
	
	/**
	 * 댐 조회 - 차트팝업으로 이동
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goDamChart_popup.do")
	public ModelAndView goDamChart_popup(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 13: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setOrderby_time("asc");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.setViewName("/waterpolmnt/waterinfo/daminfo_chart");
		
		return modelAndView;
	}
	
	/**
	 * 댐 조회 - 차트팝업
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getDamChart_popup.do")
	public ModelAndView getDamChart_popup(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 14: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setOrderby_time("asc");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("SWL");
		itemCodeList.add("SFW");
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("수위");
		itemNameList.add("방류량");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<DamDataVO> graphDataList = waterinfoService.getDamData_chartpopup(searchTaksuVO);

		int voCount = 0;
		
		for(DamDataVO detailData : graphDataList) {
			
			if(detailData.getSWL() != null)
			{
				List data =  dataMap.get("SWL");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getRcv_date());
				valMap.put("y", detailData.getSWL());
					data.add(valMap);
				dataMap.put("SWL", data);
			}
			if(detailData.getSFW() != null)
			{
				List data =  dataMap.get("SFW");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getRcv_date());
				valMap.put("y", detailData.getSFW());
				data.add(valMap);
				dataMap.put("SFW", data);
			}
		
			voCount++;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("chartDetailViewFlux");
		return modelAndView;
	}
	
		/**
		 *  댐 조회 - 엑셀
		 */
	@RequestMapping("/waterpolmnt/waterinfo/getDamExcel.do")
	public ModelAndView getDamExcel(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime
		)
		throws Exception {

		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 15: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);

		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		searchTaksuVO.setOrderby_time("desc");
		
		// getData
		List<DamDataVO> refreshData =  waterinfoService.getDamData(searchTaksuVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("searchTaksuVO", searchTaksuVO);

		return new ModelAndView("ExcelViewDam", "chartMap", map);
	}
	
	/**
	 * 댐 조회 - 측정소 좌표 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getDamFactLocation.do")
	public ModelAndView getDamMapLocation(
			@RequestParam(value="fact_code") String fact_code
	) throws Exception {
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();
		//System.out.println("DEBUG 16: "+fact_code);
		searchTaksuVO.setGongku(fact_code);
		
		LocationVO location = waterinfoService.getDamFactLocation(searchTaksuVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		try
		{
		
			String strLat = location.getLatitude();
			String strLon = location.getLongitude();
			
//			//"도-분-초" 방식의 위도경도 표시방식에서 도, 분, 초를 잘라냄
//			String[] arrLat = strLat.split("-");
//			String[] arrLon = strLon.split("-");
//			
//			double lat1 = Double.parseDouble(arrLat[0]);
//			double lat2 = Double.parseDouble(arrLat[1]);
//			double lat3 = Double.parseDouble(arrLat[2]);
//			
//			double lon1 = Double.parseDouble(arrLon[0]);
//			double lon2 = Double.parseDouble(arrLon[1]);
//			double lon3 = Double.parseDouble(arrLon[2]);
//			
//			//도, 분, 초 단위로 되어있는 위도경도를 소수점으로 변환
//			double latitude = (lat1) + (lat2 / 60D) + (lat3 / 3600D);
//			double longitude = (lon1) + (lon2 / 60D) + (lon3 / 3600D);
			
		  
			location.setLatitude(strLat);
			location.setLongitude(strLon);
		}
		catch(Exception e)
		{
			logger.info(e.getMessage());
			
			location = null;
		}
	  
		modelAndView.addObject("location", location);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 수위 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goDetailWL.do")
	public ModelAndView goDetailWL() throws Exception{
	 
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/waterlevel");
		
		return modelAndView;
	}
		
	/**
	 * 수위 조회_목록조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getWLData.do")
	public ModelAndView getWLData(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();		

		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		searchTaksuVO.setOrderby_time("desc");
		
		/** paging */
		searchTaksuVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());

		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<FlowDataVO> refreshData =  waterinfoService.getWLData(searchTaksuVO);
		
		int totCnt = waterinfoService.getWLData_cnt(searchTaksuVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		//modelAndView.setViewName("waterpolmnt/waterinfo/waterlvlflux");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 수위 조회 - 차트
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getWLChart.do")
	public ModelAndView getWLChart(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 17: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setOrderby_time("asc");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("WLV");
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("수위");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<FlowDataVO> graphDataList = waterinfoService.getWLData_chart(searchTaksuVO);

		int voCount = 0;
		
		boolean isLegend = false;
		
		if(graphDataList.size() != 0)
		{
			for(FlowDataVO detailData : graphDataList) {
				
				if(detailData.getValue() != null)
				{
					List data =  dataMap.get("WLV");
					Map valMap = new HashMap();
					valMap = new HashMap();
					if(detailData.getRcv_date().split(" ").length > 1)
					{
						valMap.put("x", detailData.getRcv_date());
						valMap.put("y", detailData.getValue());
							data.add(valMap);
						dataMap.put("WLV", data);
					}
				}
			
				voCount++;
			}
			
			isLegend = false;
		}
		else
		{
			itemNameList.set(0, "조회 결과가 없습니다");
			
			for(int i = 0 ; i < 3 ; i++)
			{
				List data = dataMap.get("WLV");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0.00");
				data.add(valMap);
				dataMap.put("WLV", data);
	
				voCount++;
			}
			
			isLegend = true;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", isLegend ? "Y" : "N");
		
		modelAndView.setViewName("chartDetailViewFlux");
		return modelAndView;
	}
	
	
	/**
	 * 수위 조회 - 차트팝업
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getWLChart_popup.do")
	public ModelAndView getWLChart_popup(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 18: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);
		searchTaksuVO.setOrderby_time("asc");
		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("FLW");
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("유량");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<FlowDataVO> graphDataList = waterinfoService.getWLData_chartpopup(searchTaksuVO);

		int voCount = 0;
		
		for(FlowDataVO detailData : graphDataList) {
			
			if(detailData.getValue() != null)
			{
				List data =  dataMap.get("FLW");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getRcv_date());
				valMap.put("y", detailData.getValue());
					data.add(valMap);
				dataMap.put("FLW", data);
			}
		
			voCount++;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("chartDetailViewDISCHARGE");
		return modelAndView;
	}
	
	
		/**
		 *  수위 조회 - 엑셀
		 */
	@RequestMapping("/waterpolmnt/waterinfo/getWLExcel.do")
	public ModelAndView getWLExcel(
			@RequestParam(value = "sugye", required = false) String sugye,
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime
		)
		throws Exception {

		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setSugye(sugye);
		//System.out.println("DEBUG 19: "+gongku);
		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);

		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		// getData
		List<FlowDataVO> refreshData =  waterinfoService.getWLData_chartpopup(searchTaksuVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("item", "수위");
		map.put("searchTaksuVO", searchTaksuVO);

		return new ModelAndView("ExcelViewFlux", "chartMap", map);
	}
	
	/**
	 * 수위 조회 - 측정소 좌표 조회
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getWLFactLocation.do")
	public ModelAndView getWLMapLocation(
			@RequestParam(value="fact_code") String fact_code
	) throws Exception {
		
		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();
		//System.out.println("DEBUG 20: "+fact_code);
		searchTaksuVO.setGongku(fact_code);
		
		LocationVO location = waterinfoService.getWLFactLocation(searchTaksuVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		try
		{
			String strLat = location.getLatitude();
			String strLon = location.getLongitude();
			
			//"도-분-초" 방식의 위도경도 표시방식에서 도, 분, 초를 잘라냄
			String[] arrLat = strLat.split("-");
			String[] arrLon = strLon.split("-");
			
			double lat1 = Double.parseDouble(arrLat[0]);
			double lat2 = Double.parseDouble(arrLat[1]);
			double lat3 = Double.parseDouble(arrLat[2]);
			
			double lon1 = Double.parseDouble(arrLon[0]);
			double lon2 = Double.parseDouble(arrLon[1]);
			double lon3 = Double.parseDouble(arrLon[2]);
			
			//도, 분, 초 단위로 되어있는 위도경도를 소수점으로 변환
			double latitude = (lat1) + (lat2 / 60D) + (lat3 / 3600D);
			double longitude = (lon1) + (lon2 / 60D) + (lon3 / 3600D);
			
		
			location.setLatitude(latitude+"");
			location.setLongitude(longitude+"");
		}
		catch(Exception e)
		{
			logger.info(e.getMessage());
			
			location = null;
		}
	
		modelAndView.addObject("location", location);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	/**
	 * 항공감시 목록 페이지로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goAirMnt.do")
	public ModelAndView goAirMnt() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/airmnt");

		return modelAndView;  
	}
	
	/**
	 * 항공감시 상세보기로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goAirMntView.do")
	public ModelAndView goAirMntView() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();


		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		String groupName = member.getGroupName();
		
		//항공감시 그룹의 이름을 공통코드에서 가져옴
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("39");
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		boolean isAirGroup = false;
		
		if(codeResult != null && groupName != null)
		{
			CmmnDetailCode c = (CmmnDetailCode)codeResult.get(0);
			if(c.getCodeDesc().trim().equals(groupName))
			{
				isAirGroup = true;
			}
		}
		
		modelAndView.addObject("isAirGroup", isAirGroup);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/airmntView");
		
		return modelAndView;
	}
	
	/**
	 * 조류예보 목록 페이지로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goAlgaCast.do")
	public ModelAndView goAlgaCast() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/algacast");

		return modelAndView;
	}
	
	/**
	 * 조류예보 상세보기로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goAlgaCastView.do")
	public ModelAndView goAlgaCastView() throws Exception{
		
		//return "waterpolmnt/waterinfo/algacastView";
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		String groupName = member.getGroupName();
		
		//항공감시 그룹의 이름을 공통코드에서 가져옴
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("38");
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		boolean isAlgaGroup = false;
		
		if(codeResult != null && groupName != null)
		{
			CmmnDetailCode c = (CmmnDetailCode)codeResult.get(0);
			if(c.getCodeDesc().trim().equals(groupName))
			{
				isAlgaGroup = true;
			}
		}
		
		modelAndView.addObject("isAlgaGroup", isAlgaGroup);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/algacastView");
		
		return modelAndView;
	}
	
	/**
	 * 조류예보 목록 불러오기
	 * @param survey_point
	 * @param search_date_start
	 * @param search_date_end
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getAlgaCastList.do")
	public ModelAndView getAlgaCastList(
			@ModelAttribute("AlgaCastDataVO") AlgaCastDataVO algaCastDataVO
	) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		
		PaginationInfo paginationInfo = new PaginationInfo();

		if(algaCastDataVO.getPageIndex() == 0)
			algaCastDataVO.setPageIndex(1);
		
		/** paging */
		//2014-10-22 mypark 페이징 수정
		algaCastDataVO.setPageUnit(20);
		//algaCastDataVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(algaCastDataVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(algaCastDataVO.getPageUnit());
		paginationInfo.setPageSize(algaCastDataVO.getPageSize());
	
		
		algaCastDataVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		algaCastDataVO.setLastIndex(paginationInfo.getLastRecordIndex());
		algaCastDataVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<AlgaCastDataVO> algaCastDataList = waterinfoService.getAlgaCastList(algaCastDataVO);
		
		int totCnt = waterinfoService.getAlgaCastList_cnt(algaCastDataVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("algaCastDataVO", algaCastDataVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("dataList", algaCastDataList);

		modelAndView.setViewName("jsonView");
//		modelAndView.setViewName("waterpolmnt/waterinfo/algacast");

		return modelAndView;  
	}
	
	/**
	 * 조류예보 상세정보 불러오기
	 * @param cast_num
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getAlgaCast.do")
	public ModelAndView getAlgaCast(
			@RequestParam(value="cast_num", required=false) String cast_num
	) throws Exception {

	
		AlgaCastDataVO algaData = waterinfoService.getAlgaCast(cast_num);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("algaData", algaData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;  
	}
	
	/**
	 * 조류예보 삭제
	 * @param cast_num
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/deleteAlgaCast.do")
	public ModelAndView deleteAlgaCast(
			@RequestParam(value="cast_num", required=false) String cast_num
	) throws Exception {
		
		waterinfoService.deleteAlgaCast(cast_num);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("algaData", "OK");
		modelAndView.setViewName("jsonView");
		
		//return modelAndView;
		return modelAndView;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/waterpolmnt/waterinfo/updateAlgaCast.do")
	public String updateAlgaCast(
			final MultipartHttpServletRequest multiRequest, 
			@ModelAttribute("AlgaCastDataVO") AlgaCastDataVO algaCastDataVO,
			BindingResult bindingResult, 
			SessionStatus status,
			ModelMap model) throws Exception{
		
		String resultParam = "";
		
		waterinfoService.updateAlgaCast(algaCastDataVO);

		return "forward:/waterpolmnt/waterinfo/goAlgaCastView.do?cast_num=" + algaCastDataVO.getCast_num();
	}
	
	
	/**
	 * 항공감시 목록 불러오기
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getAirMntList.do")
	public ModelAndView getAirMntList(
			@ModelAttribute("AirMntDataVO") AirMntDataVO airMntDataVO
	) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
			
		PaginationInfo paginationInfo = new PaginationInfo();		

		if(airMntDataVO.getPageIndex() == 0)
			airMntDataVO.setPageIndex(1);
		
		/** paging */
		airMntDataVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(airMntDataVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(airMntDataVO.getPageUnit());
		paginationInfo.setPageSize(airMntDataVO.getPageSize());
	
		
		airMntDataVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		airMntDataVO.setLastIndex(paginationInfo.getLastRecordIndex());
		airMntDataVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<AirMntDataVO> airMntDataList = waterinfoService.getAirMntList(airMntDataVO);
		
		int totCnt = waterinfoService.getAirMntList_cnt(airMntDataVO);		
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("airMntDataVO", airMntDataVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("dataList", airMntDataList);
		modelAndView.setViewName("jsonView");
//		modelAndView.setViewName("waterpolmnt/waterinfo/airmnt");

		return modelAndView;  
	}
	
	/**
	 * 항공감시 상세정보 불러오기
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getAirMnt.do")
	public ModelAndView getAirMnt(
			@RequestParam(value="obv_num", required=false) String obv_num
	) throws Exception {

	
		AirMntDataVO airMntData = waterinfoService.getAirMnt(obv_num);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("airData", airMntData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;  
	}
	
	/**
	 * 항공감시 데이터 삭제
	 */
	@RequestMapping("/waterpolmnt/waterinfo/deleteAirMnt.do")
	public ModelAndView deleteAirMnt(
			@RequestParam(value="obv_num", required=false) String obv_num
	) throws Exception {
		
		waterinfoService.deleteAirMnt(obv_num);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("airData", "OK");
		modelAndView.setViewName("jsonView");
		
		//return modelAndView;
		return modelAndView;
	}
	
	/**
	 * 항공감세 데이터 업데이트
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/waterpolmnt/waterinfo/updateAirMnt.do")
	public String updateAirMnt(
			final MultipartHttpServletRequest multiRequest, 
			@ModelAttribute("AirMntDataVO") AirMntDataVO airMntDataVO,
			BindingResult bindingResult, 
			SessionStatus status,
			ModelMap model) throws Exception{
		
		String resultParam = "";
		
		waterinfoService.updateAirMnt(airMntDataVO);

		return "forward:/waterpolmnt/waterinfo/goAirMntView.do?obv_num=" + airMntDataVO.getObv_num();
	}
	
	// 하천수질조회(경보 3시간이상)
	@RequestMapping("/waterpolmnt/waterinfo/goRiverWater3HourWarning.do")
	public ModelAndView goRiverWater3HourWarning() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater3hourwarning");
		
		return modelAndView;
		
	}

	// 하천수질조회(경보 3시간이상)
	@RequestMapping("/waterpolmnt/waterinfo/getRiverWater3HourWarning.do")
	public ModelAndView getRiverWater3HourWarning(
			@ModelAttribute("RiverWater3HourWarningSearchVO") RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		riverWater3HourWarningSearchVO.setUserId(user.getId());
		riverWater3HourWarningSearchVO.setUserGubun(user.getRoleCode());
		
		ModelAndView modelAndView = new ModelAndView();
	
		PaginationInfo paginationInfo = new PaginationInfo();

		if(riverWater3HourWarningSearchVO.getPageIndex() == 0)
			riverWater3HourWarningSearchVO.setPageIndex(1);
		
//		int alertTime = riverWater3HourWarningSearchVO.getAlertTime();
		
//		if(alertTime == 1)
//			riverWater3HourWarningSearchVO.setPeriodTime(3);
//		else if(alertTime == 2)
//			riverWater3HourWarningSearchVO.setPeriodTime(9);
//		else if(alertTime >= 3)
//			riverWater3HourWarningSearchVO.setPeriodTime(21);
		
//		if(alertTime == 1)
//			riverWater3HourWarningSearchVO.setPeriodTime(3);
//		else if(alertTime == 2)
//			riverWater3HourWarningSearchVO.setPeriodTime(6);
//		else if(alertTime >= 3)
//			riverWater3HourWarningSearchVO.setPeriodTime(12);
		
		/** paging */
		//2014-10-22 mypakr 페이징 수정
		riverWater3HourWarningSearchVO.setPageUnit(20);
		//riverWater3HourWarningSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(riverWater3HourWarningSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(riverWater3HourWarningSearchVO.getPageUnit());
		paginationInfo.setPageSize(riverWater3HourWarningSearchVO.getPageSize());
	
		
		riverWater3HourWarningSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		riverWater3HourWarningSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		riverWater3HourWarningSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<RiverWater3HourWarningVO> dataList =  waterinfoService.getRiverWater3HourWarning(riverWater3HourWarningSearchVO);
		
		int totCnt = waterinfoService.getRiverWarning_cnt(riverWater3HourWarningSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("riverWater3HourWarningSearchVO", riverWater3HourWarningSearchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("dataList", dataList);
		modelAndView.setViewName("jsonView");
//		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater3hourwarning");
		
		return modelAndView;
	}
  
	// 하천수질조회(경보 3시간이상) - 엑셀출력
	@RequestMapping("/waterpolmnt/waterinfo/getExcelWarning.do")
	public ModelAndView getExcelWarning(
			@ModelAttribute("RiverWater3HourWarningSearchVO") RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		riverWater3HourWarningSearchVO.setUserId(user.getId());
		riverWater3HourWarningSearchVO.setUserGubun(user.getRoleCode());
		
//		int alertTime = riverWater3HourWarningSearchVO.getAlertTime();
		
//		if(alertTime == 1)
//			riverWater3HourWarningSearchVO.setPeriodTime(3);
//		else if(alertTime == 2)
//			riverWater3HourWarningSearchVO.setPeriodTime(9);
//		else if(alertTime >= 3)
//			riverWater3HourWarningSearchVO.setPeriodTime(21);
//		//else if(alertTime == 4)
//		//	riverWater3HourWarningSearchVO.setPageIndex(24);
		
//		if(alertTime == 1)
//			riverWater3HourWarningSearchVO.setPeriodTime(3);
//		else if(alertTime == 2)
//			riverWater3HourWarningSearchVO.setPeriodTime(6);
//		else if(alertTime >= 3)
//			riverWater3HourWarningSearchVO.setPeriodTime(12);
		
//		List<RiverWater3HourWarningVO> refreshData =  waterinfoService.getChartWarning(riverWater3HourWarningSearchVO);
		List<RiverWater3HourWarningVO> refreshData =  waterinfoService.getRiverWater3HourWarningExcel(riverWater3HourWarningSearchVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("riverWater3HourWarningSearchVO", riverWater3HourWarningSearchVO);

		return new ModelAndView("ExcelViewWarning", "chartMap", map);
	}
	
	// 하천수질조회(경보 3시간이상) - 그래프 팝업
	@RequestMapping("/waterpolmnt/waterinfo/getChartWarning.do")
	public ModelAndView getChartWarning(
			@ModelAttribute("RiverWater3HourWarningSearchVO") RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();

		List<RiverWater3HourWarningVO> graphDataList =  waterinfoService.getChartWarning(riverWater3HourWarningSearchVO);
	
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("TUR");
		itemCodeList.add("DOW");
		itemCodeList.add("TEM");
		itemCodeList.add("PHY");
		itemCodeList.add("CON");
	
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("탁도");
		itemNameList.add("DO");
		itemNameList.add("수온");
		itemNameList.add("pH");
		itemNameList.add("전기전도도");
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			itemCount++;
		}

		int voCount = 0;
		
		for(RiverWater3HourWarningVO detailData : graphDataList) {
			
			List data = dataMap.get(detailData.getItem_code().substring(0, 3));
			Map valMap = new HashMap();
			valMap.put("x", detailData.getMin_time());
			valMap.put("y", detailData.getMin_vl());
			data.add(valMap);
			dataMap.put(detailData.getItem_code().substring(0, 3), data);

			voCount++;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);
		modelAndView.addObject("legBox", "N");

		modelAndView.setViewName("watersysMntPopDetailChartView");
		
		return modelAndView;
	}
	
	
	// 하천수질조회(경보 3시간이상)- 세부조회
	@RequestMapping("/waterpolmnt/waterinfo/goRiverWater3HourWarningPopDetail.do")
	public String goRiverWater3HourWarningPopDetail() throws Exception{
		return "/waterpolmnt/waterinfo/riverwater3hourwarningpopdetail";
	}

	// 하천수질조회(경보 3시간이상)- 세부조회
	@RequestMapping("/waterpolmnt/waterinfo/getRiverWater3HourWarningPopDetail.do")
	public ModelAndView getRiverWater3HourWarningPopDetail(
			@RequestParam(value="fact_code", required=false) String fact_code,
			@RequestParam(value="as_id", required=false) String as_id,
//			@RequestParam(value="alertTime", required=false) String alertTime,
			@RequestParam(value="river_div", required=false) String river_div,
			@RequestParam(value="branch_no", required=false) String branch_no,
			@RequestParam(value="branch_name", required=false) String branch_name,
			@RequestParam(value="sys_kind", required=false) String sys_kind,
			@RequestParam(value="frDate", required=false) String frDate,
			@RequestParam(value="toDate", required=false) String toDate,
			@RequestParam(value="frTime", required=false) String frTime,
			@RequestParam(value="toTime", required=false) String toTime,
			@RequestParam(value="item1", required=false) String item1,
			@RequestParam(value="item2", required=false) String item2,
			@RequestParam(value="item3", required=false) String item3,
			@RequestParam(value="item4", required=false) String item4,
			@RequestParam(value="item5", required=false) String item5
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO = new RiverWater3HourWarningSearchVO();
		
		riverWater3HourWarningSearchVO.setFact_code(fact_code);
		riverWater3HourWarningSearchVO.setRiver_div(river_div);
		riverWater3HourWarningSearchVO.setBranch_no(branch_no);
		riverWater3HourWarningSearchVO.setSys_kind(sys_kind);
		riverWater3HourWarningSearchVO.setFrDate(frDate);
		riverWater3HourWarningSearchVO.setToDate(toDate);
		riverWater3HourWarningSearchVO.setFrTime(frTime);
		riverWater3HourWarningSearchVO.setToTime(toTime);
		riverWater3HourWarningSearchVO.setItem01(item1);
		riverWater3HourWarningSearchVO.setItem02(item2);
		riverWater3HourWarningSearchVO.setItem03(item3);
		riverWater3HourWarningSearchVO.setItem04(item4);
		riverWater3HourWarningSearchVO.setItem05(item5);
		riverWater3HourWarningSearchVO.setAs_id(as_id);
		try
		{
//			riverWater3HourWarningSearchVO.setAlertTime(Integer.parseInt(alertTime));
		}
		catch(Exception e)
		{
//			riverWater3HourWarningSearchVO.setAlertTime(3);
		}
		

		List<RiverWater3HourWarningVO> refreshData =  waterinfoService.getRiverWater3HourWarningPopDetail(riverWater3HourWarningSearchVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}	
	
	
	// 하천수질조회(경보 3시간이상) - 세부팝업 그래프
	@RequestMapping("/waterpolmnt/waterinfo/getRiverWater3HourWarningPopDetailGraph.do")
	public ModelAndView getWatersysMntDetailGraph(
			@RequestParam(value="fact_code", required=false) String fact_code,
			@RequestParam(value="as_id", required=false) String as_id,
//			@RequestParam(value="alertTime", required=false) String alertTime,
			@RequestParam(value="river_div", required=false) String river_div,
			@RequestParam(value="branch_no", required=false) String branch_no,
			@RequestParam(value="branch_name", required=false) String branch_name,
			@RequestParam(value="sys_kind", required=false) String sys_kind,
			@RequestParam(value="frDate", required=false) String frDate,
			@RequestParam(value="toDate", required=false) String toDate,
			@RequestParam(value="frTime", required=false) String frTime,
			@RequestParam(value="toTime", required=false) String toTime,
			@RequestParam(value="item1", required=false) String item1,
			@RequestParam(value="item2", required=false) String item2,
			@RequestParam(value="item3", required=false) String item3,
			@RequestParam(value="item4", required=false) String item4,
			@RequestParam(value="item5", required=false) String item5
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			,@RequestParam(value="legend", required=false) String legend
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO = new RiverWater3HourWarningSearchVO();
		
		riverWater3HourWarningSearchVO.setFact_code(fact_code);
		riverWater3HourWarningSearchVO.setRiver_div(river_div);
		riverWater3HourWarningSearchVO.setBranch_no(branch_no);
		riverWater3HourWarningSearchVO.setSys_kind(sys_kind);
		riverWater3HourWarningSearchVO.setFrDate(frDate);
		riverWater3HourWarningSearchVO.setToDate(toDate);
		riverWater3HourWarningSearchVO.setFrTime(frTime);
		riverWater3HourWarningSearchVO.setToTime(toTime);
		riverWater3HourWarningSearchVO.setItem01(item1);
		riverWater3HourWarningSearchVO.setItem02(item2);
		riverWater3HourWarningSearchVO.setItem03(item3);
		riverWater3HourWarningSearchVO.setItem04(item4);
		riverWater3HourWarningSearchVO.setItem05(item5);
		riverWater3HourWarningSearchVO.setAs_id(as_id);
		try
		{
//			riverWater3HourWarningSearchVO.setAlertTime(Integer.parseInt(alertTime));
		}
		catch(Exception e)
		{
//			riverWater3HourWarningSearchVO.setAlertTime(3);
		}
		
		riverWater3HourWarningSearchVO.setOrderBy("ASC");
		
		List<RiverWater3HourWarningVO> graphDataList =  waterinfoService.getRiverWater3HourWarningPopDetail(riverWater3HourWarningSearchVO);

		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("TUR");
		itemCodeList.add("DOW");
		itemCodeList.add("TMP");
		itemCodeList.add("PHY");
		itemCodeList.add("CON");
		itemCodeList.add("TOF");
	
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("탁도");
		itemNameList.add("DO");
		itemNameList.add("수온");
		itemNameList.add("pH");
		itemNameList.add("전기전도도");
		itemNameList.add("Chl-a");
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			itemCount++;
		}

		int voCount = 0;
		
		for(RiverWater3HourWarningVO detailData : graphDataList) {
								
			if(detailData.getItem_code() != null)
			{
				List data = dataMap.get(detailData.getItem_code().substring(0, 3));
				Map valMap = new HashMap();
				valMap.put("x", detailData.getMin_time());
				valMap.put("y", detailData.getMin_vl());
				data.add(valMap);
				dataMap.put(detailData.getItem_code().substring(0, 3), data);
	
				voCount++;
			}
			
			if(detailData.getItemCode2() != null)
			{
				List data = dataMap.get(detailData.getItemCode2().substring(0, 3));
				Map valMap = new HashMap();
				valMap.put("x", detailData.getMin_time());
				valMap.put("y", detailData.getMinVl2());
				data.add(valMap);
				dataMap.put(detailData.getItemCode2().substring(0, 3), data);
	
				voCount++;
			}
			
			if(detailData.getItemCode3() != null)
			{
				List data = dataMap.get(detailData.getItemCode3().substring(0, 3));
				Map valMap = new HashMap();
				valMap.put("x", detailData.getMin_time());
				valMap.put("y", detailData.getMinVl3());
				data.add(valMap);
				dataMap.put(detailData.getItemCode3().substring(0, 3), data);
	
				voCount++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		if(dataMap.get("TUR").size() == 0)
		{
			itemNameList.remove("탁도");
			itemCodeList.remove("TUR");
		}
		if(dataMap.get("PHY").size() == 0)
		{
			itemNameList.remove("pH");
			itemCodeList.remove("PHY");
		}
		if(dataMap.get("DOW").size() == 0)
		{
			itemNameList.remove("DO");
			itemCodeList.remove("DOW");
		}
		if(dataMap.get("CON").size() == 0)
		{
			itemNameList.remove("전기전도도");
			itemCodeList.remove("CON");
		}
		if(dataMap.get("TMP").size() == 0)
		{
			itemNameList.remove("수온");
			itemCodeList.remove("TMP");
		}
		if(dataMap.get("TOF").size() == 0)
		{
			itemNameList.remove("Chl-a");
			itemCodeList.remove("TOF");
		}
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("sys", sys_kind);
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);	
		
		if("true".equals(legend))
			modelAndView.addObject("legBox", "Y");
		else
			modelAndView.addObject("legBox", "N");
	
		
		modelAndView.setViewName("warningChartView");
		
		return modelAndView;
	}
	
	 // 측정망 엑셀데이터 업로드 팝업
	@RequestMapping("/waterpolmnt/waterinfo/goExcelUpload.do")
	public String goExcelUpload()
	{
		return "/waterpolmnt/waterinfo/excelupload";
	}
	
	
	 /**
	 * 엑셀파일 데이터 저장
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/waterpolmnt/waterinfo/uploadExcelData.do")
	public ModelAndView insertBoardArticle(
			final MultipartHttpServletRequest multiRequest, 
			@RequestParam(value="river_div", required=false) String river_div,
			@RequestParam(value="fact_code", required=false) String fact_code
	) throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String tmpFileName = "";
		FileInputStream fis;
		Boolean result = true;
		String errorMsg = "no error";
		
		String time = "";
		
		try
		{
			if (isAuthenticated) {
				
				//엑셀파일 서버 저장
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				HashMap<String, String> upFileInfo = EgovFileMngUtil.upload(multiRequest.getFile("excelFile"));

				HashMap<String, Object> resultMap = waterinfoService.uploadExcelData(fact_code, upFileInfo);
				
				time = resultMap.get("insertTime").toString();
			}
			else
			{
				result = false;
				errorMsg = "Access denied";
			}
		}
		catch(Exception ex)
		{
			result = false;
			
			if(ex != null)
			{
				errorMsg = ex.getMessage();
			
				if(errorMsg == null)
					errorMsg = "";
				else if(errorMsg.contains("ORA-00001:"))
					errorMsg = "측정시간이 동일한 데이터가 이미 입력되어 있습니다.";
				else if(errorMsg.contains("waterinfoDAO.insertValidData-InlineParameterMap"))
					errorMsg = "데이터 형식이 잘못되어있습니다.";
			}
			else
			{
				errorMsg = "데이터 업로드를 실패하였습니다.";
			}
		}

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/waterpolmnt/waterinfo/excelupload");
		modelAndView.addObject("result", result);
		modelAndView.addObject("river_div", river_div);
		modelAndView.addObject("fact_code", fact_code);
		modelAndView.addObject("insertTime", time);
		modelAndView.addObject("errorMsg", errorMsg);
		
		return modelAndView;
	}
	
	
	// 기상이력조회 페이지로
	@RequestMapping("/waterpolmnt/waterinfo/goWeatherInfo.do")
	public String goWeatherInfo()
	{
		return "/waterpolmnt/waterinfo/weatherinfo";
	}
	
	
	 /**
	  * 기상이력조회
	  * @param weatherInfoVO
	  * @return
	  * @throws Exception
	  */
	@RequestMapping("/waterpolmnt/waterinfo/getWeatherInfoList.do")
	public ModelAndView getWeatherInfoList(
			@ModelAttribute("weatherInfoVO") WeatherInfoVO weatherInfoVO
	)
	throws Exception{
		
		weatherInfoVO.setFcast_flag("N");
		
		ModelAndView modelAndView = new ModelAndView();
		
		
		PaginationInfo paginationInfo = new PaginationInfo();

		if(weatherInfoVO.getPageIndex() == 0)
			weatherInfoVO.setPageIndex(1);
		
		/** paging */
		//2014-10-22 mypark 페이징 처리
		weatherInfoVO.setPageUnit(20);
//		weatherInfoVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(weatherInfoVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(weatherInfoVO.getPageUnit());
		paginationInfo.setPageSize(weatherInfoVO.getPageSize());
	
		
		weatherInfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		weatherInfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
		weatherInfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<WeatherInfoVO> refreshData =  weatherService.getWeatherInfoList(weatherInfoVO);
		
		int totCnt = weatherService.getWeatherInfoList_cnt(weatherInfoVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("wetherInfoVO", weatherInfoVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("dataList", refreshData);
		modelAndView.setViewName("jsonView");
//		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater");
		return modelAndView;
	}
	
	
	/**
	  * 기상이력조회(페이지 없이)
	  * @param weatherInfoVO
	  * @return
	  * @throws Exception
	  */
	@RequestMapping("/waterpolmnt/waterinfo/getWeatherInfoList2.do")
	public ModelAndView getWeatherInfoList2(
			@ModelAttribute("weatherInfoVO") WeatherInfoVO weatherInfoVO
	)
	throws Exception{
			weatherInfoVO.setFcast_flag("N");
		
			ModelAndView modelAndView = new ModelAndView();
		
			PaginationInfo paginationInfo = new PaginationInfo();
			
			if(weatherInfoVO.getPageIndex() == 0)
				weatherInfoVO.setPageIndex(1);
			
			weatherInfoVO.setFirstIndex(0);
			weatherInfoVO.setRecordCountPerPage(Integer.MAX_VALUE);
			
			if(!"U".equals(weatherInfoVO.getSys()))
			{
				weatherInfoVO.setBranch_no("1");
			}
			
			List<WeatherInfoVO> refreshData =  weatherService.getWeatherInfoList(weatherInfoVO);
			
		modelAndView.addObject("wetherInfoVO", weatherInfoVO);
		modelAndView.addObject("dataList", refreshData);
		modelAndView.setViewName("jsonView");
//		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater");
		return modelAndView;
	}
	
	// 기상이력(엑셀)
	@RequestMapping("/waterpolmnt/waterinfo/getWeatherInfoList_forExcel.do")
	public ModelAndView getWeatherInfoList_forExcel(
			@ModelAttribute("WeatherInfoVO") WeatherInfoVO weatherInfoVO
	)
	throws Exception {

		List<WeatherInfoVO> data =  weatherService.getWeatherInfoList_forExcel(weatherInfoVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("data", data);
		map.put("weatherInfoVO", weatherInfoVO);

		ModelAndView modelAndView = null;
		
		modelAndView = new ModelAndView("ExcelViewWeatherInfo", "map", map);
	

		return modelAndView;
	}	
	
	
	// 시간강수량 이력조회 페이지로
	@RequestMapping("/waterpolmnt/waterinfo/goHourRainfall.do")
	public String goWeatherForecast()
	{
		return "/waterpolmnt/waterinfo/weatherhourrainfall";
	}
	
	 /**
	  * 시간강수량 이력조회
	  */
	@RequestMapping("/waterpolmnt/waterinfo/getHourRainfallList.do")
	public ModelAndView getWeatherForecastList(
			@ModelAttribute("HourRainfallVO") HourRainfallVO hourRainfallVO
	)
	throws Exception{
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			hourRainfallVO.setUserId(user.getId());
			hourRainfallVO.setUserGubun(user.getRoleCode());
			
			ModelAndView modelAndView = new ModelAndView();

			PaginationInfo paginationInfo = new PaginationInfo();
	
			if(hourRainfallVO.getPageIndex() == 0)
				hourRainfallVO.setPageIndex(1);
			
			/** paging */
			//2014-10-22 mypark 페이징 처리
			hourRainfallVO.setPageUnit(20);
//			hourRainfallVO.setPageUnit(100000);
			paginationInfo.setCurrentPageNo(hourRainfallVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(hourRainfallVO.getPageUnit());
			paginationInfo.setPageSize(hourRainfallVO.getPageSize());
		
			
			hourRainfallVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			//System.out.println("firstindex  : "+hourRainfallVO.getFirstIndex());
			
			hourRainfallVO.setLastIndex(paginationInfo.getLastRecordIndex());
			//System.out.println("Lastindex  : "+hourRainfallVO.getLastIndex());
			
			hourRainfallVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
			List<HourRainfallVO> refreshData =  weatherService.getHourRainfallList(hourRainfallVO);
			
			int totCnt = weatherService.getHourRainfallList_cnt(hourRainfallVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
			modelAndView.addObject("paginationInfo", paginationInfo);
			modelAndView.addObject("hourRainfallVO", hourRainfallVO);
			modelAndView.addObject("totCnt", totCnt);
			modelAndView.addObject("dataList", refreshData);
				modelAndView.setViewName("jsonView");
	//		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater");
			return modelAndView;
	}
	
	
	// 시간강수량(엑셀)
	@RequestMapping("/waterpolmnt/waterinfo/getHourRainfallList_forExcel.do")
	public ModelAndView getHourRainfallList_forExcel(
			@ModelAttribute("hourRainfallVO") HourRainfallVO hourRainfallVO
	)
	throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		hourRainfallVO.setUserId(user.getId());
		hourRainfallVO.setUserGubun(user.getRoleCode());
		
		List<HourRainfallVO> data =  weatherService.getHourRainfallList_forExcel(hourRainfallVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("data", data);
		map.put("hourRainfallVO", hourRainfallVO);

		ModelAndView modelAndView = null;
		
		modelAndView = new ModelAndView("ExcelViewHourRainfall", "map", map);
		
		//if("N".equals(fcast_flag))
		//else if("Y".equals(fcast_flag))
		//	modelAndView = new ModelAndView("ExcelViewWeatherForecast", "map", map);

		return modelAndView;
	}	
	
	// 기상특보조회 페이지로
	@RequestMapping("/waterpolmnt/waterinfo/goWeatherWarn.do")
	public String goWeatherWarn()
	{
		return "/waterpolmnt/waterinfo/weatherwarn";
	}
	
	 /**
	  * 기상특보조회
	  */
	@RequestMapping("/waterpolmnt/waterinfo/getWeatherWarnList.do")
	public ModelAndView getWeatherWarnList(
			@ModelAttribute("warningDataVO") WarningDataVO warningDataVO
	)
	throws Exception{
		

			ModelAndView modelAndView = new ModelAndView();

			PaginationInfo paginationInfo = new PaginationInfo();
	
			if(warningDataVO.getPageIndex() == 0)
				warningDataVO.setPageIndex(1);
			
			/** paging */
			//2014-10-22 mypark 페이징 처리
			warningDataVO.setPageUnit(20);
			//warningDataVO.setPageUnit(100000);
			paginationInfo.setCurrentPageNo(warningDataVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(warningDataVO.getPageUnit());
			paginationInfo.setPageSize(warningDataVO.getPageSize());
		
			
			warningDataVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			warningDataVO.setLastIndex(paginationInfo.getLastRecordIndex());
			warningDataVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
			List<WarningDataVO> refreshData =  weatherService.getWeatherWarnList(warningDataVO);
			
			int totCnt = weatherService.getWeatherWarnList_cnt(warningDataVO);		
			paginationInfo.setTotalRecordCount(totCnt);
			
			modelAndView.addObject("paginationInfo", paginationInfo);
			modelAndView.addObject("warningDataVO", warningDataVO);
			modelAndView.addObject("totCnt", totCnt);
			modelAndView.addObject("dataList", refreshData);
				modelAndView.setViewName("jsonView");
	//		modelAndView.setViewName("waterpolmnt/waterinfo/riverwater");
			return modelAndView;
	}
	
	
	//기상특보조회 이력조회 엑셀
	@RequestMapping("/waterpolmnt/waterinfo/getWeatherWarnList_forExcel.do")
	public ModelAndView getWeatherWarnList_forExcel(
			@ModelAttribute("warningDataVO") WarningDataVO warningDataVO
	)
	throws Exception {

		List<WarningDataVO> data =  weatherService.getWeatherWarnList_forExcel(warningDataVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("data", data);
		map.put("warningDataVO", warningDataVO);

		ModelAndView modelAndView = null;
		modelAndView = new ModelAndView("ExcelViewWeatherWarn", "map", map);


		return modelAndView;
	}
	
	// 공구 상세정보
	@RequestMapping("/waterpolmnt/waterinfo/goFactDetail.do")
	public String goFactDetail()
	{
		return "/waterpolmnt/waterinfo/factdetail";
	}
	
	//측정소 이름
	@RequestMapping("/waterpolmnt/waterinfo/getBranchName.do")
	public ModelAndView getBranchName(
			@RequestParam(value="factCode") String factCode,
			@RequestParam(value="branchNo") String branchNo
	) throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO stv = new SearchTaksuVO();
		//System.out.println("DEBUG 21: "+factCode);
		stv.setGongku(factCode);
		stv.setChukjeongso(branchNo);
		
		SearchTaksuVO data = waterinfoService.getBranchName(stv);
		
		modelAndView.addObject("data", data);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	//측정소 이름
	@RequestMapping("/waterpolmnt/waterinfo/getFlowOBSName.do")
	public ModelAndView getFlowOBSName(
			@RequestParam(value="factCode") String factCode
	) throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO stv = new SearchTaksuVO();
		//System.out.println("DEBUG 23: "+factCode);
		stv.setGongku(factCode);
		
		SearchTaksuVO data = waterinfoService.getFlowOBSName(stv);
		
		modelAndView.addObject("data", data);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	//공구이름
	@RequestMapping("/waterpolmnt/waterinfo/getFactName.do")
	public ModelAndView getFactName(
			@RequestParam(value="factCode") String factCode
	) throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuVO stv = new SearchTaksuVO();
		//System.out.println("DEBUG 24: "+factCode);
		stv.setGongku(factCode);

		SearchTaksuVO data = waterinfoService.getBranchName(stv);
		
		modelAndView.addObject("data", data);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 보 운영정보 목록 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/boManageList.do")
	public String boManageList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/waterpolmnt/waterinfo/boManageList";
	}	
	
	/**
	 * 보 운영정보 목록 페이지 DATA 가져오기
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/waterpolmnt/waterinfo/getBoManageList.do")
	public ModelAndView getBoManageList(
			  @ModelAttribute("loginVO") LoginVO loginVO
			  ,@ModelAttribute("searchVO") BoSearchVO searchVO
			) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(20);
//		searchVO.setPageUnit(100000);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = waterinfoService.getBoManageList(searchVO);
		int totCnt = waterinfoService.getBoManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}	
	
	// 공구 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getBoObsCdList.do")
	public ModelAndView getBoObsCdList(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="sugye") String sugye
	) throws Exception{		
		
		//List gongku = waterinfoService.getGongkuList(system, sugye);
		List obsCd = waterinfoService.getBoObsCdList(sugye);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("obsCd", obsCd);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 조류 측정 정보 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/algacastAutoView.do")
	public String algacastAutoView(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/waterpolmnt/waterinfo/algacastAutoView";
	}	
	
	// 조류측정 정보 조회 
	@RequestMapping("/waterpolmnt/waterinfo/getAlgacastAutoList.do")
	public ModelAndView getAlgacastAutoList(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		
		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		boolean flag = false;
		String ftime = searchTaksuVO.getFrTime();
		
		if(ftime.length() == 2)
			searchTaksuVO.setFrTime(ftime+"00");
		else
		{
			flag = true;
			searchTaksuVO.setLastFlag("O");
		}
		
		String totime = searchTaksuVO.getToTime();
		if(totime.length() == 2)
			searchTaksuVO.setToTime(totime+"59");
		
		//2014-10-22 mypark 페이징 처리
		/** paging */
		/*if(!flag)
			//searchTaksuVO.setPageUnit(20);
			searchTaksuVO.setPageUnit(100000);
		else 
			//searchTaksuVO.setPageUnit(10000);
			searchTaksuVO.setPageUnit(100000);*/
		searchTaksuVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());
	
		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		
		
		List<DetailViewVO> refreshData =  waterinfoService.getAlgacastAutoList(searchTaksuVO);
		
		int totCnt = 0;
		if(!flag )
			totCnt = waterinfoService.getAlgacastAutoCnt(searchTaksuVO);
//		System.out.println("totCnt : "+String.valueOf(totCnt));
		
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	// 하천수질조회(엑셀)
	@RequestMapping("/waterpolmnt/waterinfo/getExcelAlgacastAuto.do")
	public ModelAndView getExcelAlgacastAuto(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
			)
			throws Exception {

		
		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);

		searchTaksuVO.setFrTime(searchTaksuVO.getFrTime()+"00");
		searchTaksuVO.setToTime(searchTaksuVO.getToTime()+"59");
				
		List<DetailViewVO> refreshData =  waterinfoService.getAlgacastAutoList(searchTaksuVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("searchTaksuVO", searchTaksuVO);

		
		ModelAndView modelAndView = new ModelAndView("ExcelViewAlgacastAuto", "chartMap", map);;
		
		
		return modelAndView;
	}
	
	
	
	// 측정소 기준치 정보
	@RequestMapping("/waterpolmnt/waterinfo/goFactLimit.do")
	public String goFactLimit()
	{
		return "/waterpolmnt/waterinfo/factlimit";
	}
	
	// 측정소 기준치 조회 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/getDetailViewLIMIT_U.do")
	public ModelAndView getDetailViewLIMIT_U(
			@ModelAttribute("limitDataVO") LimitDataVO limitDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<LimitDataVO> refreshData =  waterinfoService.getDetailViewLIMIT_U(limitDataVO);
		
		modelAndView.addObject("limitDataVO", limitDataVO);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 측정소 기준치 조회 (국가수질측정망)
	@RequestMapping("/waterpolmnt/waterinfo/getDetailViewLIMIT_A.do")
	public ModelAndView getDetailViewLIMIT_A(
			@ModelAttribute("limitDataVO") LimitDataVO limitDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<LimitDataVO> refreshData =  waterinfoService.getDetailViewLIMIT_A(limitDataVO);
		
		modelAndView.addObject("limitDataVO", limitDataVO);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 측정소 기준치 적용 (수질측정망 -> IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/applyDetailViewLIMIT.do")
	public ModelAndView applyDetailViewLIMIT(
			@ModelAttribute("limitDataVO") LimitDataVO limitDataVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.applyDetailViewLIMIT(limitDataVO);
		
		modelAndView.addObject("limitDataVO", limitDataVO);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	// 측정소 기준치 수정 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/updateDetailViewLIMIT.do")
	public ModelAndView updateDetailViewLIMIT(
			@ModelAttribute("limitDataVO") LimitDataVO limitDataVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		waterinfoService.updateDetailViewLIMIT(limitDataVO);
		
		modelAndView.addObject("limitDataVO", limitDataVO);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	// 측정소 수질 선별 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/goSelectRIVER.do")
	public ModelAndView goSelectRIVER_U() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/selectriver");
		
		return modelAndView;
	}
	
	/**
	 * 선별데이터보고서
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/selectDataReport_popup.do")
	public ModelAndView dailyWorkPrintView_popup(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
			, @RequestParam(value="river_div", 		required=false) String river_div
			, @RequestParam(value="searchYear", 		required=false) String searchYear
			, @RequestParam(value="searchMonth", 		required=false) String searchMonth
			, @RequestParam(value="fact_code", 		required=false) String fact_code
			, @RequestParam(value="branch_no", 		required=false) String branch_no
			, @RequestParam(value="pop_gubun", 		required=false) String pop_gubun
	) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
				
		selectDataVO.setRiver_div(river_div);
		selectDataVO.setSearchYear(searchYear);
		selectDataVO.setSearchMonth(searchMonth);
		selectDataVO.setFact_code(fact_code);
		selectDataVO.setBranch_no(branch_no);
		
		selectDataVO.setPop_gubun(pop_gubun);		//view:상세조회 save:저장
		
		List<SelectDataVO> selectDataList =  waterinfoService.getSelectDataReportList(selectDataVO);
		
		SelectDataVO selectDataInfo = waterinfoService.getSelectDataInfo(selectDataVO);
		if(!StringUtil.isEmpty(pop_gubun)) {
			if(pop_gubun.equals("view")){
				SelectDataVO selectDataViewInfo = waterinfoService.getSelectDataEtcInfo(selectDataVO.getSel_seq());
				if(selectDataViewInfo != null)
				{
					searchData.setMemberId(selectDataViewInfo.getReg_id());
				
					modelAndView.addObject("selectDataViewInfo", selectDataViewInfo);
				}
			}
		} else {
			SelectDataVO selectDataViewInfo = waterinfoService.getSelectDataEtcInfo(selectDataVO);
			modelAndView.addObject("selectDataViewInfo", selectDataViewInfo);
		}
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		List<SelectDataVO> fileList =  waterinfoService.getSelectDataFileList(selectDataVO);
		
		modelAndView.addObject("selectDataVO", selectDataVO);
		modelAndView.addObject("detailViewList", selectDataList);
		modelAndView.addObject("fileList", fileList);
		modelAndView.addObject("member", member);
		modelAndView.addObject("selectDataInfo", selectDataInfo);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/selectDataReport");
		return modelAndView;
	}
	
	
	// 측정소 데이터 선별 조회 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/getSelectDataList.do")
	public ModelAndView getSelectDataList(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		PaginationInfo paginationInfo = new PaginationInfo();
		
		if(selectDataVO.getPageIndex() == 0)
			selectDataVO.setPageIndex(1);
		
		selectDataVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(selectDataVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(selectDataVO.getPageUnit());
		paginationInfo.setPageSize(selectDataVO.getPageSize());
		
		selectDataVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		selectDataVO.setLastIndex(paginationInfo.getLastRecordIndex());
		selectDataVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int selectCheck = waterinfoService.getCntSelectDataInfo(selectDataVO);
		
		if(selectCheck > 0){
			paginationInfo.setTotalRecordCount(0);
			
			modelAndView.addObject("paginationInfo", paginationInfo);
			modelAndView.addObject("totCnt", 0);
			modelAndView.addObject("stdCnt", 0);
			modelAndView.addObject("detailViewList", "");
		}else{
			List<LimitViewVO> refreshData =  waterinfoService.getSelectDataList(selectDataVO);
	//		String maxDate = waterinfoService.getSelectDataMaxDate(selectDataVO);
			selectDataVO.setCountYn("Y");
			int totCnt = waterinfoService.getSelectDataCnt(selectDataVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
			//2017.06.13 add by Naturetech : 기준치정보 존재유무 확인
			int stdCnt = waterinfoService.getStandardInfoCnt(selectDataVO);
			
			modelAndView.addObject("paginationInfo", paginationInfo);
			modelAndView.addObject("totCnt", totCnt);
			modelAndView.addObject("stdCnt", stdCnt);
			modelAndView.addObject("detailViewList", refreshData);
		}
		modelAndView.addObject("selectDataVO", selectDataVO);
//		modelAndView.addObject("maxDate", maxDate);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 측정소 데이터 선별 조회 (IP-USN) Excel
	@RequestMapping("/waterpolmnt/waterinfo/getSelectDataListExcel.do")
	public ModelAndView getSelectDataListExcel(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		List<LimitViewVO> data =  waterinfoService.getSelectDataListAll(selectDataVO);
//		int totCnt = waterinfoService.getSelectDataCnt(selectDataVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("totCnt", totCnt);
		map.put("data", data);
		map.put("selectDataVO", selectDataVO);

		ModelAndView modelAndView = null;
		
		modelAndView = new ModelAndView("ExcelViewSelectDataList", "map", map);

		return modelAndView;
	}
	
	
	
	// 데이터 선별 등록
	@RequestMapping("/waterpolmnt/waterinfo/saveSelectData.do")
	public ModelAndView saveSelectData(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		
		String message = waterinfoService.saveSelectData(selectDataVO);
		
		modelAndView.addObject("message", message);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 데이터 선별 상세 삭제
	@RequestMapping("/waterpolmnt/waterinfo/deleteSelectData.do")
	public ModelAndView deleteSelectData(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());

		waterinfoService.deleteSelectData(selectDataVO);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 데이터 선별 상세 초기화
	@RequestMapping("/waterpolmnt/waterinfo/deleteSelectDataAll.do")
	public ModelAndView deleteSelectDataAll(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());

		waterinfoService.deleteSelectDataAll(selectDataVO);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 데이터 선별 상세 조회
	@RequestMapping("/waterpolmnt/waterinfo/getDetailSelectData.do")
	public ModelAndView getDetailSelectData(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SelectDataVO searchData =  waterinfoService.getDetailSelectData(selectDataVO);
		
		modelAndView.addObject("searchData", searchData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	

	// 확정 데이터 입력
	@RequestMapping("/waterpolmnt/waterinfo/insertDefiniteData.do")
	public ModelAndView insertDefiniteData(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		
		waterinfoService.insertDefiniteData(selectDataVO);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 선별/ 확정 데이터 입력
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/saveSelectDataInfo.do")
	public ModelAndView saveSelectDataInfo(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		
		selectDataVO.setStatus("S");
		if("S".equals(selectDataVO.getGubun())) {
			waterinfoService.updateSelectDataInfo(selectDataVO);
		} else {
			waterinfoService.saveSelectDataInfo(selectDataVO);
		}
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	// 측정소 수질 선별 이력 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/goSelectHis.do")
	public ModelAndView goSelectHis() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/select_his");
		
		return modelAndView;
	}
	
	// 측정소 수질 선별 이력 조회 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/getSelectHisList.do")
	public ModelAndView getSelectHisList(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		PaginationInfo paginationInfo = new PaginationInfo();

		List<SelectDataVO> refreshData =  waterinfoService.getSelectHisList(selectDataVO);
		int totCnt = waterinfoService.getSelectHisCnt(selectDataVO);
		
		modelAndView.addObject("selectDataVO", selectDataVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	// 측정소 수질 선별 이력 조회 (IP-USN) Excel
	@RequestMapping("/waterpolmnt/waterinfo/getSelectHisListExcel.do")
	public ModelAndView getSelectHisListExcel(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
			)
	throws Exception{
		
		List<SelectDataVO> data =  waterinfoService.getSelectHisList(selectDataVO);
		int totCnt = waterinfoService.getSelectHisCnt(selectDataVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totCnt", totCnt);
		map.put("data", data);
		map.put("selectDataVO", selectDataVO);

		ModelAndView modelAndView = null;
		
		modelAndView = new ModelAndView("ExcelViewSelectHisList", "map", map);

		return modelAndView;
	}
	
	// 측정소 수질 확정 이력 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/goDefiniteDataHis.do")
	public ModelAndView goDefiniteDataHis() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/definite_his");
		
		return modelAndView;
	}

	// 측정소 수질 확정 이력 조회 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/getDefiniteHisList.do")
	public ModelAndView getDefiniteHisList(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		PaginationInfo paginationInfo = new PaginationInfo();

		List<SelectDataVO> refreshData =  waterinfoService.getDefiniteHisList(selectDataVO);
		int totCnt = waterinfoService.getDefiniteHisCnt(selectDataVO);
		
		modelAndView.addObject("selectDataVO", selectDataVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	// 측정소 수질 확정 이력 조회 (IP-USN) Excel
	@RequestMapping("/waterpolmnt/waterinfo/getDefiniteHisListExcel.do")
	public ModelAndView getDefiniteHisListExcel(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
			)
	throws Exception{
		
		List<SelectDataVO> data =  waterinfoService.getDefiniteHisList(selectDataVO);
		int totCnt = waterinfoService.getDefiniteHisCnt(selectDataVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totCnt", totCnt);
		map.put("data", data);
		map.put("selectDataVO", selectDataVO);

		ModelAndView modelAndView = null;
		
		modelAndView = new ModelAndView("ExcelViewDefiniteHisList", "map", map);

		return modelAndView;
	}
	
	// 측정소 수질 확정 취소 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/deleteDefiniteData.do")
	public ModelAndView deleteDefiniteData(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());

		String message = waterinfoService.deleteDefiniteData(selectDataVO);
		
		modelAndView.addObject("message", message);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 측정소 수질 확정 데이터 조회 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/goSelectDefiniteData.do")
	public ModelAndView goSelectDefiniteData() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/definite_data");
		
		return modelAndView;
	}
	
	// 측정소 데이터 확정 조회 (IP-USN)
	@RequestMapping("/waterpolmnt/waterinfo/getDefiniteDataList.do")
	public ModelAndView getDefiniteDataList(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		PaginationInfo paginationInfo = new PaginationInfo();
		
		List<String> item_list = new ArrayList<String>();
		String item_list_text = selectDataVO.getItem_list_text();
		String[] item_code_list = item_list_text.split(",");
		for(int i=0;i<item_code_list.length;i++){
			String check_item = item_code_list[i];
			if(check_item.equals("TUR00")){
				item_list.add("TUR00");
			}else if(check_item.equals("TMP00")){
				item_list.add("TMP00");
				item_list.add("TMP01");
			}else if(check_item.equals("PHY00")){
				item_list.add("PHY00");
				item_list.add("PHY01");
			}else if(check_item.equals("DOW00")){
				item_list.add("DOW00");
				item_list.add("DOW01");
			}else if(check_item.equals("CON00")){
				item_list.add("CON00");
				item_list.add("CON01");
			}else if(check_item.equals("TOF00")){
				item_list.add("TOF00");
			}
		}
		selectDataVO.setItem_list(item_list);
		
		if(selectDataVO.getPageIndex() == 0)
			selectDataVO.setPageIndex(1);
		
		selectDataVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(selectDataVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(selectDataVO.getPageUnit());
		paginationInfo.setPageSize(selectDataVO.getPageSize());
		
		selectDataVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		selectDataVO.setLastIndex(paginationInfo.getLastRecordIndex());
		selectDataVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<LimitViewVO> refreshData =  waterinfoService.getDefiniteDataList(selectDataVO);
		selectDataVO.setCountYn("Y");
		//selectDataVO.setCountYn("Y");
		int totCnt = waterinfoService.getDefiniteDataCnt(selectDataVO);
		
		SumViewVO sumData =  waterinfoService.getDefiniteDataSum(selectDataVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("selectDataVO", selectDataVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("sumData", sumData);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	
	// 측정소 데이터 확정 조회 (IP-USN) Excel
	@RequestMapping("/waterpolmnt/waterinfo/getDefiniteDataListExcel.do")
	public ModelAndView getDefiniteDataListExcel(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
			)
	throws Exception{
		
		List<String> item_list = new ArrayList<String>();
		String item_list_text = selectDataVO.getItem_list_text();
		String[] item_code_list = item_list_text.split(",");
		for(int i=0;i<item_code_list.length;i++){
			String check_item = item_code_list[i];
			if(check_item.equals("TUR00")){
				item_list.add("TUR00");
			}else if(check_item.equals("TMP00")){
				item_list.add("TMP00");
				item_list.add("TMP01");
			}else if(check_item.equals("PHY00")){
				item_list.add("PHY00");
				item_list.add("PHY01");
			}else if(check_item.equals("DOW00")){
				item_list.add("DOW00");
				item_list.add("DOW01");
			}else if(check_item.equals("CON00")){
				item_list.add("CON00");
				item_list.add("CON01");
			}else if(check_item.equals("TOF00")){
				item_list.add("TOF00");
			}
		}
		selectDataVO.setItem_list(item_list);
		selectDataVO.setCountYn("Y");
		List<LimitViewVO> data =  waterinfoService.getDefiniteDataListAll(selectDataVO);
		SumViewVO sumData =  waterinfoService.getDefiniteDataSum(selectDataVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sumData", sumData);
		map.put("data", data);
		map.put("selectDataVO", selectDataVO);

		ModelAndView modelAndView = null;
		
		modelAndView = new ModelAndView("ExcelViewDefiniteDataList", "map", map);

		return modelAndView;
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/definiteDataChartView.do")
	public String getDefiniteDataChartView(@ModelAttribute("SelectDataVO") LimitViewVO LimitViewVO, ModelMap model) throws Exception{
		model.addAttribute("param_s", LimitViewVO);
		return "waterpolmnt/waterinfo/definiteDataChartView";
	}
	@RequestMapping("/waterpolmnt/waterinfo/getDefiniteDataChart.do")
	public String getDefiniteDataChart(@ModelAttribute("SelectDataVO") LimitViewVO LimitViewVO, ModelMap model) throws Exception{
		
		//itemCodeList
		StringBuffer title = new StringBuffer();
		title.append("");
		
		model.addAttribute("title", title.toString());
		LimitViewVO.setDefiniteflag("Y");
		model.addAttribute("lastYearList",waterinfoService.getDefiniteDataChart(LimitViewVO));
		LimitViewVO.setDefiniteflag("N");
		model.addAttribute("YearList",waterinfoService.getDefiniteDataChart(LimitViewVO));
		model.addAttribute("width","750");
		model.addAttribute("height","450");
		model.addAttribute("constLine", "N");
		model.addAttribute("chartType", 2);  
		
		return "definiteDataChart";
	}	
	
	// 파일업로드
	@RequestMapping("/waterpolmnt/waterinfo/FileUpload.do")
	public ModelAndView FileUpload(
			final MultipartHttpServletRequest multiRequest
	)
	throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		SelectDataVO selectDataVO;
		String file_img = "";
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			try{
				List<FileVO> result = null;
				
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				if (!files.isEmpty()) {
					result = fileUtil.parseFileInf(files, "waterinfoF_", 0, "", "");
					file_img = fileMngService.insertFileInfs(result);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		modelAndView.addObject("file_img", file_img);
		modelAndView.setViewName("waterpolmnt/waterinfo/upload_message");
		return modelAndView;
	}
	
	
	/**
	 * 데이터확정 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goSelectConfirm.do")
	public ModelAndView goSelectConfirm() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/select_confirm");
		
		return modelAndView;
	}
	
	/**
	 * 데이터확정 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goSelectConfirmList.do")
	public ModelAndView goSelectConfirmList(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setRoleCode(user.getRoleCode());
		selectDataVO.setUserId(user.getId());
		
		ModelAndView modelAndView = new ModelAndView();
		PaginationInfo paginationInfo = new PaginationInfo();
		
		if(selectDataVO.getPageIndex() == 0)
			selectDataVO.setPageIndex(1);
		
		selectDataVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(selectDataVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(selectDataVO.getPageUnit());
		paginationInfo.setPageSize(selectDataVO.getPageSize());
		
		selectDataVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		selectDataVO.setLastIndex(paginationInfo.getLastRecordIndex());
		selectDataVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<SelectDataVO> refreshData =  waterinfoService.getSelectConfirmList(selectDataVO);
		int totCnt = waterinfoService.getSelectConfirmListCnt(selectDataVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("selectDataVO", selectDataVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 데이터 선별취소
	 * 2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/cancelSelectDataInfo.do")
	public ModelAndView cancelSelectDataInfo(
			 @ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		selectDataVO.setStatus("C");					//S:선별, C:선별취소, E:확정, D:확정취소
		
		waterinfoService.cancelSelectDataInfo(selectDataVO);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 데이터확정
	 * 2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/confirmSelectDataInfo.do")
	public ModelAndView confirmSelectDataInfo(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		selectDataVO.setStatus("E");					//S:선별, C:선별취소, E:확정, D:확정취소
		
		selectDataVO.setStr_time(selectDataVO.getSelect_year()+selectDataVO.getSelect_month()+"010000");
		selectDataVO.setEnd_time(selectDataVO.getSelect_year()+selectDataVO.getSelect_month()+"312359");
		
		waterinfoService.insertDefiniteData(selectDataVO);
		
		waterinfoService.confirmSelectDataInfo(selectDataVO);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 데이터확정 취소
	 * 2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/confirmCancelSelectDataInfo.do")
	public ModelAndView confirmCancelSelectDataInfo(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		selectDataVO.setStatus("D");					//S:선별, C:선별취소, E:확정, D:확정취소
		
		selectDataVO.setStr_time(selectDataVO.getSelect_year()+selectDataVO.getSelect_month()+"010000");
		selectDataVO.setEnd_time(selectDataVO.getSelect_year()+selectDataVO.getSelect_month()+"312359");
		
		String message = waterinfoService.deleteDefiniteData(selectDataVO);
		
		waterinfoService.cancelSelectDataInfo(selectDataVO);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 데이터 선별 이력
	 * 2014.11.12 kyr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goSelectDataHis.do")
	public ModelAndView goSelectDataHis() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/select_data_his");
		
		return modelAndView;
	}
	
	/**
	 * 데이터선별이력 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goSelectDataHisList.do")
	public ModelAndView goSelectDataHisList(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setRoleCode(user.getRoleCode());
		selectDataVO.setUserId(user.getId());
		
		
		ModelAndView modelAndView = new ModelAndView();
		PaginationInfo paginationInfo = new PaginationInfo();
		
		if(selectDataVO.getPageIndex() == 0)
			selectDataVO.setPageIndex(1);
		
		selectDataVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(selectDataVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(selectDataVO.getPageUnit());
		paginationInfo.setPageSize(selectDataVO.getPageSize());

		selectDataVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		selectDataVO.setLastIndex(paginationInfo.getLastRecordIndex());
		selectDataVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<SelectDataVO> refreshData =  waterinfoService.getSelectDataHisList(selectDataVO);
		int totCnt = waterinfoService.getSelectDataHisListCnt(selectDataVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("selectDataVO", selectDataVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 취소사유 정보 조회
	 * 2014.11.12 kyr
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getCancelDataInfo.do")
	public ModelAndView getCancelDataInfo(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
			,@RequestParam(value="sel_his_seq", 		required=false) String sel_his_seq
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		List cancelDataInfo = waterinfoService.getCancelDataInfo(sel_his_seq);
		
		modelAndView.addObject("cancelDataInfo", cancelDataInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 데이터 선별 등록
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/saveSelectDataNew.do")
	public ModelAndView saveSelectDataNew(
			final HttpServletRequest request
			, @ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
			, @RequestParam(value="sel_fact_code",					required=false) String sel_fact_code
			, @RequestParam(value="sel_branch_no",					required=false) String sel_branch_no
			, @RequestParam(value="sel_str_time",					required=false) String sel_str_time
			, @RequestParam(value="sel_end_time",					required=false) String sel_end_time
			, @RequestParam(value="file_yn",							required=false) String file_yn
			, @RequestParam(value="atch_file_id",						required=false) String atchFileId
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		//첨부파일 저장
		List<FileVO> result = null;
		if(file_yn.equals("Y")){
			final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			if (!files.isEmpty()) {
				if(StringUtil.isEmpty(atchFileId)){
					result = fileUtil.parseFileInf(files, "SELECT_", 0, "", "");
					atchFileId = fileMngService.insertFileInfs(result);
					
					selectDataVO.setAtch_file_id(atchFileId);
				}else{
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					List<FileVO> _result = fileUtil.parseFileInf(files, "SELECT_", cnt, atchFileId, "");
					fileMngService.updateFileInfs(_result);
					
					selectDataVO.setAtch_file_id(atchFileId);
				}
			}
		}else{
			selectDataVO.setAtch_file_id(atchFileId);
		}
		
		selectDataVO.setFact_code(sel_fact_code);
		selectDataVO.setBranch_no(sel_branch_no);
		selectDataVO.setStr_time(sel_str_time);
		selectDataVO.setEnd_time(sel_end_time);
		//선별 데이터 저장
		String message = waterinfoService.saveSelectData(selectDataVO);
		
		modelAndView.addObject("message", message);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 데이터 선별 상세조회
	 * 2014.11.14 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getDetailSelectDataInfo.do")
	public ModelAndView getDetailSelectDataInfo(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		FileVO fileVO = new FileVO();
		
		SelectDataVO searchData =  waterinfoService.getDetailSelectData(selectDataVO);
		
		fileVO.setAtchFileId(searchData.getAtch_file_id());
		
		List<FileVO> fileList = fileMngService.selectImageFileList(fileVO);
		
		modelAndView.addObject("searchData", searchData);
		modelAndView.addObject("fileList", fileList);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 파일 삭제
	 * @param sel_seq
	 * @param atchFileId
	 * @param fileSn
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/FileDelete.do")
	public ModelAndView FileDelete(
			  @RequestParam(value="sel_seq",							required=false) String sel_seq
			, @RequestParam(value="atchFileId",						required=false) String atchFileId
			, @RequestParam(value="fileSn",								required=false) String fileSn
	)
	throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		FileVO fileVO = new FileVO();
		
		fileVO.setAtchFileId(atchFileId);
		fileVO.setFileSn(fileSn);
		
		fileMngService.deleteFileInf(fileVO);
		
		int fileCnt = fileMngService.getFileCnt(fileVO);
		
		if(fileCnt==0){
			waterinfoService.updateAtchFileId(atchFileId);
		}
		modelAndView.addObject("sel_seq", sel_seq);
		modelAndView.setViewName("waterpolmnt/waterinfo/delete_message");
		return modelAndView;
	}
	
	/**
	 * 선별데이터 초기화
	 * 2014.11.17 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/initSelectData.do")
	public ModelAndView initSelectData(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		
		waterinfoService.initSelectData(selectDataVO);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 선별데이터 선택 초기화
	 * 2014.11.17 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/initCheckSelectData.do")
	public ModelAndView initCheckSelectData(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		selectDataVO.setReg_id(user.getId());
		
		//일지 여러개 선택
		String checkNoArray[] = selectDataVO.getChk_sel_seq().split(",");
		
		for(int i=0; i<checkNoArray.length; i++){
			waterinfoService.initCheckSelectData(checkNoArray[i]);
		}
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 선별보고서 엑셀 다운로드
	 * 2014.11.28
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getSelectDataReportExcel.do")
	public ModelAndView getSelectDataReportExcel(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
			, @RequestParam(value="searchYear", 		required=false) String searchYear
			, @RequestParam(value="searchMonth", 		required=false) String searchMonth
			, @RequestParam(value="fact_code", 		required=false) String fact_code
			, @RequestParam(value="branch_no", 		required=false) String branch_no
			, @RequestParam(value="sel_seq", 		required=false) String sel_seq
	)
	throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO searchData = new MemberVO();
		
		selectDataVO.setSearchYear(searchYear);
		selectDataVO.setSearchMonth(searchMonth);
		selectDataVO.setFact_code(fact_code);
		selectDataVO.setBranch_no(branch_no);
		
		SelectDataVO selectDataInfo = waterinfoService.getSelectDataInfo(selectDataVO);
		
		List<SelectDataVO> selectDataList =  waterinfoService.getSelectDataReportList(selectDataVO);
		
		SelectDataVO selectDataViewInfo = waterinfoService.getSelectDataEtcInfo(Integer.parseInt(sel_seq));
		
		if(!StringUtil.isEmpty(selectDataViewInfo.getReg_id())) {
			searchData.setMemberId(selectDataViewInfo.getReg_id());
			
			MemberVO member = memberService.selectMemberDetail(searchData);
			
			map.put("member", member);
		}
		
		
		
		List<SelectDataVO> fileList =  waterinfoService.getSelectDataFileList(selectDataVO);
		
		map.put("selectDataInfo", selectDataInfo);
		map.put("selectDataList", selectDataList);
		map.put("selectDataViewInfo", selectDataViewInfo);
		map.put("fileList", fileList);
		
		map.put("selectDataVO", selectDataVO);

		ModelAndView modelAndView = null;
		
		modelAndView = new ModelAndView("ExcelViewSelectDataReport", "map", map);

		return modelAndView;
	}
	
	/**
	 * 선별사유 상태 코드 가져오기(맵핑코드)
	 * 2015.01.08
	 * @param status
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/goStatusCode.do")
	public ModelAndView goStatusCode(
			@RequestParam(value="status", required=false) String status
	) throws Exception{
		List statusList = waterinfoService.goStatusCode(status);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("statusList", statusList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 데이터 선별 선별사유 조회
	 * 2015.01.12 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpolmnt/waterinfo/getSelectDataReason.do")
	public ModelAndView getSelectDataReason(
			@ModelAttribute("SelectDataVO") SelectDataVO selectDataVO
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SelectDataVO selectDataReason =  waterinfoService.getSelectDataReason(selectDataVO);
		
		modelAndView.addObject("selectDataReason", selectDataReason);
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	// 수계 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/goSugyeList.do")
	public ModelAndView goSugyeList(
			@RequestParam(value="userId", required=false) String userId
			,@RequestParam(value="system", required=false) String system
	) throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		String userGubun = user.getRoleCode();
		
		List sugye = waterinfoService.getSugyeList(userId, system, userGubun);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("sugye", sugye);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 금호강 일대 공구 목록 조회
	@RequestMapping("/waterpolmnt/waterinfo/getGongkuListKumho.do")
	public ModelAndView getGongkuListKumho() throws Exception{
		
		List gongku = waterinfoService.getGongkuListKumho();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("gongku", gongku);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 금호강 일대 시간 데이터 조회
	@RequestMapping("/waterpolmnt/waterinfo/getKumhoData.do")
	public ModelAndView getKumhoData(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		
		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		searchTaksuVO.setOrderby_time("desc");
		
		/** paging */
		searchTaksuVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());
		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<DetailViewVO> refreshData =  null;
		int totCnt = 0;
		
		if("R".equals(searchTaksuVO.getDataType())) {
			refreshData = waterinfoService.getKumhoRealData(searchTaksuVO);
			totCnt = waterinfoService.getKumhoRealData_cnt(searchTaksuVO);
		} else {
			refreshData = waterinfoService.getKumhoModelingData(searchTaksuVO);
			totCnt = waterinfoService.getKumhoModelingData_cnt(searchTaksuVO);
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	//금호강 일대 시간 자료 조회 - 엑셀다운
	/*@RequestMapping("/waterpolmnt/waterinfo/getKumhoDataExcel.do")
	public ModelAndView getKumhoDataExcel(
			@RequestParam(value = "gongku", required = false) String gongku,
			@RequestParam(value = "frDate", required = false) String frDate,
			@RequestParam(value = "frTime", required = false) String frTime,
			@RequestParam(value = "toDate", required = false) String toDate,
			@RequestParam(value = "toTime", required = false) String toTime
		)
		throws Exception {

		SearchTaksuVO searchTaksuVO = new SearchTaksuVO();

		searchTaksuVO.setGongku(gongku);
		searchTaksuVO.setFrDate(frDate);
		searchTaksuVO.setFrTime(frTime);
		searchTaksuVO.setToDate(toDate);
		searchTaksuVO.setToTime(toTime);

		searchTaksuVO.setFirstIndex(0);
		searchTaksuVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		searchTaksuVO.setOrderby_time("desc");
		
		// getData
		List<DetailViewVO> refreshData =  waterinfoService.getKumhoData(searchTaksuVO);

		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("chart", refreshData);
		map.put("chart", refreshData);
		map.put("searchTaksuVO", searchTaksuVO);

		return new ModelAndView("ExcelViewKumho", "chartMap", map);
	}*/
	
	// 금호강 일대 모델링 자료 엑셀 업로드
	@RequestMapping("/waterpolmnt/waterinfo/goKumhoExcelUpload.do")
	public String goKumhoExcelUpload()
	{
		return "/waterpolmnt/waterinfo/popupExcelUpload";
	}
	
	/**
	 * 금호강 모델링 엑셀파일 데이터 저장
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/waterpolmnt/waterinfo/uploadKumhoExcelData.do")
	public ModelAndView uploadKumhoExcelData(
			final MultipartHttpServletRequest multiRequest,
			HttpServletResponse response
	) throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String tmpFileName = "";
		FileInputStream fis;
		Boolean result = true;
		String errorMsg = "no error";
		
		String time = "";
		int resultCnt = 0;
		
		try
		{
			if (isAuthenticated) {
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				
				if(files !=null){
					if (!files.isEmpty()) {
						//엑셀파일 서버 저장
						HashMap<String, String> upFileInfo = fileUtil.uploadExcelFile(multiRequest.getFile("excelFile"));
						
						resultCnt = waterinfoService.readExcelUpdateModeling(upFileInfo);
					}
				}
			} else {
				result = false;
				errorMsg = "Access denied";
			}
		}
		catch(Exception ex)
		{
			result = false;
			
			if(ex != null)
			{
				errorMsg = ex.getMessage();
			
				if(errorMsg == null)
					errorMsg = "";
				else if(errorMsg.contains("ORA-00001:"))
					errorMsg = "측정시간이 동일한 데이터가 이미 입력되어 있습니다.";
				else if(errorMsg.contains("waterinfoDAO.insertValidData-InlineParameterMap"))
					errorMsg = "데이터 형식이 잘못되어있습니다.";
			}
			else
			{
				errorMsg = "데이터 업로드를 실패하였습니다.";
			}
		}

		if(resultCnt  > 0) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('저장되었습니다.'); window.opener.location.reload();window.close();</script>");
		} else{ 
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('Error'); window.opener.location.reload(); window.close(); </script>"); 
		} 
		
		return null;
	}
	
	@RequestMapping(value = "/waterpolmnt/waterinfo/modelingRegist.do")
	public String spotManageRegist(ModelMap model) throws Exception {
		return "/waterpolmnt/waterinfo/modelingRegist";
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/modelingExcelRegist.do")
	public String workJournalRegist(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		
		return "/waterpolmnt/waterinfo/modelingExcelRegist";
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/modelingImageRegist.do")
	public String modelingImageRegist(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		
		return "/waterpolmnt/waterinfo/modelingImageRegist";
	}
	
	/**
	 * 모델링 결과 엑셀 파일 등록
	 * @param multiRequest
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/waterpolmnt/waterinfo/uploadModelingData.do")
	public ModelAndView modelingExcelRegist(
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO,
			HttpServletResponse response
	) throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String tmpFileName = "";
		FileInputStream fis;
		Boolean result = true;
		String errorMsg = "no error";
		
		String time = "";
		int resultCnt = 0;
		
		try
		{
			if (isAuthenticated) {
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				
				String atchFileId = "";
				
				if(files !=null){
					if (!files.isEmpty()) {
						List<FileVO> upFileInfo = fileUtil.parseWpStepFileInf(files, "ITEM_", 0, "", "");
						atchFileId = fileMngService.insertFileInfs(upFileInfo);
						
						wareHouseVO.setAtchFileId(atchFileId);
						
						FileVO vo = (FileVO)upFileInfo.get(0);
						wareHouseVO.setTitle(vo.getOrignlFileNm());
						
						//if(dailyWork.getSeqNo()==null || "".equals(dailyWork.getSeqNo())) {
						wareHouseVO.setRegId(user.getId());
						
						if(vo.getFileExtsn().equals("xls")) {
							resultCnt = waterinfoService.insertModelingInfoXls(multiRequest, vo, wareHouseVO);
						} else if(vo.getFileExtsn().equals("xlsx")) {
							resultCnt = waterinfoService.insertModelingInfoXlsx(multiRequest, vo, wareHouseVO);
						}
							
						/*} else {
							dailyWork.setModId(user.getId());
							
							resultCnt = dailyWorkService.updateWorkJournalInfo(dailyWork);
						}*/
					}
				}
			} else {
				result = false;
				errorMsg = "Access denied";
			}
		}
		catch(Exception ex)
		{
			result = false;
			
			if(ex != null)
			{
				errorMsg = ex.getMessage();
			
				if(errorMsg == null)
					errorMsg = "";
				else if(errorMsg.contains("ORA-00001:"))
					errorMsg = "측정시간이 동일한 데이터가 이미 입력되어 있습니다.";
				else if(errorMsg.contains("waterinfoDAO.insertModelingInfo-InlineParameterMap"))
					errorMsg = "데이터 형식이 잘못되어있습니다.";
			}
			else
			{
				errorMsg = "데이터 업로드를 실패하였습니다.";
			}
		}

		//return "forward:/bbs/selectBoardList.do";
		if(resultCnt  > 0) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('저장되었습니다.');</script>");
		} else{ 
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('Error');</script>"); 
		} 
		
		response.getWriter().print("<script>location.href='/waterpolmnt/waterinfo/modelingRegist.do';</script>"); 
		
		return null;
	}
	
	/**
	 * 모델링 결과 엑셀 파일 등록
	 * @param multiRequest
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/waterpolmnt/waterinfo/uploadModelingImage.do")
	public ModelAndView modelingImageRegist(
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO,
			HttpServletResponse response
	) throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String tmpFileName = "";
		FileInputStream fis;
		Boolean result = true;
		String errorMsg = "no error";
		
		String time = "";
		int resultCnt = 0;
		
		try
		{
			if (isAuthenticated) {
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				
				String atchFileId = "";
				
				if(files !=null){
					if (!files.isEmpty()) {
						List<FileVO> upFileInfo = fileUtil.parseWpStepFileInf(files, "MODEL_", 0, "", "");
						atchFileId = fileMngService.insertFileInfs(upFileInfo);
						
						wareHouseVO.setAtchFileId(atchFileId);
						
						FileVO vo = (FileVO)upFileInfo.get(0);
						wareHouseVO.setTitle(vo.getOrignlFileNm());
						
						wareHouseVO.setRegId(user.getId());
						wareHouseVO.setImageDateFrom(multiRequest.getParameter("imageDateFrom"));
						wareHouseVO.setImageDateTo(multiRequest.getParameter("imageDateTo"));
						wareHouseVO.setItemCode(multiRequest.getParameter("itemCode"));
						resultCnt = waterinfoService.insertModelingImage(multiRequest, vo, wareHouseVO);
					}
				}
			} else {
				result = false;
				errorMsg = "Access denied";
			}
		}
		catch(Exception ex)
		{
			result = false;
			
			if(ex != null)
			{
				errorMsg = ex.getMessage();
			
				if(errorMsg == null)
					errorMsg = "";
				else if(errorMsg.contains("ORA-00001:"))
					errorMsg = "측정시간이 동일한 데이터가 이미 입력되어 있습니다.";
				else if(errorMsg.contains("waterinfoDAO.insertModelingImage-InlineParameterMap"))
					errorMsg = "데이터 형식이 잘못되어있습니다.";
			}
			else
			{
				errorMsg = "데이터 업로드를 실패하였습니다.";
			}
		}

		//return "forward:/bbs/selectBoardList.do";
		if(resultCnt  > 0) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('저장되었습니다.');</script>");
		} else{ 
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('Error');</script>"); 
		} 
		
		response.getWriter().print("<script>location.href='/waterpolmnt/waterinfo/modelingRegist.do';</script>"); 
		
		return null;
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/modelingResult.do")
	public ModelAndView modelingResult() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/modelingResult");
		
		return modelAndView;
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/modelingResultList.do")
	public ModelAndView modelingResultList(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		searchTaksuVO.setUserId(user.getId());
		searchTaksuVO.setRoleCode(user.getRoleCode());
		if("ROLE_ADMIN".equals(user.getRoleCode())){
			searchTaksuVO.setUserGubun("ROLE_ADMIN");
		}
		
		ModelAndView modelAndView = new ModelAndView();
		
		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchTaksuVO.getPageIndex() == 0)
			searchTaksuVO.setPageIndex(1);
		
		searchTaksuVO.setPageUnit(20);
		
		if(null != searchTaksuVO.getMainPageUnit()){
			searchTaksuVO.setPageUnit(Integer.parseInt(searchTaksuVO.getMainPageUnit()));
		}
		paginationInfo.setCurrentPageNo(searchTaksuVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchTaksuVO.getPageUnit());
		paginationInfo.setPageSize(searchTaksuVO.getPageSize());
	
		
		searchTaksuVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchTaksuVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchTaksuVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<ExcelModelingVO> refreshData =  waterinfoService.getModelingResultList(searchTaksuVO);
		
		int totCnt = 0;
		totCnt = waterinfoService.getTotCntModelingResult(searchTaksuVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/modelingChart.do")
	public ModelAndView modelingChart() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/modelingChart");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/waterpolmnt/waterinfo/modelingResultDetail.do")
	public ModelAndView modelingResultDetail(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO) throws Exception {

		List<ExcelModelingVO> list = waterinfoService.getModelingResultDetail(searchTaksuVO);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("getModelingResultDetail", list);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/modelingImageResult.do")
	public ModelAndView modelingImageResult() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		//로긴 한 유저의 그룹
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		modelAndView.addObject("member", member);
		
		modelAndView.setViewName("waterpolmnt/waterinfo/modelingImageResult");
		
		return modelAndView;
	}
	
	@RequestMapping("/waterpolmnt/waterinfo/modelingImageResultList.do")
	public ModelAndView modelingImageResultList(
			@ModelAttribute("searchTaksuVO") SearchTaksuVO searchTaksuVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		searchTaksuVO.setUserId(user.getId());
		searchTaksuVO.setRoleCode(user.getRoleCode());
		if("ROLE_ADMIN".equals(user.getRoleCode())){
			searchTaksuVO.setUserGubun("ROLE_ADMIN");
		}
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<WareHouseVO> refreshData =  waterinfoService.getModelingImageResultList(searchTaksuVO);
		
		modelAndView.addObject("searchTaksuVO", searchTaksuVO);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
}
