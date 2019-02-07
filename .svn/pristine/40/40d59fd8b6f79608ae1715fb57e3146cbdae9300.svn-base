package daewooInfo.admin.mindataEmployee.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.admin.mindataEmployee.bean.MindataEmployeeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("MindataEmployeeDAO")
public class MindataEmployeeDAO extends EgovAbstractDAO {
	/** log */
    protected static final Log LOG = LogFactory.getLog(MindataEmployeeDAO.class);
    
    /**
	 * 데이터 선별 담당자를 조회한다.
     * @param mindataEmployeeVO
     * @return List(담당자 목록)
     * @throws Exception
     */
    public List<MindataEmployeeVO> selectMindataEmployeeList(MindataEmployeeVO mindataEmployeeVO) throws Exception {
        return list("MindataEmployeeDAO.selectMindataEmployeeList", mindataEmployeeVO);
    }
    
    /**
	 * 데이터 선별 담당자를 입력 한다.
     * @param mindataEmployeeVO
     */
    public void insertMindataEmployee(MindataEmployeeVO mindataEmployeeVO) throws Exception {
        insert("MindataEmployeeDAO.insertMindataEmployee", mindataEmployeeVO);
    }

    /**
	 * 데이터 선별 담당자를 삭제한다.
     * @param mindataEmployeeVO
     */
    public void deleteMindataEmployee(MindataEmployeeVO mindataEmployeeVO) throws Exception {
        delete("MindataEmployeeDAO.deleteMindataEmployee", mindataEmployeeVO);
    }
    
    /**
	 * 데이터 선별 담당자를 삭제한다.
     * @param mindataEmployeeVO
     */
    public void updateMindataDefiniteDate(MindataEmployeeVO mindataEmployeeVO) throws Exception {
        update("MindataEmployeeDAO.updateMindataDefiniteDate", mindataEmployeeVO);
    }
}