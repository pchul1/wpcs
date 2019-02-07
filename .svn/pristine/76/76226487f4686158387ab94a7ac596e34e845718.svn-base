package daewooInfo.mobile.warehouse.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.mobile.com.service.MobileCommonCodeService;
import daewooInfo.warehouse.bean.ItemCodeSearchVO;
import daewooInfo.warehouse.bean.ItemCodeVO;
import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.warehouse.service.WareHouseManageService;

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
public class MobileWareHouseController {

	/**
	 * 공통 코드 서비스
	 */
    @Resource(name="MobileCommonCodeService")
    private MobileCommonCodeService mobileCommonCodeService;
    
	/**
	 * @uml.property  name="wareHouseManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "WareHouseManageService")
	private WareHouseManageService wareHouseManageService;

	/**
	 * 방제물품 창고 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/warehouse/ware/waresearch.do")
	public String warehousesearch(WareHouseSearchVO wareHouseSearchVO, ModelMap model) throws Exception {
		return "/mobile/sub/warehouse/ware/waresearch";
	}
	
	/**
	 * 방제물품 창고 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/warehouse/ware/warelist.do")
	public String wareHouseList(WareHouseSearchVO wareHouseSearchVO, ModelMap model) throws Exception {
		wareHouseSearchVO.setFirstIndex(0);
		wareHouseSearchVO.setRecordCountPerPage(100000);
		
		List<WareHouseSearchVO> list = wareHouseManageService.getSearchWareHouseList(wareHouseSearchVO);

		model.addAttribute("List", list);
		model.addAttribute("sugyeName", mobileCommonCodeService.getCodeName("01", wareHouseSearchVO.getRiverDiv()));
		model.addAttribute("WhName", mobileCommonCodeService.getWarehouseName(wareHouseSearchVO.getWhCode()));  
		model.addAttribute("param_s", wareHouseSearchVO);
		return "/mobile/sub/warehouse/ware/warelist";
	}

	/**
	 * 방제물품 창고 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/warehouse/ware/wareview.do")
	public String warehouseview(WareHouseSearchVO wareHouseSearchVO, ModelMap model) throws Exception {
		wareHouseSearchVO.setFirstIndex(0);
		wareHouseSearchVO.setRecordCountPerPage(100000);
		
		List<WareHouseSearchVO> list= wareHouseManageService.getSearchWareHouseList(wareHouseSearchVO);
		
		WareHouseSearchVO View = new WareHouseSearchVO(); 
		if(list != null) View = list.get(0);

		model.addAttribute("View", View);
		model.addAttribute("param_s", wareHouseSearchVO);
		return "/mobile/sub/warehouse/ware/wareview";
	}

	/**
	 * 방제물품 창고 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/warehouse/ware/waremap.do")
	public String warehousemap(WareHouseSearchVO wareHouseSearchVO, ModelMap model) throws Exception {
		wareHouseSearchVO.setFirstIndex(0);
		wareHouseSearchVO.setRecordCountPerPage(100000);
		
		List<WareHouseSearchVO> list= wareHouseManageService.getSearchWareHouseList(wareHouseSearchVO);
		
		WareHouseSearchVO View = new WareHouseSearchVO(); 
		if(list != null) View = list.get(0);

		model.addAttribute("View", View);
		model.addAttribute("param_s", wareHouseSearchVO);
		model.addAttribute("param_s", wareHouseSearchVO);
		return "/mobile/sub/warehouse/ware/waremap";
	}

	/**
	 * 방제물품 창고 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/warehouse/item/itemsearch.do")
	public String itemsearch(ItemCodeSearchVO itemCodeSearchVO, ModelMap model) throws Exception {
		return "/mobile/sub/warehouse/item/itemsearch";
	}
	
	/**
	 * 방제물품 창고 관리 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/warehouse/item/itemlist.do")
	public String itemlist(ItemCodeSearchVO itemCodeSearchVO, ModelMap model) throws Exception {
		itemCodeSearchVO.setFirstIndex(0);
		itemCodeSearchVO.setRecordCountPerPage(100000);
		
		List<ItemCodeVO> list = wareHouseManageService.getSearchItemStockList(itemCodeSearchVO);
		
		model.addAttribute("List", list);
		model.addAttribute("sugyeName", mobileCommonCodeService.getCodeName("01", itemCodeSearchVO.getRiverDiv()));
		model.addAttribute("WhName", mobileCommonCodeService.getWarehouseName(itemCodeSearchVO.getWhCode()));  
		model.addAttribute("param_s", itemCodeSearchVO);
		return "/mobile/sub/warehouse/item/itemlist";
	}
}