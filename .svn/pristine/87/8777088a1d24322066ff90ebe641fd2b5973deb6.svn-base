package daewooInfo.admin.keyword.service;

import java.util.List;

import daewooInfo.admin.keyword.bean.KeywordSearchVO;
import daewooInfo.admin.keyword.bean.KeywordVO;

public interface KeywordService {

	/**
	 * 키워드의 목록을 조회한다.
	 * @param searchVO
	 * @return List(유저 목록)
	 * @throws Exception
	 */
	List<KeywordSearchVO> selectKeywordList(KeywordSearchVO searchVO) throws Exception;
	
	/**
	 * 키워드의 총 갯수를 조회한다.
	 * @param searchVO
	 * @return int(유저 총 갯수)
	 */
	int selectKeywordListTotCnt(KeywordSearchVO keywordVO) throws Exception;
	
	/**
	 * 키워드를 삭제한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	void deleteKeyword(KeywordVO keywordVO) throws Exception;
	
	/**
	 * 키워드를 등록한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	void insertKeyword(KeywordVO keywordVO) throws Exception;

	/**
	 * 키워드의 상세항목을 조회한다.
	 * @param keywordVO
	 * @return MemberVO
	 * @throws Exception
	 */
	KeywordVO selectKeywordDetail(KeywordVO keywordVO) throws Exception;
	
	/**
	 * 키워드를 수정한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	void updateKeyword(KeywordVO keywordVO) throws Exception;
	
	
	/**
	 * 중복된 키워드의 목록을 조회한다.
	 * @param searchVO
	 * @return List(유저 목록)
	 * @throws Exception
	 */
	List<KeywordSearchVO> selectKeywordCheckList(KeywordSearchVO searchVO) throws Exception;
	
	
	/**
	 * 중복된 키워드가 있는지 체크한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	int selectKeywordCheckCnt(KeywordVO keywordVO) throws Exception;
	
	/**
	 * 키워드 목록 조회
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	List<KeywordVO> rssKeywordSelect() throws Exception;
}