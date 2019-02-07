package daewooInfo.waterpolmnt.algasmng.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.waterpolmnt.algasmng.bean.AlgaDataVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointMntVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("algasDAO")
public class AlgasDAO extends EgovAbstractDAO{

	public void insertAlgaCast(AlgaDataVO algaData)
	{
		insert("algasDAO.insertAlgaCast", algaData);
	}
	
	
	/**
	 * 조류예보 데이터를 가져옵니다.
	 * @param algaData
	 * @return
	 */
	public List<AlgaDataVO> getAlgaCastList(AlgaDataVO algaData)
	{
		return list("algasDAO.getAlgaCastList", algaData);
	}
	
	
	/**
	 * 조류예보 지점 리스트
	 * @return
	 */
	public List<AlgaPointVO> getAlgaPoint(AlgaPointVO algaPoint)
	{
		return list("algasDAO.getAlgaPoint", algaPoint);
	}
	
	/**
	 * 조류예보 관리자 리스트
	 * @return
	 */
	public List<AlgaPointMntVO> getAlgaPointMnt()
	{
		return list("algasDAO.getAlgaPointMnt", null);
	}
	
	/**
	 * 조류예보 관리 지점 등록
	 * @param algaPointMntVO
	 */
	public void insertPointMap(AlgaPointMntVO algaPointMntVO)
	{
		insert("algasDAO.insertPointMap", algaPointMntVO);
	}
	
	public AlgaPointMntVO getAlgaPointByUniqID(AlgaPointMntVO algaPointMntVO)
	{
		return (AlgaPointMntVO)selectByPk("algasDAO.getAlgaPointByUniqID", algaPointMntVO);
	}
}
