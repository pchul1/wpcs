package daewooInfo.waterpolmnt.airmntmng.service;

import java.util.List;

import daewooInfo.waterpolmnt.airmntmng.bean.AirDataVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointMntVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointVO;


public interface AirService {
	
	/**
	 * 항공감시 입력
	 * @throws Exception
	 */
	public void insertAirMnt(AirDataVO airData) throws Exception;
	
	//항공감시 지점
	public List<AirPointVO> getAirPoint() throws Exception;
	
	public List<AirPointVO> getAirPoint(AirPointVO airPointVO) throws Exception;
	
	public List<AirPointMntVO> getAirPointMnt() throws Exception;
	
	public void insertPointMap(AirPointMntVO airPointMntVO) throws Exception;
	
	public AirPointMntVO getAirPointByUniqID(AirPointMntVO airPointMntVO) throws Exception;
}
