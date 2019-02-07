package daewooInfo.common.menu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.common.menu.bean.MenuVO;
import daewooInfo.common.menu.dao.MenuDAO;
import daewooInfo.common.menu.service.MenuService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("menuService")
public class MenuServiceImpl extends AbstractServiceImpl implements
        MenuService {

    /**
	 * @uml.property  name="menuDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="menuDAO")
    private MenuDAO menuDAO;

	public List<MenuVO> selectMenu(MenuVO vo) throws Exception {
		
		  
		List<MenuVO> list = menuDAO.selectMenu(vo);
		
		return list;
	}

	public List<MenuVO> TreeselectMenu() throws Exception {
		return menuDAO.TreeselectMenu();
	}
	
	public MenuVO selectUpperMenuVO(String menuNo) throws Exception {
		return (MenuVO)menuDAO.selectUpperMenuVO(menuNo);
	}
	
	public String selectRoleName(String uniqID) throws Exception {
		return (String)menuDAO.selectRoleName(uniqID);
	}

	public int checkMenuDepth(String menuNo) throws Exception {
		int rtnVal = 0;

		Object  result = (Object)menuDAO.checkMenuDepth(menuNo);
		 
		if      (result == null)      { rtnVal = 1; }
		else if ("0".equals(result) ) { rtnVal = 2; }
		else { rtnVal = 3; }
		
		return rtnVal;
	}
	
	public String selectOneChildMenuNo(String menuNo) throws Exception {
		return (String)menuDAO.selectOneChildMenuNo(menuNo);
	}
	
	public String selectTwoChildMenuNo(String menuNo) throws Exception {
		return (String)menuDAO.selectTwoChildMenuNo(menuNo);
	}
	
	//2014-11-03 mypark 최하위 메뉴의 링크를 세팅
	public List<MenuVO> selectSubMenuUrl(MenuVO vo) throws Exception {
		List<MenuVO> list = menuDAO.selectSubMenuUrl(vo);
		return list;
	}
	
	//2014-11-03 mypark 최하위 메뉴의 링크를 세팅
	public MenuVO selectMenuCheck(MenuVO vo) throws Exception {
		return menuDAO.selectMenuCheck(vo);
	}
	
	public Map<String, Object> selectButtonAuth(Map<String, Object> params) throws Exception {
		return menuDAO.selectButtonAuth(params);
	}
}
