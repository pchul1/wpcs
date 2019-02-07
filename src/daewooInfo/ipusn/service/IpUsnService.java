package daewooInfo.ipusn.service;

import java.util.List;

import daewooInfo.ipusn.bean.IpUsnVO;
/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.ipusn.dao
* 2. 타입명 : IpUsnDAO.java
* 3. 작성일 : 2014. 9. 12. 오후 5:40:42
* 4. 작성자 : kys
* 5. 설명 :
* </pre>
*/
public interface IpUsnService {

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 리스트
	* </pre>
	*/
	List<IpUsnVO> getIpUsnList(IpUsnVO ipUsnVO)	throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnMap
	* 2. 작성일 : 2014. 9. 4. 오후 5:58:51
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 상세 정보
	* </pre>
	*/
	IpUsnVO getIpUsnMap(IpUsnVO ipUsnVO) throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnView
	* 2. 작성일 : 2014. 9. 4. 오후 5:58:51
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 정보
	* </pre>
	*/
	IpUsnVO getIpUsnView(IpUsnVO ipUsnVO) throws Exception;

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnLocationList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 정보
	* </pre>
	*/
	List<IpUsnVO> getIpUsnLocationList(IpUsnVO ipUsnVO)	throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : getIpUsnLocationView
	* 2. 작성일 : 2014. 9. 4. 오후 5:58:51
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 상세 정보
	* </pre>
	*/
	IpUsnVO getIpUsnLocationView(IpUsnVO ipUsnVO) throws Exception;


	/**
	* <pre>
	* 1. 메소드명 : IpUsnBranchHistoryList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 지점명 히스토리 리스트
	* </pre>
	*/
	List<IpUsnVO> IpUsnBranchHistoryList(IpUsnVO ipUsnVO)	throws Exception;
	
	
	/**
	* <pre>
	* 1. 메소드명 : IpUsnBranchHistoryList
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 지점명 히스토리 리스트 총 갯수
	* </pre>
	*/
	int IpUsnBranchHistoryTotCount(IpUsnVO ipUsnVO)	throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnDeviceStatus
	* 2. 작성일 : 2014. 9. 4. 오후 4:59:02
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 디바이스 상태 수정
	* </pre>
	*/
	int UpdateIpUsnDeviceStatus(IpUsnVO ipUsnVO)	throws Exception;
	
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnStatusFlag
	* 2. 작성일 : 2014. 9. 4. 오후 4:59:02
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 플래그 수정
	* </pre>
	*/
	int UpdateIpUsnStatusFlag(IpUsnVO ipUsnVO)	throws Exception;
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnStatusFlag
	* 2. 작성일 : 2014. 9. 4. 오후 4:59:02
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 위치 수정
	* </pre>
	*/
	int UpdateIpUsnLocationSet(IpUsnVO ipUsnVO)	throws Exception;
	

	/**
	* <pre>
	* 1. 메소드명 : IpUsnDump
	* 2. 작성일 : 2014. 8. 20. 오후 4:56:05
	* 3. 작성자 : kys
	* 4. 설명 : 지점명 히스토리 리스트
	* </pre>
	*/
	void IpUsnDump(IpUsnVO ipUsnVO)	throws Exception;
}
  