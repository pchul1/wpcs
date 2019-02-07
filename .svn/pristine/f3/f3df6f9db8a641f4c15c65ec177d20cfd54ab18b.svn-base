package daewooInfo.mobile.com.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.mobile.com.bean.MobileCommonVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
* <pre>
* 1. 패키지명 : mobile_wpcs.com.dao
* 2. 타입명 : CommonDAO.java
* 3. 작성일 : 2014. 8. 27. 오후 3:23:58
* 4. 작성자 : kys
* 5. 설명 : 공통
* </pre>
*/
@Repository("MobileCommonDAO")
public class MobileCommonDAO extends EgovAbstractDAO {

	/**
	* <pre>
	* 1. 메소드명 : getnextSequence
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 시퀀스 정보 알아오기
	* </pre>
	*/
	public int getnextSequence(MobileCommonVO commonVO)	throws Exception{
		return (Integer)selectByPk("MobileCommonDAO.getnextSequence", commonVO);
	}
}
