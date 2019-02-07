package daewooInfo.alert.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.dao.AlertLawDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.alert.service.AlertLawService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 경보기준설정을 위한 서비스 구현 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
@Service("alertLawService")
public class AlertLawServiceImpl extends AbstractServiceImpl implements AlertLawService {

	/**
	 * @uml.property  name="alertLawDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertLawDAO")
	private AlertLawDAO alertLawDAO;	

	/**
	 * 경보기준설정 목록을 가져온다.
	 * 
	 * @see daewooInfo.alert.service.AlertLawService#getAlertLawList(daewooInfo.alert.bean.AlertSearchVO)
	 */
	public List<AlertLawVO> getAlertLawList(AlertSearchVO vo) throws Exception{
		return alertLawDAO.getFactLawList(vo);
	}
	
	/**
	 * VOC의 FID 항목에 대한 ECD항목의 기준설정값을 가져온다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertLawVO> getAlertLawSubList(AlertSearchVO vo) throws Exception {
		return alertLawDAO.getAlertLawSubList(vo);
	}
	
	/**
	 * VOC의 FID 항목에 대한 ECD항목의 기준설정값을 가져온다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertLawVO> getAlertLawSubList_empty(AlertSearchVO vo) throws Exception {
		return alertLawDAO.getAlertLawSubList_empty(vo);
	}
	

	/**
	 * 경보기준설정을 추가하거나 갱신한다.
	 * 
	 * @see daewooInfo.alert.service.AlertLawService#mergeAlertLaw(daewooInfo.alert.bean.AlertLawVO)
	 */
	public int mergeAlertLaw(AlertLawVO vo) throws Exception {
		return alertLawDAO.mergeFactLaw(vo);
	}

	/**
	 * 경보기준설정을 추가하거나 갱신한다.
	 * 
	 * @see daewooInfo.alert.service.AlertLawService#mergeAlertLaw(daewooInfo.alert.bean.AlertLawVO)
	 */
	public int mergeAlertLawSub(AlertLawVO vo) throws Exception {
		return alertLawDAO.mergeAlertLawSub(vo);
	}
	
	
	/**
	 * 경보기준설정을 삭제한다.(미사용)
	 * 
	 * @see daewooInfo.alert.service.AlertLawService#deleteAlertLaw(daewooInfo.alert.bean.AlertLawVO)
	 */
	public int deleteAlertLaw(AlertLawVO vo) throws Exception {
		return alertLawDAO.deleteFactLaw(vo);
	} 
	public int updateFactLaw(AlertLawVO vo) throws Exception {
		return alertLawDAO.updateFactLaw(vo);
	}

	/**
	 * 경보기준을 가져옵니다
	 */
	public AlertDataLawVo getFactLaw(AlertSearchVO vo) throws Exception {
		return alertLawDAO.getFactLaw(vo);
	}	
}
