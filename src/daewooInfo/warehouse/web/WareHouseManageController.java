package daewooInfo.warehouse.web;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.dept.service.DeptManageService;
import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.cmmn.bean.ComDefaultVO;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.warehouse.bean.ExcelItemVO;
import daewooInfo.warehouse.bean.ItemCalcSearchVO;
import daewooInfo.warehouse.bean.ItemCodeGroupVO;
import daewooInfo.warehouse.bean.ItemCodeSearchVO;
import daewooInfo.warehouse.bean.ItemCodeVO;
import daewooInfo.warehouse.bean.ItemConditionManageSearchVO;
import daewooInfo.warehouse.bean.ItemGroupSearchVO;
import daewooInfo.warehouse.bean.ItemManageSearchVO;
import daewooInfo.warehouse.bean.SearchVO;
import daewooInfo.warehouse.bean.WareHouseManageSearchVO;
import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.warehouse.bean.WareHouseVO;
import daewooInfo.warehouse.bean.WareHouseZipcodeVO;
import daewooInfo.warehouse.service.WareHouseManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * 방제물품 관리
 * @author kisspa
 * @since 2010.07.28
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일	  수정자		   수정내용
 *  -------	--------	---------------------------
 *   2010.07.28  kisspa		  최초 생성
 *
 * </pre>
 */
@Controller
public class WareHouseManageController {

