package daewooInfo.spotmanage.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

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
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("SpotManageCounterDAO")
public class SpotManageCounterDAO extends EgovAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List getSpotMgrList(SpotManageVO spotManageVO) throws Exception {
		return list("SpotManageCounterDAO.getSpotMgrList",spotManageVO);
	}
	@SuppressWarnings("unchecked")
	public int getSpotMgrCnt(SpotManageVO spotManageVO) throws Exception {
		return (Integer)selectByPk("SpotManageCounterDAO.getSpotMgrCnt",spotManageVO);
	}
	@SuppressWarnings("unchecked")
	public SpotManageVO getSpotView(SpotManageVO spotManageVO) throws Exception {
		return (SpotManageVO)selectByPk("SpotManageCounterDAO.getSpotView", spotManageVO);	
	}
	@SuppressWarnings("unchecked")
	public List getUsnList(UsnItemVO usnItemVO) throws Exception {
		return list("SpotManageCounterDAO.getUsnList",usnItemVO);
	}
	@SuppressWarnings("unchecked")
	public List getEqList(EqItemVO eqItemVO) throws Exception {
		return list("SpotManageCounterDAO.getEqList",eqItemVO);
	}
	@SuppressWarnings("unchecked")
	public List getItemList(ItemVO itemVO) throws Exception {
		return list("SpotManageCounterDAO.getItemList",itemVO);
	}
	@SuppressWarnings("unchecked")
	public List getMemberList(SpotManageVO spotManageVO) throws Exception {
		return list("SpotManageCounterDAO.getMemberList",spotManageVO);
	}
	@SuppressWarnings("unchecked")
	public List getSpotMemList(SpotManageVO spotManageVO) throws Exception {
		return list("SpotManageCounterDAO.getSpotMemList",spotManageVO);
	}
	@SuppressWarnings("unchecked")
	public void branchmemberInsert(MemberAddVO memberAddVO) throws Exception {
		insert("SpotManageCounterDAO.branchmemberInsert",memberAddVO);
	}
	@SuppressWarnings("unchecked")
	public void branchmemberdel(MemberAddVO memberAddVO) throws Exception {
		delete("SpotManageCounterDAO.branchmemberdel",memberAddVO);
	}
	@SuppressWarnings("unchecked")
	public void usnInsert(UsnItemVO usnItemVO) throws Exception {
		insert("SpotManageCounterDAO.usnInsert",usnItemVO);
	}
	@SuppressWarnings("unchecked")
	public void usnUpdate(UsnItemVO usnItemVO) throws Exception {
		update("SpotManageCounterDAO.usnUpdate",usnItemVO);
	}
	@SuppressWarnings("unchecked")
	public UsnItemVO getUpdateView(UsnItemVO usnItemVO) throws Exception {
		return (UsnItemVO)selectByPk("SpotManageCounterDAO.getUpdateView",usnItemVO);
	}
	@SuppressWarnings("unchecked")
	public int usndel(UsnItemVO usnItemVO) throws Exception {
		return update("SpotManageCounterDAO.usndel",usnItemVO);
	}
	@SuppressWarnings("unchecked")
	public UsnItemVO selectFileInfo(UsnItemVO usnItemVO) throws Exception {
		return (UsnItemVO)selectByPk("SpotManageCounterDAO.selectFileInfo",usnItemVO);
	}
	@SuppressWarnings("unchecked")
	public void eqInsert(EqItemVO eqItemVO) throws Exception {
		insert("SpotManageCounterDAO.eqInsert",eqItemVO);
	}
	@SuppressWarnings("unchecked")
	public EqItemVO eqUpDateForm(EqItemVO eqItemVO) throws Exception {
		return (EqItemVO)selectByPk("SpotManageCounterDAO.eqUpDateForm",eqItemVO);
	}
	@SuppressWarnings("unchecked")
	public void eqUpdate(EqItemVO eqItemVO) throws Exception {
		update("SpotManageCounterDAO.eqUpdate",eqItemVO);
	}
	@SuppressWarnings("unchecked")
	public int eqDel(EqItemVO eqItemVO) throws Exception {
		return update("SpotManageCounterDAO.eqDel",eqItemVO);
	}
	@SuppressWarnings("unchecked")
	public List getAdminHistoryList(AdminHistoryVO adminHistoryVO) throws Exception {
		return list("SpotManageCounterDAO.getAdminHistoryList",adminHistoryVO);
	}
	@SuppressWarnings("unchecked")
	public void adminHistoryInsert(AdminHistoryVO adminHistoryVO) throws Exception {
		insert("SpotManageCounterDAO.adminHistoryInsert",adminHistoryVO);
	}
	@SuppressWarnings("unchecked")
	public void adminHistoryUpdate(AdminHistoryVO adminHistoryVO) throws Exception {
		update("SpotManageCounterDAO.adminHistoryUpdate",adminHistoryVO);
	}
	@SuppressWarnings("unchecked")
	public void adminHistorydel(AdminHistoryVO adminHistoryVO) throws Exception {
		delete("SpotManageCounterDAO.adminHistorydel",adminHistoryVO);
	}
	@SuppressWarnings("unchecked")
	public List getAddressList(ZipcodeVO zipcodeVO) throws Exception {
		return list("SpotManageCounterDAO.getAddressListSpot",zipcodeVO);
	}
	@SuppressWarnings("unchecked")
	public List getSysItemList(SpotManageVO spotManageVO) throws Exception {
		return list("SpotManageCounterDAO.getSysItemList",spotManageVO);
	}
	@SuppressWarnings("unchecked")
	public void saveFactinfo(FactinfoVO factinfoVO) throws Exception {
		insert("SpotManageCounterDAO.saveFactinfoSpot",factinfoVO);
	}
	@SuppressWarnings("unchecked")
	public void saveEquipInfo(SysEquipVO sysEquipVO) throws Exception {
		insert("SpotManageCounterDAO.saveEquipInfo",sysEquipVO);
	}
	@SuppressWarnings("unchecked")
	public void saveFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception {
		insert("SpotManageCounterDAO.FactbranchAddSpot",factinfoVO);
		insert("SpotManageCounterDAO.FactbranchInfoSpot",factinfoVO);
	}
	
	@SuppressWarnings("unchecked")
	public void singleSaveInsert(BranchItemVO branchItemVO) throws Exception {
		insert("SpotManageCounterDAO.singleSaveInsert",branchItemVO);
	}
	@SuppressWarnings("unchecked")
	public void singleSaveUpdate(BranchItemVO branchItemVO) throws Exception {
		update("SpotManageCounterDAO.singleSaveUpdate",branchItemVO);
	}
	@SuppressWarnings("unchecked")
	public List getBranchItemList(BranchItemVO branchItemVO) throws Exception {
		return list("SpotManageCounterDAO.getBranchItemList",branchItemVO);
	}
	@SuppressWarnings("unchecked")
	public List getFactinfoList(FactinfoVO factinfoVO) throws Exception {
		return list("SpotManageCounterDAO.getFactinfoListSpot",factinfoVO);
	}
	@SuppressWarnings("unchecked")
	public int getFactinfoListCnt(FactinfoVO factinfoVO) throws Exception {
		return (Integer)selectByPk("SpotManageCounterDAO.getFactinfoListCntSpot",factinfoVO);
	}
	@SuppressWarnings("unchecked")
	public List getFactbranchInfoAddList(FactinfoVO factinfoVO) throws Exception {
		return list("SpotManageCounterDAO.getFactbranchInfoAddListSpot",factinfoVO);
	}
	@SuppressWarnings("unchecked")
	public int getFactbranchInfoAddListCnt(FactinfoVO factinfoVO) throws Exception {
		return (Integer)selectByPk("SpotManageCounterDAO.getFactbranchInfoAddListCntSpot",factinfoVO);
	}
	@SuppressWarnings("unchecked")
	public List getFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception {
		return list("SpotManageCounterDAO.getFactbranchInfoAddSpot",factinfoVO);
	}
	public String getMaxBranchNo(SpotManageVO spotManageVO) throws Exception {
		return (String)getSqlMapClientTemplate().queryForObject("SpotManageCounterDAO.getMaxBranchNo", spotManageVO);
	}
	@SuppressWarnings("unchecked")
	public void updateFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception {
		update("SpotManageCounterDAO.updateFactbranchInfoSpot",factinfoVO);
		update("SpotManageCounterDAO.updateFactbranchWeatherSpot",factinfoVO);
		update("SpotManageCounterDAO.updateFactSystemGroupItem",factinfoVO);
	}
	@SuppressWarnings("unchecked")
	public void saveLoadData(FactinfoVO factinfoVO) throws Exception {
		update("SpotManageCounterDAO.saveLoadDataSpot",factinfoVO);
	}
	// 2013.01.11 ADD BY 최회섭(지점별 sms수신대상자리스트에 추가)
	@SuppressWarnings("unchecked")
	public void branchSmsTargetInsert(MemberAddVO memberAddVO) throws Exception {
		insert("SpotManageCounterDAO.branchSmsTargetInsert",memberAddVO);
	}
	// 2016.12.07 ADD BY KANG JINAM (지점별 담당자 삭제시 자동으로 SMS수신대상에서도 제외)
	@SuppressWarnings("unchecked")
	public void branchSmsTargetdel(MemberAddVO memberAddVO) throws Exception {
		insert("SpotManageCounterDAO.branchSmsTargetdel",memberAddVO);
	}	
	public String getItemName(SpotManageVO spotManageVO) throws Exception {
		return (String)getSqlMapClientTemplate().queryForObject("SpotManageCounterDAO.getItemName", spotManageVO);
	}
	@SuppressWarnings("unchecked")
	public List getBranchItemCodeList(ItemVO itemVO) throws Exception {
		return list("SpotManageCounterDAO.getBranchItemCodeList",itemVO);
	}
	@SuppressWarnings("unchecked")
	public List getBranchItemFullList(BranchItemVO branchItemVO) throws Exception {
		return list("SpotManageCounterDAO.getBranchItemFullList",branchItemVO);
	}
	@SuppressWarnings("unchecked")
	public List<SpotManageVO> getExcelSpotmgrList(SpotManageVO spotManageVO)
	{
		return list("SpotManageCounterDAO.getExcelSpotmgrList", spotManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public List getSysinfoList(SysEquipVO sysEquipVO) throws Exception {
		return list("SpotManageCounterDAO.getSysinfoList",sysEquipVO);
	}
	@SuppressWarnings("unchecked")
	public int getSysinfoListCnt(SysEquipVO sysEquipVO) throws Exception {
		return (Integer)selectByPk("SpotManageCounterDAO.getSysinfoListCnt",sysEquipVO);
	}
	public List getEqHsList(EqItemVO eqItemVO) {
		return list("SpotManageCounterDAO.getEqHsList",eqItemVO);
	}
	
	
	@SuppressWarnings("unchecked")
	public void usnHsInsert(UsnItemVO usnItemVO)  throws Exception {
		// TODO Auto-generated method stub
		insert("SpotManageCounterDAO.usnHsInsert",usnItemVO);
	}
	public List getSpotInfoA(SpotInfoVO spotInfoVO) throws Exception{
		// TODO Auto-generated method stub
		return list("SpotManageCounterDAO.getSpotInfoA", spotInfoVO);
	}
	public int saveSpotInfoA(SpotInfoVO spotInfoVO) throws Exception{
		// TODO Auto-generated method stub
		int result = 0; 
		result   = update("SpotManageCounterDAO.updateSpotInfoA", spotInfoVO);
		result  += update("SpotManageCounterDAO.updateSpotInfoBranchA", spotInfoVO);

		return result;
	}
	public int getSpotInfoACnt(SpotInfoVO spotInfoVO) throws Exception {
		// TODO Auto-generated method stub
		return (Integer)selectByPk("SpotManageCounterDAO.getSpotInfoACnt",spotInfoVO);
	}
}
