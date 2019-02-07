package daewooInfo.ipusn.bean;

import daewooInfo.mobile.com.bean.MobileCommonVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.ipusn.bean
* 2. 타입명 : IpUsnVO.java
* 3. 작성일 : 2014. 9. 12. 오후 5:40:21
* 4. 작성자 : kys
* 5. 설명 : IpUsnVO
* </pre>
*/
public class IpUsnVO extends MobileCommonVO{
	public String rn;
	public String river_div;
	public String river_div_name;
	public String branch_name;
	public String gps_dist;
	public String input_time;
	public String status_flag;
	public String fact_name;
	public String sys_kind_name;
	public String fact_addr;
	public String latitude;
	public String longitude;
	public String device_st;
	public String latitude1;
	public String longitude1;
	public String latitude2;
	public String longitude2;
	public String branch_use_flag;
	public String branch_mgr;
	public String branch_map_x;
	public String branch_map_y;
	public String loc_seq_no;
	public String loss_flag;
	public String cdma_group;
	public String branch_tel_no;
	public String branch_fname;
	public String branch_mgr_tel_no;
	public String branch_ip;
	public String branch_port;
	public String branch_comm_no;
	public String cdma_tel_no;
	public String leave_distance;
	public String temperature; 
	public String humidity; 
	public String battery;
	public String nowlocation;
	public String min_time;
	public String min_rtime;
	public String min_dump;
	public String min_vl;
	public String min_or;
	public String min_st;
	public String min_dcd;
	public String altitude;
	public String file;
	public String startDate;
	public String endDate;
	public String userId;
	public String userGubun;
	
	/**
	 * 현재페이지
	 * @uml.property  name="pageIndex"
	 */
	private int pageIndex = 1;

	/**
	 * 페이지갯수
	 * @uml.property  name="pageUnit"
	 */
	private int pageUnit = 20;

	/**
	 * 페이지사이즈
	 * @uml.property  name="pageSize"
	 */
	private int pageSize = 10;

	/**
	 * 첫페이지 인덱스
	 * @uml.property  name="firstIndex"
	 */
	private int firstIndex = 1;

	/**
	 * 마지막페이지 인덱스
	 * @uml.property  name="lastIndex"
	 */
	private int lastIndex = 1;

	/**
	 * 페이지당 레코드 개수
	 * @uml.property  name="recordCountPerPage"
	 */
	private int recordCountPerPage = 10;
	
