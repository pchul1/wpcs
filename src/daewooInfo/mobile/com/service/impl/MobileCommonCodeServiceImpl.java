package daewooInfo.mobile.com.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.mobile.com.bean.MobileCommonCodeVO;
import daewooInfo.mobile.com.bean.MobileCommonVO;
import daewooInfo.mobile.com.dao.MobileCommonCodeDAO;
import daewooInfo.mobile.com.service.MobileCommonCodeService;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
* <pre>
* 1. 패키지명 : wpcs.com.service.impl
* 2. 타입명 : DynamicSelectServiceImpl.java
* 3. 작성일 : 2014. 8. 20. 오후 4:55:12
* 4. 작성자 : kys
* 5. 설명 : 동적 셀렉트 박스
* </pre>
*/
@Service("MobileCommonCodeService")
public class MobileCommonCodeServiceImpl extends AbstractServiceImpl implements MobileCommonCodeService {

    @Resource(name="MobileCommonCodeDAO")
    private MobileCommonCodeDAO mobileCommonCodeDAO;

	public List<MobileCommonCodeVO> getSystemCodeList(MobileCommonCodeVO commonCodeVO) throws Exception{
		return mobileCommonCodeDAO.getSystemCodeList(commonCodeVO);
	}
	/**
	* <pre>
	* 1. 메소드명 : getbranch
	* 2. 작성일 : 2014. 8. 20. 오후 4:55:40
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 정보
	* </pre>
	*/
	public List<MobileCommonCodeVO> getbranch(MobileCommonCodeVO commonCodeVO) throws Exception{
		return mobileCommonCodeDAO.getbranch(commonCodeVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getCodeName
	* 2. 작성일 : 2014. 8. 21. 오후 3:41:15
	* 3. 작성자 : kys
	* 4. 설명 : 코드 이름 
	* </pre>
	*/
	public String getCodeName(String code) throws Exception{
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(code);
		return mobileCommonCodeDAO.getCodeName(commonCodeVO);
	}

	public String getCodeName(String common_code_category , String code) throws Exception{
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(code);
		commonCodeVO.setCommon_code_category(common_code_category);
		return mobileCommonCodeDAO.getCodeName(commonCodeVO);
	}


	/**
	* <pre>
	* 1. 메소드명 : getCodeList
	* 2. 작성일 : 2014. 8. 25. 오후 4:52:43
	* 3. 작성자 : kys
	* 4. 설명 : 일반코드 리스트
	* </pre>
	*/
	public List<MobileCommonCodeVO> getCodeList(MobileCommonCodeVO commonCodeVO) throws Exception{
		return mobileCommonCodeDAO.getCodeList(commonCodeVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getCodeList
	* 2. 작성일 : 2014. 8. 25. 오후 4:52:43
	* 3. 작성자 : kys
	* 4. 설명 : 일반코드 리스트
	* </pre>
	*/
	public String getSyskindname(String code) throws Exception{
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(code);
		return mobileCommonCodeDAO.getSyskindname(commonCodeVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getBranchName
	* 2. 작성일 : 2014. 8. 21. 오후 3:33:26
	* 3. 작성자 : kys
	* 4. 설명 : 지점 이름
	* </pre>
	*/
	public String getBranchName(String branch_no) throws Exception{
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setBranch_no(branch_no);
		return mobileCommonCodeDAO.getBranchName(commonCodeVO);
	}
	

	/**
	* <pre>
	* 1. 메소드명 : getSugyeCodeList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 수계 코드 리스트
	* </pre>
	*/
	public List<MobileCommonCodeVO> getSugyeCodeList(MobileCommonCodeVO commonCodeVO)	throws Exception{
		return mobileCommonCodeDAO.getSugyeCodeList(commonCodeVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getsigun
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시군구 코드
	* </pre>
	*/
	public List<MobileCommonCodeVO> getSido() throws Exception {
		return mobileCommonCodeDAO.getSido();
	}

	/**
	* <pre>
	* 1. 메소드명 : getsigungu
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 시군구 코드
	* </pre>
	*/
	public List<MobileCommonCodeVO> getSigungu(String sido) throws Exception {
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(sido);
		return mobileCommonCodeDAO.getSigungu(commonCodeVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getSidoName
	* 2. 작성일 : 2014. 9. 5. 오후 2:31:58
	* 3. 작성자 : kys
	* 4. 설명 : 시도명
	* </pre>
	*/
	public String getSidoName(String sido) throws Exception {
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(sido);
		return mobileCommonCodeDAO.getSidoName(commonCodeVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getSigunguName
	* 2. 작성일 : 2014. 9. 5. 오후 2:32:01
	* 3. 작성자 : kys
	* 4. 설명 : 시군구명
	* </pre>
	*/
	public String getSigunguName(String sigungu) throws Exception {
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(sigungu);
		return mobileCommonCodeDAO.getSigunguName(commonCodeVO);
	}
	

	/**
	* <pre>
	* 1. 메소드명 : getWarehouseCode
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 동적 셀렉트 박스 창고 코드
	* </pre>
	*/
	public List<MobileCommonCodeVO> getWarehouseCode(String sugye)	throws Exception{
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(sugye);
		return mobileCommonCodeDAO.getWarehouseCode(commonCodeVO);
	}
	

	/**
	* <pre>
	* 1. 메소드명 : getWarehouseName
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 창고 이름 가져오기 
	* </pre>
	*/
	public String getWarehouseName(String code) throws Exception{
		MobileCommonCodeVO commonCodeVO = new MobileCommonCodeVO();
		commonCodeVO.setCode(code);
		return mobileCommonCodeDAO.getWarehouseName(commonCodeVO);
	}
	
	/**
	 * 단일 고정 코드값 설정
	 * @param code 코드
	 * @return String
	 * @see #staticCode
	 */
	public String getAutoCodeDiv(String code){
		return (String)autoDivCode.get(code);
	}

	/**
	 * 단일 고정 코드값 설정
	 * <br>코드DAO 생성이 될때 한번만 설정되도록 함
	 */
	private static HashMap autoDivCode = new HashMap();
	static{

		/*일반항목(내부)*/
		autoDivCode.put("CON00", "COM1");
		autoDivCode.put("DOW00", "COM1");
		autoDivCode.put("TMP00", "COM1");
		autoDivCode.put("PHY00", "COM1");
		/*일반항목(외부)*/
		autoDivCode.put("TMP01", "COM2");
		autoDivCode.put("TMP02", "COM2");
		autoDivCode.put("PHY01", "COM2");
		autoDivCode.put("PHY02", "COM2");
		autoDivCode.put("DOW01", "COM2");
		autoDivCode.put("DOW01", "COM2");
		autoDivCode.put("CON01", "COM2");
		autoDivCode.put("CON02", "COM2");
		autoDivCode.put("TUR00", "COM2");
		/*생물독성(물고기)*/
		autoDivCode.put("IMP00", "BIO1");
		/*생물독성(물벼룩1)*/
		autoDivCode.put("LIM00", "BIO2");
		autoDivCode.put("RIM00", "BIO2");
		/*생물독성(물벼룩2)*/
		autoDivCode.put("LTX00", "BIO3");
		autoDivCode.put("RTX00", "BIO3");
		/*생물독성(미생물)*/
		autoDivCode.put("TOX00", "BIO4");
		/*생물독성(조류)*/
		autoDivCode.put("EVN00", "BIO5");
		/*클로로필-a*/
		autoDivCode.put("TOF00", "CHLA");
		/*휘발성 유기화합물*/
		autoDivCode.put("VOC01", "VOCS");
		autoDivCode.put("VOC02", "VOCS");
		autoDivCode.put("VOC03", "VOCS");
		autoDivCode.put("VOC04", "VOCS");
		autoDivCode.put("VOC05", "VOCS");
		autoDivCode.put("VOC06", "VOCS");
		autoDivCode.put("VOC07", "VOCS");
		autoDivCode.put("VOC08", "VOCS");
		autoDivCode.put("VOC09", "VOCS");
		autoDivCode.put("VOC10", "VOCS");
		autoDivCode.put("VOC11", "VOCS");
		autoDivCode.put("VOC12", "VOCS");
		autoDivCode.put("VOC13", "VOCS");
		autoDivCode.put("VOC14", "VOCS");
		autoDivCode.put("VOC15", "VOCS");
		/*중금속*/
		autoDivCode.put("COP00", "METL");
		autoDivCode.put("PLU00", "METL");
		autoDivCode.put("ZIN00", "METL");
		autoDivCode.put("CAD00", "METL");
		/*페놀*/
		autoDivCode.put("PHE00", "PHEN");
		autoDivCode.put("PHL00", "PHEN");
		/*유기물질*/
		autoDivCode.put("TOC00", "ORGA");
		/*영양염류*/
		autoDivCode.put("TON00", "NUTR");
		autoDivCode.put("TOP00", "NUTR");
		autoDivCode.put("NH400", "NUTR");
		autoDivCode.put("NO300", "NUTR");
		autoDivCode.put("PO400", "NUTR");
		/*강수량계*/
		autoDivCode.put("RIN00", "RAIN");
	}
}
