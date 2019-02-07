package daewooInfo.waterpolmnt.situationctl.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.waterpolmnt.situationctl.bean.AlertTargetVO;
import daewooInfo.waterpolmnt.situationctl.bean.AutoDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.FactLawVO;
import daewooInfo.waterpolmnt.situationctl.bean.FactLocationVO;
import daewooInfo.waterpolmnt.situationctl.bean.MainChartVO;
import daewooInfo.waterpolmnt.situationctl.bean.ResultChartVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuPopupVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuSumDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.SeqInfoVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuPopupVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuTopDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainSearchVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainTopTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntNorecvSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntNorecvTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntSummaryVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntCoordVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailTSVO;
import daewooInfo.waterpolmnt.situationctl.dao.SituationctlDAO;
import daewooInfo.waterpolmnt.situationctl.service.SituationctlService;
import daewooInfo.waterpolmnt.waterinfo.bean.AirMntDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AlgaCastDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.BoSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DamViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("situationctlService")
public class SituationctlServiceImpl extends AbstractServiceImpl implements SituationctlService {
	
	/**
	 * @uml.property  name="situationctlDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "situationctlDAO")
    private SituationctlDAO situationctlDAO;

	// 메인(로그인후) - 측정값 조회
	public List<TaksuMainVO> getDetailRIVERMAIN(SearchTaksuMainVO searchTaksuMainVO) throws Exception{
    	return situationctlDAO.getDetailRIVERMAIN(searchTaksuMainVO);
    }

    // 통합감시 - 통계표 조회	
	public List<TotalMntMainTopTSVO> getTotalMntMainTopTS() throws Exception{
    	return situationctlDAO.getTotalMntMainTopTS();
    }
    
	 // 통합감시 - 상세정보 조회	
	public List<TotalMntSummaryVO> getTotalMntSummary(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception{
    	return situationctlDAO.getTotalMntSummary(totalMntMainSearchTSVO);
    }
        
	// 통합감시 - 측정값 조회(전체)
	public List<TotalMntMainVO> getTotalMntMain(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception{
    	return situationctlDAO.getTotalMntMain(totalMntMainSearchVO);
    }
	
	// 통합감시 - 측정값 조회(한강)
	public List<TotalMntMainVO> getTotalMntMainR01(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception{
    	return situationctlDAO.getTotalMntMainR01(totalMntMainSearchVO);
    }

	// 통합감시 - 측정값 조회(금강)
	public List<TotalMntMainVO> getTotalMntMainR03(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception{
    	return situationctlDAO.getTotalMntMainR03(totalMntMainSearchVO);
    }

	// 통합감시 - 측정값 조회(낙동강)
	public List<TotalMntMainVO> getTotalMntMainR02(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception{
    	return situationctlDAO.getTotalMntMainR02(totalMntMainSearchVO);
    }

	// 통합감시 - 측정값 조회(영산강)
	public List<TotalMntMainVO> getTotalMntMainR04(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception{
    	return situationctlDAO.getTotalMntMainR04(totalMntMainSearchVO);
    }

	// 통합감시 - 측정값 조회(세부팝업)
	public List<TotalMntMainDetailTSVO> getTotalMntMainDetailTS(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO) throws Exception{
    	return situationctlDAO.getTotalMntMainDetailTS(totalMntMainDetailSearchTSVO);
    }
	
	public List<TotalMntMainDetailTSVO> getTotalMntMainDetailTSGraph(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO) throws Exception{
		return situationctlDAO.getTotalMntMainDetailTSGraph(totalMntMainDetailSearchTSVO);
	}
	
	public List<TotalMntMainDetailTSVO> getTotalMntMainDetailTSGraph_compare(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO) throws Exception{
		return situationctlDAO.getTotalMntMainDetailTSGraph_compare(totalMntMainDetailSearchTSVO);
	}
	
	// 통합감시 - 측정값 조회(세부팝업-상황전파자)
	public List<AlertTargetVO> getAlertTargetList(AlertTargetVO alertTargetVO) throws Exception{
		return situationctlDAO.getAlertTargetList(alertTargetVO);
	}
	
	 // 통합감시 - 측정값 조회(세부팝업-그래프)
	public List<ResultChartVO> getTotalMntGraph(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception{
    	return situationctlDAO.getTotalMntGraph(totalMntMainSearchTSVO);
    }
	// 통합감시 - 측정값 조회(세부팝업-그래프)
	public List<ResultChartVO> getTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception{
		return situationctlDAO.getTotalMntGraph2(totalMntMainSearchTSVO);
	}
	
	// 통합감시 - 선택한 측정값 조회(세부팝업-그래프)
	public List<ResultChartVO> getSelectTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception{
		return situationctlDAO.getSelectTotalMntGraph2(totalMntMainSearchTSVO);
	}
	
	// 통합감시 - 선택한 측정값 조회(세부팝업-그래프)
	public List<ResultChartVO> getSelectMultiTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception{
		return situationctlDAO.getSelectMultiTotalMntGraph2(totalMntMainSearchTSVO);
	}

	 // 통합감시 - 미수신 정보 조회	
	public List<TotalMntNorecvTSVO> getTotalMntNorecv(TotalMntNorecvSearchTSVO totalMntNorecvSearchTSVO) throws Exception{
    	return situationctlDAO.getTotalMntNorecv(totalMntNorecvSearchTSVO);
    }

	// 수계별 통합감시 - 통계표 조회
	public List<TaksuTopDataVO> getTopDataTAKSU(SearchTaksuSumDataVO searchTaksuSumDataVO) throws Exception{
    	return situationctlDAO.getTopDataTAKSU(searchTaksuSumDataVO);
    }
    
	// 수계별 통합감시 - 측정값 조회
	public List<TaksuPopupVO> getWATERSYSMNT(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception{
    	return situationctlDAO.getWATERSYSMNT(searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<TaksuPopupVO> getSelectWATERSYSMNT(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception{
		return situationctlDAO.getSelectWATERSYSMNT(searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<DetailViewVO> getAllDetailViewDISCHARGE(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception{
		return situationctlDAO.getAllDetailViewDISCHARGE(searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<BoSearchVO> getAllDetailViewBO(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception{
		return situationctlDAO.getAllDetailViewBO(searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<DamViewVO> getAllDetailViewDAM(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception{
		return situationctlDAO.getAllDetailViewDAM(searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<WareHouseSearchVO> getAllDetailViewWAREHOUSE(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception{
		return situationctlDAO.getAllDetailViewWAREHOUSE(searchTaksuPopupVO);
    }
		
	// 통합감시 - 차트 
    public List<ResultChartVO> getRiverMainChart(MainChartVO mainChartVO) throws Exception{
    	return situationctlDAO.getRiverMainChart(mainChartVO);
    }

    // 수계별 통합감시 - 게이지 차트 
    public ResultChartVO getRiverGaugeChart(MainChartVO mainChartVO) throws Exception{
    	return situationctlDAO.getRiverGaugeChart(mainChartVO);
    }

	// 수계별 통합감시 - 측정값 조회(세부팝업)
	public List<WatersysMntMainDetailTSVO> getWatersysMntMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception{
    	return situationctlDAO.getWatersysMntMainDetail(watersysMntMainDetailSearchTSVO);
    }
	
	// 수계별 통합감시 - 측정값 조회(세부팝업)
	public List<WatersysMntMainDetailTSVO> getWatersysMntMainDetail_all(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception{
    	return situationctlDAO.getWatersysMntMainDetail_all(watersysMntMainDetailSearchTSVO);
    }
	
	//2014-10-21 mypark 수계별 통합감시 - 측정값 총 카운트
	public int getWatersysMntMainDetail_all_count(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception{
    	return situationctlDAO.getWatersysMntMainDetail_all_count(watersysMntMainDetailSearchTSVO);
    }

	public List<WatersysMntMainDetailTSVO> getWatersysMntMainDetailGraph(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception{
    	return situationctlDAO.getWatersysMntMainDetailGraph(watersysMntMainDetailSearchTSVO);
    }
	
	// 수계별 통합감시 - 측정값 모바일 조회(세부팝업)
	public List<WatersysMntMainDetailTSVO> getWaterMobilesysMntMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception{
    	return situationctlDAO.getWaterMobilesysMntMainDetail(watersysMntMainDetailSearchTSVO);
    }
	
	/**
	 * FactLaw 조회
	 */
	public FactLawVO getFactLaw(FactLawVO factLaw)
	{
		return situationctlDAO.getFactLaw(factLaw);
	}
	
