package daewooInfo.warehouse.bean;

import java.io.Serializable;

public class WareHouseVO  implements Serializable {
	
	 
	private static final long serialVersionUID = 1L;
	
	/**
	 * @uml.property  name="whCode"
	 */
	private String whCode;
	/**
	 * @uml.property  name="whName"
	 */
	private String whName;
	/**
	 * @uml.property  name="adminDept"
	 */
	private String adminDept;
	/**
	 * @uml.property  name="upperDept"
	 */
	private String upperDept;
	/**
	 * @uml.property  name="adminName"
	 */
	private String adminName;
	/**
	 * @uml.property  name="adminNameSub"
	 */
	private String adminNameSub;
	/**
	 * @uml.property  name="adminTelno"
	 */
	private String adminTelno;
	/**
	 * @uml.property  name="addr"
	 */
	private String addr;
	/**
	 * @uml.property  name="lon"
	 */
	private String lon;
	/**
	 * @uml.property  name="lat"
	 */
	private String lat;
	/**
	 * @uml.property  name="ctyCode"
	 */
	private String ctyCode;
	/**
	 * @uml.property  name="ctyName"
	 */
	private String ctyName;
	/**
	 * @uml.property  name="num"
	 */
	private String num;
	/**
	 * @uml.property  name="riverDiv"
	 */
	private String riverDiv;
    /**
	 * @uml.property  name="useFlag"
	 */
    private String useFlag;
    /**
	 * @uml.property  name="warehouseSeq"
	 */
    private String warehouseSeq;
    /**
	 * @uml.property  name="deleteWhCode"
	 */
    private String deleteWhCode;
    
    /**
	 * @uml.property  name="subDept"
	 */
    private String subDept;
    /**
	 * @uml.property  name="subName"
	 */
    private String subName;
    /**
	 * @uml.property  name="zipcode"
	 */
    private String zipcode;
    /**
	 * @uml.property  name="addrDetail"
	 */
    private String addrDetail;
    
    /**
	 * @uml.property  name="adminDeptName"
	 */
    private String adminDeptName;
    /**
	 * @uml.property  name="subDeptName"
	 */
    private String subDeptName;
    
    /**
	 * @uml.property  name="adminMemberName"
	 */
    private String adminMemberName;
    /**
	 * @uml.property  name="subMemberName"
	 */
    private String subMemberName;	
    /**
	 * @uml.property  name="adminDeptSub"
	 */
    private String adminDeptSub;
    /**
	 * @uml.property  name="itemCode"
	 */
    private String itemCode;
    
	/**
	 * @uml.property  name="adminCode"
	 */
	private String adminCode;
    /**
	 * @uml.property  name="riverName"
	 */
    private String riverName;
    /**
	 * @uml.property  name="adminDeptNameSub"
	 */
    private String adminDeptNameSub;
	/**
	 * @uml.property  name="adminId"
	 */
	private String adminId;
    /**
	 * @uml.property  name="adminIdSub"
	 */
    private String adminIdSub;
    
    private String itemCodeNum;
    
    private String doCode;
    
    private String upperAdminDept;
    private String upperAdminName;
    private String upperAdminDeptSub;
    private String upperAdminNameSub;
    
    private String atchFileId;
    private String title;
    private String regId;
    
    private String imageDateFrom;
    private String imageDateTo;
    
    /**
	 * @return
	 * @uml.property  name="adminId"
	 */
    public String getAdminId() {
		return adminId;
	}
	/**
	 * @param adminId
	 * @uml.property  name="adminId"
	 */
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	/**
	 * @return
	 * @uml.property  name="adminIdSub"
	 */
	public String getAdminIdSub() {
		return adminIdSub;
	}
	/**
	 * @param adminIdSub
	 * @uml.property  name="adminIdSub"
	 */
	public void setAdminIdSub(String adminIdSub) {
		this.adminIdSub = adminIdSub;
	}

    /**
	 * @return
	 * @uml.property  name="ctyName"
	 */
    public String getCtyName() {
		return ctyName;
	}
	/**
	 * @param ctyName
	 * @uml.property  name="ctyName"
	 */
	public void setCtyName(String ctyName) {
		this.ctyName = ctyName;
	}