	/**
	 * @uml.property  name="wareHouseManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "WareHouseManageService")
	private WareHouseManageService wareHouseManageService;

	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * @uml.property  name="deptManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "deptManageService")
	private DeptManageService deptManageService;
	
	/**
	 * tmsMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(WareHouseManageController.class);
	
	/**
	 * 창고 목록 조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/selectWareHouseList.do")
	public ModelAndView selectWareHouseList(
			@ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO,
			Map<String, Object> commandMap
			) throws Exception{
		
	 
		WareHouseVO vo;  
		
		ModelAndView modelAndView = new ModelAndView();
		List<WareHouseVO> list = wareHouseManageService.selectWareHouseList(wareHouseVO);
		
		String flag = (String)commandMap.get("flag");
		if (flag == null) flag = "";
			
		if (flag.equals("all")) {
			vo = new WareHouseVO();
			vo.setWhCode("");
			vo.setWhName("전체");
			list.add(0,vo);
		} else if (flag.equals("select")) {
			vo = new WareHouseVO();
			vo.setWhCode("");
			vo.setWhName("선택");
			list.add(0,vo);
		}
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 창고 물품 간단조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/selectWareHouseItemSimpleList.do")
	public ModelAndView selectWareHouseItemSimpleList(
			Map<String, Object> commandMap
			) throws Exception {
		
		String whCode = (String)commandMap.get("whCode");
		if(whCode == null) whCode="";
		String itemCode = (String)commandMap.get("itemCode");
		if(itemCode == null) itemCode="";
		
		SearchVO vo = new SearchVO();
		vo.setWhCode(whCode);
		vo.setItemCode(itemCode);
		
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = null;
		if ("".equals(whCode)) {
			list = wareHouseManageService.selectWareHouseItemListSimpleAll(vo);
		} else {
			list = wareHouseManageService.selectWareHouseItemListSimpleOne(vo);
		}
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 창고 물품 상세조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/selectWareHouseItemDetailList.do")
	public ModelAndView selectWareHouseItemDetailList(
			Map<String, Object> commandMap
			) throws Exception {
		
		String whCode = (String)commandMap.get("whCode");
		if(whCode == null) whCode="";
		String itemCode = (String)commandMap.get("itemCode");
		if(itemCode == null) itemCode="";
		String startDate = (String)commandMap.get("startDate");
		String endDate = (String)commandMap.get("endDate");
		String inoutFlag = (String)commandMap.get("inoutFlag");
		
		SearchVO vo = new SearchVO();
		vo.setWhCode(whCode);
		vo.setItemCode(itemCode);
		if (startDate != null && !"".equals(startDate)) {
			vo.setStartDate(startDate);
		}
		if (endDate != null && !"".equals(endDate)) {
			vo.setEndDate(endDate);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = null;
		if ("in".equals(inoutFlag)) {
			list = wareHouseManageService.selectWareHouseItemListDetail_store(vo);
		} else {
			list = wareHouseManageService.selectWareHouseItemListDetail_rele(vo);
		}
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 코드 목록 조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/selectWareHouseItemCodeList.do")
	public ModelAndView selectWareHouseItemCodeList(
			Map<String, Object> commandMap
			) throws Exception {
		
	 
		ModelAndView modelAndView = new ModelAndView();
		
		List<ItemCodeVO> list = wareHouseManageService.selectWareHouseItemCodeList(null);
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 코드 입력
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/insertWareHouseItemCode.do")
	public String insertWareHouseItemCode(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		
		wareHouseManageService.insertWareHouseItemCode(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemCodeList.do";
	}
	
	/**
	 * 코드 수정
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/updateWareHouseItemCode.do")
	public String updateWareHouseItemCode(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		
		wareHouseManageService.updateWareHouseItemCode(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemCodeList.do";
	}
	
	/**
	 * 아이템 목록
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getWareHouseItemCodeDetailList.do")
	public ModelAndView getWareHouseItemCodeDetailList(
			Map<String, Object> commandMap
			) throws Exception {
		
		String itemCode = (String)commandMap.get("itemCode");
		String itemCodeDet = (String)commandMap.get("itemCodeDet");
		
		SearchVO vo = new SearchVO();
		vo.setItemCode(itemCode);
		vo.setItemCodeDet(itemCodeDet);
		
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = wareHouseManageService.selectWareHouseItemCodeList(vo);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;	
	}
	
	/**
	 * 입고 목록
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/selectWareHouseItemStorList.do")
	public ModelAndView selectWareHouseItemStorList(
			Map<String, Object> commandMap
			) throws Exception {
		
		SearchVO vo = new SearchVO();
		
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = wareHouseManageService.selectWareHouseItemStorList(vo);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 입고 입력
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/insertWareHouseItemStor.do")
	public String insertWareHouseItemStor(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		wareHouseManageService.insertWareHouseItemStor(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemStorList.do";
	}
	
	/**
	 * 입고 수정
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/updateWareHouseItemStor.do")
	public String updateWareHouseItemStor(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		wareHouseManageService.updateWareHouseItemStor(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemStorList.do";
	}
	
	/**
	 * 입고 삭제
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/deleteWareHouseItemStor.do")
	public String deleteWareHouseItemStor(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		int delCnt = wareHouseManageService.deleteWareHouseItemStor(itemCodeVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("updateCnt", delCnt);
		
		return "forward:/warehouse/selectWareHouseItemStorList.do";
	}
	
	/**
	 * 출고 목록
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/selectWareHouseItemReleList.do")
	public ModelAndView selectWareHouseItemReleList(
			Map<String, Object> commandMap
			) throws Exception {
		
		SearchVO vo = new SearchVO();
		
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = wareHouseManageService.selectWareHouseItemReleList(vo);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 출고 입력
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/insertWareHouseItemRele.do")
	public String insertWareHouseItemRele(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		wareHouseManageService.insertWareHouseItemRele(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemReleList.do";
	}
	
	/**
	 * 출고 수정
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/updateWareHouseItemRele.do")
	public String updateWareHouseItemRele(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		wareHouseManageService.updateWareHouseItemRele(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemReleList.do";
	}
	
	/**
	 * 입고 삭제
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/deleteWareHouseItemRele.do")
	public String deleteWareHouseItemRele(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		wareHouseManageService.deleteWareHouseItemRele(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemReleList.do";
	}


	
	/**
	 * 입고 목록 화면..
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemStoreList.do")
	public String itemStoreList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemStoreList";
	}
	
	/**
	 * 입고 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemStoreDataList.do")
	public ModelAndView itemStoreDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setItemCode(StringUtil.nullConvert(searchVO.getItemCode()));
		searchVO.setWhCode(StringUtil.nullConvert(searchVO.getWhCode()));
		searchVO.setStartDate(StringUtil.nullConvert(searchVO.getStartDate()));
		searchVO.setEndDate(StringUtil.nullConvert(searchVO.getEndDate()));
		
		List<ItemCodeSearchVO> list = wareHouseManageService.itemStoreDataList(searchVO);
		int totCnt = wareHouseManageService.itemStoreDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 출고 목록 화면..
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemReleList.do")
	public String itemReleList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemReleList";
	}
	
	/**
	 * 출고 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemReleDataList.do")
	public ModelAndView itemReleDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setItemCode(StringUtil.nullConvert(searchVO.getItemCode()));
		searchVO.setWhCode(StringUtil.nullConvert(searchVO.getWhCode()));
		searchVO.setStartDate(StringUtil.nullConvert(searchVO.getStartDate()));
		searchVO.setEndDate(StringUtil.nullConvert(searchVO.getEndDate()));
		
		List<ItemCodeSearchVO> list = wareHouseManageService.itemReleDataList(searchVO);
		int totCnt = wareHouseManageService.itemReleDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 정산 목록 화면..
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemCalcList.do")
	public String itemCalaList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemCalcList";
	}
	
	/**
	 * 정산 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemCalcDataList.do")
	public ModelAndView itemCalcDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCalcSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setCalcOrg(StringUtil.nullConvert(searchVO.getCalcOrg()));
		searchVO.setStartDate(StringUtil.nullConvert(searchVO.getStartDate()));
		searchVO.setEndDate(StringUtil.nullConvert(searchVO.getEndDate()));
		
		List<ItemCodeSearchVO> list = wareHouseManageService.itemCalcDataList(searchVO);
		int totCnt = wareHouseManageService.itemCalcDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 전체정산목록
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/ItemCalcTotalList.do")
	public ModelAndView ItemCalcTotalList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCalcSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
			ModelAndView modelAndView = new ModelAndView();
			
			searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
			searchVO.setPageSize(propertiesService.getInt("pageSize"));
			
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getRecordCountPerPage());
			paginationInfo.setPageSize(searchVO.getPageSize());
			
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			searchVO.setCalcOrg(StringUtil.nullConvert(searchVO.getCalcOrg()));
			searchVO.setStartDate(StringUtil.nullConvert(searchVO.getStartDate()));
			searchVO.setEndDate(StringUtil.nullConvert(searchVO.getEndDate()));
			
			List totalCalcList = wareHouseManageService.WareHouseCalcTotalList(searchVO);  // List
			
			int totalCalcCount = wareHouseManageService.WareHouseCalcTotalCnt(searchVO);   // Count
			paginationInfo.setTotalRecordCount(totalCalcCount);
			
			modelAndView.addObject("totalCalcList", totalCalcList);
			modelAndView.addObject("paginationInfo", paginationInfo);
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		
		
	}
	
	/**
	 * 방제물품 창고정보 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/mergeItemCalc.do")
	public ModelAndView mergeItemCalc(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCalcSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		wareHouseManageService.insertWareHouseItemCalc(searchVO);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	/**
	 * 방제물품 정산관리 정산기간 조회 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/ItemCalcProc.do")
	public ModelAndView ItemCalcProc(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCalcSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		 
			List costResultList = wareHouseManageService.CalcTotalCost(searchVO);
			modelAndView.addObject("costResultList",costResultList);
			modelAndView.setViewName("jsonView");
	 
		return modelAndView;
	}
	/**
	 * 방제물품 정산관리 정산기간 조회 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/ItemCalcPrintInfo.do")
	public ModelAndView ItemCalcPrintInfo(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCalcSearchVO itemCalcVO
			, Map<String, Object> commandMap
	) throws Exception {
		
			ModelAndView modelAndView = new ModelAndView();
			
			if("Y".equals(itemCalcVO.getPre())){
				modelAndView.addObject("ItemCalcSearchVO", itemCalcVO);
				modelAndView.setViewName("/warehouse/itemCalcAccountPrint");
			}else{
				List printInfoList = wareHouseManageService.getcalcItemPrintInfo(itemCalcVO);
				modelAndView.addObject("PrintInfoList",printInfoList);
				modelAndView.setViewName("jsonView");
			}
		 
		return modelAndView;
	}
	 
	/**
	 * 방제물품 조회 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemSearchList.do")
	public String itemSearchList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemSearchList";
	}
	
	/**
	 * 방제물품 삭제
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/deleteSearchList.do")
	public ModelAndView deleteSearchList(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		
		int updateCnt = wareHouseManageService.deleteWareHouseItemStor(itemCodeVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 조회 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemSearchDataList.do")
	public ModelAndView itemSearchDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		WareHouseVO whInfo = null;
		
		//searchVO.setPageUnit(10);
		searchVO.setPageUnit(100000);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<ItemCodeSearchVO> list = null;
		int totCnt = 0;
		
		searchVO.setWhCode(StringUtil.nullConvert(searchVO.getWhCode()));
		String whCodeFlag = StringUtil.nullConvert(searchVO.getWhCode());
		searchVO.setItemCode(StringUtil.nullConvert(searchVO.getItemCode()));
		
		// 전체인지 특정 창고인지 구분
		if ( "".equals(whCodeFlag) || " ".equals(whCodeFlag) ) {
			list = wareHouseManageService.itemSearchDataListALL(searchVO);
			totCnt = wareHouseManageService.itemSearchDataListCntALL(searchVO);
		} else {
			list = wareHouseManageService.itemSearchDataList(searchVO);
			totCnt = wareHouseManageService.itemSearchDataListCnt(searchVO);
			whInfo = wareHouseManageService.wareHouseInfo(searchVO.getWhCode());
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("whInfo", whInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	 
	
	/**
	 * 방제물품 코드 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemCodeList.do")
	public String itemCodeList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/newItemCodeList";
	}
	
	/**
	 * 방제물품 코드 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemCodeDataList.do")
	public ModelAndView itemCodeDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		//searchVO.setPageUnit(10);
		searchVO.setPageUnit(100000);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setWhCode(StringUtil.nullConvert(searchVO.getWhCode()));
		searchVO.setItemCode(StringUtil.nullConvert(searchVO.getItemCode()));
		
		List<ItemCodeSearchVO> list = wareHouseManageService.itemCodeDataList(searchVO);
		int totCnt = wareHouseManageService.itemCodeDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/mergeWareHouseItemStor.do")
	public ModelAndView mergeWareHouseItemStor(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int updateCnt = 0;
		
		updateCnt = wareHouseManageService.mergeWareHouseItemStor(searchVO);
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품코드 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/mergeWareHouseItemCode.do")
	public ModelAndView mergeWareHouseItemCode(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int duplicateCnt = 0;
		int updateCnt = 0;
		
		// 입력 모드 insert 일때 중복체크
		String mode = (String)commandMap.get("mode");
		if ("insert".equals(mode)) {
			duplicateCnt = wareHouseManageService.duplicateItemCode(searchVO);
			if (duplicateCnt > 0) {
				modelAndView.addObject("duplicateCnt", duplicateCnt);
			}
		}
		
		if (duplicateCnt <= 0) {
			updateCnt = wareHouseManageService.mergeWareHouseItemCode(searchVO);
			modelAndView.addObject("updateCnt", updateCnt);
		}
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품코드 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/mergeWareHouseItemCodeN.do")
	public ModelAndView mergeWareHouseItemCodeN(
			final MultipartHttpServletRequest multiRequest
			,@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int duplicateCnt = 0;
		int updateCnt = 0;
		
		// 입력 모드 insert 일때 중복체크
		String mode = (String)commandMap.get("mode");
		if ("insert".equals(mode)) {
			duplicateCnt = wareHouseManageService.duplicateItemCode(searchVO);
			if (duplicateCnt > 0) {
				modelAndView.addObject("duplicateCnt", duplicateCnt);
			}
		}
		
		if (duplicateCnt <= 0) {	
			
			if("Y".equals(searchVO.getImageDel())){
				searchVO.setAtchFileId("");
				searchVO.setChkFileId("");
			}
			
			if("Y".equals(searchVO.getFileUploadChk())){
				List<FileVO> result = null;
				String atchFileId = "";
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				if (!files.isEmpty()) {
					result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
					atchFileId = fileMngService.insertFileInfs(result);
				}
				searchVO.setAtchFileId(atchFileId);
				searchVO.setChkFileId(atchFileId);
			}
			
			updateCnt = wareHouseManageService.mergeWareHouseItemCodeN(searchVO);
			modelAndView.addObject("valiFileId", searchVO.getChkFileId());
			modelAndView.addObject("updateCnt", updateCnt);
			modelAndView.addObject("itemListVal", searchVO);
		}		
		
		modelAndView.setViewName("warehouse/newItemCodeList");
		//modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/listWareHouseItemCodeN.do")
	public ModelAndView listWareHouseItemCodeN(
			final MultipartHttpServletRequest multiRequest
			,@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("valiFileId", searchVO.getChkFileId());
		modelAndView.addObject("itemListVal", searchVO);
		modelAndView.setViewName("warehouse/newItemCodeList");
		return modelAndView;
	}
	
	/**
	 * 방제업체 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseEnterpriseList.do")
	public String wareHouseEnterpriseList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/wareHouseEnterpriseList";
	}
	
	
	/**
	 * 방제물품 창고 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseList.do")
	public String wareHouseList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/wareHouseList";
	}
	
	/**
	 * 방제물품 창고관리 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseDataList.do")
	public ModelAndView wareHouseDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") WareHouseSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(10);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setWhName(StringUtil.nullConvert(searchVO.getWhName()));
		
		List<WareHouseSearchVO> list = wareHouseManageService.wareHouseDataList(searchVO);
		int totCnt = wareHouseManageService.wareHouseDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 방제물품 창고정보 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/mergeWareHouse.do")
	public ModelAndView mergeWareHouse(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") WareHouseSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int updateCnt = 0;
		updateCnt = wareHouseManageService.mergeWareHouse(searchVO);
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 지역코드
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/ctyCode.do")
	public ModelAndView ctyCode(
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.ctyCode();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	@RequestMapping("/warehouse/doCode.do")
	public ModelAndView doCode(
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.selectDoCode();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 지역코드
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHousectyCode.do")
	public ModelAndView wareHousectyCode(
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.wareHousectyCode();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}		
	
	/**
	 * 방제물품 창고 좌표 지정
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/popupMap.do")
	public String popupMap(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/popupMap";
	}
	

	
	
	
	/**
	 * 방재물품현황 입출고 관리 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/openItemHistory.do")
	public String openItemHistory(
			Map<String, Object> commandMap
			,ItemCodeSearchVO searchvo
			, ModelMap model
			) throws Exception {
		return "/warehouse/organItem";
	}
	
	
	
	/**
	 * 유관기관물품현황
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/organItem.do")
	public String organItem(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/organItem";
	}
	
	/**
	 * 유관기관물품현황
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/signgate/LoginForm.do")
	public String LoginForm(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/signgate/LoginForm";
	}

	//윤일권 수정 시작.

	/**
	 * 창고 목록 조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("/warehouse/wareHouseManageList.do")
//	public String wareHouseManageList(
//			 Map<String, Object> commandMap
//			,@ModelAttribute("loginVO") LoginVO loginvo
//			,@ModelAttribute("searchVO") WareHouseManageSearchVO searchVO
//			,ModelMap model
//			) throws Exception{
//		
//		/** EgovPropertyService.sample */
//		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//		
//		searchVO.setPageUnit(10);
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//
//		/** paging */
//		searchVO.setPageUnit(100000);
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
//		paginationInfo.setPageSize(searchVO.getPageSize());
//		
//		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//		
//		List wareHouseManageList = wareHouseManageService.getWareHouseManageList(searchVO);
//		model.addAttribute("resultList", wareHouseManageList);
//		
//		int totCnt = wareHouseManageService.getWareHouseManageListCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//		model.addAttribute("paginationInfo", paginationInfo);
//		
//		return "/warehouse/wareHouseManageList";
//	}
	