	//통합 감시 하단 조류예보
	public AlgaCastDataVO getRecentAlga() throws Exception{
		return situationctlDAO.getRecentAlga();
	}
	
	// 통합감시 하단 항공 감시
	public AirMntDataVO getRecentAir() throws Exception{
		return situationctlDAO.getRecentAir();
	}
	
	/**
	 * 다음 또는 이전공구를 가져옵니다
	 * @param search(isNext가 Y이면 다음공구/N이면 이전공구
	 * @return
	 */
	public WatersysMntMainDetailTSVO getNextFact(WatersysMntMainDetailSearchTSVO search)
	{
		return situationctlDAO.getNextFact(search);
	}
	
	
	/**
	 * 다음 또는 이전공구를 가져옵니다 IP_USN용
	 * @param search(isNext가 Y이면 다음공구/N이면 이전공구
	 * @return
	 */
	public WatersysMntMainDetailTSVO getNextFact_U(WatersysMntMainDetailSearchTSVO search)
	{
		return situationctlDAO.getNextFact_U(search);
	}
	
	
	/***
	 * 수계별 통합감시용 
	 */
	public List<WatersysMntCoordVO> getWaterSysMnt_coord(SearchTaksuPopupVO searchTaksuPopupVO)
	{
		return situationctlDAO.getWaterSysMnt_coord(searchTaksuPopupVO);
	}
	
