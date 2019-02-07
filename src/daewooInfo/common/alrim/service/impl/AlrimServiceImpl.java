package daewooInfo.common.alrim.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.ServletRequestUtils;

import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.alrim.dao.AlrimDAO;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 알림 안내 ServiceImpl 클래스
 * @author 박미영
 * @since 2014.09.04
 * @version 1.0
 * @see
 */
@Service("alrimService")
public class AlrimServiceImpl extends AbstractServiceImpl implements AlrimService {
    /**
	 * @uml.property  name="alrimDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="alrimDAO")
    private AlrimDAO alrimDAO;
    
	/**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "alrimIdGnrService")
    private EgovIdGnrService idgenService;
    
    public List<AlrimVO> selectAlrimList(AlrimVO alrimVO) throws Exception {
		return alrimDAO.selectAlrimList(alrimVO);
	}
    
    public int selectAlrimtotList(AlrimVO alrimVO) throws Exception {
		return alrimDAO.selectAlrimtotList(alrimVO);
	}
	
	public int selectAlrimListTotCount(AlrimVO alrimVO) throws Exception {
		return alrimDAO.selectAlrimListTotCount(alrimVO);
	}

	public List<AlrimVO> selectUnConfirmAlrimList(AlrimVO alrimVO) throws Exception {
		return alrimDAO.selectUnConfirmAlrimList(alrimVO);
	}

	/**
	 * 알림 전체 목록을 조회
	 * @param alrimVO
	 * @return List(알림 목록)
	 * @throws Exception
	 */
	public List<AlrimVO> selectMobileSeminarAlrimList(AlrimVO alrimVO) throws Exception{
		return alrimDAO.selectMobileSeminarAlrimList(alrimVO);
	}
	
	public int selectUnConfirmAlrimCount(AlrimVO alrimVO) throws Exception {
		return alrimDAO.selectUnConfirmAlrimCount(alrimVO);
	}	
	
	public String insertAlrim(AlrimVO alrimVO) throws Exception {
    	String alrimInsertCheck = "";
    	String alrimId = idgenService.getNextStringId();
    	alrimVO.setAlrimId(alrimId);
		alrimInsertCheck = alrimDAO.insertAlrim(alrimVO);
		
		return alrimInsertCheck;
	}  
	
	public void updateAlrim(AlrimVO alrimVO) throws Exception {
		alrimDAO.updateAlrim(alrimVO);
	}
	
	public void updateAlrimList(AlrimVO alrimVO,HttpServletRequest request) throws Exception{
		for(String alrimId : ServletRequestUtils.getStringParameters(request, "alrimIdCheck"))
		{
			alrimVO.setAlrimId(alrimId);
			alrimVO.setAlrimApprovalId(LogInfoUtil.GetSessionLogin().getId());
			alrimDAO.updateAlrim(alrimVO);
		}
	}
	
	public void deleteAlrim(AlrimVO alrimVO,HttpServletRequest request) throws Exception {
		for(String alrimId : ServletRequestUtils.getStringParameters(request, "alrimIdCheck"))
		{
			alrimVO.setAlrimId(alrimId);
			alrimVO.setAlrimApprovalId(LogInfoUtil.GetSessionLogin().getId());
			alrimDAO.deleteAlrim(alrimVO);
		}
	}	
}