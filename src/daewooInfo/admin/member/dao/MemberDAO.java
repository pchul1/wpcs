package daewooInfo.admin.member.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.admin.member.bean.UserMenuAuthVO;
import daewooInfo.common.login.bean.MemberVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("memberDAO")
public class MemberDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(MemberDAO.class);
    
    /**
	 * 유저 목록을 조회한다.
     * @param searchVO
     * @return List(유저 목록)
     * @throws Exception
     */
    public List selectMemberList(MemberSearchVO searchVO) throws Exception {
        return list("MemberManageDAO.selectMemberList", searchVO);
    }
    
    /**
	 * 유저 총 갯수를 조회한다.
     * @param searchVO
     * @return int(유저 총 갯수)
     */
    public int selectMemberListTotCnt(MemberSearchVO searchVO) throws Exception {
        return (Integer)selectByPk("MemberManageDAO.selectMemberListTotCnt", searchVO);
    }
    
    /**
	 * 유저의 상세항목을 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 */
	public MemberVO selectMemberDetail(MemberVO memberVO) throws Exception {
		return (MemberVO)selectByPk("MemberManageDAO.selectMemberDetail", memberVO);
	}
    
    /**
	 * 유저의 개인정보보호정보를 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 */
	public MemberVO selectMemberPrivacy(MemberVO memberVO) throws Exception {
		return (MemberVO)selectByPk("MemberManageDAO.selectMemberPrivacy", memberVO);
	}
    
    
    /**
	 * 유저를 등록한다.
	 * @param memberVO
	 * @throws Exception
	 */
	public void insertMember(MemberVO memberVO) throws Exception {
        insert("MemberManageDAO.insertMember", memberVO);
	}

	/**
	 * 유저를 수정한다.
	 * @param memberVO
	 * @throws Exception
	 */
	public void updateMember(MemberVO memberVO) throws Exception {
		update("MemberManageDAO.updateMember", memberVO);
	}
	  
	/**
	 * 유저를 수정한다.
	 * @param memberVO
	 * @throws Exception
	 */
	public void updateInfo(MemberVO memberVO) throws Exception {
		update("MemberManageDAO.updateInfo", memberVO);
	}
	
	/**
	 * 유저를 삭제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void deleteMember(MemberVO memberVO) throws Exception {
		delete("MemberManageDAO.deleteMember", memberVO);
	}

	/**
	 * 계정 휴면 상태를 해제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void unlockDormancy(MemberVO memberVO) throws Exception {
		delete("MemberManageDAO.unlockDormancy", memberVO);
	}
	
	/**
	 * 계정 비밀번호 잠금을 해제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void unlockPassword(MemberVO memberVO) throws Exception {
		delete("MemberManageDAO.unlockPassword", memberVO);
	}
	
	/**
	 * 개인정보동의를 수정한다.
	 * @param memberVO
	 * @throws Exception
	 */
	public void updatePrivacy(MemberVO memberVO) throws Exception {
		update("MemberManageDAO.updatePrivacy", memberVO);
	}
	
	/**
	 * 비밀번호를 변경한다.
	 * @param memberVO
	 * @throws Exception
	 */
	public void changePassword(MemberVO memberVO) throws Exception {
		update("MemberManageDAO.changePassword", memberVO);
	}

    /**
	 * 유저 히스토리를 등록한다.
	 * @param memberVO
	 * @throws Exception
	 */
	public void insertMemberHistory(MemberVO memberVO) throws Exception {
        insert("MemberManageDAO.insertMemberHistory", memberVO);
	}
	
    /**
	 * 유저 히스토리를 조회한다.
     * @param searchVO
     * @return List(유저 목록)
     * @throws Exception
     */
    public List selectMemberHistoryList(MemberSearchVO searchVO) throws Exception {
        return list("MemberManageDAO.selectMemberHistoyList", searchVO);
    }
    
    /**
	 * 유저히스토리의 총 갯수를 조회한다.
     * @param searchVO
     * @return int(유저히스토리 총 갯수)
     */
    public int selectMemberHistoryListTotCnt(MemberSearchVO searchVO) throws Exception {
        return (Integer)selectByPk("MemberManageDAO.selectMemberHistoryListTotCnt", searchVO);
    }
    
    /**
	 * ID중복 체크
     * @param searchVO
     * @return
     */
    public int getDuplicateIdCheck(String memberId) throws Exception {
        return (Integer)selectByPk("MemberManageDAO.getDuplicateIdCheck", memberId);
    }
    
    /**
	 * 계정신청
	 * @param memberVO
	 * @throws Exception
	 */
	public void insertMemberApply(MemberVO memberVO) throws Exception {
        insert("MemberManageDAO.insertMemberApply", memberVO);
	}
	
	/**
	 * 관리자 ID 생성
	 * @param memberVO
	 * @throws Exception
	 */
	public void updateMemberMgId(String memberId) throws Exception {
		update("MemberManageDAO.updateMemberMgId", memberId);
	}
	
	/**
	 * 유저의 상세항목을 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 */
	public MemberVO selectMemberInfo(String memberId) throws Exception {
		return (MemberVO)selectByPk("MemberManageDAO.selectMemberInfo", memberId);
	}
	
	/**
	 * 승인처리
	 * @param memberVO
	 * @throws Exception
	 */
	public void updateMemberApp(MemberVO memberVO) throws Exception {
		update("MemberManageDAO.updateMemberApp", memberVO);
	}
	
	/**
	 * 권한처리
	 * @param memberVO
	 * @throws Exception
	 */
	public void insertAuthorGroup(MemberVO memberVO) throws Exception {
		update("MemberManageDAO.insertAuthorGroup", memberVO);
	}
	
	 /**
	 * ID찾기
     * @param searchVO
     * @return
     */
    public String getAccountFindId(MemberVO memberVO) throws Exception {
        return (String)selectByPk("MemberManageDAO.getAccountFindId", memberVO);
    }

    public List<HashMap> getTmsCityList(String tmsDoCode)
 	{
 		HashMap paraMap = new HashMap();
 		paraMap.put("tmsDoCode", tmsDoCode);
 		return list("MemberManageDAO.getTmsCityList", paraMap);
 	}

    public List<HashMap> getMemberAuthorFactList(String member_id)
 	{
 		HashMap paraMap = new HashMap();
 		paraMap.put("member_id", member_id);
 		return list("MemberManageDAO.getMemberAuthorFactList", paraMap);
 	}
    
    public List<HashMap> getAuthorFactList(String auth_syskind, String auth_riverdiv)
 	{
 		HashMap paraMap = new HashMap();
 		paraMap.put("auth_syskind", auth_syskind);
 		paraMap.put("auth_riverdiv", auth_riverdiv);
 		return list("MemberManageDAO.getAuthorFactList", paraMap);
 	}
	
	public void InsertMyAuthorFact(String member_id, String auth_syskind, String fact_code, String branch_no){
 		HashMap paraMap = new HashMap();
 		paraMap.put("member_id", member_id);
 		paraMap.put("sys_kind", auth_syskind);
 		paraMap.put("fact_code", fact_code);
 		paraMap.put("branch_no", branch_no);
 		update("MemberManageDAO.InsertMyAuthorFact", paraMap);
 	}  

	public void DeleteMyAuthorFact(String member_id, String fact_code, String branch_no){
 		HashMap paraMap = new HashMap();
 		paraMap.put("member_id", member_id);
 		paraMap.put("fact_code", fact_code);
 		paraMap.put("branch_no", branch_no);
 		delete("MemberManageDAO.DeleteMyAuthorFact", paraMap);
	}

	public List<UserMenuAuthVO> getUserMenuAuthList(MemberVO memberVO) throws Exception{
		// TODO Auto-generated method stub
		return list("MemberManageDAO.getUserMenuAuthList", memberVO);
	}

	public int getUserAuthorCnt(UserMenuAuthVO umav) throws Exception{
		// TODO Auto-generated method stub
		return (Integer)selectByPk("MemberManageDAO.getUserMenuAuthCnt", umav);
	}

	public void userMenuAuthSavei(UserMenuAuthVO umav) throws Exception{
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@");
		insert("MemberManageDAO.userMenuAuthSavei", umav);
	}
	public void userMenuAuthSaveu(UserMenuAuthVO umav) throws Exception{
		update("MemberManageDAO.userMenuAuthSaveu", umav);
	}
}
