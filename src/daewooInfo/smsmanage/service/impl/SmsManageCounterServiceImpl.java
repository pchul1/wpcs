package daewooInfo.smsmanage.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.smsmanage.bean.SmsBranchVO;
import daewooInfo.smsmanage.bean.SmsTargetVO;
import daewooInfo.smsmanage.bean.SmsVO;
import daewooInfo.smsmanage.dao.SmsManageCounterDAO;
import daewooInfo.smsmanage.service.SmsManageCounterService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("SmsManageCounterService")
public class SmsManageCounterServiceImpl extends AbstractServiceImpl implements SmsManageCounterService {

	@Resource(name="SmsManageCounterDAO")
	private SmsManageCounterDAO smsManageCounterDAO;
	
	public List<SmsVO> getSmsConfigList(){
		return smsManageCounterDAO.getSmsConfigList();
	}
	
	public SmsVO getSmsConfigDetail(SmsVO smsVo){
		return smsManageCounterDAO.getSmsConfigDetail(smsVo);
	}
	
	public int MergeSmsConfig(SmsVO smsVo){
		int i=0;
		i += smsManageCounterDAO.MergeSmsConfig(smsVo);
		i += smsManageCounterDAO.MergeAllSms(smsVo);
		return i; 
	}
	
	public List<SmsTargetVO> CommonSmsTargetList(SmsTargetVO smsTargetVO){
		return smsManageCounterDAO.CommonSmsTargetList(smsTargetVO);
	}
	
	public void InsertSmsTarget(SmsTargetVO smsTargetVO){
		String[] member_id = smsTargetVO.getMember_id().split(",");
		
		for(int i=0;i<member_id.length;i++){
			smsTargetVO.setMember_id(member_id[i]);
			smsManageCounterDAO.InsertSmsTarget(smsTargetVO);
		}
	}
	
	public void DeleteSmsTarget(SmsTargetVO smsTargetVO){
		smsManageCounterDAO.DeleteSmsTarget(smsTargetVO);
	}

	public int isExistBranchMember(SmsTargetVO smsTargetVO){
		return smsManageCounterDAO.isExistBranchMember(smsTargetVO);
	}
	
	public SmsBranchVO DetailSmsBranchConfig(SmsBranchVO smsBranchVO){
		return smsManageCounterDAO.DetailSmsBranchConfig(smsBranchVO);
	}
	
	public int MergeSmsBranchConfig(SmsBranchVO smsBranchVO){
		int i=0;
		i += smsManageCounterDAO.MergeSmsBranchConfig(smsBranchVO);
		// 2016.12.08 KANG JINAM 공통SMS수신설정 변경 시 
		// 모든 측정소의 SMS수신설정이 함께 변경되지 않도록 주석처리
		// i += smsManageCounterDAO.MergeAllSmsBranch(smsBranchVO);
		return i; 
	}
	
	public int InitFactSmsConfig(SmsVO smsVO){
		int i=0;
		i += smsManageCounterDAO.InitSmsConfig(smsVO);
		SmsBranchVO smsBranchVO = new SmsBranchVO();
		smsBranchVO.setFact_code(smsVO.getFact_code());
		smsBranchVO.setBranch_no(smsVO.getBranch_no());
		i += smsManageCounterDAO.InitSmsBranchConfig(smsBranchVO);
		return i;
	}
	
	public List<SmsVO> getFactSmsList(SmsVO smsVO){
		return smsManageCounterDAO.getFactSmsList(smsVO);
	}
	
	public SmsBranchVO DetailFactSmsBranch(SmsBranchVO smsBranchVO){
		return smsManageCounterDAO.DetailFactSmsBranch(smsBranchVO);
	}
	
	public int MergeFactSmsBranch(SmsBranchVO smsBranchVO){
		return smsManageCounterDAO.MergeFactSmsBranch(smsBranchVO); 
	}
	
	public List<SmsTargetVO> FactSmsTargetList(SmsTargetVO smsTargetVO){
		return smsManageCounterDAO.FactSmsTargetList(smsTargetVO);
	}
}