package daewooInfo.status.dao;

import org.springframework.stereotype.Repository;

import daewooInfo.status.bean.StatusVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.ipusn.dao
* 2. 타입명 : IpUsnDAO.java
* 3. 작성일 : 2014. 9. 12. 오후 5:40:42
* 4. 작성자 : kys
* 5. 설명 :
* </pre>
*/
@Repository("StatusDAO")
public class StatusDAO extends EgovAbstractDAO {

	/**
	* <pre>
	* 1. 메소드명 : water
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 수질자동측정망 최근 입력시간 알아오기 
	* </pre>
	*/
	public StatusVO Water()	throws Exception{
		return (StatusVO)selectByPk("StatusDAO.Water", null);
	}

	/**
	* <pre>
	* 1. 메소드명 : Nier
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 국립환경과학원 최근 입력시간 알아오기 
	* </pre>
	*/
	public StatusVO Nier()	throws Exception{
		return (StatusVO)selectByPk("StatusDAO.Nier", null);
	}

	/**
	* <pre>
	* 1. 메소드명 : weather
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 기상청 최근 입력시간 알아오기 
	* </pre>
	*/
	public StatusVO Weather()	throws Exception{
		return (StatusVO)selectByPk("StatusDAO.Weather", null);
	}

	/**
	* <pre>
	* 1. 메소드명 : TMS
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : TMS 최근 입력시간 알아오기 
	* </pre>
	*/
	public StatusVO TMS()	throws Exception{
		return (StatusVO)selectByPk("StatusDAO.TMS", null);
	}
}
