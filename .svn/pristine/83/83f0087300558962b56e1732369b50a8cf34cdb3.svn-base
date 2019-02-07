package daewooInfo.admin.keyword.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.admin.keyword.bean.KeywordSearchVO;
import daewooInfo.admin.keyword.bean.KeywordVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("keywordDAO")
public class KeywordDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(KeywordDAO.class);
    
    /**
	 * 키워드 목록을 조회한다.
     * @param searchVO
     * @return List(키워드 목록)
     * @throws Exception
     */
    public List selectKeywordList(KeywordSearchVO searchVO) throws Exception {
        return list("KeywordManageDAO.selectKeywordList", searchVO);
    }
    
    /**
	 * 키워드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(키워드 총 갯수)
     */
    public int selectKeywordListTotCnt(KeywordSearchVO searchVO) throws Exception {
        return (Integer)selectByPk("KeywordManageDAO.selectKeywordListTotCnt", searchVO);
    }
    
    
    /**
	 * 키워드의 상세항목을 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 */
	public KeywordVO selectKeywordDetail(KeywordVO keywordVO) throws Exception {
		return (KeywordVO)selectByPk("KeywordManageDAO.selectKeywordDetail", keywordVO);
	}
    
    /**
	 * 키워드를 등록한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	public void insertKeyword(KeywordVO keywordVO) throws Exception {
        insert("KeywordManageDAO.insertKeyword", keywordVO);
	}

	/**
	 * 키워드를 수정한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	public void updateKeyword(KeywordVO keywordVO) throws Exception {
		update("KeywordManageDAO.updateKeyword", keywordVO);
	}
	  
	/**
	 * 키워드를 삭제한다.
	 * @param keywordVO
	 * @throws Exception
	 */
	public void deleteKeyword(KeywordVO keywordVO) throws Exception {
		delete("KeywordManageDAO.deleteKeyword", keywordVO);
	}
	
    
    /**
	 * 중복된 키워드 목록을 조회한다.
     * @param searchVO
     * @return List(키워드 목록)
     * @throws Exception
     */
    public List selectKeywordCheckList(KeywordSearchVO searchVO) throws Exception {
        return list("KeywordManageDAO.selectKeywordCheckList", searchVO);
    }

    /**
	 * 중복된 키워드가 있는지 체크한다.
     * @param keywordVO
     * @return int(키워드 총 갯수)
     */
    public int selectKeywordCheckCnt(KeywordVO keywordVO) throws Exception {
        return (Integer)selectByPk("KeywordManageDAO.selectKeywordCheckCnt", keywordVO);
    }
    
    /**
     * 키워드 목록 조회
     */
    public List rssKeywordSelect() throws Exception {
        return list("KeywordManageDAO.rssKeywordSelect", "");
    }
    
}
