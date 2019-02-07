 package daewooInfo.spotmanage.service;

import java.util.List;

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


public interface SpotManageCounterService {
	/* 지점관리 리스트 가져오기 */
	List getSpotMgrList(SpotManageVO spotManageVO) throws Exception;
	int getSpotMgrCnt(SpotManageVO spotManageVO) throws Exception;
	/* 지점상세보기 */
	SpotManageVO getSpotView(SpotManageVO spotManageVO) throws Exception;
	/* Usn 리스트 가져오기 */
	List getUsnList(UsnItemVO usnItemVO) throws Exception;
	/* 설치장비 리스트 가져오기 */
	List getEqList(EqItemVO eqItemVO) throws Exception;
	/* 지점관리 리스트 가져오기 */
	List getItemList(ItemVO itemVO) throws Exception;
	/* 관리자 리스트 가져오기 */
	List getMemberList(SpotManageVO spotManageVO) throws Exception;
	/* 지점 관리자 리스트 가져오기 */
	List getSpotMemList(SpotManageVO spotManageVO) throws Exception;
	/* 관리자 등록하기 */
	void branchmemberInsert(MemberAddVO memberAddVO) throws Exception;
	/* 관리자 삭제하기 */
	void branchmemberdel(MemberAddVO memberAddVO) throws Exception;
	/* usn 측정일 등록 */
	void usnInsert(UsnItemVO usnItemVO) throws Exception;
	/* usn 측정일 수정 */
	void usnUpdate(UsnItemVO usnItemVO) throws Exception;
	/* 수정 전 데이터 가져오기 */
	UsnItemVO getUpdateView(UsnItemVO usnItemVO) throws Exception;
	/* usn 삭제 처리 (업데이트) */
	int usndel(UsnItemVO usnItemVO) throws Exception;
	/* usn 파일 다운로드 내용 조회 */
	UsnItemVO selectFileInfo(UsnItemVO usnItemVO) throws Exception;
	/* 설치장비 등록 */
	void eqInsert(EqItemVO eqItemVO) throws Exception;
	/* 설치장비수정내용가져오기 */
	EqItemVO eqUpDateForm(EqItemVO eqItemVO) throws Exception;
	/* 설치장비 수정 처리 */
	void eqUpdate(EqItemVO eqItemVO) throws Exception;
	/* 설치장비 삭제 처리 */
	int eqDel(EqItemVO eqItemVO) throws Exception;
	/* 설치장비 관리이력리스트 가져오기 */
	List getAdminHistoryList(AdminHistoryVO adminHistoryVO) throws Exception;
	/* 설치장비 관리이력 등록 */
	void adminHistoryInsert(AdminHistoryVO adminHistoryVO) throws Exception;
	/* 설치장비 관리이력 수정 */
	void adminHistoryUpdate(AdminHistoryVO adminHistoryVO) throws Exception;
	/* 설치장비 관리이력 삭제 */
	void adminHistorydel(AdminHistoryVO adminHistoryVO) throws Exception;
	/* 주소 리스트 가져오기 */
	List getAddressList(ZipcodeVO zipcodeVO) throws Exception;
	/* 항목 리스트 가져오기 */
	List getSysItemList(SpotManageVO spotManageVO) throws Exception;
	/* 단일 항목 저장 */
	void singleSaveInsert(BranchItemVO branchItemVO) throws Exception;
	/* 단일 항목 업데이트 */
	void singleSaveUpdate(BranchItemVO branchItemVO) throws Exception;
	/* 지점별 항목리스트 가져오기  */
	List getBranchItemList(BranchItemVO branchItemVO) throws Exception;
	/* 지점 저장하기 */
	void saveFactinfo(FactinfoVO factinfoVO) throws Exception;
	/* 장비 저장하기 */
	void saveEquipInfo(SysEquipVO sysEquipVO) throws Exception;
	/* 측정소 저장하기 */
	void saveFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception;
	/* 지점 리스트 가져오기 */
	List getFactinfoList(FactinfoVO factinfoVO) throws Exception;
	int getFactinfoListCnt(FactinfoVO factinfoVO) throws Exception;
	/* 측정소 리스트 가져오기 */
	List getFactbranchInfoAddList(FactinfoVO factinfoVO) throws Exception;
	int getFactbranchInfoAddListCnt(FactinfoVO factinfoVO) throws Exception;
	/* 측정소 가져오기 */
	List getFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception;
	/* 측정장비 화면에서 항목명 조회 */
	String getMaxBranchNo(SpotManageVO spotManageVO) throws Exception;
	/* 측정소 수정하기 */
	void updateFactbranchInfoAdd(FactinfoVO factinfoVO) throws Exception;
	/* 측정소 수정하기 */
	void saveLoadData(FactinfoVO factinfoVO) throws Exception;
	/* 측정장비 화면에서 항목명 조회 */
	String getItemName(SpotManageVO spotManageVO) throws Exception;
	/* 지점별 항목리스트 가져오기  */
	List getBranchItemCodeList(ItemVO itemVO) throws Exception;
	/* 지점별 항목리스트 가져오기  */
	List getBranchItemFullList(BranchItemVO branchItemVO) throws Exception;
	/* 측정소 리스트 가져오기  */
	public List<SpotManageVO> getExcelSpotmgrList(SpotManageVO spotManageVO) throws Exception;
	
	/* 시스템장비 리스트 가져오기 */
	List getSysinfoList(SysEquipVO sysEquipVO) throws Exception;
	int getSysinfoListCnt(SysEquipVO sysEquipVO) throws Exception;
	
	
	/* 측정소 설치 장비 이력 */
	List getEqHsList(EqItemVO eqItemVO) throws Exception;
	
	/* 측정소 관리 이력 추가  2015-11-12 HMS */
	void usnHsInsert(UsnItemVO usnItemVO)throws Exception;
	
	List getSpotInfoA(SpotInfoVO spotInfoVO) throws Exception;
	
	int saveSpotInfoA(SpotInfoVO spotInfoVO) throws Exception;
	
	int getSpotInfoACnt(SpotInfoVO spotInfoVO) throws Exception;
	
}
