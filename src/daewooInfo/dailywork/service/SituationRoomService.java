package daewooInfo.dailywork.service;

import java.util.Map;
import java.util.List;

import daewooInfo.dailywork.bean.DailyWorkSearchVO;
import daewooInfo.dailywork.bean.SituationRoomVO;

/**
 * 
 * 상황실 근무일지
 * @author yrkim
 * @since 2014.09.24
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.24  yrkim          최초 생성
 *
 * </pre>
 */
public interface SituationRoomService {
	
	/**
	 * 상황실 근무일지 등록
	 * @param situationRoomVO
	 * @throws Exception
	 */
	public void insertSituationRoomInfo(SituationRoomVO situationRoomVO) throws Exception;
	
	/**
	 * 상황전파 현황 저장
	 */
	public void insertSituationSpreadInfo(SituationRoomVO situationRoomVO) throws Exception;
	
	/**
	 * 상황전파 현황 삭제
	 */
	public int deleteSituationSpreadInfo(String dailyWorkId) throws Exception;
	
	/**
     * 상황실 근무일지 근무상황
     */
    public SituationRoomVO selectSituationRoomInfo(String dailyWorkId) throws Exception; 
    
    /**
	 * 상황실 근무일지 수정
	 * @param situationRoomVO
	 * @throws Exception
	 */
	public void updateSituationRoomInfo(SituationRoomVO situationRoomVO) throws Exception;
	
	/**
	 * 상황전파 현황
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<SituationRoomVO> selectSituationSpreadInfo(SituationRoomVO situationRoomVO) throws Exception;
}
