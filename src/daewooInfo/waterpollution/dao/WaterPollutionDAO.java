package daewooInfo.waterpollution.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.cmmn.bean.ChartVO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.waterpollution.bean.WaterPollutionReportSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionReportVO;
import daewooInfo.waterpollution.bean.WaterPollutionSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionStepVO;
import daewooInfo.waterpollution.bean.WaterPollutionVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 방제실적에 대한 데이터 접근 클래스를 정의한다
 * @author yik
 * @since 2013.04.20
 * @version 1.0
 * @see
 *
 * <pre>
 * 
 * 수정일	 		수정자			수정내용
 * -------		--------	---------------------------
 * 2013.04.20	yik			 최초 생성
 *
 * </pre>
 */
@Repository("WaterPollutionDAO")
public class WaterPollutionDAO extends EgovAbstractDAO {
	
	/** log */
	protected static final Log log = LogFactory.getLog(WaterPollutionDAO.class);

	@SuppressWarnings("unchecked")
	public List getWaterPollutionList(WaterPollutionSearchVO searchVO) {
		return list("WaterPollutionDAO.getWaterPollutionList", searchVO);
	}

	public int getWaterPollutionListCnt(WaterPollutionSearchVO searchVO) {
		return (Integer)selectByPk("WaterPollutionDAO.getWaterPollutionListCnt", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List getLoginMemberInfo(HashMap<String, String> map) {
		return list("WaterPollutionDAO.getLoginMemberInfo", map);
	}

	public String getWaterPollutionCode() {
		return (String)selectByPk("WaterPollutionDAO.getWaterPollutionCode", null);
	}

	public void inserttWaterPollutionInfo(WaterPollutionVO waterPollutionVO) {
		insert("WaterPollutionDAO.inserttWaterPollutionInfo", waterPollutionVO);
	}

	public void inserttWaterPollutionStepInfo(WaterPollutionStepVO waterPollutionStepVO) {
		insert("WaterPollutionDAO.inserttWaterPollutionStepInfo", waterPollutionStepVO);
	}

	public int inserttWaterPollutionSmsInfo(HashMap<String, String> map) {
		return (Integer)update("WaterPollutionDAO.inserttWaterPollutionSmsInfo", map);
	}


	public int insertWaterPollutionCheckAlrim(HashMap<String, String> map) {
		return (Integer)update("WaterPollutionDAO.insertWaterPollutionCheckAlrim", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getWaterPollutionDetail(HashMap<String, String> map) {
		return list("WaterPollutionDAO.getWaterPollutionDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getWaterPollutionSms(HashMap<String, String> map) {
		return list("WaterPollutionDAO.getWaterPollutionSms", map);
	}

	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getWaterPollutionStep(HashMap<String, String> map) {
		return list("WaterPollutionDAO.getWaterPollutionStep", map);
	}

	@SuppressWarnings("unchecked")
	public String getWaterPollutionNextStep(HashMap map) {
		return (String)selectByPk("WaterPollutionDAO.getWaterPollutionNextStep", map);
	}

	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> waterPollutionStepModifyInfo(HashMap<String, String> map) {
		return list("WaterPollutionDAO.waterPollutionStepModifyInfo", map);
	}

	public void modifyWaterPollutionStep(WaterPollutionStepVO waterPollutionStepVO) {
		update("WaterPollutionDAO.modifyWaterPollutionStep", waterPollutionStepVO);
	}

	public void modifyWaterPollution(WaterPollutionVO waterPollutionVO) {
		update("WaterPollutionDAO.modifyWaterPollution", waterPollutionVO);
	}
	
	public void modifyWaterPollutionStepWPS_Code(HashMap<String, String> map) {
		 update("WaterPollutionDAO.modifyWaterPollutionStepWPS_Code", map);
	}

	public String insertAlertFileInfs(List<FileVO> result) {
		FileVO vo			= (FileVO)result.get(0);
		String atchFileId	= vo.getAtchFileId(); 
		
		insert("WaterPollutionDAO.insertWpsStepFile", vo);

		Iterator iter = result.iterator();
		while (iter.hasNext()) {
			vo = (FileVO)iter.next(); 
			insert("WaterPollutionDAO.insertWpsStepFileDetail", vo);
		} 
		return atchFileId;
	}

	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getWaterPollutionImg(HashMap<String, String> map) {
		return list("WaterPollutionDAO.getWaterPollutionImg", map);
	}

	public int deleteWaterPollutionStepImg(HashMap<String, String> map) {
		return update("WaterPollutionDAO.deleteWaterPollutionStepImg", map);
	}
	
	public void deleteWaterPollutionStep(WaterPollutionStepVO waterPollutionStepVO) {
		update("WaterPollutionDAO.deleteWaterPollutionStep", waterPollutionStepVO);
	}

	public void deleteWaterPollution(WaterPollutionSearchVO searchVO) {
		update("WaterPollutionDAO.deleteWaterPollution", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List getWaterPollutionStats(WaterPollutionSearchVO searchVO) {
		return list("WaterPollutionDAO.getWaterPollutionStats", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getWaterPollutionStatsChartRiver(WaterPollutionSearchVO waterPollutionSearchVO) {
		return list("WaterPollutionDAO.getWaterPollutionStatsChartRiver", waterPollutionSearchVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getWaterPollutionStatsChartYear(WaterPollutionSearchVO waterPollutionSearchVO) {
		return list("WaterPollutionDAO.getWaterPollutionStatsChartYear", waterPollutionSearchVO);
	}

	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getWaterPollutionStatsChartWpKind(WaterPollutionSearchVO waterPollutionSearchVO) {
		return list("WaterPollutionDAO.getWaterPollutionStatsChartWpKind", waterPollutionSearchVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<WaterPollutionReportVO> getWaterPollutionReportList(WaterPollutionReportSearchVO waterPollutionReportSearchVO) {
		return list("WaterPollutionDAO.getWaterPollutionReportList", waterPollutionReportSearchVO);
	}
	
	public List<WaterPollutionVO> getWaterPollutionStatus(WaterPollutionSearchVO waterPollutionSearchVO) {
		return list("WaterPollutionDAO.getWaterPollutionStatus", waterPollutionSearchVO);
	}
	
	public List<WaterPollutionVO> getWaterPollutionStatusList(WaterPollutionSearchVO waterPollutionSearchVO) {
		return list("WaterPollutionDAO.getWaterPollutionStatusList", waterPollutionSearchVO);
	}
	
	public int getWaterPollutionReportListCnt(WaterPollutionReportSearchVO searchVO) {
		return (Integer)selectByPk("WaterPollutionDAO.getWaterPollutionReportListCnt", searchVO);
	}
	
	public int getWaterPollutionRCVCnt() {
		return (Integer)selectByPk("WaterPollutionDAO.getWaterPollutionRCVCnt", null);
	}

	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getAlertCnt() {
		return list("WaterPollutionDAO.getAlertCnt", null);
	}
	
	@SuppressWarnings("unchecked")
	public List<WaterPollutionVO> getAlertCnt2() {
		return list("WaterPollutionDAO.getAlertCnt2", null);
	}
	
	@SuppressWarnings("unchecked")
	public String selectWaterPollutionFile(String wpCode) {
		return  (String)selectByPk("WaterPollutionDAO.selectWaterPollutionFile", wpCode);
	}
	
	@SuppressWarnings("unchecked")
	public List<ChartVO> getMainChart(ChartVO chartVO) {
		return list("WaterPollutionDAO.getMainChart", chartVO);
	}
	
	
	
	/**
     * 첨부파일 갯수조회
     */
    public int selectWaterPollutionFileCnt(String atchFileId) throws Exception {
    	return (Integer)selectByPk("WaterPollutionDAO.selectWaterPollutionFileCnt", atchFileId);
    }
	
	
}
