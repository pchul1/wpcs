package daewooInfo.admin.access.service.impl;

import java.io.IOException;
import java.net.InetAddress;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import daewooInfo.admin.access.bean.AccessManageVO;
import daewooInfo.admin.access.dao.AccessManageDAO;
import daewooInfo.admin.access.service.AccessManageService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.CommonUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("accessManageService")
public class AccessManageServiceImpl extends AbstractServiceImpl implements AccessManageService {

    @Resource(name="accessManageDAO")
    private AccessManageDAO accessManageDAO;

    /** 개인정보조회이력  ************************/

	public void insertFilterAccess(AccessManageVO accessManageVO) throws Exception {

		InetAddress ip = InetAddress.getLocalHost();
		String serverIp = ip.getHostAddress();

		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		accessManageVO.setLoginId(user.getId());

		accessManageVO.setIp(serverIp);

		accessManageDAO.insertFilterAccess(accessManageVO);
	}

	public List selectAccessIndiList(AccessManageVO vo) throws Exception {
		return accessManageDAO.selectAccessIndiList(vo);
	}

	public int selectAccessIndiListTotCnt(AccessManageVO vo) throws Exception {
		return accessManageDAO.selectAccessIndiListTotCnt(vo);
	}

	public List selectAccessChangeInfoList(AccessManageVO vo) throws Exception {
		return accessManageDAO.selectAccessChangeInfoList(vo);
	}


    /** 접속이력  ************************/

	public void insertAccessLogin(AccessManageVO accessManageVO, HttpServletRequest request) throws Exception {
		
		try{
			String User_Agent  = request.getHeader("User-Agent");
			String OsBrName[] = CommonUtil.osName(User_Agent.toLowerCase());
			String session_id =  request.getSession().getId();
			String uip =  request.getHeader("Proxy-Client-IP");
	//		uip = uip == null || "".equals(uip) ? request.getRemoteAddr() : uip;
	//		InetAddress ip = InetAddress.getLocalHost();
	//		String serverIp = ip.getHostAddress();
			String udomain =  request.getServerName();
			String UPAGE = request.getRequestURI();
	
			
			boolean insert = true;
			String[] notinsertstr = {".jsp","validator.do","init.do"}; 
			
			for(int i=0;i<notinsertstr.length;i++){
				if(UPAGE.indexOf(notinsertstr[i]) > 0){
					insert = false;
				}
			}
			
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			
			if(insert && user!=null){
				accessManageVO.setUip(uip);
				accessManageVO.setUpage(UPAGE);
				accessManageVO.setUdomain(udomain);
				accessManageVO.setUos(OsBrName[0]);
				accessManageVO.setUbrowser(OsBrName[1]);
		
				accessManageVO.setUserId(user.getId());
		
				HttpSession session = request.getSession();
				session.setAttribute("user_id", accessManageVO.getUserId());
		
				accessManageDAO.insertAccessLogin(accessManageVO);
			}
		} catch (Exception e) { 
			log.error("AccessManageServiceImpl.java : insertAccessLogin 에러");
		} 
	}

	public List selectAccessLoginList(AccessManageVO vo) throws Exception {
		return accessManageDAO.selectAccessLoginList(vo);
	}

	public int selectAccessLoginListTotCnt(AccessManageVO vo) throws Exception {
		return accessManageDAO.selectAccessLoginListTotCnt(vo);
	}
}
