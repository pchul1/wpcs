package daewooInfo.itemmanage.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.itemmanage.bean.GroupItemVO;
import daewooInfo.itemmanage.bean.ItemGroupVO;
import daewooInfo.itemmanage.bean.ItemInfoVO;
import daewooInfo.itemmanage.bean.ItemVO;
import daewooInfo.itemmanage.bean.UnitVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.itemmanage.bean.GroupManageVO;
import daewooInfo.itemmanage.bean.ItemManageVO;
import daewooInfo.itemmanage.bean.SystemManageVO;
import daewooInfo.itemmanage.service.ItemManageCounterService;
import daewooInfo.spotmanage.bean.SpotInfoVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : SpotManageController.java
 * @Description : 지점 관리를 위한 Controller
 * @Modification Information
 * 수정일			수정자			수정내용
 * -------		--------	---------------------------
 * 
 * 
 * @author yong
 * @since 2012.01.25
 * @version 1.0
 * @see
 * 
 */
@Controller
public class ItemManageController {

	/**
	 * @uml.property  name="itemManageCounterService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "ItemManageCounterService")
	private ItemManageCounterService itemManageCounterService;
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * 측정항목 정의 호출
	 * 
	 * @return 출력페이지정보 "itemmanage/itemDefine"
	 * @exception Exception
	 */
	@RequestMapping(value = "/itemmanage/goItemDefine.do")
	public String goItemDefine(ModelMap model) throws Exception {
		return "itemmanage/itemDefine";
	}
	
	/**
	 * 시스템 항목 정의 호출
	 * 
	 * @return 출력페이지정보 "itemmanage/systemItemDefine"
	 * @exception Exception
	 */
	@RequestMapping(value = "/itemmanage/goSystemItemDefine.do")
	public String goSystemItemDefine(ModelMap model) throws Exception {
		return "itemmanage/systemItemDefine";
	}
	
