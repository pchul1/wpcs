package daewooInfo.common.menu.bean;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class MenuVO  implements Serializable {
	
	/**
	 * @uml.property  name="selected"
	 */
	private String selected = "";
	/**
	 * @uml.property  name="roleName"
	 */
	private String roleName = "";
	/**
	 * @uml.property  name="menuName"
	 */
	private String menuName = "";
	/**
	 * @uml.property  name="menuNo"
	 */
	private int menuNo = 0;
	/**
	 * @uml.property  name="menuUpperNo"
	 */
	private int menuUpperNo = 0;
	/**
	 * @uml.property  name="menuOrder"
	 */
	private int menuOrder = 0;
	/**
	 * @uml.property  name="url"
	 */
	private String url = "";
	/**
	 * @uml.property  name="relateImagePath"
	 */
	private String relateImagePath = "";
	/**
	 * @uml.property  name="relateImageName"
	 */
	private String relateImageName = "";
	/**
	 * @uml.property  name="relatesavepath"
	 */
	private String relatesavepath = "";
	/**
	 * @uml.property  name="subMenuList"
	 * @uml.associationEnd  multiplicity="(0 -1)" elementType="daewooInfo.common.menu.bean.MenuVO"
	 */
	
	private String lvl;
	private List<MenuVO> subMenuList = null;
	
	/**
	 * @uml.property  name="subMenuNo"
	 */
	private int subMenuNo = 0;
	
	/**
	 * @return
	 * @uml.property  name="selected"
	 */
	public String getSelected() {
		return selected;
	}
	/**
	 * @param selected
	 * @uml.property  name="selected"
	 */
	public void setSelected(String selected) {
		this.selected = selected;
	}
	public List<MenuVO> getSubMenuList() {
		return subMenuList;
	}
	public void setSubMenuList(List<MenuVO> subMenuList) {
		this.subMenuList = subMenuList;
	}
	/**
	 * @return
	 * @uml.property  name="roleName"
	 */
	public String getRoleName() {
		return roleName;
	}
	/**
	 * @param roleName
	 * @uml.property  name="roleName"
	 */
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	/**
	 * @return
	 * @uml.property  name="menuName"
	 */
	public String getMenuName() {
		return menuName;
	}
	/**
	 * @param menuName
	 * @uml.property  name="menuName"
	 */
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	/**
	 * @return
	 * @uml.property  name="menuNo"
	 */
	public int getMenuNo() {
		return menuNo;
	}
	/**
	 * @param menuNo
	 * @uml.property  name="menuNo"
	 */
	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}
	/**
	 * @return
	 * @uml.property  name="menuUpperNo"
	 */
	public int getMenuUpperNo() {
		return menuUpperNo;
	}
	/**
	 * @param menuUpperNo
	 * @uml.property  name="menuUpperNo"
	 */
	public void setMenuUpperNo(int menuUpperNo) {
		this.menuUpperNo = menuUpperNo;
	}
	/**
	 * @return
	 * @uml.property  name="menuOrder"
	 */
	public int getMenuOrder() {
		return menuOrder;
	}
	/**
	 * @param menuOrder
	 * @uml.property  name="menuOrder"
	 */
	public void setMenuOrder(int menuOrder) {
		this.menuOrder = menuOrder;
	}
	/**
	 * @return
	 * @uml.property  name="url"
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * @param url
	 * @uml.property  name="url"
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * @return
	 * @uml.property  name="relateImagePath"
	 */
	public String getRelateImagePath() {
		return relateImagePath;
	}
	/**
	 * @param relateImagePath
	 * @uml.property  name="relateImagePath"
	 */
	public void setRelateImagePath(String relateImagePath) {
		this.relateImagePath = relateImagePath;
	}
	/**
	 * @return
	 * @uml.property  name="relateImageName"
	 */
	public String getRelateImageName() {
		return relateImageName;
	}
	/**
	 * @param relateImageName
	 * @uml.property  name="relateImageName"
	 */
	public void setRelateImageName(String relateImageName) {
		this.relateImageName = relateImageName;
	}
	/**
	 * @return
	 * @uml.property  name="relatesavepath"
	 */
	public String getRelatesavepath() {
		return relatesavepath;
	}
	/**
	 * @param relatesavepath
	 * @uml.property  name="relatesavepath"
	 */
	public void setRelatesavepath(String relatesavepath) {
		this.relatesavepath = relatesavepath;
	}
	public String getLvl() {
		return lvl;
	}
	public void setLvl(String lvl) {
		this.lvl = lvl;
	}
	/**
	 * @return the subMenuNo
	 */
	public int getSubMenuNo() {
		return subMenuNo;
	}
	/**
	 * @param subMenuNo the subMenuNo to set
	 */
	public void setSubMenuNo(int subMenuNo) {
		this.subMenuNo = subMenuNo;
	}
}
