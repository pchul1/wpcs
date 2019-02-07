package daewooInfo.common.menu.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.common.menu.bean.MenuVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
 


@Repository("menuDAO")
public class MenuDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(MenuDAO.class);
    
    public List<MenuVO> selectMenu(MenuVO bean) throws Exception {
    	return list("menuDAO.selectMenu", bean);
    }
    
    public List<MenuVO> TreeselectMenu() throws Exception {
    	return list("menuDAO.TreeselectMenu", null);
    }
    
    
    public MenuVO selectUpperMenuVO(String menuNo) throws Exception {
    	return (MenuVO)selectByPk("menuDAO.selectUpperMenuVO", menuNo);
    }
    
    public Object selectRoleName(String uniqID) throws Exception {
    	return selectByPk("menuDAO.selectRoleName", uniqID);
    }
    
    public Object checkMenuDepth(String menuNo) throws Exception {
    	return selectByPk("menuDAO.checkMenuDepth",menuNo);
    }
    
    public Object selectOneChildMenuNo(String menuNo) throws Exception {
    	return selectByPk("menuDAO.selectOneChildMenuNo", menuNo);
    }
    
    public Object selectTwoChildMenuNo(String menuNo) throws Exception {
    	return selectByPk("menuDAO.selectTwoChildMenuNo", menuNo);
    }
    
    //2014-11-03 mypark 최하위 메뉴의 링크를 세팅
    public List<MenuVO> selectSubMenuUrl(MenuVO bean) throws Exception {
    	return list("menuDAO.selectSubMenuUrl", bean);
    }
    
    public MenuVO selectMenuCheck(MenuVO bean) throws Exception {
    	return (MenuVO)selectByPk("menuDAO.selectMenuCheck", bean);
    }
    
    @SuppressWarnings("unchecked")
	public Map<String, Object> selectButtonAuth(Map<String, Object> params) throws Exception {
    	return (Map<String, Object>)getSqlMapClientTemplate().queryForObject("menuDAO.selectButtonAuth", params);
    }
}
