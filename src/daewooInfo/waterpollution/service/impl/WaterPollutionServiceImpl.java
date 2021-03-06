package daewooInfo.waterpollution.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.cmmn.bean.ChartVO;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.dao.FileManageDAO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.itemmanage.bean.ItemGroupVO;
import daewooInfo.warehouse.bean.WareHouseZipcodeVO;
import daewooInfo.warehouse.bean.ItemCalcSearchVO;
import daewooInfo.warehouse.bean.ItemCalcVO;
import daewooInfo.warehouse.bean.ItemCodeGroupVO;
import daewooInfo.warehouse.bean.ItemCodeSearchVO;
import daewooInfo.warehouse.bean.ItemCodeVO;
import daewooInfo.warehouse.bean.ItemConditionManageSearchVO;
import daewooInfo.warehouse.bean.ItemGroupSearchVO;
import daewooInfo.warehouse.bean.ItemManageSearchVO;
import daewooInfo.warehouse.bean.SearchVO;
import daewooInfo.warehouse.bean.WareHouseManageSearchVO;
import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.warehouse.bean.WareHouseVO;
import daewooInfo.warehouse.dao.WareHouseManageDAO;
import daewooInfo.warehouse.service.WareHouseManageService;
import daewooInfo.waterpollution.bean.WaterPollutionReportSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionReportVO;
import daewooInfo.waterpollution.bean.WaterPollutionSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionStepVO;
import daewooInfo.waterpollution.bean.WaterPollutionVO;
import daewooInfo.waterpollution.dao.WaterPollutionDAO;
import daewooInfo.waterpollution.service.WaterPollutionService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 
 * 방제실적에 대한 서비스 구현클래스를 정의한다
 * @author yik
 * @since 2013.04.21
 * @version 1.0
 * @see
 *
 * <pre>
 * 
 * 수정일			 수정자		수정내용
 * -------		--------	---------------------------
 * 2013.04.21	yik			최초 생성
 *
 * </pre>
 */
@Service("WaterPollutionService")
public class WaterPollutionServiceImpl extends AbstractServiceImpl implements WaterPollutionService {

