package daewooInfo.mobile.com.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.mobile.com.bean.MobileCommonCodeVO;
import daewooInfo.mobile.com.bean.MobileCommonVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
* <pre>
* 1. 패키지명 : wpcs.com.service.impl
* 2. 타입명 : DynamicSelectDAO.java
* 3. 작성일 : 2014. 8. 20. 오후 4:58:09
* 4. 작성자 : kys
* 5. 설명 : 동적 셀렉트 박스
* </pre>
*/
@Repository("MobileCommonCodeDAO")
public class MobileCommonCodeDAO extends EgovAbstractDAO {


	public List<MobileCommonCodeVO> getSystemCodeList(MobileCommonCodeVO commonCodeVO) throws Exception{
		return list("MobileCommonCodeDAO.getSystemCodeList", commonCodeVO);
	}
	/**
	* <pre>
	* 1. 메소드명 : getbranch
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 정보
	* </pre>
	*/
	public List<MobileCommonCodeVO> getbranch(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return list("MobileCommonCodeDAO.getbranch", commonCodeVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getCodeName
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 코드 이름 
	* </pre>
	*/
	public String getCodeName(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return (String)selectByPk("MobileCommonCodeDAO.getCodeName", commonCodeVO);
	}	


	/**
	* <pre>
	* 1. 메소드명 : getCodeList
	* 2. 작성일 : 2014. 8. 25. 오후 4:52:43
	* 3. 작성자 : kys
	* 4. 설명 : 일반코드 리스트
	* </pre>
	*/
	public List<MobileCommonCodeVO> getCodeList(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return list("MobileCommonCodeDAO.getCodeList", commonCodeVO);
	}	

	/**
	* <pre>
	* 1. 메소드명 : getSyskindname
	* 2. 작성일 : 2014. 8. 25. 오후 4:52:43
	* 3. 작성자 : kys
	* 4. 설명 : 수계정보 이름 가져오기
	* </pre>
	*/
	public String getSyskindname(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return (String)selectByPk("MobileCommonCodeDAO.getSyskindname", commonCodeVO);
	}	
	
	/**
	* <pre>
	* 1. 메소드명 : getBranchName
	* 2. 작성일 : 2014. 8. 21. 오후 3:33:26
	* 3. 작성자 : kys
	* 4. 설명 : 지점 이름
	* </pre>
	*/
	public String getBranchName(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return (String)selectByPk("MobileCommonCodeDAO.getBranchName", commonCodeVO);
	}	

	/**
	* <pre>
	* 1. 메소드명 : getSugyeCodeList
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 수계 코드 리스트
	* </pre>
	*/
	public List<MobileCommonCodeVO> getSugyeCodeList(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return list("MobileCommonCodeDAO.getSugyeCodeList", commonCodeVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getsigun
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시도 코드
	* </pre>
	*/
	public List<MobileCommonCodeVO> getSido() throws Exception {
		return list("MobileCommonCodeDAO.getSido", null);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getsigungu
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시군구 코드
	* </pre>
	*/
	public List<MobileCommonCodeVO> getSigungu(MobileCommonCodeVO commonCodeVO) throws Exception {
		return list("MobileCommonCodeDAO.getSigungu", commonCodeVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getSidoName
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시도명
	* </pre>
	*/
	public String getSidoName(MobileCommonCodeVO commonCodeVO) throws Exception {
		return (String)selectByPk("MobileCommonCodeDAO.getSidoName", commonCodeVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getSigunguName
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시군구이름
	* </pre>
	*/
	public String getSigunguName(MobileCommonCodeVO commonCodeVO) throws Exception {
		return (String)selectByPk("MobileCommonCodeDAO.getSigunguName", commonCodeVO);
	}


	/**
	* <pre>
	* 1. 메소드명 : getWarehouseCode
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 동적 셀렉트 박스 창고 코드
	* </pre>
	*/
	public List<MobileCommonCodeVO> getWarehouseCode(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return list("MobileCommonCodeDAO.getWarehouseCode", commonCodeVO);
	}
	

	/**
	* <pre>
	* 1. 메소드명 : getWarehouseName
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 창고 이름 가져오기 
	* </pre>
	*/
	public String getWarehouseName(MobileCommonCodeVO commonCodeVO) throws Exception{
		return (String)selectByPk("MobileCommonCodeDAO.getWarehouseName", commonCodeVO);
	}
}
