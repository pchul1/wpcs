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
public class TotalMntNorecvSearchTSVO {
	/**/
    /**
	 * @uml.property  name="sys_kind"
	 */
    private String sys_kind;
    /**
	 * @uml.property  name="river_div"
	 */
    private String river_div;

	/**
	 * @return
	 * @uml.property  name="sys_kind"
	 */
	public String getSys_kind() {
		return sys_kind;
	}
	/**
	 * @param sys_kind
	 * @uml.property  name="sys_kind"
	 */
	public void setSys_kind(String sys_kind) {
		this.sys_kind = sys_kind;
	}
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
}