	/**
	 * 수계별 통합감시 좌표 수정
	 */
	public void updateWaterSysMnt_coord(WatersysMntCoordVO watersysMntCoordVO)
	{
		 situationctlDAO.updateWaterSysMnt_coord(watersysMntCoordVO);
	}
	
	/**
	 * Fact - Branch 의 위도, 경도 정보를 가져옴
	 */
	public FactLocationVO getFactLocation(FactLocationVO factLocationVO)
	{
		return situationctlDAO.getFactLocation(factLocationVO);
	}
	
	/**
	 * 자동측정망 실시간 데이터 조회
	 */
	public List<AutoDataVO> getAutoData()
	{
		return situationctlDAO.getAutoData();
	}
	
	/**
	 * 자동측정망 실시간 데이터 조회
	 */
	public List<AutoDataVO> getAutoInsertData(String time)
	{
		return situationctlDAO.getAutoInsertData(time);
	}
	
	// 소속기관 목록 조회
	public List<HashMap> getDepts() {
    	return situationctlDAO.getDepts();
    }
	
	//상위 댐 정보
	public SeqInfoVO getHighDamInfo(SeqInfoVO vo)
	{
		return situationctlDAO.getHighDamInfo(vo);
	}
	
	//하위 취 정수장 정보
	public SeqInfoVO getLowWaterDCCenter(SeqInfoVO vo)
	{
		return situationctlDAO.getLowWaterDCCenter(vo);
	}
	
	public List<WatersysMntMainDetailTSVO> IndexWaterSysMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception{
		return situationctlDAO.IndexWaterSysMainDetail(watersysMntMainDetailSearchTSVO); 
	}
}