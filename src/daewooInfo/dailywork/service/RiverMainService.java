package daewooInfo.dailywork.service;

import daewooInfo.dailywork.bean.RiverMainVO;

/**
 * 
 * 4대강주요수계일지
 * @author yrkim
 * @since 2014.10.10
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.10.10  yrkim          최초 생성
 *
 * </pre>
 */
public interface RiverMainService {
	
	/**
	 * 4대강주요수계일지 등록
	 * @param riverMainVO
	 * @throws Exception
	 */
	public void insertRiverMainInfo(RiverMainVO riverMainVO) throws Exception;
	
	/**
     * 4대강주요수계일지 정보 조회
     */
    public RiverMainVO selectRiverMainInfo(String dailyWorkId) throws Exception;
    
    /**
	 * 4대강주요수계일지 수정
	 * @param riverMainVO
	 * @throws Exception
	 */
	public void updateRiverMainInfo(RiverMainVO riverMainVO) throws Exception;
}
