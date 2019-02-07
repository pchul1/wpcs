package daewooInfo.spotmanage.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class SysEquipVO extends ComDefaultVO{
	//시스템 종류
	String sys_kind;
	
	//장비코드
	String equip_code;
	
	//제조사
	String equip_maker;
	
	//모델명
	String equip_name;
	
	//등록자id
	String reg_id;
	
	//등록일
	String reg_date;
	
	//수정자id
	String mod_id;
		
	//수정일
	String mod_date;
	
	String e_sys_kind;
	
	String searchSysKeyword;
	
	String searchSysKind;
	
	String sys_kind_name;

	public String getSys_kind() {
		return sys_kind;
	}

	public void setSys_kind(String sys_kind) {
		this.sys_kind = sys_kind;
	}

	public String getEquip_code() {
		return equip_code;
	}

	public void setEquip_code(String equip_code) {
		this.equip_code = equip_code;
	}

	public String getEquip_maker() {
		return equip_maker;
	}

	public void setEquip_maker(String equip_maker) {
		this.equip_maker = equip_maker;
	}

	public String getEquip_name() {
		return equip_name;
	}

	public void setEquip_name(String equip_name) {
		this.equip_name = equip_name;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getMod_date() {
		return mod_date;
	}

	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}

	public String getSearchSysKeyword() {
		return searchSysKeyword;
	}

	public void setSearchSysKeyword(String searchSysKeyword) {
		this.searchSysKeyword = searchSysKeyword;
	}

	public String getE_sys_kind() {
		return e_sys_kind;
	}

	public void setE_sys_kind(String e_sys_kind) {
		this.e_sys_kind = e_sys_kind;
	}

	public String getSearchSysKind() {
		return searchSysKind;
	}

	public void setSearchSysKind(String searchSysKind) {
		this.searchSysKind = searchSysKind;
	}

	public String getSys_kind_name() {
		return sys_kind_name;
	}

	public void setSys_kind_name(String sys_kind_name) {
		this.sys_kind_name = sys_kind_name;
	}
	
	
		
}
