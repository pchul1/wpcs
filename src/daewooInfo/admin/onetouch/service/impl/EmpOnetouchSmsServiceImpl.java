package daewooInfo.admin.onetouch.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.ServletRequestUtils;

import daewooInfo.admin.onetouch.bean.EmpOnetouchSmsVO;
import daewooInfo.admin.onetouch.dao.EmpOnetouchSmsDAO;
import daewooInfo.admin.onetouch.service.EmpOnetouchSmsService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("EmpOnetouchSmsService")
public class EmpOnetouchSmsServiceImpl extends AbstractServiceImpl implements EmpOnetouchSmsService {

    @Resource(name="EmpOnetouchSmsDAO")
    private EmpOnetouchSmsDAO empOnetouchSmsDAO;
    
    /**
	 * 원터치 담당자를 조회한다.
     * @param empOnetouchSmsVO
     * @return List(담당자 목록)
     * @throws Exception
     */
    public List<EmpOnetouchSmsVO> selectEmpOnetouchSmsList(EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception {
        return empOnetouchSmsDAO.selectEmpOnetouchSmsList(empOnetouchSmsVO);
    }
    
    /**
	 * 원터치 담당자를 입력 또는 수정한다.
     * @param empOnetouchSmsVO
     */
    public void insertEmpOnetouchSms(EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception {
    	for(String id : empOnetouchSmsVO.getMember_id().split(","))
    	{
    		empOnetouchSmsVO = new EmpOnetouchSmsVO();
    		empOnetouchSmsVO.setMember_id(id);
    		empOnetouchSmsDAO.insertEmpOnetouchSms(empOnetouchSmsVO);
    	}
    }
    
    /**
	 * 원터치 담당자를 삭제한다.
     * @param empOnetouchSmsVO
     */
    public void deleteEmpOnetouchSms(EmpOnetouchSmsVO empOnetouchSmsVO, HttpServletRequest request) throws Exception {

    	for(String seq : ServletRequestUtils.getStringParameters(request, "SeqCheck"))
    	{
    		empOnetouchSmsVO = new EmpOnetouchSmsVO();
    		empOnetouchSmsVO.setSeq(seq);
    		empOnetouchSmsDAO.deleteEmpOnetouchSms(empOnetouchSmsVO);
    	}
    }
}