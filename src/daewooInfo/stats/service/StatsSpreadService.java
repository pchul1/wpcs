package daewooInfo.stats.service;

import java.util.List;

import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsSpreadVO;

/**
 * 상황전파 통계를 내기 위한 서비스 인터페이스 클래스
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
public interface StatsSpreadService {
	
    /**
     * 상황 전파 통계를 가져온다.
     * 
     * @param StatsSearchVO
     */
    List<StatsSpreadVO> getSpreadStatsList(StatsSearchVO vo) throws Exception;
}
