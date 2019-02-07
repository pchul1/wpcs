package daewooInfo.admin.member.bean;

import java.io.Serializable;
import java.sql.Date;

public class UserMenuAuthVO implements Serializable  {
	private String menuId ;
	private String programId;
	private String menuGroup1;
	private String menuGroup2;
	private String menuGroup3;
	private String menuName;
	private String authCUse;
	private String authUUse;
	private String authDUse;
	
	private String userId;
	private String authC;
	private String authU;
	private String authD;
	private String etc;
	private Date create_date;
	private Date update_date;
	
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}
	public String getMenuGroup1() {
		return menuGroup1;
	}
	public void setMenuGroup1(String menuGroup1) {
		this.menuGroup1 = menuGroup1;
	}
	public String getMenuGroup2() {
		return menuGroup2;
	}
	public void setMenuGroup2(String menuGroup2) {
		this.menuGroup2 = menuGroup2;
	}
	public String getMenuGroup3() {
		return menuGroup3;
	}
	public void setMenuGroup3(String menuGroup3) {
		this.menuGroup3 = menuGroup3;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAuthC() {
		return authC;
	}
	public void setAuthC(String authC) {
		this.authC = authC;
	}
	public String getAuthU() {
		return authU;
	}
	public void setAuthU(String authU) {
		this.authU = authU;
	}
	public String getAuthD() {
		return authD;
	}
	public void setAuthD(String authD) {
		this.authD = authD;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public String getAuthCUse() {
		return authCUse;
	}
	public void setAuthCUse(String authCUse) {
		this.authCUse = authCUse;
	}
	public String getAuthUUse() {
		return authUUse;
	}
	public void setAuthUUse(String authUUse) {
		this.authUUse = authUUse;
	}
	public String getAuthDUse() {
		return authDUse;
	}
	public void setAuthDUse(String authDUse) {
		this.authDUse = authDUse;
	}
	
}
