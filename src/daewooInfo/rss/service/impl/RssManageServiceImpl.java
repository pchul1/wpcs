package daewooInfo.rss.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.common.util.fcc.DateUtil;
import daewooInfo.rss.bean.RssSearchVO;
import daewooInfo.rss.bean.RssVO;
import daewooInfo.rss.dao.RssManageDAO;
import daewooInfo.rss.service.RssManageService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 
 * 보도자료 대한 서비스 구현클래스를 정의한다
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

@Service("RssManageService")
public class RssManageServiceImpl extends AbstractServiceImpl implements RssManageService {

    /**
	 * @uml.property  name="rssManageDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="RssManageDAO")
    private RssManageDAO rssManageDAO;
    
    /**
     * 보도자료 목록(페이징)
     */
    public Map<String, Object> rssDataList(RssSearchVO rssSearchVO) throws Exception {
    	List<RssSearchVO> result = rssManageDAO.rssDataList(rssSearchVO);

    	int cnt = rssManageDAO.rssDataListCnt(rssSearchVO);

    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("resultList", result);
    	map.put("resultCnt", Integer.toString(cnt));

    	return map;
    }
    
    /**
     * 보도자료 목록(페이징)_사용자
     */
    public Map<String, Object> rssDataSelect(RssSearchVO rssSearchVO) throws Exception {
    	List<RssSearchVO> result = rssManageDAO.rssDataSelect(rssSearchVO);

    	int cnt = rssManageDAO.rssDataSelectCnt(rssSearchVO);

    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("resultList", result);
    	map.put("resultCnt", Integer.toString(cnt));

    	return map;
    }
    
    /**
     * 보도자료 목록(엑셀)
     */
    public List<RssSearchVO> rssDataListExcel(RssSearchVO rssSearchVO) throws Exception{
    	
    	List<RssSearchVO> result = rssManageDAO.rssDataListExcel(rssSearchVO);    	
    	
    	return result;
    }
    
    /**
     * 보도자료 등록
     */
    public void insertRssData(RssVO rssVO) throws Exception {
    	rssManageDAO.insertRssData(rssVO);    	
    }
    
    /**
     * 보도자료 삭제
     */
    public void deleteRssData(RssVO rssVO) throws Exception {
    	rssManageDAO.deleteRssData(rssVO);    	
    }
    
    /**
     * 같은 제목의 보도 자료 여부 확인
     */
    public int rssReaderSelect(String checkDate) throws Exception {
    	int cnt = rssManageDAO.rssReaderSelect(checkDate);  
    	
    	return cnt;
    }
    
    /**
     * 보도자료 읽어서 DB에 저장
     */
    public void insertRssReader(RssVO rssVO) throws Exception {
    	rssManageDAO.insertRssReader(rssVO);    	
    }
}
