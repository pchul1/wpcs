package daewooInfo.admin.member.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import daewooInfo.admin.cmmncode.bean.CmmnCode;
import daewooInfo.admin.keyword.bean.KeywordVO;
import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.admin.member.bean.UserMenuAuthVO;
import daewooInfo.common.login.bean.MemberVO;

public interface MemberService {
	
	/**
	 * 유저를 삭제한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void deleteMember(MemberVO memberVO) throws Exception;

	/**
	 * 유저를 등록한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void insertMember(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 유저의 상세항목을 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 * @throws Exception
	 */
	MemberVO selectMemberDetail(MemberVO memberVO) throws Exception;

	/**
	 * 유저의 상세항목을 조회 후 개인정보 접근에 대한 기록을 남긴다.
	 * @param memberVO
	 * @return MemberVO
	 * @throws Exception
	 */
	MemberVO selectMemberDetail(MemberVO memberVO, Boolean personalInformation) throws Exception;
	
	/**
	 * 유저의 개인정보보호정보를 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 * @throws Exception
	 */
	MemberVO selectMemberPrivacy(MemberVO memberVO) throws Exception;
	
	/**
	 * 유저의 목록을 조회한다.
	 * @param searchVO
	 * @return List(유저 목록)
	 * @throws Exception
	 */
	List<MemberSearchVO> selectMemberList(MemberSearchVO searchVO) throws Exception;

    /**
	 * 유저의 총 갯수를 조회한다.
     * @param searchVO
     * @return int(유저 총 갯수)
     */
    int selectMemberListTotCnt(MemberSearchVO memberVO) throws Exception;
	
	/**
	 * 유저를 수정한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void updateMember(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 유저를 수정한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void updateInfo(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 개인정보동의를 수정한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void updatePrivacy(MemberVO memberVO) throws Exception;
	
	/**
	 * 비밀번호를 변경한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void changePassword(MemberVO memberVO) throws Exception;

	/**
	 * 계정 휴면 상태를 해제한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void unlockDormancy(MemberVO memberVO) throws Exception;
	
	
	/**
	 * 계정 비밀번호 잠금을 해제한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void unlockPassword(MemberVO memberVO) throws Exception;
	
	/**
	 * 유저 히스토리를 등록한다.
	 * @param memberVO
	 * @throws Exception
	 */
	void insertMemberHistory(MemberVO memberVO) throws Exception;
	
	/**
	 * ID중복체크
     * @param searchVO
     * @return int(유저 총 갯수)
     */
    int getDuplicateIdCheck(String memberId) throws Exception;
    
    /**
	 * 계정신청
	 * @param memberVO
	 * @throws Exception
	 */
	void insertMemberApply(MemberVO memberVO) throws Exception;
	
	/**
	 * 관리자 ID입력
	 */
	void updateMemberMgId(String memberId) throws Exception; 
	
	/**
	 * 유저의 상세항목을 조회한다.
	 * @param memberVO
	 * @return MemberVO
	 * @throws Exception
	 */
	MemberVO selectMemberInfo(String memberId) throws Exception;
	
	/**
	 * 승인처리
	 * @param memberVO
	 * @throws Exception
	 */
	void updateMemberApp(MemberVO memberVO, MultipartHttpServletRequest multiRequest) throws Exception;
	
	/**
	 * 권한처리
	 * @param memberVO
	 * @throws Exception
	 */
	void insertAuthorGroup(MemberVO memberVO) throws Exception;
	
	/**
	 * ID찾기
	 */
	String getAccountFindId(MemberVO memberVO) throws Exception;
	
	/**
	 * 도 정보 찾기
	 * @param sugye
	 * @return
	 * @throws Exception
	 */
	List<HashMap> getTmsCityList(String tmsDoCode) throws Exception;
	
	/**
	 * 측정소 정보 리스트 가져오기
	 * @param sugye
	 * @return
	 * @throws Exception
	 */
	List<HashMap> getAuthorFactList(String auth_syskind, String auth_riverdiv);
	
	/**
	 * 측정소 정보 리스트 가져오기
	 * @param sugye
	 * @return
	 * @throws Exception
	 */
	List<HashMap> getMemberAuthorFactList(String member_id);
	
	/**
	 * 측정소 정보 등록
	 * @param sugye
	 * @return
	 * @throws Exception
	 */
	void InsertMyAuthorFact(String member_id, String auth_syskind, String auth_myFactList);
	
	/**
	 * 측정소 정보 등록
	 * @param sugye
	 * @return
	 * @throws Exception
	 */
	void DeleteMyAuthorFact(String member_id, String auth_myFactList);

	
	
	
	
	List<UserMenuAuthVO> selectUserMenuAuthList(MemberVO mvo) throws Exception;

	int getUserAuthorCnt(UserMenuAuthVO umav) throws Exception;

	void userMenuAuthSaveu(UserMenuAuthVO umav) throws Exception;

	void userMenuAuthSavei(UserMenuAuthVO umav) throws Exception;
	
}
