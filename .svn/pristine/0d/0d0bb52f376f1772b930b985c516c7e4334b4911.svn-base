package daewooInfo.spotmanage.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import daewooInfo.spotmanage.bean.AdminHistoryVO;
import daewooInfo.spotmanage.bean.BranchItemVO;
import daewooInfo.spotmanage.bean.EqItemVO;
import daewooInfo.spotmanage.bean.FactinfoVO;
import daewooInfo.spotmanage.bean.ItemVO;
import daewooInfo.spotmanage.bean.MemberAddVO;
import daewooInfo.spotmanage.bean.SpotInfoVO;
import daewooInfo.spotmanage.bean.SpotManageVO;
import daewooInfo.spotmanage.bean.SysEquipVO;
import daewooInfo.spotmanage.bean.UsnItemVO;
import daewooInfo.spotmanage.bean.ZipcodeVO;
import daewooInfo.spotmanage.dao.SpotManageCounterDAO;
import daewooInfo.spotmanage.service.SpotManageCounterService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("SpotManageCounterService")
public  class SpotManageCounterServiceImpl extends AbstractServiceImpl implements SpotManageCounterService {
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * @uml.property  name="spotManageCounterDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "SpotManageCounterDAO")
    private SpotManageCounterDAO spotManageCounterDAO;
	public List getSpotMgrList(SpotManageVO spotManageVO) throws Exception{
		return spotManageCounterDAO.getSpotMgrList(spotManageVO);
	}
	public int getSpotMgrCnt(SpotManageVO spotManageVO) throws Exception{
		return spotManageCounterDAO.getSpotMgrCnt(spotManageVO);
	}
	public SpotManageVO getSpotView(SpotManageVO spotManageVO) throws Exception{
		return spotManageCounterDAO.getSpotView(spotManageVO);
	}
	public List getUsnList(UsnItemVO usnItemVO) throws Exception{
		return spotManageCounterDAO.getUsnList(usnItemVO);
	}
	public List getEqList(EqItemVO eqItemVO) throws Exception{
		return spotManageCounterDAO.getEqList(eqItemVO);
	}
	public List getItemList(ItemVO itemVO) throws Exception{
		return spotManageCounterDAO.getItemList(itemVO);
	}
	public List getMemberList(SpotManageVO spotManageVO) throws Exception{
		return spotManageCounterDAO.getMemberList(spotManageVO);
	}
	public List getSpotMemList(SpotManageVO spotManageVO) throws Exception{
		return spotManageCounterDAO.getSpotMemList(spotManageVO);
	}
	public void branchmemberInsert(MemberAddVO memberAddVO) throws Exception{
		spotManageCounterDAO.branchmemberInsert(memberAddVO);
		// 2013.01.11 ADD BY 최회섭(SMS수신대상자에 추가)
		spotManageCounterDAO.branchSmsTargetInsert(memberAddVO);
	}
	public void branchmemberdel(MemberAddVO memberAddVO) throws Exception{
		spotManageCounterDAO.branchmemberdel(memberAddVO);
		// 2016.12.07 ADD BY KANG JINAM(담당자 제거시 SMS대상에서도 자동으로 제외)
		spotManageCounterDAO.branchSmsTargetdel(memberAddVO);
	}
	public void usnInsert(UsnItemVO usnItemVO) throws Exception {
		spotManageCounterDAO.usnInsert(usnItemVO);
	}
	public void usnUpdate(UsnItemVO usnItemVO) throws Exception {
		spotManageCounterDAO.usnUpdate(usnItemVO);
	}
	public UsnItemVO getUpdateView(UsnItemVO usnItemVO) throws Exception {
		return spotManageCounterDAO.getUpdateView(usnItemVO);
	}
	public int usndel(UsnItemVO usnItemVO) throws Exception {
		return spotManageCounterDAO.usndel(usnItemVO);
	}
	public UsnItemVO selectFileInfo(UsnItemVO usnItemVO) throws Exception{
		return spotManageCounterDAO.selectFileInfo(usnItemVO);
	}
	public void eqInsert(EqItemVO eqItemVO) throws Exception {
		spotManageCounterDAO.eqInsert(eqItemVO);
	}
	public EqItemVO eqUpDateForm(EqItemVO eqItemVO) throws Exception {
		return spotManageCounterDAO.eqUpDateForm(eqItemVO);
	}
	public void eqUpdate(EqItemVO eqItemVO) throws Exception {
		spotManageCounterDAO.eqUpdate(eqItemVO);
	}
	public int eqDel(EqItemVO eqItemVO) throws Exception {
		return spotManageCounterDAO.eqDel(eqItemVO);
	}
	public List getAdminHistoryList(AdminHistoryVO adminHistoryVO) throws Exception{
		return spotManageCounterDAO.getAdminHistoryList(adminHistoryVO);
	}
	public void adminHistoryInsert(AdminHistoryVO adminHistoryVO) throws Exception{
		spotManageCounterDAO.adminHistoryInsert(adminHistoryVO);
	}
	public void adminHistoryUpdate(AdminHistoryVO adminHistoryVO) throws Exception{
		spotManageCounterDAO.adminHistoryUpdate(adminHistoryVO);
	}
	public void adminHistorydel(AdminHistoryVO adminHistoryVO) throws Exception {
		spotManageCounterDAO.adminHistorydel(adminHistoryVO);
	}
	public List getAddressList(ZipcodeVO zipcodeVO) throws Exception{
		return spotManageCounterDAO.getAddressList(zipcodeVO);
	}
	public List getSysItemList(SpotManageVO spotManageVO) throws Exception {
		return spotManageCounterDAO.getSysItemList(spotManageVO);
	}
	public void singleSaveInsert(BranchItemVO branchItemVO) throws Exception {
		spotManageCounterDAO.singleSaveInsert(branchItemVO);
	}
	public void singleSaveUpdate(BranchItemVO branchItemVO) throws Exception {
		spotManageCounterDAO.singleSaveUpdate(branchItemVO);
	}
	public List getBranchItemList(BranchItemVO branchItemVO) throws Exception {
		return spotManageCounterDAO.getBranchItemList(branchItemVO);
	}
	public void saveFactinfo(FactinfoVO factinfoVO) throws Exception {
		spotManageCounterDAO.saveFactinfo(factinfoVO);
	}
	public void saveEquipInfo(SysEquipVO sysEquipVO) throws Exception {
		spotManageCounterDAO.saveEquipInfo(sysEquipVO);
	}
	public void saveFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception {
		spotManageCounterDAO.saveFactbranchInfoAdd(factinfoVO);
	}
	public List getFactinfoList(FactinfoVO factinfoVO) throws Exception {
		return spotManageCounterDAO.getFactinfoList(factinfoVO);
	}
	public int getFactinfoListCnt(FactinfoVO factinfoVO) throws Exception{
		return spotManageCounterDAO.getFactinfoListCnt(factinfoVO);
	}
	public List getFactbranchInfoAddList(FactinfoVO factinfoVO) throws Exception {
		return spotManageCounterDAO.getFactbranchInfoAddList(factinfoVO);
	}
	public int getFactbranchInfoAddListCnt(FactinfoVO factinfoVO) throws Exception{
		return spotManageCounterDAO.getFactbranchInfoAddListCnt(factinfoVO);
	}
	public String getMaxBranchNo(SpotManageVO spotManageVO) throws Exception {
		return spotManageCounterDAO.getMaxBranchNo(spotManageVO);
	}
	public List getFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception {
		return spotManageCounterDAO.getFactbranchInfoAdd(factinfoVO);
	}
	public void updateFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception {
		spotManageCounterDAO.updateFactbranchInfoAdd(factinfoVO);
	}
	public void saveLoadData(FactinfoVO factinfoVO) throws Exception {
		spotManageCounterDAO.saveLoadData(factinfoVO);
	}
	public String getItemName(SpotManageVO spotManageVO) throws Exception {
		return spotManageCounterDAO.getItemName(spotManageVO);
	}
	public List getBranchItemCodeList(ItemVO itemVO) throws Exception {
		return spotManageCounterDAO.getBranchItemCodeList(itemVO);
	}
	public List getBranchItemFullList(BranchItemVO branchItemVO) throws Exception {
		return spotManageCounterDAO.getBranchItemFullList(branchItemVO);
	}
	public List<SpotManageVO> getExcelSpotmgrList(SpotManageVO spotManageVO) throws Exception{
		List<SpotManageVO> result = null;		
		result = spotManageCounterDAO.getExcelSpotmgrList(spotManageVO);
		return result; 
    }
	
