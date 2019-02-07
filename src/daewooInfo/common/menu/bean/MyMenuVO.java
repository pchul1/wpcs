package daewooInfo.common.menu.bean;


public class MyMenuVO  extends MenuVO{
	
	private static final long serialVersionUID = 1L;
	
	private String member_id;
	private String menu_open;
	private String view_mode;
	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMenu_open() {
		return menu_open;
	}

	public void setMenu_open(String menu_open) {
		this.menu_open = menu_open;
	}

	public String getView_mode() {
		return view_mode;
	}

	public void setView_mode(String view_mode) {
		this.view_mode = view_mode;
	}
}