    /**
	 * @return
	 * @uml.property  name="adminCode"
	 */
    public String getAdminCode() {
		return adminCode;
	}
	/**
	 * @param adminCode
	 * @uml.property  name="adminCode"
	 */
	public void setAdminCode(String adminCode) {
		this.adminCode = adminCode;
	}
	/**
	 * @return
	 * @uml.property  name="riverName"
	 */
	public String getRiverName() {
		return riverName;
	}
	/**
	 * @param riverName
	 * @uml.property  name="riverName"
	 */
	public void setRiverName(String riverName) {
		this.riverName = riverName;
	}
	/**
	 * @return
	 * @uml.property  name="adminDeptNameSub"
	 */
	public String getAdminDeptNameSub() {
		return adminDeptNameSub;
	}
	/**
	 * @param adminDeptNameSub
	 * @uml.property  name="adminDeptNameSub"
	 */
	public void setAdminDeptNameSub(String adminDeptNameSub) {
		this.adminDeptNameSub = adminDeptNameSub;
	}
    /**
	 * @return
	 * @uml.property  name="itemCode"
	 */
    public String getItemCode() {
		return itemCode;
	}
	/**
	 * @param itemCode
	 * @uml.property  name="itemCode"
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	
    /**
	 * @return
	 * @uml.property  name="adminDeptSub"
	 */
    public String getAdminDeptSub() {
		return adminDeptSub;
	}
	/**
	 * @param adminDeptSub
	 * @uml.property  name="adminDeptSub"
	 */
	public void setAdminDeptSub(String adminDeptSub) {
		this.adminDeptSub = adminDeptSub;
	}
	
	/**
	 * @return
	 * @uml.property  name="riverDiv"
	 */
	public String getRiverDiv() {
		return riverDiv;
	}
	/**
	 * @param riverDiv
	 * @uml.property  name="riverDiv"
	 */
	public void setRiverDiv(String riverDiv) {
		this.riverDiv = riverDiv;
	}
	/**
	 * @return
	 * @uml.property  name="useFlag"
	 */
	public String getUseFlag() {
		return useFlag;
	}
	/**
	 * @param useFlag
	 * @uml.property  name="useFlag"
	 */
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
 
