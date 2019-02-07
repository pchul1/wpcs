package daewooInfo.waterpolmnt.airmntmng.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.waterpolmnt.airmntmng.bean.AirDataVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointMntVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointVO;
import daewooInfo.waterpolmnt.airmntmng.dao.AirDAO;
import daewooInfo.waterpolmnt.airmntmng.service.AirService;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointMntVO;

@Service("airService")
public class AirServiceImpl implements AirService{

	/**
	 * @uml.property  name="airDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "airDAO")
    private AirDAO airDAO;
	
	public void test() {
		// TODO Auto-generated method stub
		
	}

	/**
	 * 항공감시 입력
	 */
	public void insertAirMnt(AirDataVO airData) throws Exception
	{
			airDAO.insertAirMnt(airData);
	}
	
	/**
	 * 항공감시 지점
	 */
	public List<AirPointVO> getAirPoint()
	{
			return airDAO.getAirPoint();
	}
	
	/**
	 * 조류예보 지점
	 */
	public List<AirPointVO> getAirPoint(AirPointVO airPointVO)
	{
			return airDAO.getAirPoint(airPointVO);
	}
	
	public List<AirPointMntVO> getAirPointMnt()
	{
		return airDAO.getAirPointMnt();
	}
	
	public void insertPointMap(AirPointMntVO airPointMntVO)
	{
		airDAO.insertPointMap(airPointMntVO);
	}
	
	public AirPointMntVO getAirPointByUniqID(AirPointMntVO airPointMntVO)
	{
		return airDAO.getAirPointByUniqID(airPointMntVO);
	}
}

