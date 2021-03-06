package daewooInfo.admin.member.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import daewooInfo.admin.access.bean.AccessManageVO;
import daewooInfo.admin.access.service.AccessManageService;
import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.admin.member.bean.UserMenuAuthVO;
import daewooInfo.admin.member.dao.MemberDAO;
import daewooInfo.admin.member.service.MemberService;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.sim.FileScrty;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("memberService")
public class MemberServiceImpl extends AbstractServiceImpl implements MemberService {

    /**
	 * @uml.property  name="memberDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="memberDAO")
    private MemberDAO memberDAO;
    
    /**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "memberIdGnrService")
    private EgovIdGnrService idgenService;
    

	/**
	 * @uml.property  name="fileUtil"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	/**
	 * @uml.property  name="fileMngService"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;


    @Resource(name = "accessManageService")
    private AccessManageService accessManageService;
    
	public void deleteMember(MemberVO memberVO) throws Exception {
		this.accessHistoryManage(memberVO,"D");
		memberDAO.deleteMember(memberVO);
		
		memberVO.setHtype("D");
		memberDAO.insertMemberHistory(memberVO);
	}

	public void insertMember(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception {
		
		// uniq_id 부여
		String uniqId = idgenService.getNextStringId();
		memberVO.setUniqId(uniqId);
		
		// 패스워드 암호화
		String enpassword = FileScrty.encryptPassword(memberVO.getPassword());
		memberVO.setPassword(enpassword);

		this.accessHistoryManage(memberVO,"W",multiRequest);
		memberVO.setHtype("W");
		memberDAO.insertMemberHistory(memberVO);
		
		String atchFileId = "";
		List<FileVO> result = null;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		result = fileUtil.parseFileInf(files, "MEMBER_", 0, "", "");
		if (result.size() >0 ) {
			//썸네일
			String loadFile = result.get(0).getFileStreCours() + result.get(0).getStreFileNm();
			fileUtil.resizeImage(loadFile, loadFile, 100, 70);
			
			atchFileId = fileMngService.insertFileInfs(result);
			memberVO.setSignature_file(atchFileId);
		}
		
		memberDAO.insertMember(memberVO);
		
	}

	public List<MemberSearchVO> selectMemberList(MemberSearchVO searchVO)
			throws Exception {
		return memberDAO.selectMemberList(searchVO);	
	}

	public int selectMemberListTotCnt(MemberSearchVO searchVO) throws Exception {
		return memberDAO.selectMemberListTotCnt(searchVO);
	}

	public MemberVO selectMemberDetail(MemberVO memberVO) throws Exception {
		return memberDAO.selectMemberDetail(memberVO);
	}
	
	public MemberVO selectMemberDetail(MemberVO memberVO, Boolean personalInfomation) throws Exception {
		if(personalInfomation) {
			this.accessHistoryManage(memberVO,"R");
		}
		return memberDAO.selectMemberDetail(memberVO);
	}

	public MemberVO selectMemberPrivacy(MemberVO memberVO) throws Exception {
	return memberDAO.selectMemberPrivacy(memberVO);
}
	
	public void updateMember(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String atchFileId = "";
		List<FileVO> result = null;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		result = fileUtil.parseFileInf(files, "MEMBER_", 0, "", "");
		if (result.size() >0 ) {
			
			//썸네일
			String loadFile = result.get(0).getFileStreCours() + result.get(0).getStreFileNm();
			fileUtil.resizeImage(loadFile, loadFile, 100, 70);
			
			atchFileId = fileMngService.insertFileInfs(result);
			memberVO.setSignature_file(atchFileId);
		}
		this.accessHistoryManage(memberVO,"U",multiRequest);
		memberVO.setHtype("U");
		memberDAO.insertMemberHistory(memberVO);
		memberDAO.updateMember(memberVO);
	}

	public void updateInfo(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String atchFileId = "";
		List<FileVO> result = null;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		result = fileUtil.parseFileInf(files, "MEMBER_", 0, "", "");
		if (result.size() >0 ) {
			
			//썸네일
			String loadFile = result.get(0).getFileStreCours() + result.get(0).getStreFileNm();
			fileUtil.resizeImage(loadFile, loadFile, 100, 70);
			
			atchFileId = fileMngService.insertFileInfs(result);
			memberVO.setSignature_file(atchFileId);
		}
		this.accessHistoryManage(memberVO,"U",multiRequest);
		memberVO.setHtype("U");
		memberDAO.insertMemberHistory(memberVO);
		memberDAO.updateInfo(memberVO);
	}

	public void updatePrivacy(MemberVO memberVO) throws Exception {
		this.accessHistoryManage(memberVO,"U");
		memberVO.setHtype("U");
		memberDAO.insertMemberHistory(memberVO);
		memberDAO.updatePrivacy(memberVO);
	}
	
	public void unlockDormancy(MemberVO memberVO) throws Exception {
		this.accessHistoryManage(memberVO,"U");
		memberVO.setHtype("U");
		memberDAO.insertMemberHistory(memberVO);
		memberDAO.unlockDormancy(memberVO);
	}
	
	public void unlockPassword(MemberVO memberVO) throws Exception {
		this.accessHistoryManage(memberVO,"U");
		memberVO.setHtype("U");
		memberDAO.insertMemberHistory(memberVO);
		memberDAO.unlockPassword(memberVO);
	}
	
	public void changePassword(MemberVO memberVO) throws Exception {
		// 패스워드 암호화
		String enpassword = FileScrty.encryptPassword(memberVO.getPassword());
		memberVO.setPassword(enpassword);
		
		memberDAO.changePassword(memberVO);
	}
	
	public void insertMemberHistory(MemberVO memberVO) throws Exception {			
    	
    	memberDAO.insertMemberHistory(memberVO);
    	
	}	
	
	public void accessHistoryManage(MemberVO memberVO, String type) throws Exception {
		AccessManageVO accessManageVO = new AccessManageVO();
		accessManageVO.setMemberId(memberVO.getMemberId());
		accessManageVO.setTableNm("T_MEMBER");
		accessManageVO.setType(type);
		accessManageVO.setConnectIp(memberVO.getConnectIp());
    	accessManageService.insertFilterAccess(accessManageVO);    	
	}
	
	public void accessHistoryManage(MemberVO memberVO, String type,
			MultipartHttpServletRequest multiRequest) throws Exception {
		AccessManageVO accessManageVO = new AccessManageVO();
		accessManageVO.setMemberId(memberVO.getMemberId());
		accessManageVO.setTableNm("T_MEMBER");
		accessManageVO.setType(type);
		accessManageVO.setConnectIp(multiRequest.getRemoteAddr());
    	accessManageService.insertFilterAccess(accessManageVO);
	}
	
	public int getDuplicateIdCheck(String memberId) throws Exception {
		return memberDAO.getDuplicateIdCheck(memberId);
	}
	
	public void insertMemberApply(MemberVO memberVO) throws Exception {
		
		// uniq_id 부여
		String uniqId = idgenService.getNextStringId();
		memberVO.setUniqId(uniqId);
		
		// 패스워드 암호화
		String enpassword = FileScrty.encryptPassword(memberVO.getPassword());
		memberVO.setPassword(enpassword);

//		this.accessHistoryManage(memberVO,"W");
		memberVO.setHtype("W");
//		memberDAO.insertMemberHistory(memberVO);
	
		memberDAO.insertMemberApply(memberVO);
		
	}
	
	public void updateMemberMgId(String memberId) throws Exception {
		memberDAO.updateMemberMgId(memberId);
		
	}
	
	public MemberVO selectMemberInfo(String memberId) throws Exception {
		return memberDAO.selectMemberInfo(memberId);
	}
	
	public void updateMemberApp(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception {
		this.accessHistoryManage(memberVO,"U",multiRequest);
		memberDAO.updateMemberApp(memberVO);
		
	}
	public void insertAuthorGroup(MemberVO memberVO) throws Exception {
		memberDAO.insertAuthorGroup(memberVO);
		
	}
	
	public String getAccountFindId(MemberVO memberVO) throws Exception {
		return memberDAO.getAccountFindId(memberVO);
	}
	
	public List<HashMap> getTmsCityList(String tmsDoCode) throws Exception {
		return memberDAO.getTmsCityList(tmsDoCode);
	}

	public List<HashMap> getAuthorFactList(String auth_syskind, String auth_riverdiv){
		return memberDAO.getAuthorFactList(auth_syskind, auth_riverdiv);
 	}

	public List<HashMap> getMemberAuthorFactList(String member_id){
		return memberDAO.getMemberAuthorFactList(member_id);
 	}
	
	public void InsertMyAuthorFact(String member_id, String auth_syskind, String auth_myFactList){
		String[] auth_myFactArray = auth_myFactList.split(",");
		String fact_code;
		String branch_no;
		for(String fact : auth_myFactArray){
			fact_code = null;
			branch_no = null;
			if(fact.indexOf("-") > -1){
				fact_code = fact.split("-")[0];
				branch_no = fact.split("-")[1];
			}else{
				fact_code = fact;
			}
			memberDAO.InsertMyAuthorFact(member_id, auth_syskind, fact_code, branch_no);
		}
 	}

	public void DeleteMyAuthorFact(String member_id, String auth_myFactList){
		String[] auth_myFactArray = auth_myFactList.split(",");
		String fact_code;
		String branch_no;
		for(String fact : auth_myFactArray){
			fact_code = null;
			branch_no = null;
			if(fact.indexOf("-") > -1)
			{
				fact_code = fact.split("-")[0];
				branch_no = fact.split("-")[1];
			}
			memberDAO.DeleteMyAuthorFact(member_id, fact_code, branch_no);
		}
	}

	@Override
	public List<UserMenuAuthVO> selectUserMenuAuthList(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
			return memberDAO.getUserMenuAuthList(memberVO);
	}

	@Override
	public int getUserAuthorCnt(UserMenuAuthVO umav) throws Exception{
		// TODO Auto-generated method stub
		return memberDAO.getUserAuthorCnt(umav);
	}
	@Override
	public void userMenuAuthSavei(UserMenuAuthVO umav) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println(umav.getAuthC());
		//System.out.println(umav.getAuthU());
		//System.out.println(umav.getAuthD());
		//System.out.println(umav.getUserId());
		//System.out.println(umav.getMenuId());
		memberDAO.userMenuAuthSavei(umav);
	}
	@Override
	public void userMenuAuthSaveu(UserMenuAuthVO umav) throws Exception {
		// TODO Auto-generated method stub
		memberDAO.userMenuAuthSaveu(umav);
	}
}
