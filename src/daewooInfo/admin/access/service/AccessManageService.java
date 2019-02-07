package daewooInfo.admin.access.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import daewooInfo.admin.access.bean.AccessManageVO;

public interface AccessManageService {	

    /** 개인정보조회이력  ************************/
	/**
	 * 개인정보조회이력 정보를 등록한다.
	 * @param AccessManageVO
	 * @throws Exception
	 */
	void insertFilterAccess(AccessManageVO accessManageVO) throws Exception;    
	
	/**
	 * 개인정보조회이력 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	List selectAccessIndiList(AccessManageVO vo) throws Exception;

	/**
	 * 개인정보조회이력 총건수를 조회한다.
	 * @param vo ComDefaultVO 
	 * @return int 
	 * @exception Exception
	 */
	int selectAccessIndiListTotCnt(AccessManageVO vo) throws Exception;
	
	/**
	 * 개인정보조회이력 정보변경 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	List selectAccessChangeInfoList(AccessManageVO vo) throws Exception;


    /** 접속이력  ************************/
	
	/**
	 * 접속이력 정보를 등록한다.
	 * @param AccessManageVO
	 * @throws Exception
	 */
	void insertAccessLogin(AccessManageVO accessManageVO, HttpServletRequest request) throws Exception;    
	
	/**
	 * 접속이력 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	List selectAccessLoginList(AccessManageVO vo) throws Exception;

	/**
	 * 접속이력 총건수를 조회한다.
	 * @param vo ComDefaultVO 
	 * @return int 
	 * @exception Exception
	 */
	int selectAccessLoginListTotCnt(AccessManageVO vo) throws Exception;
	
}
