package daewooInfo.stats.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.stats.bean.ThematicMapSearchVO;
import daewooInfo.stats.bean.ThematicMapVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("thematicMapDAO")
public class ThematicMapDAO extends EgovAbstractDAO{
    /**
	 * 사용자별 범례정보 가져오기
	 */
    public List getBermSettingInfo(ThematicMapSearchVO searchVO) throws Exception {
		return list("thematicMapDAO.getBermSettingInfo",searchVO);
	}
    
    /**
	 * 사용자별 범례정보 가져오기
	 */
    public List getBermDataList(ThematicMapSearchVO searchVO) throws Exception {
		return list("thematicMapDAO.getBermDataList",searchVO);
	}
    
    /* 범례정보 저장 */
	public void saveBermSettingInfo(ThematicMapVO thematicMapVO) throws Exception {
		insert("thematicMapDAO.saveBermSettingInfo",thematicMapVO);
	}
	
	/**
	 *  확정전,후 데이터 조회
	 */
	public List<ThematicMapVO> getThematicMapDetail(ThematicMapSearchVO searchVO) throws Exception {
		return list("thematicMapDAO.getThematicMapDetail",searchVO);
	}
	
	/**
	 * FactCode 조회
	 */
	public String getFactCodeValue(String searchSugye) throws Exception {
		return (String)getSqlMapClientTemplate().queryForObject("thematicMapDAO.getFactCodeValue", searchSugye);
	}
}