	/**
	 * @uml.property  name="waterPollutionDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="WaterPollutionDAO")
	private WaterPollutionDAO waterPollutionDAO;
	
	/**
	 * @uml.property  name="fileMngDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "FileManageDAO")
	private FileManageDAO fileMngDAO;

	public List getWaterPollutionList(WaterPollutionSearchVO searchVO) {
		return waterPollutionDAO.getWaterPollutionList(searchVO);
	}

	public int getWaterPollutionListCnt(WaterPollutionSearchVO searchVO) {
		return waterPollutionDAO.getWaterPollutionListCnt(searchVO);
	}

	public List getLoginMemberInfo(HashMap<String, String> map) {
		return waterPollutionDAO.getLoginMemberInfo(map);
	}

	public String getWaterPollutionCode() {
		return waterPollutionDAO.getWaterPollutionCode();
	}

	public void inserttWaterPollutionInfo(WaterPollutionVO waterPollutionVO) {
		waterPollutionDAO.inserttWaterPollutionInfo(waterPollutionVO);
	}

	public void inserttWaterPollutionStepInfo(WaterPollutionStepVO waterPollutionStepVO) {
		waterPollutionDAO.inserttWaterPollutionStepInfo(waterPollutionStepVO);
	}

	public int inserttWaterPollutionSmsInfo(HashMap<String, String> map) {
		return waterPollutionDAO.inserttWaterPollutionSmsInfo(map);
	}

	public int insertWaterPollutionCheckAlrim(HashMap<String, String> map) {
		return waterPollutionDAO.insertWaterPollutionCheckAlrim(map);
	}
	
	public List<WaterPollutionVO> getWaterPollutionDetail(HashMap<String, String> map) {
		return waterPollutionDAO.getWaterPollutionDetail(map);
	}

	public List<WaterPollutionVO> getWaterPollutionSms(HashMap<String, String> map) {
		return waterPollutionDAO.getWaterPollutionSms(map);
	}

	public List<WaterPollutionVO> getWaterPollutionStep(HashMap<String, String> map) {
		return waterPollutionDAO.getWaterPollutionStep(map);
	}

	public String getWaterPollutionNextStep(HashMap map) {
		return waterPollutionDAO.getWaterPollutionNextStep(map);
	}

	public List<WaterPollutionVO> waterPollutionStepModifyInfo(HashMap<String, String> map) {
		return waterPollutionDAO.waterPollutionStepModifyInfo(map);
	}

	public void modifyWaterPollutionStep(WaterPollutionStepVO waterPollutionStepVO) {
		waterPollutionDAO.modifyWaterPollutionStep(waterPollutionStepVO);
	}

	public void modifyWaterPollution(WaterPollutionVO waterPollutionVO) {
		waterPollutionDAO.modifyWaterPollution(waterPollutionVO);
	}

	public void modifyWaterPollutionStepWPS_Code(HashMap<String,String> map) {
		// TODO Auto-generated method stub
		waterPollutionDAO.modifyWaterPollutionStepWPS_Code(map);
		
	}	
	
	public String insertWpsStepFileInfs(List<FileVO> result) {
		String atchFileId = "";
		
		if (result.size() != 0) {
			atchFileId = waterPollutionDAO.insertAlertFileInfs(result);
		} 
		return atchFileId;
	}

	public List<WaterPollutionVO> getWaterPollutionImg(HashMap<String, String> map) {
		return waterPollutionDAO.getWaterPollutionImg(map);
	}

	public int deleteWaterPollutionStepImg(HashMap<String, String> map) {
		return waterPollutionDAO.deleteWaterPollutionStepImg(map);
	}

	public void deleteWaterPollutionStep(WaterPollutionStepVO waterPollutionStepVO) {
		waterPollutionDAO.deleteWaterPollutionStep(waterPollutionStepVO);
	}


	public void deleteWaterPollution(WaterPollutionSearchVO searchVO){
		waterPollutionDAO.deleteWaterPollution(searchVO);
	}
	
	public List getWaterPollutionStats(WaterPollutionSearchVO searchVO) {
		return waterPollutionDAO.getWaterPollutionStats(searchVO);
	}

	public List<WaterPollutionVO> getWaterPollutionStatsChartRiver(WaterPollutionSearchVO waterPollutionSearchVO) {
		return waterPollutionDAO.getWaterPollutionStatsChartRiver(waterPollutionSearchVO);
	}
	
	public List<WaterPollutionVO> getWaterPollutionStatsChartYear(WaterPollutionSearchVO waterPollutionSearchVO) {
		return waterPollutionDAO.getWaterPollutionStatsChartYear(waterPollutionSearchVO);
	}
	
	public List<WaterPollutionVO> getWaterPollutionStatsChartWpKind(WaterPollutionSearchVO waterPollutionSearchVO) {
		return waterPollutionDAO.getWaterPollutionStatsChartWpKind(waterPollutionSearchVO);
	}
	
	public List<WaterPollutionReportVO> getWaterPollutionReportList(WaterPollutionReportSearchVO waterPollutionReportSearchVO) {
		return waterPollutionDAO.getWaterPollutionReportList(waterPollutionReportSearchVO);
	}
	
	public List<WaterPollutionVO> getWaterPollutionStatus(WaterPollutionSearchVO waterPollutionSearchVO) {
		return waterPollutionDAO.getWaterPollutionStatus(waterPollutionSearchVO);
	}
	
	public List<WaterPollutionVO> getWaterPollutionStatusList(WaterPollutionSearchVO waterPollutionSearchVO) {
		return waterPollutionDAO.getWaterPollutionStatusList(waterPollutionSearchVO);
	}
	
	public int getWaterPollutionReportListCnt(WaterPollutionReportSearchVO searchVO) {
		return waterPollutionDAO.getWaterPollutionReportListCnt(searchVO);
	}
	
	public int getWaterPollutionRCVCnt(){
		return waterPollutionDAO.getWaterPollutionRCVCnt();
	}
	
	public List<WaterPollutionVO> getAlertCnt() {
		return waterPollutionDAO.getAlertCnt();
	}
	
	public List<WaterPollutionVO> getAlertCnt2() {
		return waterPollutionDAO.getAlertCnt2();
	}
	
	public String selectWaterPollutionFile(String wpCode){
		return waterPollutionDAO.selectWaterPollutionFile(wpCode);
	}
	
	public List<ChartVO> getMainChart(ChartVO chartVO){
		return waterPollutionDAO.getMainChart(chartVO);
	}
	
	/**
     * 첨부파일 갯수조회
     */
    public int selectWaterPollutionFileCnt(String atchFileId) throws Exception {
    	return waterPollutionDAO.selectWaterPollutionFileCnt(atchFileId);
    }
}
