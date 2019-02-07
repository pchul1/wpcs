package daewooInfo.rss.service.impl;

import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

import daewooInfo.common.util.CommonUtil;
import daewooInfo.rss.bean.RssKeywordVO;
import daewooInfo.rss.bean.RssVO;
import daewooInfo.rss.dao.RssKeywordDAO;
import daewooInfo.rss.dao.RssManageDAO;

/**
 * 2014.09.17
 * @author yrkim
 *
 */

public class RssReaderSchdlrImpl extends QuartzJobBean { 
	
	private static Log log = LogFactory.getLog(RssReaderSchdlrImpl.class);
	
	private RssKeywordDAO rssKeywordDAO;
	
	private RssManageDAO rssManageDAO;
	
	public void setRssKeywordDAO(RssKeywordDAO rssKeywordDAO){
		this.rssKeywordDAO = rssKeywordDAO;
	}
	
	public void setRssManageDAO(RssManageDAO rssManageDAO){
		this.rssManageDAO = rssManageDAO;
	}
	
	//private int count = 0;
	
	public RssReaderSchdlrImpl() {}
    
	/**
	 * 
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("############################################Start RssReader by Scheduler!###########################################");
		
		try {
			//if(count == 0) {
				rssReader();
			//}
		}catch(Exception e){
			e.printStackTrace();
			log.error(" RssReaderSchdlrImpl 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
		//count ++;
		
	}	
	
	/**
	 * 보도자료 조회
	 * 
	 */
	private void rssReader () throws Exception{	
		try {
			//System.out.println("###################### 보도자료 시작 ####################");
			RssVO rssVO = new RssVO();
			
			List<RssKeywordVO> rssKeyword = rssKeywordDAO.rssKeywordSelect();
			
//			String keyword = "";
//			for(int i=0; i<rssKeyword.size(); i++){
//				if(i==0){
//					keyword = rssKeyword.get(i).getKeywordNm();
//				}else{
//					keyword = keyword+"+"+rssKeyword.get(i).getKeywordNm();
//				}
//			}
			
//			if(!keyword.equals("")){
			
			//현재 날짜 구하기
			String checkDate = CommonUtil.getCurrentDate("yyyyMMdd");
			
//			System.out.println("RssReader checkData >>>> " + checkDate);
			
			// 오늘 날짜에 등록된 기사 카운트
			int cnt = rssManageDAO.rssReaderSelect(checkDate);
			
//			System.out.println("RssReader cnt >>>> " + cnt);
			// 오늘 등록된 게시글이 있다면 수행하지 않음
			if(cnt == 0){
//				System.out.println("RssReader keyword size >>>> " + rssKeyword.size());
				for(int i=0; i<rssKeyword.size(); i++){
					//System.out.println("keyword >>>>> " + rssKeyword.get(i).getKeywordNm());
					//System.out.println("keyword >>>>> " + new String(rssKeyword.get(i).getKeywordNm().getBytes("euc-kr"), "utf-8"));
					//System.out.println("keyword >>>>> " + new String(rssKeyword.get(i).getKeywordNm().getBytes("utf-8"), "euc-kr"));
					//System.out.println("keyword >>>>> " + new String(rssKeyword.get(i).getKeywordNm().getBytes("utf-8"), "ksc5601"));
					//String rssFeedUrl = "http://newssearch.naver.com/search.naver?where=rss&query="+rssKeyword.get(i).getKeywordNm()+"&st=news.all&q_enc=EUC-KR&r_enc=UTF-8&r_format=xml&rp=none&sm=all.basic&ic=all&so=rel.dsc&detail=0&pd=1&start=1&display=50";
					String rssFeedUrl = "http://newssearch.naver.com/search.naver?where=rss&query="+rssKeyword.get(i).getKeywordNm()+"&field=0";
					//System.out.println("rssURL >>> " + rssFeedUrl);
					URL feedUrl = new URL(rssFeedUrl);
//					System.out.println("feedUrl >>> " + feedUrl);
					SyndFeedInput input = new SyndFeedInput();
//					System.out.println("input >>> " + input);
					SyndFeed feed = input.build(new XmlReader(feedUrl));
//					System.out.println("feed >>> " + feed);
					List<SyndEntry> entries = feed.getEntries();
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
//					System.out.println("Rss entry size >>> " + entries.size());
					for(int j=0; j<entries.size(); j++){
						SyndEntry entry = null;
						
						entry = entries.get(j);
						
						if(entry.getTitle().indexOf(rssKeyword.get(i).getKeywordNm()) > 0 || entry.getDescription().getValue().indexOf(rssKeyword.get(i).getKeywordNm()) > 0) {
						
							rssVO.setAuthor(entry.getAuthor());
							rssVO.setTitle(entry.getTitle());
							rssVO.setDescription(entry.getDescription().getValue());
							rssVO.setUrl(entry.getUri());
							rssVO.setPublisheddate(sdf.format(entry.getPublishedDate()));
							
							//System.out.println("entry author >>>> " + entry.getAuthor());
							//System.out.println("entry title >>>> " + entry.getTitle());
							//System.out.println("entry value >>>> " + entry.getDescription().getValue());
							//System.out.println("entry uri >>>> " + entry.getUri());
							//System.out.println("entry date >>>> " + sdf.format(entry.getPublishedDate()));
							
							rssManageDAO.insertRssReader(rssVO);
						}
					}
				}
			}
//			}	
		} catch(Exception e){
			e.printStackTrace();
			log.error(" RssReaderSchdlrImpl 스케줄러 rssReader() 에러 : " + e.getMessage());
		}
	}
}