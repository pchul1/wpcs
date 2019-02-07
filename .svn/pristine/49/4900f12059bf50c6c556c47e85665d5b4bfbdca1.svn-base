 package daewooInfo.smsmanage.service;

import java.util.List;

import daewooInfo.smsmanage.bean.SmsBranchVO;
import daewooInfo.smsmanage.bean.SmsTargetVO;
import daewooInfo.smsmanage.bean.SmsVO;



/**
 * @author  hyun
 */
public interface SmsManageCounterService {
	
	List<SmsVO> getSmsConfigList();
	
	SmsVO getSmsConfigDetail(SmsVO smsVo);
	
	int MergeSmsConfig(SmsVO smsVo);
	
	List<SmsTargetVO> CommonSmsTargetList(SmsTargetVO smsTargetVO);

	void InsertSmsTarget(SmsTargetVO smsTargetVO);
	  
	void DeleteSmsTarget(SmsTargetVO smsTargetVO);
	
	int isExistBranchMember(SmsTargetVO smsTargetVO);
	
	SmsBranchVO DetailSmsBranchConfig(SmsBranchVO smsBranchVO);
	
	int MergeSmsBranchConfig(SmsBranchVO smsBranchVO);
	
	int InitFactSmsConfig(SmsVO smsVO);
	
	List<SmsVO> getFactSmsList(SmsVO smsVO);
	
	SmsBranchVO DetailFactSmsBranch(SmsBranchVO smsBranchVO);
	
	int MergeFactSmsBranch(SmsBranchVO smsBranchVO);
	
	List<SmsTargetVO> FactSmsTargetList(SmsTargetVO smsTargetVO);
	
}
