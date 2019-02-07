package daewooInfo.common.code.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.common.code.bean.ResultVO;
import daewooInfo.common.code.bean.SearchVO;
import daewooInfo.common.code.dao.CommonCodeDAO;
import daewooInfo.common.code.service.CommonCodeService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("commonCodeService")
public class CommonCodeServiceImpl extends AbstractServiceImpl implements CommonCodeService {

	/**
	 * @uml.property  name="commonCodeDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="commonCodeDAO")
	private CommonCodeDAO commonCodeDAO;
	
	public List<ResultVO> getCode(SearchVO searchVO) throws Exception{
		return commonCodeDAO.getCode(searchVO); 
	}
	
}
