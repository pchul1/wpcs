package daewooInfo.rss.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.rss.bean.RssSearchVO;
import daewooInfo.rss.bean.RssVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 보도자료에 대한 데이터 접근 클래스를 정의한다
 * @author yrkim
 * @since 2014.09.04
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.03  yrkim          최초 생성
 *
 * </pre>
 */
@Repository("RssManageDAO")
public class RssManageDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(RssManageDAO.class);
	
    /**
     * 보도자료 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List rssDataList(RssSearchVO rssSearchVO) throws Exception {
    	return list("RssManageDAO.rssDataList", rssSearchVO);
    }
    
    
    
    /**
     * 보도자료 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int rssDataListCnt(RssSearchVO rssSearchVO) throws Exception {
    	return (Integer)selectByPk("RssManageDAO.rssDataListCnt", rssSearchVO);
    }
    
    /**
     * 보도자료 데이터 목록(엑셀)
     */
    public List<RssSearchVO> rssDataListExcel(RssSearchVO rssSearchVO) throws Exception{
    	return list("RssManageDAO.rssDataListExcel", rssSearchVO);
    }
    
    /**
     * 보도자료 데이터 목록 (페이징)_사용자
     * @param vo
     * @return
     * @throws Exception
     */
    public List rssDataSelect(RssSearchVO rssSearchVO) throws Exception {
    	return list("RssManageDAO.rssDataSelect", rssSearchVO);
    }
    
    /**
     * 보도자료 데이터 목록 카운트_사용자
     * @param vo
     * @return
     * @throws Exception
     */
    public int rssDataSelectCnt(RssSearchVO rssSearchVO) throws Exception {
    	return (Integer)selectByPk("RssManageDAO.rssDataSelectCnt", rssSearchVO);
    }
    
    /**
     * 보도자료 등록
     */
    public void insertRssData(RssVO rssVO) throws Exception{
    	update("RssManageDAO.insertRssData", rssVO);
    }
    
    /**
     * 보도자료 삭제
     */
    public void deleteRssData(RssVO rssVO) throws Exception{
    	update("RssManageDAO.deleteRssData", rssVO);
    }
    
    /**
     * 같은 제목의 보도 자료 여부 확인
     * @param rssVO
     * @return
     * @throws Exception
     */
    public int rssReaderSelect(String checkDate) throws Exception{
    	return (Integer)selectByPk("RssManageDAO.rssReaderSelect", checkDate);
    }
    /**
     * 보도자료 읽어서 DB에 저장
     */
    public void insertRssReader(RssVO rssVO) throws Exception{
    	insert("RssManageDAO.insertRssReader", rssVO);
    }
    
}
