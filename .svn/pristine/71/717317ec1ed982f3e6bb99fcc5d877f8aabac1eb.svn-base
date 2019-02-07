package daewooInfo.stats.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsSpreadVO;
import daewooInfo.stats.dao.StatsSpreadDAO;
import daewooInfo.stats.service.StatsSpreadService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 상황전파 통계를 내기 위한 서비스 구현 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
@Service("statsSpreadService")
public class StatsSpreadServiceImpl extends AbstractServiceImpl implements StatsSpreadService{

	/**
	 * @uml.property  name="statsSpreadDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "statsSpreadDAO")
	private StatsSpreadDAO statsSpreadDAO;
	
    /**
     * 상황 전파 통계를 가져온다.
     * 
     * @see daewooInfo.stats.service.StatsSpreadService#getSpreadStatsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsSpreadVO> getSpreadStatsList(StatsSearchVO vo) throws Exception {
        return statsSpreadDAO.getSpreadStatsList(vo);
    }		    
		    
}