	public List getSysinfoList(SysEquipVO sysEquipVO) throws Exception {
		return spotManageCounterDAO.getSysinfoList(sysEquipVO);
	}
	public int getSysinfoListCnt(SysEquipVO sysEquipVO) throws Exception{
		return spotManageCounterDAO.getSysinfoListCnt(sysEquipVO);
	}
	@Override
	public List getEqHsList(EqItemVO eqItemVO) throws Exception {
		return spotManageCounterDAO.getEqHsList(eqItemVO);
	}
	
	@Override	
	public void usnHsInsert(UsnItemVO usnItemVO) throws Exception {
		// TODO Auto-generated method stub
		spotManageCounterDAO.usnHsInsert(usnItemVO);
	}
	public List getSpotInfoA(SpotInfoVO spotInfoVO) throws Exception {
		return spotManageCounterDAO.getSpotInfoA(spotInfoVO);
	}
	public int saveSpotInfoA(SpotInfoVO spotInfoVO) throws Exception {
		// TODO Auto-generated method stub
		return (int)spotManageCounterDAO.saveSpotInfoA(spotInfoVO);
	}
	public int getSpotInfoACnt(SpotInfoVO spotInfoVO) throws Exception{
		return spotManageCounterDAO.getSpotInfoACnt(spotInfoVO);
	}
}