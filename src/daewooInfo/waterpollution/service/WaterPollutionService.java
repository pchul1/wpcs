package daewooInfo.waterpollution.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daewooInfo.cmmn.bean.ChartVO;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.cmmn.bean.FileVO;
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
import daewooInfo.waterpollution.bean.WaterPollutionReportSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionReportVO;
import daewooInfo.waterpollution.bean.WaterPollutionSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionStepVO;
import daewooInfo.waterpollution.bean.WaterPollutionVO;


/**
 * 방제실적에 관한 서비스 인터페이스 클래스를 정의한다
 * @author  yik
 * @since  2013.04.20
 * @version  1.0
 * @see  <pre>  수정일			 수정자		수정내용  -------		--------	---------------------------  2013.04.20	yik			최초 생성  </pre>
 */
public interface WaterPollutionService {

	List getWaterPollutionList(WaterPollutionSearchVO searchVO);

	int getWaterPollutionListCnt(WaterPollutionSearchVO searchVO);

	List getLoginMemberInfo(HashMap<String, String> map);

	/**
	 * @uml.property  name="waterPollutionCode"
	 */
	String getWaterPollutionCode();

	void inserttWaterPollutionInfo(WaterPollutionVO waterPollutionVO);

	void inserttWaterPollutionStepInfo(WaterPollutionStepVO waterPollutionStepVO);

	int inserttWaterPollutionSmsInfo(HashMap<String, String> map);

	int insertWaterPollutionCheckAlrim(HashMap<String, String> map);
	
	List<WaterPollutionVO> getWaterPollutionDetail(HashMap<String, String> map);

	List<WaterPollutionVO> getWaterPollutionSms(HashMap<String, String> map);

	List<WaterPollutionVO> getWaterPollutionStep(HashMap<String, String> map);

	String getWaterPollutionNextStep(HashMap map);

	List<WaterPollutionVO> waterPollutionStepModifyInfo(HashMap<String, String> map);

	void modifyWaterPollutionStep(WaterPollutionStepVO waterPollutionStepVO);

	void modifyWaterPollution(WaterPollutionVO waterPollutionVO);
	
	void modifyWaterPollutionStepWPS_Code(HashMap<String,String> map);

	String insertWpsStepFileInfs(List<FileVO> result);

	List<WaterPollutionVO> getWaterPollutionImg(HashMap<String, String> map);

	int deleteWaterPollutionStepImg(HashMap<String, String> map);

	void deleteWaterPollutionStep(WaterPollutionStepVO waterPollutionStepVO);
	
	void deleteWaterPollution(WaterPollutionSearchVO searchVO);

	List getWaterPollutionStats(WaterPollutionSearchVO searchVO);

	List<WaterPollutionVO> getWaterPollutionStatsChartRiver(WaterPollutionSearchVO waterPollutionSearchVO);

	List<WaterPollutionVO> getWaterPollutionStatsChartYear(WaterPollutionSearchVO waterPollutionSearchVO);

	List<WaterPollutionVO> getWaterPollutionStatsChartWpKind(WaterPollutionSearchVO waterPollutionSearchVO);
	
	List<WaterPollutionVO> getWaterPollutionStatus(WaterPollutionSearchVO waterPollutionSearchVO);
	
	List<WaterPollutionVO> getWaterPollutionStatusList(WaterPollutionSearchVO waterPollutionSearchVO);
	
	List<WaterPollutionReportVO> getWaterPollutionReportList(WaterPollutionReportSearchVO waterPollutionReportSearchVO);
	
	int getWaterPollutionReportListCnt(WaterPollutionReportSearchVO searchVO);
	
	List<WaterPollutionVO> getAlertCnt();
	
	List<WaterPollutionVO> getAlertCnt2();
	
	String selectWaterPollutionFile(String wpCode);
	
	List<ChartVO> getMainChart(ChartVO chartVO);
	
	int getWaterPollutionRCVCnt();
	/**
	 * 첨부파일 갯수조회
	 */
	public int selectWaterPollutionFileCnt(String atchFileId) throws Exception;
	
	
}
