package daewooInfo.waterpolmnt.waterinfo.bean;

import java.util.Collection;
import java.util.HashMap;

import daewooInfo.cmmn.bean.ComDefaultVO;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. loafzzang.
 * @version 1.0
 * @Class Name : SearchVO.java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------   ------------   -------------------------------
 * @ 2010. 1. 27  loafzzang                   new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 27
 */
public class SearchTaksuVO extends ComDefaultVO{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**/
    /**
	 * @uml.property  name="sugye"
	 */
    private String sugye;
    /**
	 * @uml.property  name="gongku"
	 */
    private String gongku;
    /**
	 * @uml.property  name="gongkuName"
	 */
    private String gongkuName;
    /**
	 * @uml.property  name="chukjeongso"
	 */
    private String chukjeongso;
    /**
	 * @uml.property  name="bangryu"
	 */
    private String bangryu; //방류소 
    /**
	 * @uml.property  name="dataType"
	 */
    private String dataType;
    /**
	 * @uml.property  name="frDate"
	 */
    private String frDate;
    /**
	 * @uml.property  name="toDate"
	 */
    private String toDate;
    /**
	 * @uml.property  name="frTime"
	 */
    private String frTime;
    /**
	 * @uml.property  name="toTime"
	 */
    private String toTime;
    /**
	 * @uml.property  name="sys"
	 */
    private String sys;
    /**
	 * @uml.property  name="item01"
	 */
    private String item01;
    /**
	 * @uml.property  name="item02"
	 */
    private String item02;
    /**
	 * @uml.property  name="item03"
	 */
    private String item03;
    /**
	 * @uml.property  name="item04"
	 */
    private String item04;
    /**
	 * @uml.property  name="item05"
	 */
    private String item05;
    /**
	 * @uml.property  name="item06"
	 */
    private String item06;
    /**
	 * @uml.property  name="item07"
	 */
    private String item07;
    /**
	 * @uml.property  name="orderby_time"
	 */
    private String orderby_time;
    /**
	 * @uml.property  name="minor"
	 */
    private String minor;
    /**
	 * @uml.property  name="valid"
	 */
    private String valid;
    /**
	 * @uml.property  name="item"
	 */
    private String item;
    
    /**
	 * @uml.property  name="minTime"
	 */
    private String minTime;
    /**
	 * @uml.property  name="endTime"
	 */
    private String endTime;
    
    /**
	 * @uml.property  name="orderType1"
	 */
    private String orderType1;
    
    /**
	 * @uml.property  name="lastFlag"
	 */
    private String lastFlag = "X";
    /**
	 * @uml.property  name="useflag"
	 */
    private String useflag;
    
    private String userGubun;
    
    private String userId;
    
    private String branchNo;
    
    private String roleCode;
    
    private String mainPageUnit;
    
    private String modelSeq;
    
    private String factCode;
    
