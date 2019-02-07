package daewooInfo.common.code.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.common.code.bean.ResultVO;
import daewooInfo.common.code.bean.SearchVO;
import daewooInfo.common.code.service.CommonCodeService;

/**
 * 공통 코드를 가져오는 DAO 클래스
 * @author 공통서비스 DaewooInfo c.y.h
 * @since 2010.05.29
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2010.05.29  최영호          최초 생성 
 *  
 *  </pre>
 */

@Controller
public class CommonCodeController {
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(CommonCodeController.class);
	
    /**
	 * @uml.property  name="commonCodeService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "commonCodeService")
    private CommonCodeService commonCodeService;
	
	@RequestMapping("/common/code/getCode.do")
	public ModelAndView getCode(
			@RequestParam("codeGbn") String codeGbn
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SearchVO srchVO = new SearchVO();
		
		srchVO.setCodeGbn(codeGbn);
		
		List<ResultVO> resultList = (List<ResultVO>)commonCodeService.getCode(srchVO);
		
		modelAndView.addObject("codes", resultList);
		modelAndView.setViewName("jsonView");
				
		return modelAndView;
	}
}
