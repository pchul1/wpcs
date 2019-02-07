package daewooInfo.mobile.com.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import daewooInfo.mobile.com.bean.MobileCommonCodeVO;


/**
* <pre>
* 1. 패키지명 : wpcs.com.service
* 2. 타입명 : DynamicSelectService.java
* 3. 작성일 : 2014. 8. 20. 오후 4:55:57
* 4. 작성자 : kys
* 5. 설명 : 동적 셀렉트 박스
* </pre>
*/
public interface MobileCommonCodeService {

	List<MobileCommonCodeVO> getSystemCodeList(MobileCommonCodeVO commonCodeVO)	throws Exception;
	/**
	* <pre>
	* 1. 메소드명 : getbranch
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 정보
	* </pre>
	*/
	List<MobileCommonCodeVO> getbranch(MobileCommonCodeVO commonCodeVO)	throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : getAutoCodeDiv
	* 2. 작성일 : 2014. 8. 21. 오후 3:33:26
	* 3. 작성자 : kys
	* 4. 설명 : 코드 네임
	* </pre>
	*/
	String getCodeName(String code)	throws Exception;
	String getCodeName(String common_code_category ,String code) throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getCodeList
	* 2. 작성일 : 2014. 8. 25. 오후 4:52:43
	* 3. 작성자 : kys
	* 4. 설명 : 일반코드 리스트
	* </pre>
	*/
	List<MobileCommonCodeVO> getCodeList(MobileCommonCodeVO commonCodeVO) throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getCodeList
	* 2. 작성일 : 2014. 8. 25. 오후 4:52:43
	* 3. 작성자 : kys
	* 4. 설명 : 일반코드 리스트
	* </pre>
	*/
	String getSyskindname(String code) throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : getAutoCodeDiv
	* 2. 작성일 : 2014. 8. 21. 오후 3:33:26
	* 3. 작성자 : kys
	* 4. 설명 : 코드 네임
	* </pre>
	*/
	String getBranchName(String branch_no)	throws Exception;
	

	/**
	* <pre>
	* 1. 메소드명 : getSugyeCodeList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 수계 코드 리스트
	* </pre>
	*/
	List<MobileCommonCodeVO> getSugyeCodeList(MobileCommonCodeVO commonCodeVO)	throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : getsido
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시군구 코드
	* </pre>
	*/
	List<MobileCommonCodeVO> getSido()	throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : getsigungu
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시군구 코드
	* </pre>
	*/
	List<MobileCommonCodeVO> getSigungu(String sido)	throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getSidoName
	* 2. 작성일 : 2014. 9. 5. 오후 2:31:58
	* 3. 작성자 : kys
	* 4. 설명 : 시도명
	* </pre>
	*/
	String getSidoName(String code) throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getSigunguName
	* 2. 작성일 : 2014. 9. 5. 오후 2:32:01
	* 3. 작성자 : kys
	* 4. 설명 : 시군구명
	* </pre>
	*/
	String getSigunguName(String code) throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getWarehouseCode
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 동적 셀렉트 박스 창고 코드
	* </pre>
	*/
	List<MobileCommonCodeVO> getWarehouseCode(String sugye)	throws Exception;
	

	/**
	* <pre>
	* 1. 메소드명 : getWarehouseName
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 창고 이름 가져오기 
	* </pre>
	*/
	String getWarehouseName(String code) throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : getAutoCodeDiv
	* 2. 작성일 : 2014. 8. 21. 오후 3:33:26
	* 3. 작성자 : kys
	* 4. 설명 : 단일 고정 코드값 설정
	* </pre>
	*/
	String getAutoCodeDiv(String code);
}
  