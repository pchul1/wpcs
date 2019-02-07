package daewooInfo.admin.onetouch.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import daewooInfo.admin.onetouch.bean.EmpOnetouchSmsVO;

public interface EmpOnetouchSmsService {


    /**
	 * 원터치 담당자를 조회한다.
     * @param empOnetouchSmsVO
     * @return List(담당자 목록)
     * @throws Exception
     */
	List<EmpOnetouchSmsVO> selectEmpOnetouchSmsList(EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception;
    
    /**
	 * 원터치 담당자를 입력 또는 수정한다.
     * @param empOnetouchSmsVO
     */
	void insertEmpOnetouchSms(EmpOnetouchSmsVO empOnetouchSmsVO) throws Exception;
	

    /**
	 * 원터치 담당자를 삭제한다.
     * @param empOnetouchSmsVO
     */
	void deleteEmpOnetouchSms(EmpOnetouchSmsVO empOnetouchSmsVO,HttpServletRequest request) throws Exception;
}