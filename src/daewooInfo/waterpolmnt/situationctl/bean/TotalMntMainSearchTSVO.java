package daewooInfo.waterpolmnt.situationctl.bean;

import java.util.HashMap;
import java.util.List;


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
public class TotalMntMainSearchTSVO {
	/**/
    /**
	 * @uml.property  name="sys"
	 */
    private String sys;
    /**
	 * @uml.property  name="river"
	 */
    private String river;
    /**
	 * @uml.property  name="step"
	 */
    private String step;
    /**
	 * @uml.property  name="item"
	 */
    private String item;
    /**
	 * @uml.property  name="orderby"
	 */
    private String orderby;
    
    private List<HashMap<String, Object>> listData;	
	
	public List<HashMap<String, Object>> getListData() {
		return listData;
	}
	public void setListData(List<HashMap<String, Object>> listData) {
		this.listData = listData;
	}
    
	/**
	 * @return
	 * @uml.property  name="orderby"
	 */
	public String getOrderby() {
		return orderby;
	}
	/**
	 * @param orderby
	 * @uml.property  name="orderby"
	 */
	public void setOrderby(String orderby) {
		this.orderby = orderby;
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
	 * @uml.property  name="river"
	 */
	public String getRiver() {
		return river;
	}
	/**
	 * @param river
	 * @uml.property  name="river"
	 */
	public void setRiver(String river) {
		this.river = river;
	}
	/**
	 * @return
	 * @uml.property  name="step"
	 */
	public String getStep() {
		return step;
	}
	/**
	 * @param step
	 * @uml.property  name="step"
	 */
	public void setStep(String step) {
		this.step = step;
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
}
