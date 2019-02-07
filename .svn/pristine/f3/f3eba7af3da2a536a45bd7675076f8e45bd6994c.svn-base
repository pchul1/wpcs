package daewooInfo.stats.service;

import java.util.List;

import daewooInfo.stats.bean.ThematicMapSearchVO;
import daewooInfo.stats.bean.ThematicMapVO;

public interface ThematicMapService {
	/**
	 * 사용자별 범례정보 가져오기
	 */
	List getBermSettingInfo(ThematicMapSearchVO searchVO) throws Exception;
	
	/**
	 *  범례정보 저장 
	 */
	void saveBermSettingInfo(ThematicMapVO thematicMapVO) throws Exception;
	
	/**
	 *  확정전,후 데이터 조회
	 */
	List<ThematicMapVO> getThematicMapDetail(ThematicMapSearchVO searchVO) throws Exception;
	
	/**
	 * FactCode 조회
	 */
	String getFactCodeValue(String searchSugye) throws Exception;
	
	/**
	 * 사용자별 범례정보 가져오기
	 */
	List getBermDataList(ThematicMapSearchVO searchVO) throws Exception;
}