	/**
	 * @return
	 * @uml.property  name="num"
	 */
	public String getNum() {
		return num;
	}
	/**
	 * @param num
	 * @uml.property  name="num"
	 */
	public void setNum(String num) {
		this.num = num;
	}
	/**
	 * @return
	 * @uml.property  name="ctyCode"
	 */
	public String getCtyCode() {
		return ctyCode;
	}
	/**
	 * @param ctyCode
	 * @uml.property  name="ctyCode"
	 */
	public void setCtyCode(String ctyCode) {
		this.ctyCode = ctyCode;
	}
	/**
	 * @return
	 * @uml.property  name="whCode"
	 */
	public String getWhCode() {
		return whCode;
	}
	/**
	 * @param whCode
	 * @uml.property  name="whCode"
	 */
	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	/**
	 * @return
	 * @uml.property  name="whName"
	 */
	public String getWhName() {
		return whName;
	}
	/**
	 * @param whName
	 * @uml.property  name="whName"
	 */
	public void setWhName(String whName) {
		this.whName = whName;
	}
	/**
	 * @return
	 * @uml.property  name="adminDept"
	 */
	public String getAdminDept() {
		return adminDept;
	}
	/**
	 * @param adminDept
	 * @uml.property  name="adminDept"
	 */
	public void setAdminDept(String adminDept) {
		this.adminDept = adminDept;
	}
	/**
	 * @return
	 * @uml.property  name="adminName"
	 */
	public String getAdminName() {
		return adminName;
	}
	/**
	 * @param adminName
	 * @uml.property  name="adminName"
	 */
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	/**
	 * @return
	 * @uml.property  name="adminTelno"
	 */
	public String getAdminTelno() {
		return adminTelno;
	}
	/**
	 * @param adminTelno
	 * @uml.property  name="adminTelno"
	 */
	public void setAdminTelno(String adminTelno) {
		this.adminTelno = adminTelno;
	}
	/**
	 * @return
	 * @uml.property  name="addr"
	 */
	public String getAddr() {
		return addr;
	}
	/**
	 * @param addr
	 * @uml.property  name="addr"
	 */
	public void setAddr(String addr) {
		this.addr = addr;
	}
	/**
	 * @return
	 * @uml.property  name="lon"
	 */
	public String getLon() {
		return lon;
	}
	/**
	 * @param lon
	 * @uml.property  name="lon"
	 */
	public void setLon(String lon) {
		this.lon = lon;
	}
	/**
	 * @return
	 * @uml.property  name="lat"
	 */
	public String getLat() {
		return lat;
	}
	/**
	 * @param lat
	 * @uml.property  name="lat"
	 */
	public void setLat(String lat) {
		this.lat = lat;
	}
	/**
	 * @param warehouseSeq
	 * @uml.property  name="warehouseSeq"
	 */
	public void setWarehouseSeq(String warehouseSeq) {
		this.warehouseSeq = warehouseSeq;
	}
	/**
	 * @return
	 * @uml.property  name="warehouseSeq"
	 */
	public String getWarehouseSeq() {
		return warehouseSeq;
	}
	/**
	 * @param adminNameSub
	 * @uml.property  name="adminNameSub"
	 */
	public void setAdminNameSub(String adminNameSub) {
		this.adminNameSub = adminNameSub;
	}
	/**
	 * @return
	 * @uml.property  name="adminNameSub"
	 */
	public String getAdminNameSub() {
		return adminNameSub;
	}
	/**
	 * @param upperDept
	 * @uml.property  name="upperDept"
	 */
	public void setUpperDept(String upperDept) {
		this.upperDept = upperDept;
	}
	/**
	 * @return
	 * @uml.property  name="upperDept"
	 */
	public String getUpperDept() {
		return upperDept;
	}
	/**
	 * @param deleteWhCode
	 * @uml.property  name="deleteWhCode"
	 */
	public void setDeleteWhCode(String deleteWhCode) {
		this.deleteWhCode = deleteWhCode;
	}
	/**
	 * @return
	 * @uml.property  name="deleteWhCode"
	 */
	public String getDeleteWhCode() {
		return deleteWhCode;
	}
	/**
	 * @return
	 * @uml.property  name="subDept"
	 */
	public String getSubDept() {
		return subDept;
	}
	/**
	 * @param subDept
	 * @uml.property  name="subDept"
	 */
	public void setSubDept(String subDept) {
		this.subDept = subDept;
	}
	/**
	 * @return
	 * @uml.property  name="subName"
	 */
	public String getSubName() {
		return subName;
	}
	/**
	 * @param subName
	 * @uml.property  name="subName"
	 */
	public void setSubName(String subName) {
		this.subName = subName;
	}	
	/**
	 * @return
	 * @uml.property  name="zipcode"
	 */
	public String getZipcode() {
		return zipcode;
	}
	/**
	 * @param zipcode
	 * @uml.property  name="zipcode"
	 */
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	/**
	 * @return
	 * @uml.property  name="addrDetail"
	 */
	public String getAddrDetail() {
		return addrDetail;
	}
	/**
	 * @param addrDetail
	 * @uml.property  name="addrDetail"
	 */
	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}	
	/**
	 * @return
	 * @uml.property  name="adminDeptName"
	 */
	public String getAdminDeptName() {
		return adminDeptName;
	}
	/**
	 * @param adminDeptName
	 * @uml.property  name="adminDeptName"
	 */
	public void setAdminDeptName(String adminDeptName) {
		this.adminDeptName = adminDeptName;
	}
	/**
	 * @return
	 * @uml.property  name="subDeptName"
	 */
	public String getSubDeptName() {
		return subDeptName;
	}
	/**
	 * @param subDeptName
	 * @uml.property  name="subDeptName"
	 */
	public void setSubDeptName(String subDeptName) {
		this.subDeptName = subDeptName;
	}
	/**
	 * @return
	 * @uml.property  name="adminMemberName"
	 */
	public String getAdminMemberName() {
		return adminMemberName;
	}
	/**
	 * @param adminMemberName
	 * @uml.property  name="adminMemberName"
	 */
	public void setAdminMemberName(String adminMemberName) {
		this.adminMemberName = adminMemberName;
	}
	/**
	 * @return
	 * @uml.property  name="subMemberName"
	 */
	public String getSubMemberName() {
		return subMemberName;
	}
	/**
	 * @param subMemberName
	 * @uml.property  name="subMemberName"
	 */
	public void setSubMemberName(String subMemberName) {
		this.subMemberName = subMemberName;
	}
	public String getItemCodeNum() {
		return itemCodeNum;
	}
	public void setItemCodeNum(String itemCodeNum) {
		this.itemCodeNum = itemCodeNum;
	}
	public String getDoCode() {
		return doCode;
	}
	public void setDoCode(String doCode) {
		this.doCode = doCode;
	}
	public String getUpperAdminDept() {
		return upperAdminDept;
	}
	public void setUpperAdminDept(String upperAdminDept) {
		this.upperAdminDept = upperAdminDept;
	}
	public String getUpperAdminName() {
		return upperAdminName;
	}
	public void setUpperAdminName(String upperAdminName) {
		this.upperAdminName = upperAdminName;
	}
	public String getUpperAdminDeptSub() {
		return upperAdminDeptSub;
	}
	public void setUpperAdminDeptSub(String upperAdminDeptSub) {
		this.upperAdminDeptSub = upperAdminDeptSub;
	}
	public String getUpperAdminNameSub() {
		return upperAdminNameSub;
	}
	public void setUpperAdminNameSub(String upperAdminNameSub) {
		this.upperAdminNameSub = upperAdminNameSub;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getTitle() {
		return title;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImageDateFrom() {
		return imageDateFrom;
	}
	public void setImageDateFrom(String imageDateFrom) {
		this.imageDateFrom = imageDateFrom;
	}
	public String getImageDateTo() {
		return imageDateTo;
	}
	public void setImageDateTo(String imageDateTo) {
		this.imageDateTo = imageDateTo;
	}
	
}
