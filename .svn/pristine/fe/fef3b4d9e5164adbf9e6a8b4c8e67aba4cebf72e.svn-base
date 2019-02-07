package daewooInfo.seminar.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.dao.AlrimDAO;
import daewooInfo.seminar.bean.SeminarEntryVO;
import daewooInfo.seminar.bean.SeminarVO;
import daewooInfo.seminar.dao.SeminarDAO;

/**
 * 2014.10.24
 * @author myarpk
 *
 */

public class SeminarSchdlrImpl extends QuartzJobBean { 
	
	private static Log log = LogFactory.getLog(SeminarSchdlrImpl.class);
	
	private SeminarDAO seminarDAO;
	private AlrimDAO alrimDAO;
	
	public void setSeminarDAO(SeminarDAO seminarDAO){
		this.seminarDAO = seminarDAO;
	}
	
	public void setAlrimDAO(AlrimDAO alrimDAO){
		this.alrimDAO = alrimDAO;
	}
	
	private int count = 0;
		
	public SeminarSchdlrImpl() {}
    
	/**
	 * 
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {
		log.debug("Start Seminar by Scheduler!");		
		try {
			if(count == 0) {
				seminarAlrim();
			}
		}catch(Exception e){
			e.printStackTrace();
			log.error(" SeminarSchdlrImpl 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
		count ++;
	}
	
	/**
	 * 교육 알림
	 * 
	 */
	private void seminarAlrim (){	
		try {
			
			SeminarVO seminarVO = new SeminarVO();
			AlrimVO alrimVO = new AlrimVO();
			
			List<SeminarVO> seminarInfoList = seminarDAO.selectSeminarInfoAlrimCheck(seminarVO);
			
			for(int i=0; i<seminarInfoList.size(); i++){
				seminarVO.setSeminarId(seminarInfoList.get(i).getSeminarId());
				List<SeminarEntryVO> seminarEntryList = seminarDAO.selectSeminarEntryAlrimCheck(seminarVO);
				int entryCount = seminarEntryList.size();
				// 참여자가 있는 경우 교육 알림 
				if(entryCount > 0) {
					String seminarDate = seminarInfoList.get(i).getSeminarDate()+" "+seminarInfoList.get(i).getSeminarTimeFrom()+"~" + seminarInfoList.get(i).getSeminarTimeTo();
					String title = "["+seminarDate+"]" + seminarInfoList.get(i).getSeminarTitle();
					alrimVO.setAlrimGubun("S");
			    	alrimVO.setAlrimTitle(title);
			    	alrimVO.setAlrimLink("/seminar/SeminarScheduleList.do");	
			    	alrimVO.setAlrimMenuId(34000);
			    	//교육 담당자 알림등록
			    	alrimVO.setAlrimApprovalId(seminarInfoList.get(i).getSeminarLectId());
			    	if(alrimVO.getAlrimApprovalId() != null) {
			    		alrimDAO.insertSeminarAlrim(alrimVO);
			    	}
			    	
			    	for(int j=0; j<seminarEntryList.size(); j++){
			    		//참여자 알림등록
				    	alrimVO.setAlrimApprovalId(seminarEntryList.get(j).getSeminarMemId());
				    	if(alrimVO.getAlrimApprovalId() != null) {
				    		alrimDAO.insertSeminarAlrim(alrimVO);
				    	}
					}
				}
			}									
		} catch(Exception e){
			e.printStackTrace();
			log.error(" SeminarSchdlrImpl 스케줄러 rssReader() 에러 : " + e.getMessage());
		}
	}
}