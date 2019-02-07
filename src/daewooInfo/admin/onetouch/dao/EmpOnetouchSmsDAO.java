package daewooInfo.admin.onetouch.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.admin.onetouch.bean.EmpOnetouchSmsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("EmpOnetouchSmsDAO")
public class EmpOnetouchSmsDAO extends EgovAbstractDAO {
	/** log */
    protected static final Log LOG = LogFactory.getLog(EmpOnetouchSmsDAO.class);
    
    /**
	 * 원터치 담당자를 조회한다.
     * @param empOnetouchSmsVO
     * @return List(담당자 목록)
     * @throws Exception
     */
    public List<EmpOnetouchSmsVO> selectEmpOnetouchSmsList(EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception {
        return list("EmpOnetouchSmsDAO.selectEmpOnetouchSmsList", empOnetouchSmsVO);
    }
    
    /**
	 * 원터치 담당자를 입력 한다.
     * @param empOnetouchSmsVO
     */
    public void insertEmpOnetouchSms(EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception {
        insert("EmpOnetouchSmsDAO.insertEmpOnetouchSms", empOnetouchSmsVO);
    }

    /**
	 * 원터치 담당자를 삭제한다.
     * @param empOnetouchSmsVO
     */
    public void deleteEmpOnetouchSms(EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception {
        delete("EmpOnetouchSmsDAO.deleteEmpOnetouchSms", empOnetouchSmsVO);
    }
}