	/**
	 * 항목그룹 리스트 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/itemmanage/getGroupList.do")
	public ModelAndView getGroupList() throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ItemGroupVO itemGroupVO = new ItemGroupVO();
		PaginationInfo paginationInfo = new PaginationInfo();
		
		if (itemGroupVO.getPageIndex() == 0)
			itemGroupVO.setPageIndex(1);
		
		/** paging */
		itemGroupVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(itemGroupVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(itemGroupVO.getPageUnit());
		paginationInfo.setPageSize(itemGroupVO.getPageSize());
		
		itemGroupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		itemGroupVO.setLastIndex(paginationInfo.getLastRecordIndex());
		itemGroupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List refreshData = itemManageCounterService.getGroupList(itemGroupVO);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("itemGroupVO", itemGroupVO);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/itemmanage/groupinsert.do")
	public ModelAndView groupInsert(
			@ModelAttribute("itemGroupVO") ItemGroupVO itemGroupVO
			) throws Exception {
		itemManageCounterService.groupInsert(itemGroupVO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/itemmanage/groupupdate.do")
	public ModelAndView groupUpdate(
			@ModelAttribute("itemGroupVO") ItemGroupVO itemGroupVO
			) throws Exception {
		itemManageCounterService.groupUpdate(itemGroupVO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/itemmanage/goGroupDel.do")
	public ModelAndView goGroupDel(
			@ModelAttribute("itemGroupVO") ItemGroupVO itemGroupVO
			) throws Exception {
		itemManageCounterService.goGroupDel(itemGroupVO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/itemmanage/setSaveGroup.do")
	public ModelAndView setSaveGroup(
			@RequestParam(value="groupCode", required=false) String[] groupCode
			,@RequestParam(value="dpYn", required=false) String[] dpYn			
			) throws Exception {
		ItemGroupVO itemGroupVO;
		for(int i=0; i<groupCode.length; i++){
			itemGroupVO = new ItemGroupVO();
			itemGroupVO.setGroupCode(groupCode[i]);
			itemGroupVO.setDpYn(dpYn[i]);
			itemManageCounterService.setSaveGroup(itemGroupVO);
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/itemmanage/getItemList.do")
	public ModelAndView getItemList(
			@RequestParam(value="groupCode", required=false) String groupCode
			) throws Exception {
		GroupItemVO groupItemVO = new GroupItemVO();
		groupItemVO.setGroupCode(groupCode);
		List list=itemManageCounterService.getGroupItemList(groupItemVO);
		List itemlist=itemManageCounterService.getItemList(groupItemVO);
		ItemGroupVO itemGroupVO = itemManageCounterService.groupMemo(groupItemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("getGroupItemList",list);
		modelAndView.addObject("groupMemo",itemGroupVO);
		modelAndView.addObject("getItemList",itemlist);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping("/itemmanage/getItemInfo.do")
	public ModelAndView getItemInfo(
			@RequestParam(value="groupCode", required=false) String groupCode
			) throws Exception {
		GroupItemVO groupItemVO = new GroupItemVO();
		groupItemVO.setGroupCode(groupCode);
		
		ItemGroupVO itemGroupVO = itemManageCounterService.getItemInfo(groupItemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("groupMemo",itemGroupVO);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	@RequestMapping(value = "/itemmanage/saveItem.do")
	public ModelAndView saveItem(
			@RequestParam("groupCode") String groupCode,
			@RequestParam("valArr") String valArr
			) throws Exception {
		GroupItemVO groupItemVO = new GroupItemVO();;
		groupItemVO.setGroupCode(groupCode);
		itemManageCounterService.deleteItem(groupItemVO);
		for(int i=0; i<valArr.split(",").length; i++){
			groupItemVO.setItemCode(valArr.split(",")[i]);
			itemManageCounterService.saveItem(groupItemVO);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/* 항목관리 상세보기 */
	@RequestMapping(value = "/itemmanage/goItemView.do")
	public ModelAndView goItemView(
			@ModelAttribute("itemVO") ItemVO itemVO
			) throws Exception {
		
		ItemVO getItemVO = itemManageCounterService.goItemView(itemVO);
		List unitList = itemManageCounterService.getUnitList();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("getUnitList",unitList);
		modelAndView.addObject("itemVO",getItemVO);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/* 항목관리 상세보기 */
	@RequestMapping(value = "/itemmanage/getItemUnitList.do")
	public ModelAndView getItemUnitList(
			@ModelAttribute("itemVO") ItemVO itemVO
			) throws Exception {
		
		List unitList = itemManageCounterService.getUnitList();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("getUnitList",unitList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/* 항목등록 */
	@RequestMapping(value = "/itemmanage/goItemInsert.do")
	public ModelAndView goItemInsert(
			@ModelAttribute("itemVO") ItemVO itemVO
			) throws Exception {
		
		itemManageCounterService.goItemInsert(itemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/* 항목수정저장 */
	@RequestMapping(value = "/itemmanage/goItemUpdate.do")
	public ModelAndView goItemUpdate(
			@ModelAttribute("itemVO") ItemVO itemVO
			) throws Exception {
		
		itemManageCounterService.goItemUpdate(itemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/* 항목수정저장 */
	@RequestMapping(value = "/itemmanage/goItemAllUpdate.do")
	public ModelAndView goItemAllUpdate(
			@ModelAttribute("itemVO") ItemVO itemVO
			) throws Exception {
		
		itemManageCounterService.goItemUpdate(itemVO);
		itemManageCounterService.goItemAllUpdate(itemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	
	/* 항목삭제저장 */
	@RequestMapping(value = "/itemmanage/goItemDelete.do")
	public ModelAndView goItemDelete(
			@ModelAttribute("itemVO") ItemVO itemVO
			) throws Exception {
		
		itemManageCounterService.goItemDelete(itemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 시스템 List 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/getSystemListItem.do")
	public ModelAndView getSystemListItem(
			@ModelAttribute("systemManageVO") SystemManageVO systemManageVO) throws Exception {
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		if (systemManageVO.getPageIndex() == 0)systemManageVO.setPageIndex(1);
		systemManageVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(systemManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(systemManageVO.getPageUnit());
		paginationInfo.setPageSize(systemManageVO.getPageSize());
		systemManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		systemManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		systemManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/** 쿼리 실행*/
		List list = itemManageCounterService.getSystemListItem(systemManageVO);
		SystemManageVO sysKindVo = new SystemManageVO();
		List selectGubunList = itemManageCounterService.getSystemListGubun(sysKindVo);
		
		/** 리턴값 설정*/
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("systemManageVO", systemManageVO);
		modelAndView.addObject("systemList", list);
		modelAndView.addObject("systemGubunList", selectGubunList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 시스템 코드로 그룹 List 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/getGroupListItem.do")
	public ModelAndView getGroupListItem(
			@ModelAttribute("groupManageVO") GroupManageVO groupManageVO) throws Exception {
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		if (groupManageVO.getPageIndex() == 0)groupManageVO.setPageIndex(1);
		groupManageVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());
		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/** 쿼리 실행*/
		List list = itemManageCounterService.getGroupListItem(groupManageVO);
		
		/** 리턴값 설정*/
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("groupManageVO", groupManageVO);
		modelAndView.addObject("groupList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 그룹 코드로 아이템 List 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/getItemListItem.do")
	public ModelAndView getItemListItem(
			@ModelAttribute("groupManageVO") ItemManageVO itemManageVO) throws Exception {
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		if (itemManageVO.getPageIndex() == 0)itemManageVO.setPageIndex(1);
		itemManageVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(itemManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(itemManageVO.getPageUnit());
		paginationInfo.setPageSize(itemManageVO.getPageSize());
		itemManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		itemManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		itemManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		/** 쿼리 실행*/
		List list = itemManageCounterService.getItemListItem(itemManageVO);
		/** 리턴값 설정*/
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("itemManageVO", itemManageVO);
		modelAndView.addObject("itemList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 시스템 사용여부 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/systemSaveItem.do")
	public ModelAndView systemSaveItem(
			@RequestParam(value="idArr", required=false) String idArr
			,@RequestParam(value="valArr", required=false) String valArr
			,@RequestParam(value="typeArr", required=false) String typeArr) throws Exception {
		ModelAndView modelAndView  = new ModelAndView(); 
		SystemManageVO vo = null; 
		String[] idArray = idArr.split(",");
		String[] valArray = valArr.split(",");
		String[] typeArray = typeArr.split(",");
		 
		for(int i=0; i<idArray.length; i++) {
			vo = new SystemManageVO(); 
			vo.setSys_code(idArray[i]);
			vo.setSys_yn(valArray[i]);
			vo.setSys_type(typeArray[i]);
			itemManageCounterService.systemSaveItem(vo);
		} 
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/itemmanager/getSystemItemInfo.do")
	public ModelAndView getSystemItemInfo(
			@ModelAttribute("systemManageVO") SystemManageVO systemManageVO) throws Exception {
		
		SystemManageVO systemItemInfo = itemManageCounterService.getSystemItemInfo(systemManageVO);
		
		/** 리턴값 설정*/
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("systemItemInfo", systemItemInfo);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 시스템리스트에 항목을 추가
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/systemInsertItem.do")
	public ModelAndView systemInsItem(
			@ModelAttribute("systemManageVO") SystemManageVO systemManageVO) throws Exception {
		ModelAndView modelAndView  = new ModelAndView();
		
		itemManageCounterService.systemInsItem(systemManageVO);
		
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	/**
	 * 시스템리스트 항목 수정
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/systemUpdateItem.do")
	public ModelAndView systemUpdateItem(
			@ModelAttribute("systemManageVO") SystemManageVO systemManageVO) throws Exception {
		ModelAndView modelAndView  = new ModelAndView();
		
		itemManageCounterService.systemUpdateItem(systemManageVO);
		
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	/**
	 * 시스템리스트의 항목을 삭제
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/systemDeleteItem.do")
	public ModelAndView systemDelItem(
			@ModelAttribute("systemManageVO") SystemManageVO systemManageVO) throws Exception {
		ModelAndView modelAndView  = new ModelAndView(); 
		
		itemManageCounterService.systemDelItem(systemManageVO);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 시스템 코드로 그룹에 추가 가능한 그룹 List 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/getGroupAddListItem.do")
	public ModelAndView getGroupAddListItem(
			@ModelAttribute("groupManageVO") GroupManageVO groupManageVO) throws Exception {
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		if (groupManageVO.getPageIndex() == 0)groupManageVO.setPageIndex(1);
		groupManageVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());
		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/** 쿼리 실행*/
		List list = itemManageCounterService.getGroupAddListItem(groupManageVO);
		/** 리턴값 설정*/
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("groupManageVO", groupManageVO);
		modelAndView.addObject("groupList", list);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	/**
	 * 그룹 리스트에 항목을 추가
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/groupInsertItem.do")
	public ModelAndView groupInsItem(
			@ModelAttribute("systemManageVO") GroupManageVO groupManageVO) throws Exception {
		ModelAndView modelAndView  = new ModelAndView(); 
		
		itemManageCounterService.groupInsItem(groupManageVO);
		
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	/**
	 * 그룹 리스트의 항목을 삭제
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/groupDeleteItem.do")
	public ModelAndView groupDelItem(
			@ModelAttribute("systemManageVO") GroupManageVO groupManageVO) throws Exception {
		ModelAndView modelAndView  = new ModelAndView(); 
		
		itemManageCounterService.groupDelItem(groupManageVO);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 아이템 사용여부 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanager/itemUpdateItem.do")
	public ModelAndView itemUpateItem(
			@RequestParam(value="dpynArr", required=false) String dpynArr
			,@RequestParam(value="itemcodeArr", required=false) String itemcodeArr
			,@RequestParam(value="groupcodeArr", required=false) String groupcodeArr
			,@RequestParam(value="syscodeArr", required=false) String syscodeArr) throws Exception {
		ModelAndView modelAndView  = new ModelAndView(); 
		ItemManageVO vo = null; 
		String[] dpynArray = dpynArr.split(",");
		String[] itemcodeArray = itemcodeArr.split(",");
		String[] groupcodeArray = groupcodeArr.split(",");
		String[] syscodeArray = syscodeArr.split(",");
		for(int i=0; i<dpynArray.length; i++) {
			vo = new ItemManageVO(); 
			vo.setDp_yn(dpynArray[i]);
			vo.setItem_code(itemcodeArray[i]);
			vo.setGroup_code(groupcodeArray[i]);
			vo.setSys_code(syscodeArray[i]);
			itemManageCounterService.itemUpdateItem(vo);
		}
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value = "/itemmanage/goItemDefineTake.do")
	public String goIpusnItemDefine(ModelMap model) throws Exception {
		return "itemmanage/itemDefineTake";
	}
	
	@RequestMapping("/itemmanage/getTakItemList.do")
	public ModelAndView getTakeItemList(
			@RequestParam(value="groupCode", required=false) String groupCode
			) throws Exception {
		GroupItemVO groupItemVO = new GroupItemVO();
		groupItemVO.setGroupCode(groupCode);
		List list=itemManageCounterService.getGroupItemList(groupItemVO);
		List itemlist=itemManageCounterService.getItemList(groupItemVO);
		ItemGroupVO itemGroupVO = itemManageCounterService.groupMemo(groupItemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("getGroupItemList",list);
		modelAndView.addObject("groupMemo",itemGroupVO);
		modelAndView.addObject("getItemList",itemlist);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	/**
	 * 국가수질 측정항목 변경 정보 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanage/getItemInfoA.do")
	public ModelAndView getItemInfoA(@ModelAttribute("itemInfoVO") ItemInfoVO itemInfoVO) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();

		if (itemInfoVO.getPageIndex() == 0)
			itemInfoVO.setPageIndex(1);
		/** paging */
		itemInfoVO.setPageUnit(10);
		paginationInfo.setCurrentPageNo(itemInfoVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(itemInfoVO.getPageUnit());
		paginationInfo.setPageSize(itemInfoVO.getPageSize());

		itemInfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		itemInfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
		itemInfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List itemInfoList = itemManageCounterService.getItemInfoA(itemInfoVO);
		int totCnt = itemManageCounterService.getItemInfoACnt(itemInfoVO);
		paginationInfo.setTotalRecordCount(totCnt);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("itemInfoList", itemInfoList);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	/**
	 * 국가수질 측정항목 변경 Merge
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/itemmanage/saveItemInfoA.do")
	public ModelAndView saveItemInfoA(HttpServletResponse res, @RequestParam("itemCode") String itemCode,
			@ModelAttribute("itemInfoVO") ItemInfoVO itemInfoVO
			) throws Exception {
		
		int result  = 0;
		
		String [] sItemCode = itemCode.split(":");
		
		for(int i = 0; i < sItemCode.length; i++){
			itemInfoVO.setItemCode(sItemCode[i]);
			result = itemManageCounterService.saveItemInfoA(itemInfoVO);
		}
		if(result > 0){
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('성공적으로 저장되었습니다.');document.location.href='/itemmanage/goItemDefine.do'</script>");			
		}else{
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('ERROR');document.location.href='/itemmanage/goItemDefine.do'</script>");	
		}
		
		return null;
	}

}