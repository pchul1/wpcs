package daewooInfo.waterpolmnt.airmntmng.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.waterpolmnt.airmntmng.bean.AirDataVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointMntVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointMntVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("airDAO")
public class AirDAO extends EgovAbstractDAO{

	public void insertAirMnt(AirDataVO airData)
	{
		insert("airDAO.insertAirMnt", airData);
	}

	/**
	 * 항공감시 지점 리스트
	 * @return
	 */
	public List<AirPointVO> getAirPoint()
	{
		return list("airDAO.getAirPoint", null);
	}
	
	/**
	 * 조류예보 지점 리스트
	 * @return
	 */
	public List<AirPointVO> getAirPoint(AirPointVO airPointVO)
	{
		return list("airDAO.getAirPoint", airPointVO);
	}
	
	/**
	 * 조류예보 관리자 리스트
	 * @return
	 */
	public List<AirPointMntVO> getAirPointMnt()
	{
		return list("airDAO.getAirPointMnt", null);
	}
	
	/**
	 * 조류예보 관리 지점 등록
	 * @param algaPointMntVO
	 */
	public void insertPointMap(AirPointMntVO airPointMntVO)
	{
		insert("airDAO.insertPointMap", airPointMntVO);
	}
	
	public AirPointMntVO getAirPointByUniqID(AirPointMntVO airPointMntVO)
	{
		return (AirPointMntVO)selectByPk("airDAO.getAirPointByUniqID", airPointMntVO);
	}
}
