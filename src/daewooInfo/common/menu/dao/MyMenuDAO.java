package daewooInfo.common.menu.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.common.menu.bean.MyMenuVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
 


@Repository("MyMenuDAO")
public class MyMenuDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(MenuDAO.class);
    
    public List<MyMenuVO> TreeselectMenu(MyMenuVO myMenuVO) throws Exception {
    	return list("MyMenuDAO.TreeselectMenu", myMenuVO);
    }
    

    public void DeleteMyMenu(MyMenuVO myMenuVO) throws Exception {
    	delete("MyMenuDAO.DeleteMyMenu", myMenuVO);
    }
    

    public void InsertMyMenu(MyMenuVO myMenuVO) throws Exception {
    	insert("MyMenuDAO.InsertMyMenu", myMenuVO);
    }
}