	@RequestMapping("/warehouse/wareHouseManageList.do")
	public String wareHouseManageList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/wareHouseManageList";
	}
	
	@RequestMapping("/warehouse/getWareHouseManageList.do")
	public ModelAndView getWareHouseManageList(
			//Map<String, Object> commandMap
			//, HttpServletRequest request
			//,@ModelAttribute("loginVO") LoginVO loginvo
			@ModelAttribute("searchVO") WareHouseManageSearchVO searchVO
			//,ModelMap model
			) throws Exception{
		
 		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchVO.getPageIndex() == 0)
			searchVO.setPageIndex(1);
		
		//searchVO.setOrderby_time("desc");
		
		/** paging */
		searchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List wareHouseManageList = wareHouseManageService.getWareHouseManageList(searchVO);
		
		int totCnt = wareHouseManageService.getWareHouseManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchVO", searchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultList", wareHouseManageList);
		//modelAndView.setViewName("/warehouse/wareHouseManageList");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
 	}
	
	/**
	 * 방제물품 창고관리 창고등록
	 * @param loginVO
	 * @param wareHouseVO
	 * @param bindingResult
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseManageRegist.do")
	public String wareHouseManageRegist(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		String returnValue= "";
		String mode = (String)commandMap.get("mode");

		if (mode == null) mode = "";
		
		if(mode.equals("register")){
			wareHouseManageService.insertWareHouseManage(wareHouseVO);			
			returnValue = "forward:/warehouse/wareHouseManageList.do";
		}else{
			returnValue = "/warehouse/wareHouseManageRegist";
		}		
		return returnValue;
	}

	
	/**
	 * 상위부서 코드
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseManageDeptUpper.do")
	public ModelAndView wareHouseManageDeptUpper(
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.wareHouseManageDeptUpper();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	/**
	 * 담당부서 코드
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseManageDeptAdmin.do")
	public ModelAndView wareHouseManageDeptAdmin(
			Map<String, Object> commandMap
			,@ModelAttribute("deptVO") DeptVO deptVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.wareHouseManageDeptAdmin(deptVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 담당부서 코드
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseManageAdminName.do")
	public ModelAndView wareHouseManageAdminName(
			Map<String, Object> commandMap
			,@ModelAttribute("memberVO") MemberVO memberVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.wareHouseManageAdminName(memberVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 창고관리 창고수정.
	 * @param loginVO
	 * @param wareHouseVO
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/wareHouseManageModify.do")
	public String wareHouseManageModify(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		String returnValue= "";
		String mode = (String)commandMap.get("mode");

		if (mode == null) mode = "";
		
		if(mode.equals("modify")){
			wareHouseManageService.updateWareHouseManage(wareHouseVO);
			returnValue = "forward:/warehouse/wareHouseManageList.do";
		}else if(mode.equals("delete")){
			wareHouseManageService.deleteWareHouseManage(wareHouseVO);
			returnValue = "forward:/warehouse/wareHouseManageList.do";
		}else{
			List getWareHouseManageDetail = wareHouseManageService.getWareHouseManageDetail(wareHouseVO);
			model.addAttribute("resultDetail", getWareHouseManageDetail);
			returnValue = "/warehouse/wareHouseManageModify";
		}		
		return returnValue;
	}	
	
	/**
	 * 방제물품 코드관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("/warehouse/itemManageList.do")
//	public String itemManageList(
//			Map<String, Object> commandMap
//			,@ModelAttribute("loginVO") LoginVO loginvo
//			,@ModelAttribute("searchVO") ItemManageSearchVO searchVO
//			,ModelMap model
//			) throws Exception {
//		
//		/** EgovPropertyService.sample */
//		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//		
//		searchVO.setPageUnit(10);
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//
//		/** paging */
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
//		paginationInfo.setPageSize(searchVO.getPageSize());
//		
//		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//		
//		List ItemManageList = wareHouseManageService.getItemManageList(searchVO);
//		model.addAttribute("resultList", ItemManageList);
//		
//		int totCnt = wareHouseManageService.getItemManageListCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//		model.addAttribute("paginationInfo", paginationInfo);
//		
//		return "/warehouse/itemManageList";
//	}
	
	@RequestMapping("/warehouse/itemManageList.do")
	public String itemManageList(
			Map<String, Object> commandMap
			,@ModelAttribute("searchVO") ItemManageSearchVO searchVO
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemManageList";
	}
	
	/**
	 * 방제물품 코드관리 화면
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getItemManageList.do")
	public ModelAndView getItemManageList(
			@ModelAttribute("searchVO") ItemManageSearchVO searchVO
			) throws Exception {
		
		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchVO.getPageIndex() == 0)
			searchVO.setPageIndex(1);

		/** paging */
		searchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List ItemManageList = wareHouseManageService.getItemManageList(searchVO);
		
		int totCnt = wareHouseManageService.getItemManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("resultList", ItemManageList);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("searchVO", searchVO);
		//modelAndView.setViewName("/warehouse/itemManageList");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	/**
	 * 방제물품 물품관리 물품수정
	 * @param loginVO
	 * @param itemCodeVO
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemManageModify.do")
	public String itemManageModify(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		String returnValue= "";
		String mode = (String)commandMap.get("mode");

		if (mode == null) mode = "";
		
		if(mode.equals("modify")){
			wareHouseManageService.updateItemManage(itemCodeVO);
			returnValue = "forward:/warehouse/itemManageList.do";
		}else{
			List getItemManageDetail = wareHouseManageService.getItemManageDetail(itemCodeVO);
			model.addAttribute("resultDetail", getItemManageDetail);
			returnValue = "/warehouse/itemManageModify";
		}		
		return returnValue;
	}
	
	/**
	 * 방제물품 물품관리 물품등록
	 * @param loginVO
	 * @param itemCodeVO
	 * @param bindingResult
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemManageRegist.do")
	public String itemManageRegist(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		String returnValue= "";
		String mode = (String)commandMap.get("mode");

		if (mode == null) mode = "";
		
		if(mode.equals("register")){
			wareHouseManageService.insertItemManage(itemCodeVO);
			returnValue = "forward:/warehouse/itemManageList.do";
		}else{
			returnValue = "/warehouse/itemManageRegist";
		}		
		return returnValue;
	}
	
	/**
	 * 방제물품 대분류코드 가져오기
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemManageUpperGroupCode.do")
	public ModelAndView itemManageGroupCode(
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.itemManageUpperGroupCode();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 중분류코드 가져오기
	 * @param commandMap
	 * @param itemCodeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemManageGroupCode.do")
	public ModelAndView itemManageGroupCode(
			Map<String, Object> commandMap
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.itemManageGroupCode(itemCodeVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 물품코드 가져오기
	 * @param commandMap
	 * @param itemCodeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemConditionCode.do")
	public ModelAndView itemConditionCode(
			Map<String, Object> commandMap
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.itemConditionCode(itemCodeVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/itemCodeInWareHouse.do")
	public ModelAndView itemCodeInWareHouse(
			Map<String, Object> commandMap
			, @ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.itemCodeInWareHouse(wareHouseVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 코드관리 코드목록
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemGroupList.do")
	public String itemGroupList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemGroupList";
	}
	
	/**
	 * 방제물품 코드관리 대분류목록
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemUpperGroupDataList.do")
	public ModelAndView itemUpperGroupDataList(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemGroupSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		//searchVO.setPageUnit(10);
		searchVO.setPageUnit(100000);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<ItemCodeSearchVO> list = wareHouseManageService.itemUpperGroupDataList(searchVO);
		int totCnt = wareHouseManageService.itemUpperGroupDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 코드관리 중분류목록
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemGroupDataList.do")
	public ModelAndView itemGroupDataList(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemGroupSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		//searchVO.setPageUnit(10);
		searchVO.setPageUnit(100000);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<ItemCodeSearchVO> list = wareHouseManageService.itemGroupDataList(searchVO);
		int totCnt = wareHouseManageService.itemGroupDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 물품분류항목 수정
	 * @param itemGroupVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemGroupModify.do")
	public ModelAndView itemGroupModify(
			@ModelAttribute("itemCodeGroupVO") ItemCodeGroupVO itemCodeGroupVO	
			) throws Exception {		
		ModelAndView modelAndView = new ModelAndView();
		wareHouseManageService.itemGroupModify(itemCodeGroupVO);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 대분류항목 등록
	 * @param itemGroupVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemUpperGroupInsert.do")
	public ModelAndView itemUpperGroupInsert(
			@ModelAttribute("itemCodeGroupVO") ItemCodeGroupVO itemCodeGroupVO
			) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		wareHouseManageService.itemUpperGroupInsert(itemCodeGroupVO);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	/**
	 * 중분류항목 등록
	 * @param itemGroupVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemGroupInsert.do")
	public ModelAndView itemGroupInsert(
			@ModelAttribute("itemCodeGroupVO") ItemCodeGroupVO itemCodeGroupVO
			) throws Exception {		
		ModelAndView modelAndView = new ModelAndView();
		wareHouseManageService.itemGroupInsert(itemCodeGroupVO);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	//getItemGroupNextCode
	
	/**
	 * 중분류항목 등록
	 * @param itemGroupVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getItemGroupNextCode.do")
	public ModelAndView getItemGroupNextCode(
			@ModelAttribute("itemCodeGroupVO") ItemCodeGroupVO itemCodeGroupVO
			) throws Exception {
		
		String code = wareHouseManageService.getItemGroupNextCode(itemCodeGroupVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("code", code);
		modelAndView.setViewName("jsonView");
		return modelAndView;

	}
	
	/**
	 * 물품현황 현황목록
	 * @param commandMap
	 * @param loginvo
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("/warehouse/itemConditionManageList.do")
//	public String itemConditionManageList(
//			 Map<String, Object> commandMap
//			,@ModelAttribute("loginVO") LoginVO loginvo
//			,@ModelAttribute("searchVO") ItemConditionManageSearchVO searchVO
//			,ModelMap model
//			) throws Exception{
//		
//		String roleCode = "";
//		
//		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
//		
//				
//		
//		/** EgovPropertyService.sample */
//		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//		
//		searchVO.setPageUnit(10);
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//
//		/** pageing */
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
//		paginationInfo.setPageSize(searchVO.getPageSize());
//		
//		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//		
//		/*권한별 목록*/
//		searchVO.setRoleCode(user.getRoleCode());
//		searchVO.setDeptNo(user.getDeptNo());
//		searchVO.setMemberId(user.getId());
//		
//		List itemConditionManageList = wareHouseManageService.getItemConditionManageList(searchVO);
//		model.addAttribute("resultList", itemConditionManageList);
//		
//		int totCnt = wareHouseManageService.getItemConditionManageListCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//		model.addAttribute("paginationInfo", paginationInfo);
//		
//		return "/warehouse/itemConditionManageList";
//	}
	
	@RequestMapping("/warehouse/itemConditionManageList.do")
	public String itemConditionManageList(
			Map<String, Object> commandMap
			,@ModelAttribute("searchVO") ItemConditionManageSearchVO searchVO
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemConditionManageList";
	}
	
	@RequestMapping("/warehouse/getItemConditionManageList.do")
	public ModelAndView getItemConditionManageList(
			@ModelAttribute("loginVO") LoginVO loginvo
			,@ModelAttribute("searchVO") ItemConditionManageSearchVO searchVO
			) throws Exception{
		
		//String roleCode = "";
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
 		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchVO.getPageIndex() == 0)
			searchVO.setPageIndex(1);
		
		//searchVO.setOrderby_time("desc");
		
		/** paging */
		searchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/*권한별 목록*/
		searchVO.setRoleCode(user.getRoleCode());
		searchVO.setDeptNo(user.getDeptNo());
		searchVO.setMemberId(user.getId());

		List itemConditionManageList = wareHouseManageService.getItemConditionManageList(searchVO);
		
		int totCnt = wareHouseManageService.getItemConditionManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchVO", searchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultList", itemConditionManageList);
		//modelAndView.setViewName("/warehouse/itemConditionManageList");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
 	}
	
	/**
	 * 물품 입고
	 * @param loginVO
	 * @param itemCodeVO
	 * @param bindingResult
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemConditionStorRegist.do")
	public String itemConditionStorRegist(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		String returnValue= "";
		String mode	  = (String)commandMap.get("mode");
		
		LoginVO user = null;
		
		if (mode == null) mode = "";
		
		if(mode.equals("insertStor")){
			Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
			
			if (isAuthenticated) {
				user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			} else {
				user = new LoginVO();
				user.setUniqId("");
			}
			itemCodeVO.setRegId(user.getId());
			
			wareHouseManageService.insertItemConditionStor(itemCodeVO);
			returnValue = "forward:/warehouse/itemConditionManageList.do";
		}else{				
			returnValue = "/warehouse/itemConditionStorRegist";
		}		
		return returnValue;
	}
	
	/**
	 * 담당하는 창고목록 가져오기
	 * @param commandMap
	 * @param wareHouseVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getWareHouseCode.do")
	public ModelAndView getWareHouseCode(
			Map<String, Object> commandMap
			, @ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.getWareHouseCode(wareHouseVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 규격, 단위 가져오기.
	 * @param commandMap
	 * @param itemCodeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getItemDetailValue.do")
	public ModelAndView getItemDetailValue(
			Map<String, Object> commandMap
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String tmpItemCode[] = itemCodeVO.getItemCode().split("-");
		itemCodeVO.setItemCode(tmpItemCode[0]);
		itemCodeVO.setItemCodeNum(tmpItemCode[1]);
		try{
			List<Map<String,String>> codes = wareHouseManageService.getItemDetailValue(itemCodeVO);
			modelAndView.addObject("codes", codes);
		}catch (Exception e){
			e.printStackTrace();
		}
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	@RequestMapping("/warehouse/itemConditionReleRegist.do")
	public String itemConditionReleRegist(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		String returnValue= "";
		String mode	  = (String)commandMap.get("mode");
		
		LoginVO user = null;
		
		if (mode == null) mode = "";
		
		if(mode.equals("insertRele")){
			Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
			
			if (isAuthenticated) {
				user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			} else {
				user = new LoginVO();
				user.setUniqId("");
			}
			itemCodeVO.setRegId(user.getId());
			
			wareHouseManageService.insertItemConditionRele(itemCodeVO);
			returnValue = "forward:/warehouse/itemConditionManageList.do";
		}else{		
			List getItemConditionReleDetail = wareHouseManageService.getItemConditionReleDetail(itemCodeVO);
			model.addAttribute("resultDetail", getItemConditionReleDetail);
			
			returnValue = "/warehouse/itemConditionReleRegist";
		}		
		return returnValue;
	}

	/**
	 * 방제물품 정산관리 정산목록 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemCalculateManage.do")
	public String itemCalculateManage(
			Map<String, Object> commandMap
			, ModelMap model
			, HttpServletRequest request
			) throws Exception {
		
		String strSearchType = (String)request.getParameter("strSearchType");
		
		if(strSearchType != null){
			request.setAttribute("strSearchType", strSearchType);
		}
		
		return "/warehouse/itemCalculateManageList";
	}
	
	/**
	 * 방제물품 정산관리 목록 가져오기
	 * @param loginVO
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemCalculateManageList.do")
	public ModelAndView itemGroupDataList(
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		//searchVO.setPageUnit(10);
		searchVO.setPageUnit(100000);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());	
		
		String searchType = (String)commandMap.get("searchType");
		
		if (searchType == null) searchType = "river";
		
		
		searchVO.setSearchType(searchType);
		
		List<ItemCodeSearchVO> list = null;
		int totCnt = 0;
		
		list = wareHouseManageService.itemCalculateManageList(searchVO);
		totCnt = wareHouseManageService.itemCalculateManageListCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		 
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 상세내역
	 * @param loginVO
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemCalculateManageDetailList.do")
	public ModelAndView itemCalculateManageDetailList(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		List list = wareHouseManageService.itemCalculateManageDetailList(itemCodeVO);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제물품 정산관리 상세
	 * @param loginVO
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("/warehouse/itemCalculateManageDetail.do")
//	public String itemCalculateManageDetail(
//			  @ModelAttribute("loginVO") LoginVO loginVO
//			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
//			, Map<String, Object> commandMap
//			, ModelMap model
//			) throws Exception {
//		
//		/** EgovPropertyService.sample */
//		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//		
//		searchVO.setPageUnit(10);
//		searchVO.setPageSize(propertiesService.getInt("pageSize"));
//
//		/** pageing */
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
//		paginationInfo.setPageSize(searchVO.getPageSize());
//		
//		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());		
//		
//		List list = wareHouseManageService.getItemCalculateManageDetail(searchVO);
//		model.addAttribute("resultList", list);
//		
//		int totCnt = wareHouseManageService.getItemCalculateManageDetailCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//		model.addAttribute("paginationInfo", paginationInfo);
//		
//		return "/warehouse/itemCalculateManageDetail";
//	}
	
	@RequestMapping("/warehouse/itemCalculateManageDetail.do")
	public String itemCalculateManageDetail(
			Map<String, Object> commandMap
			,@ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, ModelMap model
			) throws Exception {
		return "/warehouse/itemCalculateManageDetail";
	}
	
	@RequestMapping("/warehouse/getItemCalculateManageDetail.do")
	public ModelAndView getItemCalculateManageDetail(
			@ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			) throws Exception{
		
 		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchVO.getPageIndex() == 0)
			searchVO.setPageIndex(1);
		
		//searchVO.setOrderby_time("desc");
		
		/** paging */
		searchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List list = wareHouseManageService.getItemCalculateManageDetail(searchVO);
		
		int totCnt = wareHouseManageService.getItemCalculateManageDetailCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchVO", searchVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("resultList", list);
		//modelAndView.setViewName("/warehouse/itemCalculateManageDetail");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
 	}
	
	/**
	 * 부서 선택 팝업을 조회한다. 
	 * @param searchVO  ComDefaultVO 
	 * @return 출력페이지정보 "admin/dept/DeptMvmn" 
	 * @exception Exception
	 */
	@RequestMapping(value="/warehouse/selectDeptPopupList.do")
	public String selectDeptPopupList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			HttpServletRequest request, 
			ModelMap model)
			throws Exception { 
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		
		List list_deptlist = deptManageService.selectDeptList();
		model.addAttribute("list_deptlist", list_deptlist);
	  	return  "/warehouse/selectDeptPopup"; 
	}
	
	
	/**
	 * 주소찾기 팝업
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/selectAddrPopupList.do")
	public String selectAddrPopupList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/selectAddrPopupList";
	}
	
	
	@RequestMapping("/warehouse/itemUpperGroupCodeDup.do")
	public ModelAndView itemUpperGroupCodeDup(
			Map<String, Object> commandMap	
			, HttpServletRequest request
			, @ModelAttribute("itemCodeGroupVO") ItemCodeGroupVO itemCodeGroupVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeSearchVO> list = wareHouseManageService.itemUpperGroupCodeDup(itemCodeGroupVO);
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 분류코드 등록 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemGroupRegistPopup.do")
	public String itemGroupRegistPopup(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemGroupRegistPopup";
	}
	
	/**
	 * 분류코드 수정 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemGroupModifyPopup.do")
	public String itemGroupModifyPopup(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemGroupModifyPopup";
	}
	
	/**
	 * 담당(정)직원의 전화번호 가져오기
	 * @param commandMap
	 * @param itemCodeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getAdminTelNo.do")
	public ModelAndView getAdminTelNo(
			Map<String, Object> commandMap
			, @ModelAttribute("memberVO") MemberVO memberVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.getAdminTelNo(memberVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 주소 리스트 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/warehouse/getWarehouseAddrList.do")
	public ModelAndView getAddressList(
			@ModelAttribute("zipcodeVO") WareHouseZipcodeVO zipcodeVO
			) throws Exception {
		List list = wareHouseManageService.getWarehouseAddrList(zipcodeVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("getAddressList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 물품코드 최대 순번 가져오기 
	 * @param ItemCodeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getMaxItemCode.do")
	public ModelAndView getMaxItemCode(
			Map<String, Object> commandMap
			,@ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String codes = wareHouseManageService.getMaxItemCode(searchVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	// warehouse List 관련 < 저장 >
	/**
	 * 등록 창 열기 
	 * @param strMode
	 * @return
	 * @throws Exception
	 * @RequestParam(value="memberId", required=false) String members
	 */
	
	@RequestMapping("/warehouse/wareHouseRegistModifyPopup.do")
	public String wareHouseRegistModifyPopup(
			Map<String, Object> commandMap,
			ModelMap model
			) throws Exception {
		
	
		return "/warehouse/wareHouseRegistPopup";
	}
	
	
	/**
	 * 방제물품 물품관리 물품수정
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getRiverCodeTwo.do")
	public ModelAndView getRiverCodeTwo(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.getRiverCodeTwo();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 운영기관/관리주체 검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getUpperDeptCode.do")
	public ModelAndView getUpperDeptCode(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.getUpperDeptCode();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}	
	
	/**
	 * 운영부서/관리부서  검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getDeptCode.do")
	public ModelAndView getDeptCode(
			Map<String, Object> commandMap
			,@RequestParam(value="upperDeptCode",  required=true) String upperDeptCode
			, ModelMap model
			) throws Exception {
		
		
		ModelAndView modelAndView = new ModelAndView();
		Map<String, String> mapParam = new HashMap<String, String>();
		mapParam.put("upperDeptCode", upperDeptCode);
		List<Map<String,String>> codes = wareHouseManageService.getDeptCode(mapParam);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 창고코드 최대 순번 가져오기 
	 * @param ItemCodeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getMaxWareHouseCode.do")
	public ModelAndView getMaxWareHouseCode(
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String codes = wareHouseManageService.getMaxWareHouseCode();
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	/**
	 * 담당자 검색 
	 * @param MemberSearchVO
	 * @return List<MemberSearchVO>
	 * @throws Exception
	 */
	
	@RequestMapping("/warehouse/getSearchMember.do")
	public ModelAndView getSearchMember(
			Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("memberSearchVO") MemberSearchVO memberSearchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		List<MemberSearchVO> list = wareHouseManageService.getSearchMember(memberSearchVO);
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	/**
	 * 창고 목록 조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/warehouse/getSearchWareHouseList.do")
	public ModelAndView getSearchWareHouseList(
			Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("wareHouseSearchVO") WareHouseSearchVO wareHouseSearchVO
			) throws Exception{
		
		PaginationInfo paginationInfo = new PaginationInfo();

		if(wareHouseSearchVO.getPageIndex() == 0)
			wareHouseSearchVO.setPageIndex(1);
		
		/** paging */
		wareHouseSearchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(wareHouseSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(wareHouseSearchVO.getPageUnit());
		paginationInfo.setPageSize(wareHouseSearchVO.getPageSize()); 
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<WareHouseSearchVO> list = wareHouseManageService.getSearchWareHouseList(wareHouseSearchVO);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 재고 목록 조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getSearchItemStockList.do")
	public ModelAndView getSearchItemStockList(
			Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("wareHouseSearchVO") ItemCodeSearchVO searchVO
			) throws Exception{
		
		 
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = wareHouseManageService.getSearchItemStockList(searchVO);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 등록 창 열기 
	 * @param 
	 * @return
	 * @throws 
	 * @RequestParam
	 */
	
	@RequestMapping("/warehouse/wareHouseStockRegistPopup.do")
	public String wareHouseStockRegistPopup(
			Map<String, Object> commandMap,
			@ModelAttribute("wareHouseSearchVO") WareHouseSearchVO wareHouseSearchVO,
			 ModelMap model
			) throws Exception {
		
		model.addAttribute("param_s", wareHouseSearchVO);
		return "/warehouse/wareHouseStockRegistPopup";
	}
	
	/**
	 * 같은 시간때 같은 물품 입고(또는 출고) 확인 // 동일 건 INSERT 오류(PK)
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/checkDuplicateItemInOut.do")
	public ModelAndView checkDuplicateItemInOut(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		int result = wareHouseManageService.checkDuplicateItemInOut(itemCodeVO);
		if(result < 1){
			modelAndView.addObject("duplicate", false);	// 중복 아님
		}else{
			modelAndView.addObject("duplicate", true);	// 중복
		}
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 출고 입력
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/addItemInOut.do")
	public ModelAndView addItemInOut(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		wareHouseManageService.addItemInOut(itemCodeVO);
		modelAndView.addObject("updateCnt", true);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 출고 수정
	 * @param itemCodeVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/modifyStockItem.do")
	public String modifyStockItem(
			@ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO,
			Map<String, Object> commandMap
			) throws Exception {
		wareHouseManageService.modifyStockItem(itemCodeVO);
		return "forward:/warehouse/selectWareHouseItemReleList.do";
	}
	
	/**
	 * 방제물품 창고정보 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/mergeItemStock.do")
	public ModelAndView mergeItemStock(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int updateCnt = 0;
		updateCnt = wareHouseManageService.mergeItemStock(itemCodeVO);
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/tranItemInOut.do")
	public ModelAndView tranItemInOut(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		int updateCnt = 0;
		try{
			wareHouseManageService.addItemInOut(itemCodeVO);
			updateCnt = wareHouseManageService.mergeItemStock(itemCodeVO);
		}catch(Exception e){
			modelAndView.addObject("err", e.toString());
		}
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
//getItemInOutList
	
	/**
	 * 재고 현환 이력 조회 
	 * @param ItemCodeSearchVO
	 * @return List<ItemCodeVO>
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getItemInOutList.do")
	public ModelAndView getItemInOutList(
			Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("wareHouseSearchVO") ItemCodeSearchVO searchVO
			) throws Exception{
		
		 
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = wareHouseManageService.getItemInOutList(searchVO);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 재고 이력 창 열기 
	 * @param 
	 * @return
	 * @throws Exception
	 * @RequestParam
	 */
	
	@RequestMapping("/warehouse/wareHouseManageRegistPopup.do")
	public String wareHousemanageRegistPopup(
			Map<String, Object> commandMap,
			 ModelMap model
			) throws Exception {
		
	
		return "/warehouse/wareHouseManageRegistPopup";
	}
	
	/**
	 * 방제물품 보유현황 물품별 조회시 물품별 창고 분포현황 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/itemWarehouseManage.do")
	public ModelAndView itemWarehouseManage(
			Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("wareHouseSearchVO") ItemCodeSearchVO searchVO
			) throws Exception{
		
		 
		ModelAndView modelAndView = new ModelAndView();
		List<ItemCodeVO> list = wareHouseManageService.itemWarehouseManage(searchVO);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	/**
	 * 담당하는 창고목록 가져오기
	 * @param commandMap
	 * @param wareHouseVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/getWareHouseNames.do")
	public ModelAndView getWareHouseNames(
			Map<String, Object> commandMap
			, @ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<Map<String,String>> codes = wareHouseManageService.getWareHouseNames(wareHouseVO);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	@RequestMapping("/warehouse/itemHoldConditionList.do")
	public String itemHoldConditionList(
			Map<String, Object> commandMap
			,@ModelAttribute("searchVO") ItemConditionManageSearchVO searchVO
			, ModelMap model
			) throws Exception {
		
		return "/warehouse/itemHoldConditionList";
	}
	@RequestMapping("/warehouse/getItemHoldConditionList.do")
	public ModelAndView getItemHoldConditionList(
			@ModelAttribute("loginVO") LoginVO loginvo
			,@ModelAttribute("searchVO") ItemConditionManageSearchVO searchVO
			) throws Exception{
		
		//String roleCode = "";
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
 		PaginationInfo paginationInfo = new PaginationInfo();

		if(searchVO.getPageIndex() == 0)
			searchVO.setPageIndex(1);
		
		//searchVO.setOrderby_time("desc");
		
		/** paging */
		searchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/*권한별 목록*/
		searchVO.setRoleCode(user.getRoleCode());
		//searchVO.setDeptNo(user.getDeptNo());
		searchVO.setMemberId(user.getId());

		//List itemConditionManageList = wareHouseManageService.getItemConditionManageList(searchVO);
		List itemHoldConditionList = wareHouseManageService.getItemHoldConditionList(searchVO);
		
		
		// int totCnt = wareHouseManageService.getItemHoldConditionListCnt(searchVO);
		int totCnt = itemHoldConditionList.size();
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("searchVO", searchVO);
		modelAndView.addObject("tot", totCnt);
		modelAndView.addObject("resultList", itemHoldConditionList);
		//modelAndView.setViewName("/warehouse/itemConditionManageList");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
 	}
	@RequestMapping("/warehouse/getExcelViewWareHouseItem.do")
	public ModelAndView getExcelViewWareHouseItem(
			@ModelAttribute("searchVO") ItemConditionManageSearchVO searchVO,
			@RequestParam(value="item", required=false) String item,
			@RequestParam(value="deptNo", required=false) String deptNo
			)
			throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(Integer.MAX_VALUE);
		
		List itemHoldConditionList = wareHouseManageService.getItemHoldConditionList(searchVO);
		
		int totCnt = itemHoldConditionList.size();
		
		WareHouseVO wareHouseVO = new WareHouseVO();
		wareHouseVO.setAdminDept(deptNo);
		
		List<Map<String,String>> codes = wareHouseManageService.getWareHouseNames(wareHouseVO);
		
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("resultList", itemHoldConditionList);
		map.put("totalCnt", totCnt);
		map.put("whNames", codes);
		map.put("searchVO", searchVO);
		
		ModelAndView modelAndView = null;
		modelAndView = new ModelAndView("ExcelViewWareHouseItem", "chartMap", map);
		
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/showItemDetailView.do")
	public ModelAndView showItemDetailView(Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			) throws Exception{

		ModelAndView modelAndView = new ModelAndView();
		ItemCodeVO itemVO = new ItemCodeVO();
		List<ItemCodeVO> itemLocationStockList = null;
		try{
			itemVO = wareHouseManageService.showItemDetailView(itemCodeVO);
			itemLocationStockList = wareHouseManageService.getLocationOfItemStockList(itemCodeVO);
			
			modelAndView.addObject("reqRst", "SUCCESS");
		}catch(Exception e){
			e.printStackTrace();
			modelAndView.addObject("reqErr", e.toString());
		}
		modelAndView.addObject("itemVO", itemVO);
		modelAndView.addObject("itemLocationStockList", itemLocationStockList);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/showItemLocationStock.do")
	public ModelAndView showItemLocationStock(Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			) throws Exception{

		ModelAndView modelAndView = new ModelAndView();
		ItemCodeVO itemVO = new ItemCodeVO();
		List<ItemCodeVO> itemLocationStockList = null;
		try{
			itemLocationStockList = wareHouseManageService.getLocationOfItemStockDeptList(itemCodeVO);
			
			modelAndView.addObject("reqRst", "SUCCESS");
		}catch(Exception e){
			e.printStackTrace();
			modelAndView.addObject("reqErr", e.toString());
		}
		modelAndView.addObject("itemLocationStockList", itemLocationStockList);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/saveItemDetailView.do")
	public ModelAndView saveItemDetailView(Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			) throws Exception{

		int result = 0;
		ModelAndView modelAndView = new ModelAndView();
		try{
			result = wareHouseManageService.saveItemDetailView(itemCodeVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		modelAndView.addObject("saveCount", result);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/saveWareHouseItemCodeDetail.do")
	public ModelAndView saveWareHouseItemCodeDetail(
			final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("searchVO") ItemCodeSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int updateCnt = 0;
		
		// 첨부된 파일이 있는 경우
		if("Y".equals(searchVO.getFileUploadChk())){
			List<FileVO> result = null;
			String atchFileId = "";
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
			searchVO.setAtchFileId(atchFileId);
			searchVO.setChkFileId(atchFileId);
		}
		
		try{
			updateCnt = wareHouseManageService.mergeWareHouseItemCodeN(searchVO);
			// updateCnt = wareHouseManageService.saveWareHouseItemCodeDetail(itemCodeVO);
		}catch(Exception e){
			modelAndView.addObject("errorMsg", e.toString());
		}
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping("/warehouse/itemQRDetail.do")
	public String itemQRDetail(Map<String, Object> commandMap
			, HttpServletRequest request
			, @ModelAttribute("itemCodeVO") ItemCodeVO itemCodeVO
			, ModelMap model
			) throws Exception{

		String itemCode = StringUtil.isNullToString(itemCodeVO.getItemCode());
		String itemCodeNum = StringUtil.isNullToString(itemCodeVO.getItemCodeNum());
		
		model.addAttribute("itemCode", itemCode);
		model.addAttribute("itemCodeNum", itemCodeNum);
		
		return "/warehouse/itemQRDetail";
	}
	
	
	/**
	 * 창고 삭제 
	 * @param commandMap
	 * @param wareHouseVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/warehouse/deleteWareHouse.do")
	public ModelAndView deleteWareHouse(
			Map<String, Object> commandMap
			, @ModelAttribute("wareHouseVO") WareHouseVO wareHouseVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		String status = "";
		
		try{
			status = wareHouseManageService.deleteWareHouse(wareHouseVO);
		}catch(Exception e){
			e.printStackTrace();
			modelAndView.addObject("err", e.toString());
		}
		
		modelAndView.addObject("status", status);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 방제장비물품 등록
	 * 2018.09.18
	 * Naturetech choi hoe seop
	 */
	@RequestMapping("/warehouse/itemConditionRegist.do")
	public String workJournalRegist(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		
		return "warehouse/itemConditionRegist";
	}
	
	/**
	 * 업무일지 스캔 파일 등록
	 * @param multiRequest
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/warehouse/uploadItemConditionData.do")
	public ModelAndView uploadworkJournalData(
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
							System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
							resultCnt = wareHouseManageService.insertItemConditionInfoXls(multiRequest, vo, wareHouseVO);
						} else if(vo.getFileExtsn().equals("xlsx")) {
							System.out.println("#################################################");
							resultCnt = wareHouseManageService.insertItemConditionInfoXlsx(multiRequest, vo, wareHouseVO);
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
				else if(errorMsg.contains("wareHouseManageDAO.insertValidData-InlineParameterMap"))
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
		
		response.getWriter().print("<script>location.href='/warehouse/itemConditionRegist.do';</script>"); 
		
		return null;
	}
	
	/**
	 * 방제장비물품현황 리스트
	 * @return warehouse/popupItemCondition.do
	 */
	@RequestMapping("/warehouse/recentlyItemCondition.do")
	public String getItemConditionList(Map<String, Object> commandMap, ModelMap model) {
		
		String view = (String)commandMap.get("view");
		if (StringUtil.isEmpty(view)) {
			view = "index";
		}
		
		List<ExcelItemVO> resultList = wareHouseManageService.getItemConditionList();
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("view", view);
		
		return "warehouse/recentlyItemCondition";
	}
	
	/**
	 * 방제장비물품현황 팝업
	 * @return
	 */
	@RequestMapping("/warehouse/popupItemCondition.do")
	public String popupItemCondition(Map<String, Object> commandMap, ModelMap model) {
		
		String stdDate = (String)commandMap.get("stdDate");
		
		List<ExcelItemVO> resultList = wareHouseManageService.getItemConditionDetail(stdDate);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("stdDate", stdDate);
		
		return "warehouse/popupItemCondition";
	}
}