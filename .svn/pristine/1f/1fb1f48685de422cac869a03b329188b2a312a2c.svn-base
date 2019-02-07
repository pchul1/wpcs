package daewooInfo.rss.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.rss.bean.RssKeywordSearchVO;
import daewooInfo.rss.bean.RssKeywordVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("rssKeywordDAO")
public class RssKeywordDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(RssKeywordDAO.class);
    
    /**
	 * 키워드 목록을 조회한다.
     * @param searchVO
     * @return List(키워드 목록)
     * @throws Exception
     */
    public List selectKeywordList(RssKeywordSearchVO searchVO) throws Exception {
        return list("RssKeywordManageDAO.selectKeywordList", searchVO);
    }
    
    /**
	 * 키워드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(키워드 총 갯수)
     */
    public int selectKeywordListTotCnt(RssKeywordSearchVO searchVO) throws Exception {
        return (Integer)selectByPk("RssKeywordManageDAO.selectKeywordListTotCnt", searchVO);
    }
    
    
    /**
	 * 키워드의 상세항목을 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 */
	public RssKeywordVO selectKeywordDetail(RssKeywordVO keywordVO) throws Exception {
		return (RssKeywordVO)selectByPk("RssKeywordManageDAO.selectKeywordDetail", keywordVO);
	}
    
    /**
	 * 키워드를 등록한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	public void insertKeyword(RssKeywordVO keywordVO) throws Exception {
        insert("RssKeywordManageDAO.insertKeyword", keywordVO);
	}

	/**
	 * 키워드를 수정한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	public void updateKeyword(RssKeywordVO keywordVO) throws Exception {
		update("RssKeywordManageDAO.updateKeyword", keywordVO);
	}
	  
	/**
	 * 키워드를 삭제한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	public void deleteKeyword(RssKeywordVO keywordVO) throws Exception {
		delete("RssKeywordManageDAO.deleteKeyword", keywordVO);
	}
	
    
    /**
	 * 중복된 키워드 목록을 조회한다.
     * @param searchVO
     * @return List(키워드 목록)
     * @throws Exception
     */
    public List selectKeywordCheckList(RssKeywordSearchVO searchVO) throws Exception {
        return list("RssKeywordManageDAO.selectKeywordCheckList", searchVO);
    }

    /**
	 * 중복된 키워드가 있는지 체크한다.
     * @param keywordVO
     * @return int(키워드 총 갯수)
     */
    public int selectKeywordCheckCnt(RssKeywordVO keywordVO) throws Exception {
        return (Integer)selectByPk("RssKeywordManageDAO.selectKeywordCheckCnt", keywordVO);
    }
    
    /**
     * 키워드 목록 조회
     */
    public List rssKeywordSelect() throws Exception {
        return list("RssKeywordManageDAO.rssKeywordSelect", "");
    }
}
