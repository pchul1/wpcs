package daewooInfo.common.menu.web;

//import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.admin.access.bean.AccessManageVO;
import daewooInfo.admin.access.service.AccessManageService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.menu.bean.MenuVO;
import daewooInfo.common.menu.bean.MyMenuVO;
import daewooInfo.common.menu.service.MenuService;
import daewooInfo.common.menu.service.MyMenuService;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.CommonUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.common.util.sim.ClntInfo;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MenuController {

	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * @uml.property  name="menuService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="menuService")
	MenuService menuService;
	
	/**
	 * AlrimService
	 * @uml.property  name="alrimService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alrimService")
	AlrimService alrimService;

	/** AccessManageService */
	@Resource(name = "accessManageService")
    private AccessManageService accessManageService;

	/**
	 * @uml.property  name="menuService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="MyMenuService")
	MyMenuService myMenuService;
	
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(MenuController.class);
	
	/**
	 * 메인 페이지의 GNB를 가져온다.
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/menu/main_header.do")
	public String mainHeaderMenu(
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model)
			throws Exception {
		
		int clickMenu2 = 0;
		String clickMenu = (String)commandMap.get("clickMenu");
		
		//log.debug("\n\n clickMenu : "+clickMenu);
		if (clickMenu == null) clickMenu = "0";
		
		
		try {
			clickMenu2 = Integer.parseInt(clickMenu);
		} catch (NumberFormatException e) {}
		
		// 클릭한 메뉴가 3단계이면 2단계메뉴를 찾아서 넣어준다.
		//log.debug("\n menuService.checkMenuDepth(clickMenu) "+menuService.checkMenuDepth(clickMenu)+"\n");
		if ( 3 == menuService.checkMenuDepth(clickMenu) ) {
			clickMenu2 = menuService.selectUpperMenuVO(clickMenu).getMenuNo();
		}
		
		// 로그인 되어 있다면..
		if (TmsUserDetailsHelper.isAuthenticated()) {
			
			String roleName = "";
			LoginVO loginVO = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			
			roleName = menuService.selectRoleName(loginVO.getUniqId());
			
			MenuVO bean = new MenuVO();
			bean.setRoleName(roleName);
			bean.setMenuUpperNo(0);
			
			// 권한별 1단계 메뉴
			List<MenuVO> menuList = menuService.selectMenu(bean);
			
			for (int i=0; i < menuList.size(); i++) {
				// 권한별 2단계 메뉴
				bean.setMenuUpperNo(menuList.get(i).getMenuNo());
				List<MenuVO> menuLev2 = menuService.selectMenu(bean);
				
				// 선택했는지 체크
				for (int j=0; j < menuLev2.size(); j++) {
					if ( clickMenu2 == menuLev2.get(j).getMenuNo()) {
						menuList.get(i).setSelected("true");
						break;
					}
				}
				menuList.get(i).setSubMenuList(menuLev2);
			}
			
			model.addAttribute("menuList", menuList);
			
			//2014-09-19 알림 조회 추가 mypark 
			AlrimVO alrimVO = new AlrimVO();
			alrimVO.setAlrimApprovalId(loginVO.getId());
			List<AlrimVO> alrimList = alrimService.selectUnConfirmAlrimList(alrimVO);
			int unConfirmCnt = alrimService.selectUnConfirmAlrimCount(alrimVO);
			model.addAttribute("alrimList", alrimList);
			model.addAttribute("unConfirmCnt", unConfirmCnt);

			
			//2014-09-31 마이메뉴 추가 kys
			MyMenuVO myMenuVO = new MyMenuVO();
			myMenuVO.setMember_id(LogInfoUtil.GetSessionLogin().getId());
			myMenuVO.setRoleName(LogInfoUtil.GetSessionLogin().getRoleCode());
			myMenuVO.setView_mode("Y");
			model.addAttribute("MyMenuList", myMenuService.TreeselectMenu(myMenuVO));
			
			//최종접속일자.
			AccessManageVO accessManageVO = new AccessManageVO();
			accessManageVO.setFirstIndex(0);
			accessManageVO.setRecordCountPerPage(1);
			accessManageVO.setLoginId(loginVO.getId());
			List accessList = accessManageService.selectAccessLoginList(accessManageVO);
	        model.addAttribute("accessList", accessList);
		}
		return "include/main_header";
	}
	
	/**
	 * GNB의 메뉴를 가져온다.
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/menu/header.do")
	public String headerMenu(
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model)
			throws Exception {
		
		int clickMenu2 = 0;
		String clickMenu = (String)commandMap.get("clickMenu");
		
		if (clickMenu == null) {
			clickMenu = (String)request.getSession().getAttribute("clickMenu");
		}
		
		//log.debug("\n\nclickMenu : "+clickMenu);
		if (clickMenu == null) clickMenu = "0";
		
		try {
			clickMenu2 = Integer.parseInt(clickMenu);
		} catch (NumberFormatException e) {}
		
		// 클릭한 메뉴가 3단계이면 2단계메뉴를 찾아서 넣어준다.
		//log.debug("\n menuService.checkMenuDepth(clickMenu) "+menuService.checkMenuDepth(clickMenu)+"\n");
		if ( 3 == menuService.checkMenuDepth(clickMenu) ) {
			clickMenu2 = menuService.selectUpperMenuVO(clickMenu).getMenuNo();
		}
		
		
		
		// 로그인 되어 있다면..
		if (TmsUserDetailsHelper.isAuthenticated()) {
			
			String roleName = "";
			LoginVO loginVO = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			
			roleName = menuService.selectRoleName(loginVO.getUniqId());
			
			MenuVO bean = new MenuVO();
			bean.setRoleName(roleName);
			bean.setMenuUpperNo(0);
			
			// 권한별 1단계 메뉴
			List<MenuVO> menuList = menuService.selectMenu(bean);
			for (int i=0; i < menuList.size(); i++) {
				// 권한별 2단계 메뉴
				bean.setMenuUpperNo(menuList.get(i).getMenuNo());
				//System.out.println("menuUpperNo >>>>>>>>>>>>>>>>> " + menuList.get(i).getMenuNo());
				List<MenuVO> menuLev2 = menuService.selectMenu(bean);
				
				// 선택했는지 체크
				for (int j=0; j < menuLev2.size(); j++) {
					//2014-11-03 mypark 최하위 메뉴의 링크를 세팅
					bean.setMenuUpperNo(menuLev2.get(j).getMenuNo());
					List<MenuVO> menuLev3 = menuService.selectSubMenuUrl(bean);
					for (int k=0; k < menuLev3.size(); k++) {
						bean.setMenuUpperNo(menuLev3.get(k).getMenuNo());
						List<MenuVO> menuLev4 = menuService.selectSubMenuUrl(bean);
						menuLev3.get(k).setUrl(menuLev4.get(0).getUrl());
						menuLev3.get(k).setSubMenuNo(menuLev4.get(0).getMenuNo());
					}
					if(menuLev2.get(j).getMenuNo() != 22000 && menuLev2.get(j).getMenuNo() != 23000) {
						menuLev2.get(j).setUrl(menuLev3.get(0).getUrl());
						menuLev2.get(j).setSubMenuNo(menuLev3.get(0).getSubMenuNo());
					} else {
						menuLev2.get(j).setSubMenuNo(menuLev2.get(j).getMenuNo());
					}
					if ( clickMenu2 == menuLev2.get(j).getMenuNo()) {
						menuList.get(i).setSelected("true");
						break;
					}
				}
				menuList.get(i).setSubMenuNo(menuLev2.get(0).getSubMenuNo());
				menuList.get(i).setUrl(menuLev2.get(0).getUrl());
				menuList.get(i).setSubMenuList(menuLev2);
			}
			
			// 프로그램에 없는 메뉴를 선택했을때를 대비해 세션에 클릭한 메뉴를 저장한다.
			request.getSession().setAttribute("clickMenu", clickMenu);
			
			model.addAttribute("menuList", menuList);
			model.addAttribute("clickMenu", clickMenu);
			
			//2014-09-19 알림 조회 추가 mypark
			AlrimVO alrimVO = new AlrimVO();
			alrimVO.setAlrimApprovalId(loginVO.getId());
			List<AlrimVO> alrimList = alrimService.selectUnConfirmAlrimList(alrimVO);
			int unConfirmCnt = alrimService.selectUnConfirmAlrimCount(alrimVO);
			model.addAttribute("alrimList", alrimList);
			model.addAttribute("unConfirmCnt", unConfirmCnt);

			
			//2014-09-31 마이메뉴 추가 kys
			MyMenuVO myMenuVO = new MyMenuVO();
			myMenuVO.setMember_id(LogInfoUtil.GetSessionLogin().getId());
			myMenuVO.setRoleName(LogInfoUtil.GetSessionLogin().getRoleCode());
			myMenuVO.setView_mode("Y");
			model.addAttribute("MyMenuList", myMenuService.TreeselectMenu(myMenuVO));
			
			//최종접속일자.
			/*AccessManageVO accessManageVO = new AccessManageVO();
			accessManageVO.setFirstIndex(1);
			accessManageVO.setRecordCountPerPage(1);
			accessManageVO.setLoginId(loginVO.getId());
			List<EgovMap> accessList = accessManageService.selectAccessLoginList(accessManageVO);
			if(accessList.size() > 0){
				EgovMap map = accessList.get(0);
				System.out.println(map.get("regDate"));
				model.addAttribute("accessRegdate", map.get("regDate"));
				model.addAttribute("uip", map.get("uip"));
			}*/
			/* 2016-11-24 KANG JI NAM
			 * 위의 로직에서 selectAccessLoginList 쿼리 수행시간이 오래 걸린다.
			 * 단순히 최종접속시간과 사용자IP를 확인하기 위해 해당 쿼리를 
			 * 메뉴 이동할 때마다 수행하는 것은 사이트를 느리게 만드는 것 같음
			 * (해당 쿼리 수행 시간이 waterkorea의 경우 10초가 넘게 걸림.
			*/
			String accessRegdate = CommonUtil.getCurrentDate();
			String clientIp = ClntInfo.getClntIP(request);
			if(accessRegdate != null) model.addAttribute("accessRegdate", accessRegdate);
			if(clientIp != null) model.addAttribute("uip", clientIp);
		}
		
		return "include/header";
	}
	
	/**
	 * LNB 메뉴를 가져온다.
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/menu/left.do")
	public String leftMenu(
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model)
			throws Exception {
		
		int clickMenu2 = 0;
		String clickMenu = (String)commandMap.get("clickMenu");
		String realClickMenu = (String)commandMap.get("clickMenu");
		 
		if (clickMenu == null) {
			clickMenu = (String)request.getSession().getAttribute("clickMenu");
			realClickMenu = (String)request.getSession().getAttribute("clickMenu");
		}
		
		try {
			clickMenu2 = Integer.parseInt(clickMenu);
		} catch (NumberFormatException e) {}
		
		
		if (!clickMenu.substring(3).equals("00")){
			clickMenu = menuService.selectUpperMenuVO(clickMenu).getMenuNo()+"";
			realClickMenu = clickMenu;
		}
		
		int menudepth = menuService.checkMenuDepth(clickMenu);
		
		// 클릭한 메뉴가 3단계이면 2단계메뉴를 찾아서 넣어준다.
		//log.debug("\n menuService.checkMenuDepth(clickMenu) "+menudepth+"\n");
		
		if ( 3 == menudepth ) {
			
			clickMenu2 = menuService.selectUpperMenuVO(clickMenu).getMenuNo();
			clickMenu = menuService.selectUpperMenuVO(clickMenu).getMenuNo()+"";
			
		} else if (2 == menudepth) {
			// 클릭한 메뉴가 2단계이면 3단계의 첫번째 메뉴를 가져온다.
			realClickMenu = menuService.selectOneChildMenuNo(clickMenu); 
		}
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		// 로그인 되어 있다면..
		try {
		if (TmsUserDetailsHelper.isAuthenticated()) {
			
			MenuVO upperMenuVO = null;
			String roleName = "";
			LoginVO loginVO = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			
			roleName = menuService.selectRoleName(loginVO.getUniqId());
		
			if ( !StringUtil.isEmpty(clickMenu) ) {
				// 클릭한 상위메뉴의 정보를 가져온다.(1단계메뉴정보)
				//clickMenu = "210";
				
				upperMenuVO = menuService.selectUpperMenuVO(clickMenu);
			}
			// 권한별 2단계 메뉴
			MenuVO bean = new MenuVO();
			bean.setRoleName(roleName);
			if ( upperMenuVO != null ) {
				bean.setMenuUpperNo(upperMenuVO.getMenuNo());
			}
			
			List<MenuVO> menuList = menuService.selectMenu(bean);
			//System.out.println("%%%%%%%%%%%%%%%%%%%%%%%% " + menuList.size());
			//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			for (int i=0; i < menuList.size(); i++) {
				// 권한별 2단계 메뉴
				bean.setMenuUpperNo(menuList.get(i).getMenuNo());
				List<MenuVO> menuLev2 = menuService.selectMenu(bean);
				//2014-11-03 mypark 최하위 메뉴의 링크를 세팅
				for (int j=0; j < menuLev2.size(); j++) {
					bean.setMenuUpperNo(menuLev2.get(j).getMenuNo());
					List<MenuVO> menuLev3 = menuService.selectSubMenuUrl(bean);					
					if(menuLev2.get(j).getMenuNo() != 22000 && menuLev2.get(j).getMenuNo() != 23000) {
						menuLev2.get(j).setUrl(menuLev3.get(0).getUrl());
						menuLev2.get(j).setSubMenuNo(menuLev3.get(0).getMenuNo());
					} else {
						menuLev2.get(j).setSubMenuNo(22000);
					}
				}
				// 선택했는지 체크
				for (int j=0; j < menuLev2.size(); j++) {
					if ( clickMenu2 == menuLev2.get(j).getMenuUpperNo()) {
						menuList.get(i).setSelected("true");
						break;
					}
				}
				if(menuList.get(i).getMenuNo() != 22000 && menuList.get(i).getMenuNo() != 23000) {
					menuList.get(i).setSubMenuNo(menuLev2.get(0).getSubMenuNo());
					menuList.get(i).setUrl(menuLev2.get(0).getUrl());
				} else {
					menuList.get(i).setSubMenuNo(22000);
				}
				menuList.get(i).setSubMenuList(menuLev2);
			}
			
			if ( upperMenuVO != null ) {
				//model.addAttribute("leftMenuTitle", upperMenuVO.getMenuName());
				model.addAttribute("upperMenuVO", upperMenuVO);
			}
			model.addAttribute("leftMenuList", menuList);
			model.addAttribute("clickMenu", realClickMenu);
			
		}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "include/left";
		
	}
	/**
	 * NAVIGATION 메뉴를 가져온다.
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/menu/navi.do")
	public String NaviMenu(
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model)
			throws Exception {
		
		String clickMenu = (String)commandMap.get("clickMenu");
		String realClickMenu = (String)commandMap.get("clickMenu");
		 
		if (clickMenu == null) {
			clickMenu = (String)request.getSession().getAttribute("clickMenu");
			realClickMenu = (String)request.getSession().getAttribute("clickMenu");
		}
		
		if (!clickMenu.substring(3).equals("00")){ //메뉴가 4depth로 들어올 경우 3depth로 변환 
			realClickMenu = clickMenu;	//4단계메뉴
			
		} else {
		
			int menudepth = menuService.checkMenuDepth(clickMenu);
			
			if ( 3 == menudepth ) {
				realClickMenu = menuService.selectOneChildMenuNo(clickMenu);
				
			} else if (2 == menudepth) {
				// 클릭한 메뉴가 2단계이면 3단계의 첫번째 메뉴를 가져온다.
				realClickMenu = menuService.selectTwoChildMenuNo(clickMenu);
			}
		}
		
		// 로그인 되어 있다면..
		if (TmsUserDetailsHelper.isAuthenticated()) {
			 
			MenuVO upperMenuVO = null;
			String roleName = "";
			LoginVO loginVO = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			
			roleName = menuService.selectRoleName(loginVO.getUniqId());
			
			if ( !StringUtil.isEmpty(realClickMenu) ) {
				upperMenuVO = menuService.selectUpperMenuVO(realClickMenu);
			}
			// 권한별 2단계 메뉴
			MenuVO bean = new MenuVO();
			bean.setRoleName(roleName);
			
			if ( upperMenuVO != null ) {
				bean.setMenuUpperNo(upperMenuVO.getMenuNo());
			}
			
			List<MenuVO> menuList = menuService.selectMenu(bean);
			for (int i=0; i < menuList.size(); i++) {
				// 권한별 2단계 메뉴
				bean.setMenuUpperNo(menuList.get(i).getMenuNo());
				List<MenuVO> menuLev2 = menuService.selectMenu(bean);
				menuList.get(i).setSubMenuList(menuLev2);
			}
			
			if ( upperMenuVO != null ) {
				model.addAttribute("upperMenuVO", upperMenuVO);
			}
			
			//20170818 add by Naturetech(김경환 과장 요청으로 사용자권한별 버튼처리)
			Map<String, Object> buttonAuth = new HashMap<String, Object>();
			Map<String, Object> params = new HashMap<String, Object>();
			if( !StringUtil.isEmpty(realClickMenu) ) {
				params.put("userId", loginVO.getId());
				params.put("menuId", realClickMenu);
				buttonAuth = menuService.selectButtonAuth(params);
			}
			model.addAttribute("buttonAuth", buttonAuth);
			model.addAttribute("naviMenuList", menuList);
			model.addAttribute("naviclickMenu", realClickMenu);
		}
		return "include/navi";
	}
}