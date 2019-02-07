package daewooInfo.ipusn.service.impl;

import java.util.Hashtable;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.softwarefx.sfxnet.internal.oj;

import daewooInfo.ipusn.bean.IpUsnVO;
import daewooInfo.ipusn.dao.IpUsnDAO;
import daewooInfo.ipusn.service.IpUsnService;
import daewooInfo.mobile.com.utl.ObjectUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.ipusn.dao
* 2. 타입명 : IpUsnDAO.java
* 3. 작성일 : 2014. 9. 12. 오후 5:40:42
* 4. 작성자 : kys
* 5. 설명 :
* </pre>
*/
@Service("IpUsnService")
public class IpUsnServiceImpl extends AbstractServiceImpl implements IpUsnService {

    @Resource(name="IpUsnDAO")
    private IpUsnDAO ipUsnDAO;
    
	/**
	* <pre>
	* 1. 메소드명 : getIpUsnList
	* 2. 작성일 : 2014. 8. 20. 오후 4:55:40
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 리스트
	* </pre>
	*/
	public List<IpUsnVO> getIpUsnList(IpUsnVO ipUsnVO)	throws Exception{
		return ipUsnDAO.getIpUsnList(ipUsnVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnMap
	* 2. 작성일 : 2014. 8. 20. 오후 4:55:40
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 상세 정보
	* </pre>
	*/
	public IpUsnVO getIpUsnMap(IpUsnVO ipUsnVO) throws Exception{
		return ipUsnDAO.getIpUsnMap(ipUsnVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getIpUsnView
	* 2. 작성일 : 2014. 8. 20. 오후 4:55:40
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 상세 정보
	* </pre>
	*/
	public IpUsnVO getIpUsnView(IpUsnVO ipUsnVO) throws Exception{
		return ipUsnDAO.getIpUsnView(ipUsnVO);
	}
    
	/**
	* <pre>
	* 1. 메소드명 : getIpUsnLocationList
	* 2. 작성일 : 2014. 8. 20. 오후 4:55:40
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 정보
	* </pre>
	*/
	public List<IpUsnVO> getIpUsnLocationList(IpUsnVO ipUsnVO)	throws Exception{
		return ipUsnDAO.getIpUsnLocationList(ipUsnVO);
	}

	/**
	* <pre>
	* 1. 메소드명 : getIpUsnLocationView
	* 2. 작성일 : 2014. 8. 20. 오후 4:55:40
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 상세 정보
	* </pre>
	*/
	public IpUsnVO getIpUsnLocationView(IpUsnVO ipUsnVO) throws Exception{
		return ipUsnDAO.getIpUsnLocationView(ipUsnVO);
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
		return ipUsnDAO.IpUsnBranchHistoryList(ipUsnVO);
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
		return ipUsnDAO.IpUsnBranchHistoryTotCount(ipUsnVO);
	}
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnStatusFlag
	* 2. 작성일 : 2014. 9. 4. 오후 4:59:02
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 디바이스 상태 수정
	* </pre>
	*/
	public int UpdateIpUsnDeviceStatus(IpUsnVO ipUsnVO)	throws Exception{
		return ipUsnDAO.UpdateIpUsnDeviceStatus(ipUsnVO);
	}
	
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnStatusFlag
	* 2. 작성일 : 2014. 9. 4. 오후 4:59:02
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 플래그 수정
	* </pre>
	*/
	public int UpdateIpUsnStatusFlag(IpUsnVO ipUsnVO)	throws Exception{
		return ipUsnDAO.UpdateIpUsnStatusFlag(ipUsnVO);
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
		return ipUsnDAO.UpdateIpUsnLocationSet(ipUsnVO);
	}
	
	public void IpUsnDump(IpUsnVO ipUsnVO)	throws Exception{

		String[] items = {"TMP00", "PHY00", "DOW00", "CON00", "TUR00", "TOF00"};

		String[] buffer = ObjectUtil.readFile(ipUsnVO.getFile()).split("\\n");
		
		String mintime = "";
		
		for(int i=0; i<buffer.length; i++) {
			String[] arr = buffer[i].split("&");
			if(arr.length < 10) continue;

			Hashtable<String, String> map = new Hashtable<String, String>();
			for(int j=0; j<arr.length; j++) {
				String[] arr2 = arr[j].split("=");
				if(arr2.length == 2) {
					map.put(arr2[0], arr2[1].trim());
				}
			}

			String[] codes = map.get("FC").split(":");
			mintime = map.get("DATE").substring(0, 12);
			
			for(int k=0; k<items.length; k++) {
				if(map.get(items[k]) != null) {
					String value = map.get(items[k]);
					String[] vals = value.split(":");
					
					IpUsnVO vo = new IpUsnVO();
					
					vo.setFact_code(codes[0]);
					vo.setMin_time(mintime);
					vo.setBranch_no(codes[1]);
					vo.setItem_code(items[k]);
					vo.setMin_rtime(ObjectUtil.getTimeString("yyyyMMddHHmm"));
					vo.setMin_dump("0");
					vo.setMin_vl(vals[0]);
					vo.setMin_or("0");
					vo.setMin_st(vals[1]);
					vo.setMin_dcd("1");
					try{
						ipUsnDAO.InsertTMinData(vo);
					}catch(Exception e){
						//System.out.println(e.fillInStackTrace());
					}
				}
			}

			IpUsnVO IpUsnGpsvo = new IpUsnVO();
			
			double lat = Double.parseDouble(map.get("LAT").equals("") ? "0" : map.get("LAT"));
			double lon = Double.parseDouble(map.get("LON").equals("") ? "0" : map.get("LON"));
			double latitude = (int)(lat / 100.0) + ((lat / 100.0) - (int)(lat / 100.0)) * 100.0 / 60.0;
			double longitude = (int)(lon / 100.0) + ((lon / 100.0) - (int)(lon / 100.0)) * 100.0 / 60.0;

			if(map.get("ALT") == null || "".equals(map.get("ALT"))) map.put("ALT", "0");
			if(map.get("BAT") == null || "".equals(map.get("BAT"))) map.put("BAT", "0");
			if(map.get("CEL") == null || "".equals(map.get("CEL"))) map.put("CEL", "0");
			if(map.get("HUM") == null || "".equals(map.get("HUM"))) map.put("HUM", "0");
			
			IpUsnGpsvo.setFact_code(codes[0]);
			IpUsnGpsvo.setBranch_no(codes[1]);
			IpUsnGpsvo.setInput_time(mintime);
			IpUsnGpsvo.setLatitude(latitude + "");
			IpUsnGpsvo.setLongitude(longitude + "");
			IpUsnGpsvo.setAltitude(map.get("ALT"));
			IpUsnGpsvo.setBattery(map.get("BAT"));
			IpUsnGpsvo.setTemperature(map.get("CEL"));
			IpUsnGpsvo.setHumidity(map.get("HUM"));
			IpUsnGpsvo.setStatus_flag("N");

			try{
				ipUsnDAO.InsertIpUsnGps(IpUsnGpsvo);
			}catch(Exception e){
				//System.out.println(e.fillInStackTrace());
			}
		}
		ipUsnVO.setMin_time(mintime.substring(0, 8));
		ipUsnDAO.MergeTMinDataTHourData(ipUsnVO);
	}
}
