package daewooInfo.rss.service.impl;

import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

import daewooInfo.rss.bean.RssVO;
import daewooInfo.rss.dao.RssKeywordDAO;
import daewooInfo.rss.dao.RssManageDAO;

public class RssTest {

private static Log log = LogFactory.getLog(RssReaderSchdlrImpl.class);
	private static RssKeywordDAO rssKeywordDAO;
	private static RssManageDAO rssManageDAO;
	public void setRssKeywordDAO(RssKeywordDAO rssKeywordDAO){
		this.rssKeywordDAO = rssKeywordDAO;
	}
	public void setRssManageDAO(RssManageDAO rssManageDAO){
		this.rssManageDAO = rssManageDAO;
	}
	
	private int count = 0;
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
				rssReader();
		}catch(Exception e){
			e.printStackTrace();
			log.error(" RssReaderSchdlrImpl 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
	}

	/**
	 * 보도자료 조회
	 * 
	 */
	@SuppressWarnings("unchecked")
	private static void rssReader () throws Exception{	
		try {
			RssVO rssVO = new RssVO();
			//ApplicationContext context = new ClassPathXmlApplicationContext("egovframework/spring/context-*.xml");
			//ManageMaterialService service = (ManageMaterialService)context.getBean("ManageMaterialService");

			//List<RssKeywordVO> rssKeyword = rssKeywordDAO.rssKeywordSelect();
			String[] arrStr = {"방제훈련"};
			
			String keyword = "";
			//for(int i=0; i<rssKeyword.size(); i++){
				//if(i==0){
				//	keyword = rssKeyword.get(i).getKeywordNm();
				//}else{
					//keyword = keyword+"+"+rssKeyword.get(i).getKeywordNm();
				//}
					//System.out.println("keyword >> " + keyword);
			//}
			
			
//			if(!keyword.equals("")){
			/*String checkDate = "";
			
			DecimalFormat df = new DecimalFormat("00");
			Calendar currentCalendar = Calendar.getInstance();
			//현재 날짜 구하기
			String year   = Integer.toString(currentCalendar.get(Calendar.YEAR));
			String month  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
			String day   = df.format(currentCalendar.get(Calendar.DATE));
			checkDate = year+month+day;
			
			System.out.println("checkdate >>>> " + checkDate);*/
			//int cnt = rssManageDAO.rssReaderSelect(checkDate);
			
			//타이틀이 같은 경우는 저장 하지 않음
			//if(cnt == 0){
				for(int i=0; i<arrStr.length; i++){
					
					//String rssFeedUrl = "http://newssearch.naver.com/search.naver?where=rss&query="+rssKeyword.get(i).getKeywordNm()+"&st=news.all&q_enc=EUC-KR&r_enc=UTF-8&r_format=xml&rp=none&sm=all.basic&ic=all&so=rel.dsc&detail=0&pd=1&start=1&display=50";
					String rssFeedUrl = "http://newssearch.naver.com/search.naver?where=rss&query="+arrStr[i]+"&field=0";
					
					URL feedUrl = new URL(rssFeedUrl);
					SyndFeedInput input = new SyndFeedInput();
					SyndFeed feed = input.build(new XmlReader(feedUrl));
					List<SyndEntry> entries = feed.getEntries();
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
					
					for(int j=0; j<entries.size(); j++){
						SyndEntry entry = null;
						
						entry = entries.get(j);
						
						rssVO.setAuthor(entry.getAuthor());
						rssVO.setTitle(entry.getTitle());
						rssVO.setDescription(entry.getDescription().getValue());
						rssVO.setUrl(entry.getUri());
						rssVO.setPublisheddate(sdf.format(entry.getPublishedDate()));
						
						//rssManageDAO.insertRssReader(rssVO);
						
						//System.out.println(rssVO.getAuthor());
						//System.out.println(rssVO.getTitle());
						//System.out.println(rssVO.getDescription());
						//System.out.println(rssVO.getUrl());
						//System.out.println(rssVO.getPublisheddate());
						//System.out.println(rssVO.getAuthor().length());
						//System.out.println(rssVO.getTitle().length());
						//System.out.println(rssVO.getDescription().length());
						//System.out.println(rssVO.getUrl().length());
						//System.out.println(rssVO.getPublisheddate().length());
						
					}
				}
			//}
//			}	
		} catch(Exception e){
			e.printStackTrace();
			log.error(" RssReaderSchdlrImpl 스케줄러 rssReader() 에러 : " + e.getMessage());
		}
	}
}
