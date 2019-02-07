package daewooInfo.waterpolmnt.situationctl.bean;


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
public class TotalMntMainSearchVO {
	/**/
    /**
	 * @uml.property  name="sys"
	 */
    private String sys;
    /**
	 * @uml.property  name="item"
	 */
    private String item;
    /**
	 * @uml.property  name="river_div"
	 */
    private String river_div;
    

    /**
	 * @return
	 * @uml.property  name="river_div"
	 */
    public String getRiver_div() {
		return river_div;
	}
	/**
	 * @param river_div
	 * @uml.property  name="river_div"
	 */
	public void setRiver_div(String river_div) {
		this.river_div = river_div;
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
