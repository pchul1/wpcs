package daewooInfo.rss.service;

import java.util.List;

import daewooInfo.rss.bean.RssKeywordSearchVO;
import daewooInfo.rss.bean.RssKeywordVO;

public interface RssKeywordService {

	/**
	 * 키워드의 목록을 조회한다.
	 * @param searchVO
	 * @return List(유저 목록)
	 * @throws Exception
	 */
	List<RssKeywordSearchVO> selectKeywordList(RssKeywordSearchVO searchVO) throws Exception;
	
	/**
	 * 키워드의 총 갯수를 조회한다.
	 * @param searchVO
	 * @return int(유저 총 갯수)
	 */
	int selectKeywordListTotCnt(RssKeywordSearchVO keywordVO) throws Exception;
	
	/**
	 * 키워드를 삭제한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	void deleteKeyword(RssKeywordVO keywordVO) throws Exception;
	
	/**
	 * 키워드를 등록한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	void insertKeyword(RssKeywordVO keywordVO) throws Exception;

	/**
	 * 키워드의 상세항목을 조회한다.
	 * @param keywordVO
	 * @return MemberVO
	 * @throws Exception
	 */
	RssKeywordVO selectKeywordDetail(RssKeywordVO keywordVO) throws Exception;
	
	/**
	 * 키워드를 수정한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	void updateKeyword(RssKeywordVO keywordVO) throws Exception;
	
	
	/**
	 * 중복된 키워드의 목록을 조회한다.
	 * @param searchVO
	 * @return List(유저 목록)
	 * @throws Exception
	 */
	List<RssKeywordSearchVO> selectKeywordCheckList(RssKeywordSearchVO searchVO) throws Exception;
	
	
	/**
	 * 중복된 키워드가 있는지 체크한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	int selectKeywordCheckCnt(RssKeywordVO keywordVO) throws Exception;
}