    private String imageDate;
    private String itemCode;
	/**
	 * @return
	 * @uml.property  name="useflag"
	 */
	public String getUseflag() {
		return useflag;
	}
	/**
	 * @param useflag
	 * @uml.property  name="useflag"
	 */
	public void setUseflag(String useflag) {
		this.useflag = useflag;
	}
	/**
	 * @return
	 * @uml.property  name="lastFlag"
	 */
	public String getLastFlag() {
		return lastFlag;
	}
	/**
	 * @param lastFlag
	 * @uml.property  name="lastFlag"
	 */
	public void setLastFlag(String lastFlag) {
		this.lastFlag = lastFlag;
	}
	/**
	 * @return
	 * @uml.property  name="orderType1"
	 */
	public String getOrderType1() {
		return orderType1;
	}
	/**
	 * @param orderType1
	 * @uml.property  name="orderType1"
	 */
	public void setOrderType1(String orderType1) {
		this.orderType1 = orderType1;
	}
	/**
	 * @return
	 * @uml.property  name="minTime"
	 */
	public String getMinTime() {
		return minTime;
	}
	/**
	 * @param minTime
	 * @uml.property  name="minTime"
	 */
	public void setMinTime(String minTime) {
		this.minTime = minTime;
	}
	/**
	 * @return
	 * @uml.property  name="endTime"
	 */
	public String getEndTime() {
		return endTime;
	}
	/**
	 * @param endTime
	 * @uml.property  name="endTime"
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	/**
	 * @return
	 * @uml.property  name="item"
	 */
	public String getItem() {
		return item;
	}
	/**
	 * @param item
	 * @uml.property  name="item"
	 */
	public void setItem(String item) {
		this.item = item;
	}
	/**
	 * @return
	 * @uml.property  name="minor"
	 */
	public String getMinor() {
		return minor;
	}
	/**
	 * @param minor
	 * @uml.property  name="minor"
	 */
	public void setMinor(String minor) {
		this.minor = minor;
	}
	/**
	 * @return
	 * @uml.property  name="valid"
	 */
	public String getValid() {
		return valid;
	}
	/**
	 * @param valid
	 * @uml.property  name="valid"
	 */
	public void setValid(String valid) {
		this.valid = valid;
	}
	/**
	 * @return
	 * @uml.property  name="orderby_time"
	 */
	public String getOrderby_time() {
		return orderby_time;
	}
	/**
	 * @param orderby_time
	 * @uml.property  name="orderby_time"
	 */
	public void setOrderby_time(String orderby_time) {
		this.orderby_time = orderby_time;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	/**
	 * @return
	 * @uml.property  name="bangryu"
	 */
	public String getBangryu() {
		return bangryu;
	}
	/**
	 * @param bangryu
	 * @uml.property  name="bangryu"
	 */
	public void setBangryu(String bangryu) {
		this.bangryu = bangryu;
	}
	/**
	 * @return
	 * @uml.property  name="sugye"
	 */
	public String getSugye() {
		return sugye;
	}
	/**
	 * @param sugye
	 * @uml.property  name="sugye"
	 */
	public void setSugye(String sugye) {
		this.sugye = sugye;
	}
	/**
	 * @return
	 * @uml.property  name="gongku"
	 */
	public String getGongku() {
		return gongku;
	}
	/**
	 * @param gongku
	 * @uml.property  name="gongku"
	 */
	public void setGongku(String gongku) {
		this.gongku = gongku;
	}
	/**
	 * @return
	 * @uml.property  name="gongkuName"
	 */
	public String getGongkuName() {
		return gongkuName;
	}
	/**
	 * @param gongkuName
	 * @uml.property  name="gongkuName"
	 */
	public void setGongkuName(String gongkuName) {
		this.gongkuName = gongkuName;
	}
	/**
	 * @return
	 * @uml.property  name="chukjeongso"
	 */
	public String getChukjeongso() {
		return chukjeongso;
	}
	/**
	 * @param chukjeongso
	 * @uml.property  name="chukjeongso"
	 */
	public void setChukjeongso(String chukjeongso) {
		this.chukjeongso = chukjeongso;
	}
	/**
	 * @return
	 * @uml.property  name="dataType"
	 */
	public String getDataType() {
		return dataType;
	}
	/**
	 * @param dataType
	 * @uml.property  name="dataType"
	 */
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	/**
	 * @return
	 * @uml.property  name="frDate"
	 */
	public String getFrDate() {
		return frDate;
	}
	/**
	 * @param frDate
	 * @uml.property  name="frDate"
	 */
	public void setFrDate(String frDate) {
		this.frDate = frDate;
	}
	/**
	 * @return
	 * @uml.property  name="toDate"
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate
	 * @uml.property  name="toDate"
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	/**
	 * @return
	 * @uml.property  name="frTime"
	 */
	public String getFrTime() {
		return frTime;
	}
	/**
	 * @param frTime
	 * @uml.property  name="frTime"
	 */
	public void setFrTime(String frTime) {
		this.frTime = frTime;
	}
	/**
	 * @return
	 * @uml.property  name="toTime"
	 */
	public String getToTime() {
		return toTime;
	}
	/**
	 * @param toTime
	 * @uml.property  name="toTime"
	 */
	public void setToTime(String toTime) {
		this.toTime = toTime;
	}
	/**
	 * @return
	 * @uml.property  name="sys"
	 */
	public String getSys() {
		return sys;
	}
	/**
	 * @param sys
	 * @uml.property  name="sys"
	 */
	public void setSys(String sys) {
		this.sys = sys;
	}
	/**
	 * @return
	 * @uml.property  name="item01"
	 */
	public String getItem01() {
		return item01;
	}
	/**
	 * @param item01
	 * @uml.property  name="item01"
	 */
	public void setItem01(String item01) {
		this.item01 = item01;
	}
	/**
	 * @return
	 * @uml.property  name="item02"
	 */
	public String getItem02() {
		return item02;
	}
	/**
	 * @param item02
	 * @uml.property  name="item02"
	 */
	public void setItem02(String item02) {
		this.item02 = item02;
	}
	/**
	 * @return
	 * @uml.property  name="item03"
	 */
	public String getItem03() {
		return item03;
	}
	/**
	 * @param item03
	 * @uml.property  name="item03"
	 */
	public void setItem03(String item03) {
		this.item03 = item03;
	}
	/**
	 * @return
	 * @uml.property  name="item04"
	 */
	public String getItem04() {
		return item04;
	}
	/**
	 * @param item04
	 * @uml.property  name="item04"
	 */
	public void setItem04(String item04) {
		this.item04 = item04;
	}
	/**
	 * @return
	 * @uml.property  name="item05"
	 */
	public String getItem05() {
		return item05;
	}
	/**
	 * @param item05
	 * @uml.property  name="item05"
	 */
	public void setItem05(String item05) {
		this.item05 = item05;
	}
	/**
	 * @return
	 * @uml.property  name="item06"
	 */
	public String getItem06() {
		return item06;
	}
	/**
	 * @param item06
	 * @uml.property  name="item06"
	 */
	public void setItem06(String item06) {
		this.item06 = item06;
	}
	/**
	 * @return
	 * @uml.property  name="item07"
	 */
	public String getItem07() {
		return item07;
	}
	/**
	 * @param item07
	 * @uml.property  name="item07"
	 */
	public void setItem07(String item07) {
		this.item07 = item07;
	}
	public String getUserGubun() {
		return userGubun;
	}
	public void setUserGubun(String userGubun) {
		this.userGubun = userGubun;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBranchNo() {
		return branchNo;
	}
	public void setBranchNo(String branchNo) {
		this.branchNo = branchNo;
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public String getMainPageUnit() {
		return mainPageUnit;
	}
	public void setMainPageUnit(String mainPageUnit) {
		this.mainPageUnit = mainPageUnit;
	}
	public String getModelSeq() {
		return modelSeq;
	}
	public void setModelSeq(String modelSeq) {
		this.modelSeq = modelSeq;
	}
	public String getFactCode() {
		return factCode;
	}
	public void setFactCode(String factCode) {
		this.factCode = factCode;
	}
	public String getImageDate() {
		return imageDate;
	}
	public void setImageDate(String imageDate) {
		this.imageDate = imageDate;
	}
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
}