package daewooInfo.waterpolmnt.algasmng.service;

import java.util.List;

import daewooInfo.waterpolmnt.airmntmng.bean.AirPointMntVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaDataVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointMntVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointVO;

public interface AlgasService {
	
	void test();
	
	//조류예보 입력
	public void insertAlgaCast(AlgaDataVO algaData) throws Exception;
	
	//조류예보지점
	public List<AlgaPointVO> getAlgaPoint(AlgaPointVO algaPoint) throws Exception;
	
	//조류예보관리자
	public List<AlgaPointMntVO> getAlgaPointMnt() throws Exception;
	
	public void insertPointMap(AlgaPointMntVO altaPointMntVO) throws Exception;
	
	public AlgaPointMntVO getAlgaPointByUniqID(AlgaPointMntVO algaPointMntVO) throws Exception;
}
