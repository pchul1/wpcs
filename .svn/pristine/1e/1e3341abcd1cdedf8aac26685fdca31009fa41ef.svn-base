package daewooInfo.ipusn.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.ipusn.bean.IpUsnVO;
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
@Repository("IpUsnDAO")
public class IpUsnDAO extends EgovAbstractDAO {

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnList
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : IP-USN 위치 리스트
	* </pre>
	*/
	public List<IpUsnVO> getIpUsnList(IpUsnVO ipUsnVO)	throws Exception{
		return list("IpUsnDAO.getIpUsnList", ipUsnVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnMap
	* 2. 작성일 : 2014. 9. 12. 오후 5:41:00
	* 3. 작성자 : kys
	* 4. 설명 : IP-USN 위치 상세
	* </pre>
	*/
	public IpUsnVO getIpUsnMap(IpUsnVO ipUsnVO) throws Exception{
		return  (IpUsnVO)selectByPk("IpUsnDAO.getIpUsnMap", ipUsnVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getIpUsnView
	* 2. 작성일 : 2014. 9. 12. 오후 5:41:00
	* 3. 작성자 : kys
	* 4. 설명 : IP-USN 상세정보
	* </pre>
	*/
	public IpUsnVO getIpUsnView(IpUsnVO ipUsnVO) throws Exception{
		return  (IpUsnVO)selectByPk("IpUsnDAO.getIpUsnView", ipUsnVO);
	}	

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnLocationList
	* 2. 작성일 : 2014. 9. 12. 오후 5:41:12
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 위치 리스트
	* </pre>
	*/
	public List<IpUsnVO> getIpUsnLocationList(IpUsnVO ipUsnVO)	throws Exception{
		return list("IpUsnDAO.getIpUsnLocationList", ipUsnVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getIpUsnLocationView
	* 2. 작성일 : 2014. 9. 12. 오후 5:41:29
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 위치 상세
	* </pre>
	*/
	public IpUsnVO getIpUsnLocationView(IpUsnVO ipUsnVO) throws Exception{
		return  (IpUsnVO)selectByPk("IpUsnDAO.getIpUsnLocationView", ipUsnVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : IpUsnBranchHistoryList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 지점명 히스토리 리스트
	* </pre>
	*/
	public List<IpUsnVO> IpUsnBranchHistoryList(IpUsnVO ipUsnVO)	throws Exception{
		return list("IpUsnDAO.IpUsnBranchHistoryList", ipUsnVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : IpUsnBranchHistoryList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 지점명 히스토리 리스트 총 갯수
	* </pre>
	*/
	public int IpUsnBranchHistoryTotCount(IpUsnVO ipUsnVO)	throws Exception{
		return (Integer)selectByPk("IpUsnDAO.IpUsnBranchHistoryTotCount", ipUsnVO);
	}
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnDeviceStatus
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 디바이스 상태 수정
	* </pre>
	*/
	public int UpdateIpUsnDeviceStatus(IpUsnVO ipUsnVO)	throws Exception{
		return update("IpUsnDAO.UpdateIpUsnDeviceStatus", ipUsnVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnStatusFlag
	* 2. 작성일 : 2014. 8. 20. 오후 4:58:12
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 정보 플래그 수정
	* </pre>
	*/
	public int UpdateIpUsnStatusFlag(IpUsnVO ipUsnVO)	throws Exception{
		return update("IpUsnDAO.UpdateIpUsnStatusFlag", ipUsnVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnStatusFlag
	* 2. 작성일 : 2014. 9. 4. 오후 4:59:02
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 위치 수정
	* </pre>
	*/
	public int UpdateIpUsnLocationSet(IpUsnVO ipUsnVO)	throws Exception{
		return update("IpUsnDAO.UpdateIpUsnLocationSet", ipUsnVO);
	}	
	

	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnStatusFlag
	* 2. 작성일 : 2014. 9. 4. 오후 4:59:02
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 위치 수정
	* </pre>
	*/
	public int InsertTMinData(IpUsnVO ipUsnVO)	throws Exception{
		return update("IpUsnDAO.InsertTMinData", ipUsnVO);
	}	
	
	public int InsertIpUsnGps(IpUsnVO ipUsnVO)	throws Exception{
		return update("IpUsnDAO.InsertIpUsnGps", ipUsnVO);
	}	
	
	public int MergeTMinDataTHourData(IpUsnVO ipUsnVO)	throws Exception{
		return update("IpUsnDAO.MergeTMinDataTHourData", ipUsnVO);
	}	
}
