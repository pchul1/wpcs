package daewooInfo.rss.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.rss.bean.RssKeywordSearchVO;
import daewooInfo.rss.bean.RssKeywordVO;
import daewooInfo.rss.dao.RssKeywordDAO;
import daewooInfo.rss.service.RssKeywordService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("rssKeywordService")
public class RssKeywordServiceImpl extends AbstractServiceImpl implements RssKeywordService {

    /**
	 * @uml.property  name="rssKeywordDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="rssKeywordDAO")
    private RssKeywordDAO rssKeywordDAO;

	public List<RssKeywordSearchVO> selectKeywordList(RssKeywordSearchVO searchVO)
			throws Exception {
		return rssKeywordDAO.selectKeywordList(searchVO);	
	}

	public int selectKeywordListTotCnt(RssKeywordSearchVO searchVO)
			throws Exception {
		return rssKeywordDAO.selectKeywordListTotCnt(searchVO);
	}
	
	public void deleteKeyword(RssKeywordVO keywordVO) throws Exception {
		rssKeywordDAO.deleteKeyword(keywordVO);
	}

	public RssKeywordVO selectKeywordDetail(RssKeywordVO keywordVO) throws Exception {
		return rssKeywordDAO.selectKeywordDetail(keywordVO);
	}


	public void insertKeyword(RssKeywordVO keywordVO) throws Exception {
		rssKeywordDAO.insertKeyword(keywordVO);
	}

	public void updateKeyword(RssKeywordVO keywordVO) throws Exception {
		rssKeywordDAO.updateKeyword(keywordVO);
	}

	public List<RssKeywordSearchVO> selectKeywordCheckList(RssKeywordSearchVO searchVO)
			throws Exception {
		return rssKeywordDAO.selectKeywordCheckList(searchVO);	
	}

	public int selectKeywordCheckCnt(RssKeywordVO keywordVO) throws Exception {
		return rssKeywordDAO.selectKeywordCheckCnt(keywordVO);
	}
}