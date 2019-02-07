package daewooInfo.admin.security.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.admin.security.service.EgovGroupManageService;
import daewooInfo.admin.onetouch.bean.EmpOnetouchSmsVO;
import daewooInfo.admin.security.bean.GroupManage;
import daewooInfo.admin.security.bean.GroupManageVO;
import daewooInfo.admin.security.dao.GroupManageDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 그룹관리에 관한 ServiceImpl 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *
 * </pre>
 */

@Service("egovGroupManageService")
public class EgovGroupManageServiceImpl extends AbstractServiceImpl implements EgovGroupManageService {

	/**
	 * @uml.property  name="groupManageDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="groupManageDAO")
    private GroupManageDAO groupManageDAO;
	
	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * @param groupManageVO GroupManageVO
	 * @return List<GroupManageVO>
	 * @exception Exception
	 */
	public List<GroupManageVO> selectGroupList(GroupManageVO groupManageVO) throws Exception {
		return groupManageDAO.selectGroupList(groupManageVO);
	}
	
	/**
	 * 검색조건에 따른 그룹정보를 조회
	 * @param groupManageVO GroupManageVO
	 * @return GroupManageVO
	 * @exception Exception
	 */
	public GroupManageVO selectGroup(GroupManageVO groupManageVO) throws Exception {
		return groupManageDAO.selectGroup(groupManageVO);
	}
	
	/**
	 * 검색조건에 따른 그룹정보를 조회
	 * @param groupManageVO GroupManageVO
	 * @return GroupManageVO
	 * @exception Exception
	 */
	public List<HashMap<String, String>> selectGroupMember(String groupId) throws Exception {
		return groupManageDAO.selectGroupMember(groupId);
	}

	/**
	 * 그룹 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param groupManage
	 * @param groupManageVO
	 * @param empOnetouchSmsVO
	 * @throws Exception
	 */
	public void insertGroup(GroupManage groupManage, GroupManageVO groupManageVO, EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception {
		groupManageDAO.insertGroup(groupManage);
		String regId = empOnetouchSmsVO.getReg_id();
		String groupId = groupManage.getGroupId();
		
		for(String id : empOnetouchSmsVO.getMember_id().split(","))
    	{
    		empOnetouchSmsVO = new EmpOnetouchSmsVO();
    		empOnetouchSmsVO.setMember_id(id);
    		empOnetouchSmsVO.setReg_id(regId);
    		empOnetouchSmsVO.setGroup_id(groupId);
    		
    		groupManageDAO.insertGroupMember(empOnetouchSmsVO);
    	}
	}

	/**
	 * 화면에 조회된 그룹의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param groupManage GroupManage
	 * @exception Exception
	 */
	public void updateGroup(GroupManage groupManage) throws Exception {
		groupManageDAO.updateGroup(groupManage);
	}
	
	/**
	 * 불필요한 그룹정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param groupManage GroupManage
	 * @exception Exception
	 */
	public void deleteGroup(GroupManage groupManage) throws Exception {
		groupManageDAO.deleteGroup(groupManage);
		groupManageDAO.deleteGroupMember(groupManage);
	}
	
    /**
	 * 목록조회 카운트를 반환한다
	 * @param groupManageVO GroupManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectGroupListTotCnt(GroupManageVO groupManageVO) throws Exception {
		return groupManageDAO.selectGroupListTotCnt(groupManageVO);
	}
}