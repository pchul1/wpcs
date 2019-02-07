package daewooInfo.seminar.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.seminar.bean.SeminarEntryVO;
import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;
import daewooInfo.seminar.dao.SeminarDAO;
import daewooInfo.seminar.service.SeminarService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 교육관리 ServiceImpl 클래스
 * @author 박미영
 * @since 2014.09.15
 * @version 1.0
 * @see
 */
@Service("SeminarService")
public class SeminarServiceImpl extends AbstractServiceImpl implements SeminarService {
   /**
	 * @uml.property  name="seminarDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="seminarDAO")
    private SeminarDAO seminarDAO;
    
	/**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "seminarIdGnrService")
    private EgovIdGnrService idgenService;

	/**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "seminarEntryIdGnrService")
    private EgovIdGnrService idEntryGenService;
    
    /**
	 * @uml.property  name="fileService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;
	    
	public void insertSeminar(SeminarVO seminarVO) throws Exception {
//		String seminarId = idgenService.getNextStringId();
//    	seminarVO.setSeminarId(seminarId);
		seminarDAO.insertSeminar(seminarVO);
	}
	
	public void updateSeminarInfo(SeminarVO seminarVO) throws Exception {
		seminarDAO.updateSeminarInfo(seminarVO);
	}
	
	public int selectCheckSeminarDate(SeminarVO seminarVO) throws Exception {
		return seminarDAO.selectCheckSeminarDate(seminarVO);
	}
	
	public int selectSeminarTotCnt(SeminarSearchVO searchVO) throws Exception {
		return seminarDAO.selectSeminarTotCnt(searchVO);
	}
	public List<SeminarVO> selectSeminarInfo(SeminarSearchVO searchVO)  throws Exception {
		return seminarDAO.selectSeminarInfo(searchVO);
	}
	
	public int selSeminarEntryCnt(SeminarEntryVO seminarEntryVO) throws Exception {
		return seminarDAO.selSeminarEntryCnt(seminarEntryVO);
	}
	
	public SeminarVO selSeminarInfoView(SeminarVO seminarVO)  throws Exception {
		return seminarDAO.selSeminarInfoView(seminarVO);
	}
	
	public void updateSeminarCnt(SeminarVO seminarVO) throws Exception {
		seminarDAO.updateSeminarCnt(seminarVO);
	}
	
	public void deleteSeminarInfo(SeminarVO seminarVO) throws Exception {
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(seminarVO.getAtchFileId());
		seminarDAO.deleteSeminarInfo(seminarVO);
		//첨부 파일 삭제
		if (!StringUtil.isEmpty(fvo.getAtchFileId())) {
		    fileService.deleteAllFileInf(fvo);
		}
	}
	
	public void updateSeminarState(SeminarVO seminarVO) throws Exception {
		seminarDAO.updateSeminarState(seminarVO);
	}
	
	public int selectSeminarApplicationTotCnt(SeminarSearchVO searchVO) throws Exception {
		return seminarDAO.selectSeminarApplicationTotCnt(searchVO);
	}
	
	public List<SeminarVO> selectSeminarApplication(SeminarSearchVO searchVO)  throws Exception {
		return seminarDAO.selectSeminarApplication(searchVO);
	}
	
	public List<SeminarEntryVO> selSeminarEntryView(SeminarVO seminarVO)  throws Exception {
		return seminarDAO.selSeminarEntryView(seminarVO);
	}
	
	public int selectAcceptTot(SeminarVO seminarVO) throws Exception {
		return seminarDAO.selectAcceptTot(seminarVO);
	}
	
	public int selectCompleteTot(SeminarVO seminarVO) throws Exception {
		return seminarDAO.selectCompleteTot(seminarVO);
	}
	
	public int selectPlanTot(SeminarVO seminarVO) throws Exception {
		return seminarDAO.selectPlanTot(seminarVO);
	}
	
	public int selectSeminarTot(SeminarVO seminarVO) throws Exception {
		return seminarDAO.selectSeminarTot(seminarVO);
	}
	
	public int selectLectTot(SeminarVO seminarVO) throws Exception {
		return seminarDAO.selectLectTot(seminarVO);
	}

	public void insertSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception {
		String seminarEntryId = idEntryGenService.getNextStringId();
		seminarEntryVO.setSeminarEntryId(seminarEntryId);
		seminarDAO.insertSeminarEntry(seminarEntryVO);
	}
	
	public void updateSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception {
		seminarDAO.updateSeminarEntry(seminarEntryVO);
	}
	
	public int selectCheckSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception {
		return seminarDAO.selectCheckSeminarEntry(seminarEntryVO);
	}
	
	public String selectUperDept(SeminarSearchVO searchVO) throws Exception {
		return seminarDAO.selectUperDept(searchVO);
	}
	
	public int selMySeminarApplicationTot(SeminarSearchVO searchVO) throws Exception {
		return seminarDAO.selMySeminarApplicationTot(searchVO);
	}
	
	public List<SeminarVO> selMySeminarApplication(SeminarSearchVO searchVO)  throws Exception {
		return seminarDAO.selMySeminarApplication(searchVO);
	}
	
	public String selectCheckSeminarEntryCount(SeminarVO seminarVO) throws Exception {
		return seminarDAO.selectCheckSeminarEntryCount(seminarVO);
	}
	
	public void updateSeminarAutoClosingState(SeminarSearchVO searchVO) throws Exception {
		seminarDAO.updateSeminarAutoClosingState(searchVO);
	}
	
	public List<SeminarVO> selectSeminarInfoAlrimCheck(SeminarVO seminarVO)  throws Exception {
		return seminarDAO.selectSeminarInfoAlrimCheck(seminarVO);
	}
	
	public List<SeminarEntryVO> selectSeminarEntryAlrimCheck(SeminarVO seminarVO)  throws Exception {
		return seminarDAO.selectSeminarEntryAlrimCheck(seminarVO);
	}
	
	public List<CmmnDetailCode> getEduCode() throws Exception {
		return seminarDAO.getEduCode();
	}
}