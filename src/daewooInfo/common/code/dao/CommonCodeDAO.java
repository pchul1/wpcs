package daewooInfo.common.code.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.common.code.bean.ResultVO;
import daewooInfo.common.code.bean.SearchVO;
import daewooInfo.common.login.dao.LoginDAO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("commonCodeDAO")
public class CommonCodeDAO extends EgovAbstractDAO{
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(LoginDAO.class);
    
    public List<ResultVO> getCode(SearchVO searchVO) throws Exception {
    	return list("commonCodeDAO.getCode", searchVO);
    }	
}
