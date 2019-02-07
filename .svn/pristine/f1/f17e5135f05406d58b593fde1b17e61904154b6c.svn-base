package daewooInfo.admin.mindataEmployee.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import daewooInfo.admin.mindataEmployee.bean.MindataEmployeeVO;

public interface MindataEmployeeService {


    /**
	 * 데이터 선별 담당자를 조회한다.
     * @param mindataEmployeeVO
     * @return List(담당자 목록)
     * @throws Exception
     */
	List<MindataEmployeeVO> selectMindataEmployeeList(MindataEmployeeVO mindataEmployeeVO) throws Exception;
    
    /**
	 * 데이터 선별 담당자를 입력 또는 수정한다.
     * @param mindataEmployeeVO
     */
	void insertMindataEmployee(MindataEmployeeVO mindataEmployeeVO) throws Exception;
	

    /**
	 * 데이터 선별치 담당자를 삭제한다.
     * @param mindataEmployeeVO
     */
	void deleteMindataEmployee(MindataEmployeeVO mindataEmployeeVO,HttpServletRequest request) throws Exception;
	

    /**
	 * 데이터 선별치 담당자를 삭제한다.
     * @param mindataEmployeeVO
     */
	void updateMindataDefiniteDate(MindataEmployeeVO mindataEmployeeVO,HttpServletRequest request) throws Exception;
}