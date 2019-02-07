package daewooInfo.admin.keyword.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.admin.keyword.bean.KeywordSearchVO;
import daewooInfo.admin.keyword.bean.KeywordVO;
import daewooInfo.admin.keyword.dao.KeywordDAO;
import daewooInfo.admin.keyword.service.KeywordService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("keywordService")
public class KeywordServiceImpl extends AbstractServiceImpl implements KeywordService {

    /**
	 * @uml.property  name="keywordDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="keywordDAO")
    private KeywordDAO keywordDAO;

	public List<KeywordSearchVO> selectKeywordList(KeywordSearchVO searchVO)
			throws Exception {
		return keywordDAO.selectKeywordList(searchVO);	
	}

	public int selectKeywordListTotCnt(KeywordSearchVO searchVO)
			throws Exception {
		return keywordDAO.selectKeywordListTotCnt(searchVO);
	}
	
	public void deleteKeyword(KeywordVO keywordVO) throws Exception {
		keywordDAO.deleteKeyword(keywordVO);
	}

	public KeywordVO selectKeywordDetail(KeywordVO keywordVO) throws Exception {
		return keywordDAO.selectKeywordDetail(keywordVO);
	}


	public void insertKeyword(KeywordVO keywordVO) throws Exception {
		keywordDAO.insertKeyword(keywordVO);
	}

	public void updateKeyword(KeywordVO keywordVO) throws Exception {
		keywordDAO.updateKeyword(keywordVO);
	}

	public List<KeywordSearchVO> selectKeywordCheckList(KeywordSearchVO searchVO)
			throws Exception {
		return keywordDAO.selectKeywordCheckList(searchVO);	
	}

	public int selectKeywordCheckCnt(KeywordVO keywordVO) throws Exception {
		return keywordDAO.selectKeywordCheckCnt(keywordVO);
	}
	
	public List<KeywordVO> rssKeywordSelect()
			throws Exception {
		return keywordDAO.rssKeywordSelect();	
	}
}