package daewooInfo.waterpolmnt.algasmng.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.waterpolmnt.airmntmng.bean.AirPointMntVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaDataVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointMntVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointVO;
import daewooInfo.waterpolmnt.algasmng.dao.AlgasDAO;
import daewooInfo.waterpolmnt.algasmng.service.AlgasService;

@Service("algasService")
public class AlgasServiceImpl implements AlgasService{

	/**
	 * @uml.property  name="algasDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "algasDAO")
    private AlgasDAO algasDAO;
	
	public void test() {
		// TODO Auto-generated method stub
		
	}

	
	public void insertAlgaCast(AlgaDataVO algaData)
	{
			algasDAO.insertAlgaCast(algaData);
	}
	
	/**
	 * 조류예보 지점
	 */
	public List<AlgaPointVO> getAlgaPoint(AlgaPointVO algaPoint)
	{
			return algasDAO.getAlgaPoint(algaPoint);
	}
	
	public List<AlgaPointMntVO> getAlgaPointMnt()
	{
		return algasDAO.getAlgaPointMnt();
	}
	
	public void insertPointMap(AlgaPointMntVO algaPointMnt)
	{
		algasDAO.insertPointMap(algaPointMnt);
	}
	
	public AlgaPointMntVO getAlgaPointByUniqID(AlgaPointMntVO algaPointMntVO)
	{
		return algasDAO.getAlgaPointByUniqID(algaPointMntVO);
	}
}
