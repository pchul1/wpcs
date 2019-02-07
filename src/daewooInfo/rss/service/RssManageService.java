package daewooInfo.rss.service;

import java.util.List;
import java.util.Map;

import daewooInfo.rss.bean.RssSearchVO;
import daewooInfo.rss.bean.RssVO;

/**
 * 
 * 보도자료 관한 서비스 인터페이스 클래스를 정의한다
 * @author yrkim
 * @since 2014.09.04
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.04  yrkim          최초 생성
 *
 * </pre>
 */
public interface RssManageService {
	
	/**
	 * 보도자료 데이터 목록 (페이징)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> rssDataList(RssSearchVO rssSearchVO) throws Exception;
	
	
	/**
	 * 보도자료 데이터 목록 (페이징)_사용자
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> rssDataSelect(RssSearchVO rssSearchVO) throws Exception;
	
	/**
	 * 보도자료 데이터 목록(엑셀)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<RssSearchVO> rssDataListExcel(RssSearchVO rssSearchVO) throws Exception;
	
	/**
	 * 보도자료 등록
	 */
	void insertRssData(RssVO rssVO) throws Exception;
	
	/**
	 * 보도자료 삭제
	 */
	void deleteRssData(RssVO rssVO) throws Exception;
	
	/**
	 * 같은 제목의 보도 자료 여부 확인
	 * @param rssVO
	 * @return
	 * @throws Exception
	 */
	int rssReaderSelect(String checkDate) throws Exception;
	
	/**
	 * 보도자료 읽어서 DB저장
	 */
	void insertRssReader(RssVO rssVO) throws Exception;
}
