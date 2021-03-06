package daewooInfo.admin.mindataEmployee.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.admin.mindataEmployee.bean.MindataEmployeeVO;
import daewooInfo.admin.mindataEmployee.dao.MindataEmployeeDAO;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.dao.AlrimDAO;
import daewooInfo.mobile.com.utl.ObjectUtil;

/**
 * 2014.10.24
 * @author myarpk
 *
 */

public class MindataEmployeeSchdlrImpl extends QuartzJobBean { 
	
	private static Log log = LogFactory.getLog(MindataEmployeeSchdlrImpl.class);
	
	private AlrimDAO alrimDAO;
    private MindataEmployeeDAO mindataEmployeeDAO;
    
	public void setMindataEmployeeDAO(MindataEmployeeDAO mindataEmployeeDAO){
		this.mindataEmployeeDAO = mindataEmployeeDAO;
	}
	
	public void setAlrimDAO(AlrimDAO alrimDAO){
		this.alrimDAO = alrimDAO;
	}
	
	private int count = 0;
		
	public MindataEmployeeSchdlrImpl() {}
    
	/**
	 * 
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {
		log.debug("Start MindateaEmployee by Scheduler!");		
		try {
			if(count == 0) {
				MindateaEmployeeAlrim();
			}
		}catch(Exception e){
			log.error(" MindateaEmployeeSchdlrImpl 스케줄러 executeInternal() 에러");
		}
		
		count ++;
	}
	
	/**
	 * 교육 알림
	 * 
	 */
	private void MindateaEmployeeAlrim () throws Exception{	
		AlrimVO alrimVO = new AlrimVO();
		MindataEmployeeVO mindataEmployeeVO = new MindataEmployeeVO();
		mindataEmployeeVO.setGubun("S");
		List<MindataEmployeeVO> MindataEmployeeList = mindataEmployeeDAO.selectMindataEmployeeList(mindataEmployeeVO);
		
		for(MindataEmployeeVO vo : MindataEmployeeList){
			String today = ObjectUtil.getTimeString("dd");
			String Definite_Date = vo.getDefinite_date();
			//System.out.println(today);
			//System.out.println(Definite_Date);
			if(today.equals(Definite_Date)){
				String title = "매월 "+vo.getDefinite_date()+"일은 데이터선별 확정요청일 입니다.<br/>";
				title += "데이터선별 저장을 하지 않으신 담당자께서는 [선별저장]을 해 주시기 바랍니다.";
				//선별 담당자 알림등록
				
				alrimVO.setAlrimGubun("W");
		    	alrimVO.setAlrimTitle(title);
		    	alrimVO.setAlrimLink("/waterpolmnt/waterinfo/goSelectRIVER.do");	
		    	alrimVO.setAlrimMenuId(12420);
		    	alrimVO.setAlrimWriterId(vo.getMember_id());
		    	alrimVO.setAlrimApprovalId(vo.getMember_id());
	    		alrimDAO.insertSeminarAlrim(alrimVO);
			}else{
				break;
			}
		}
	}
}