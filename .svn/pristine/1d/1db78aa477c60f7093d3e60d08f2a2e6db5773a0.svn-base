package daewooInfo.smsmanage.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.smsmanage.bean.SmsBranchVO;
import daewooInfo.smsmanage.bean.SmsTargetVO;
import daewooInfo.smsmanage.bean.SmsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("SmsManageCounterDAO")
public class SmsManageCounterDAO extends EgovAbstractDAO {

	public List<SmsVO> getSmsConfigList(){
		return list("SmsManageCounterDAO.getSmsConfigList", null);
	}
	
	public SmsVO getSmsConfigDetail(SmsVO smsVo){
		return (SmsVO)selectByPk("SmsManageCounterDAO.getSmsConfigDetail", smsVo);
	}
	
	public int MergeSmsConfig(SmsVO smsVo){
		return update("SmsManageCounterDAO.MergeSmsConfig", smsVo); 
	}
	
	public int MergeAllSms(SmsVO smsVo){
		return update("SmsManageCounterDAO.MergeAllSms", smsVo); 
	}
	
	public List<SmsTargetVO> CommonSmsTargetList(SmsTargetVO smsTargetVO){
		return list("SmsManageCounterDAO.CommonSmsTargetList", smsTargetVO);
	}
	
	public void InsertSmsTarget(SmsTargetVO smsTargetVO){
		insert("SmsManageCounterDAO.InsertSmsTarget", smsTargetVO); 
	}
	
	public void DeleteSmsTarget(SmsTargetVO smsTargetVO){
		delete("SmsManageCounterDAO.DeleteSmsTarget", smsTargetVO);
	}
	
	public int isExistBranchMember(SmsTargetVO smsTargetVO){
		return (Integer)selectByPk("SmsManageCounterDAO.isExistBranchMember", smsTargetVO);
	}
	
	public SmsBranchVO DetailSmsBranchConfig(SmsBranchVO smsBranchVO){
		return (SmsBranchVO)selectByPk("SmsManageCounterDAO.DetailSmsBranchConfig", smsBranchVO);
	}
	
	public int MergeSmsBranchConfig(SmsBranchVO smsBranchVO){
		return update("SmsManageCounterDAO.MergeSmsBranchConfig", smsBranchVO); 
	}
	
	public int MergeAllSmsBranch(SmsBranchVO smsBranchVO){
		return update("SmsManageCounterDAO.MergeAllSmsBranch", smsBranchVO); 
	}

	public int InitSmsConfig(SmsVO smsVo){
		return update("SmsManageCounterDAO.InitSmsConfig", smsVo); 
	}
	
	public int InitSmsBranchConfig(SmsBranchVO smsBranchVO){
		return update("SmsManageCounterDAO.InitSmsBranchConfig", smsBranchVO); 
	}

	public List<SmsVO> getFactSmsList(SmsVO smsVO){
		return list("SmsManageCounterDAO.getFactSmsList", smsVO);
	}
	
	public SmsBranchVO DetailFactSmsBranch(SmsBranchVO smsBranchVO){
		return (SmsBranchVO)selectByPk("SmsManageCounterDAO.DetailFactSmsBranch", smsBranchVO);
	}
	

	public int MergeFactSmsBranch(SmsBranchVO smsBranchVO){
		return update("SmsManageCounterDAO.MergeFactSmsBranch", smsBranchVO); 
	}

	public List<SmsTargetVO> FactSmsTargetList(SmsTargetVO smsTargetVO){
		return list("SmsManageCounterDAO.FactSmsTargetList", smsTargetVO);
	}
	
}
