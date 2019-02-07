package daewooInfo.common.code.service;

import java.util.List;

import daewooInfo.common.code.bean.ResultVO;
import daewooInfo.common.code.bean.SearchVO;

public interface CommonCodeService {

	List<ResultVO> getCode(SearchVO searchVO) throws Exception;	
	
}
