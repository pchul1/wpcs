package daewooInfo.common.menu.service;

import java.util.List;
import java.util.Map;

import daewooInfo.common.menu.bean.MenuVO;

public interface MenuService {
	
	/**
	 * 헤더 메뉴를 가져온다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    List<MenuVO> selectMenu(MenuVO vo) throws Exception;
    
    List<MenuVO> TreeselectMenu() throws Exception;
    
    MenuVO selectUpperMenuVO(String menuNo) throws Exception;
    
    String selectRoleName(String uniqID) throws Exception;
    
    int checkMenuDepth(String menuNo) throws Exception;
    
    String selectOneChildMenuNo(String menuNo) throws Exception;
    
    String selectTwoChildMenuNo(String menuNo) throws Exception;
    
    List<MenuVO> selectSubMenuUrl(MenuVO vo) throws Exception;
    
    MenuVO selectMenuCheck(MenuVO vo) throws Exception;
    
    Map<String, Object> selectButtonAuth(Map<String, Object> params) throws Exception;
}
