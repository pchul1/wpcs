package daewooInfo.admin.mindataEmployee.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.ServletRequestUtils;

import daewooInfo.admin.mindataEmployee.bean.MindataEmployeeVO;
import daewooInfo.admin.mindataEmployee.dao.MindataEmployeeDAO;
import daewooInfo.admin.mindataEmployee.service.MindataEmployeeService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("MindataEmployeeService")
public class MindataEmployeeImpl extends AbstractServiceImpl implements MindataEmployeeService {

    @Resource(name="MindataEmployeeDAO")
    private MindataEmployeeDAO mindataEmployeeDAO;
    
    /**
	 * 데이터 선별 담당자를 조회한다.
     * @param mindataEmployeeVO
     * @return List(담당자 목록)
     * @throws Exception
     */
    public List<MindataEmployeeVO> selectMindataEmployeeList(MindataEmployeeVO mindataEmployeeVO) throws Exception {
        return mindataEmployeeDAO.selectMindataEmployeeList(mindataEmployeeVO);
    }
    
    /**
	 * 데이터 선별 담당자를 입력 또는 수정한다.
     * @param mindataEmployeeVO
     */
    public void insertMindataEmployee(MindataEmployeeVO mindataEmployeeVO) throws Exception {
    	MindataEmployeeVO vo;
    	for(String id : mindataEmployeeVO.getMember_id().split(","))
    	{
    		vo = new MindataEmployeeVO();
    		vo.setMember_id(id);
    		vo.setGubun(mindataEmployeeVO.getGubun());
    		mindataEmployeeDAO.insertMindataEmployee(vo);
    	}
    }
    
    /**
	 * 데이터 선별 담당자를 삭제한다.
     * @param mindataEmployeeVO
     */
    public void deleteMindataEmployee(MindataEmployeeVO mindataEmployeeVO, HttpServletRequest request) throws Exception {

    	for(String seq : ServletRequestUtils.getStringParameters(request, "SeqCheck"))
    	{
    		mindataEmployeeVO = new MindataEmployeeVO();
    		mindataEmployeeVO.setSeq(seq);
    		mindataEmployeeDAO.deleteMindataEmployee(mindataEmployeeVO);
    	}
    }
    
    /**
	 * 데이터 선별 담당자를 삭제한다.
     * @param mindataEmployeeVO
     */
    public void updateMindataDefiniteDate(MindataEmployeeVO mindataEmployeeVO, HttpServletRequest request) throws Exception {
		mindataEmployeeDAO.updateMindataDefiniteDate(mindataEmployeeVO);
    }
}