	public String getRn() {
		return rn;
	}
	public void setRn(String rn) {
		this.rn = rn;
	}
	public String getRiver_div() {
		return river_div;
	}
	public void setRiver_div(String river_div) {
		this.river_div = river_div;
	}
	public String getRiver_div_name() {
		return river_div_name;
	}
	public void setRiver_div_name(String river_div_name) {
		this.river_div_name = river_div_name;
	}
	public String getBranch_name() {
		return branch_name;
	}
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	public String getGps_dist() {
		return gps_dist;
	}
	public void setGps_dist(String gps_dist) {
		this.gps_dist = gps_dist;
	}
	public String getInput_time() {
		return input_time;
	}
	public void setInput_time(String input_time) {
		this.input_time = input_time;
	}
	public String getStatus_flag() {
		return status_flag;
	}
	public void setStatus_flag(String status_flag) {
		this.status_flag = status_flag;
	}
	public String getFact_name() {
		return fact_name;
	}
	public void setFact_name(String fact_name) {
		this.fact_name = fact_name;
	}
	public String getSys_kind_name() {
		return sys_kind_name;
	}
	public void setSys_kind_name(String sys_kind_name) {
		this.sys_kind_name = sys_kind_name;
	}
	public String getFact_addr() {
		return fact_addr;
	}
	public void setFact_addr(String fact_addr) {
		this.fact_addr = fact_addr;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getDevice_st() {
		return device_st;
	}
	public void setDevice_st(String device_st) {
		this.device_st = device_st;
	}
	public String getLatitude1() {
		return latitude1;
	}
	public void setLatitude1(String latitude1) {
		this.latitude1 = latitude1;
	}
	public String getLongitude1() {
		return longitude1;
	}
	public void setLongitude1(String longitude1) {
		this.longitude1 = longitude1;
	}
	public String getLatitude2() {
		return latitude2;
	}
	public void setLatitude2(String latitude2) {
		this.latitude2 = latitude2;
	}
	public String getLongitude2() {
		return longitude2;
	}
	public void setLongitude2(String longitude2) {
		this.longitude2 = longitude2;
	}
	public String getBranch_use_flag() {
		return branch_use_flag;
	}
	public void setBranch_use_flag(String branch_use_flag) {
		this.branch_use_flag = branch_use_flag;
	}
	public String getBranch_mgr() {
		return branch_mgr;
	}
	public void setBranch_mgr(String branch_mgr) {
		this.branch_mgr = branch_mgr;
	}
	public String getBranch_map_x() {
		return branch_map_x;
	}
	public void setBranch_map_x(String branch_map_x) {
		this.branch_map_x = branch_map_x;
	}
	public String getBranch_map_y() {
		return branch_map_y;
	}
	public void setBranch_map_y(String branch_map_y) {
		this.branch_map_y = branch_map_y;
	}
	public String getLoc_seq_no() {
		return loc_seq_no;
	}
	public void setLoc_seq_no(String loc_seq_no) {
		this.loc_seq_no = loc_seq_no;
	}
	public String getLoss_flag() {
		return loss_flag;
	}
	public void setLoss_flag(String loss_flag) {
		this.loss_flag = loss_flag;
	}
	public String getCdma_group() {
		return cdma_group;
	}
	public void setCdma_group(String cdma_group) {
		this.cdma_group = cdma_group;
	}
	public String getBranch_tel_no() {
		return branch_tel_no;
	}
	public void setBranch_tel_no(String branch_tel_no) {
		this.branch_tel_no = branch_tel_no;
	}
	public String getBranch_fname() {
		return branch_fname;
	}
	public void setBranch_fname(String branch_fname) {
		this.branch_fname = branch_fname;
	}
	public String getBranch_mgr_tel_no() {
		return branch_mgr_tel_no;
	}
	public void setBranch_mgr_tel_no(String branch_mgr_tel_no) {
		this.branch_mgr_tel_no = branch_mgr_tel_no;
	}
	public String getBranch_ip() {
		return branch_ip;
	}
	public void setBranch_ip(String branch_ip) {
		this.branch_ip = branch_ip;
	}
	public String getBranch_port() {
		return branch_port;
	}
	public void setBranch_port(String branch_port) {
		this.branch_port = branch_port;
	}
	public String getBranch_comm_no() {
		return branch_comm_no;
	}
	public void setBranch_comm_no(String branch_comm_no) {
		this.branch_comm_no = branch_comm_no;
	}
	public String getCdma_tel_no() {
		return cdma_tel_no;
	}
	public void setCdma_tel_no(String cdma_tel_no) {
		this.cdma_tel_no = cdma_tel_no;
	}
	public String getLeave_distance() {
		return leave_distance;
	}
	public void setLeave_distance(String leave_distance) {
		this.leave_distance = leave_distance;
	}
	public String getTemperature() {
		return temperature;
	}
	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}
	public String getHumidity() {
		return humidity;
	}
	public void setHumidity(String humidity) {
		this.humidity = humidity;
	}
	public String getBattery() {
		return battery;
	}
	public void setBattery(String battery) {
		this.battery = battery;
	}
	public String getNowlocation() {
		return nowlocation;
	}
	public void setNowlocation(String nowlocation) {
		this.nowlocation = nowlocation;
	}
	public String getMin_time() {
		return min_time;
	}
	public void setMin_time(String min_time) {
		this.min_time = min_time;
	}
	public String getMin_rtime() {
		return min_rtime;
	}
	public void setMin_rtime(String min_rtime) {
		this.min_rtime = min_rtime;
	}
	public String getMin_dump() {
		return min_dump;
	}
	public void setMin_dump(String min_dump) {
		this.min_dump = min_dump;
	}
	public String getMin_vl() {
		return min_vl;
	}
	public void setMin_vl(String min_vl) {
		this.min_vl = min_vl;
	}
	public String getMin_or() {
		return min_or;
	}
	public void setMin_or(String min_or) {
		this.min_or = min_or;
	}
	public String getMin_st() {
		return min_st;
	}
	public void setMin_st(String min_st) {
		this.min_st = min_st;
	}
	public String getMin_dcd() {
		return min_dcd;
	}
	public void setMin_dcd(String min_dcd) {
		this.min_dcd = min_dcd;
	}
	public String getAltitude() {
		return altitude;
	}
	public void setAltitude(String altitude) {
		this.altitude = altitude;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserGubun() {
		return userGubun;
	}
	public void setUserGubun(String userGubun) {
		this.userGubun = userGubun;
	}
	
}
