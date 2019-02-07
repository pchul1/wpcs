package daewooInfo.itemmanage.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.itemmanage.bean.GroupItemVO;
import daewooInfo.itemmanage.bean.ItemGroupVO;
import daewooInfo.itemmanage.bean.ItemInfoVO;
import daewooInfo.itemmanage.bean.ItemVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.itemmanage.bean.GroupManageVO;
import daewooInfo.itemmanage.bean.ItemManageVO;
import daewooInfo.itemmanage.bean.SystemManageVO;
import daewooInfo.spotmanage.bean.SpotInfoVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("ItemManageCounterDAO")
public class ItemManageCounterDAO extends EgovAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List getGroupList(ItemGroupVO itemGroupVO) throws Exception {
		return list("ItemManageCounterDAO.getGroupList",itemGroupVO);
	}
	@SuppressWarnings("unchecked")
	public void groupInsert(ItemGroupVO itemGroupVO) throws Exception {
		insert("ItemManageCounterDAO.groupInsert",itemGroupVO);
	}
	@SuppressWarnings("unchecked")
	public void groupUpdate(ItemGroupVO itemGroupVO) throws Exception {
		update("ItemManageCounterDAO.groupUpdate",itemGroupVO);
	}
	@SuppressWarnings("unchecked")
	public void goGroupDel(ItemGroupVO itemGroupVO) throws Exception {
		delete("ItemManageCounterDAO.goGroupDel",itemGroupVO);
		delete("ItemManageCounterDAO.goGroupItemDel",itemGroupVO);
	}
	@SuppressWarnings("unchecked")
	public void setSaveGroup(ItemGroupVO itemGroupVO) throws Exception {
		update("ItemManageCounterDAO.setSaveGroup",itemGroupVO);
	}
	@SuppressWarnings("unchecked")
	public List getGroupItemList(GroupItemVO groupItemVO) throws Exception {
		return list("ItemManageCounterDAO.getGroupItemList",groupItemVO);
	}
	@SuppressWarnings("unchecked")
	public List getItemList(GroupItemVO groupItemVO) throws Exception {
		return list("ItemManageCounterDAO.getItemList",groupItemVO);
	}
	@SuppressWarnings("unchecked")
	public void saveItem(GroupItemVO groupItemVO) throws Exception {
		insert("ItemManageCounterDAO.saveItem",groupItemVO);
	}
	@SuppressWarnings("unchecked")
	public void deleteItem(GroupItemVO groupItemVO) throws Exception {
		delete("ItemManageCounterDAO.deleteItem",groupItemVO);
	}
	@SuppressWarnings("unchecked")
	public ItemVO goItemView(ItemVO itemVO) throws Exception {
		return (ItemVO)selectByPk("ItemManageCounterDAO.goItemView",itemVO);
	}
	@SuppressWarnings("unchecked")
	public void goItemInsert(ItemVO itemVO) throws Exception {
		insert("ItemManageCounterDAO.goItemInsert",itemVO);
	}
	@SuppressWarnings("unchecked")
	public void goItemUpdate(ItemVO itemVO) throws Exception {
		update("ItemManageCounterDAO.goItemUpdateInfo",itemVO);
		update("ItemManageCounterDAO.goItemUpdateAdd",itemVO);
	}
	@SuppressWarnings("unchecked")
	public List getUnitList() throws Exception {
		return list("ItemManageCounterDAO.getUnitList",0);
	}
	@SuppressWarnings("unchecked")
	public List getSystemListItem(SystemManageVO systemManageVO) throws Exception {
		return list("ItemManageCounterDAO.getSystemListItem",systemManageVO);
	}
	@SuppressWarnings("unchecked")
	public List getSystemListGubun(SystemManageVO systemManageVO) throws Exception {
		return list("ItemManageCounterDAO.getSystemListGubun",systemManageVO);
	}
	@SuppressWarnings("unchecked")
	public List getGroupListItem(GroupManageVO groupManageVO) throws Exception {
		return list("ItemManageCounterDAO.getGroupListItem",groupManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public List getItemListItem(ItemManageVO itemManageVO) throws Exception {
		return list("ItemManageCounterDAO.getItemListItem",itemManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public int systemSaveItem(SystemManageVO systemManageVO) throws Exception {
		return update("ItemManageCounterDAO.systemSaveItem", systemManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public SystemManageVO getSystemItemInfo(SystemManageVO systemManageVO) throws Exception {
		return (SystemManageVO)selectByPk("ItemManageCounterDAO.getSystemItemInfo", systemManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public int systemInsItem(SystemManageVO systemManageVO) throws Exception {
		return update("ItemManageCounterDAO.systemInsertItem", systemManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public int systemUpdateItem(SystemManageVO systemManageVO) throws Exception {
		return update("ItemManageCounterDAO.systemUpdateItem", systemManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public int systemDelItem(SystemManageVO systemManageVO) throws Exception {
		update("ItemManageCounterDAO.systemGroupDeleteItem", systemManageVO);
		return update("ItemManageCounterDAO.systemDeleteItem", systemManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public int groupInsItem(GroupManageVO groupManageVO) throws Exception {
		return update("ItemManageCounterDAO.groupInsertItem", groupManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public int groupDelItem(GroupManageVO groupManageVO) throws Exception {
		return update("ItemManageCounterDAO.groupDeleteItem", groupManageVO);
	}
	
	@SuppressWarnings("unchecked")
	public List getGroupAddListItem(GroupManageVO groupManageVO) throws Exception {
		return list("ItemManageCounterDAO.getGroupAddListItem",groupManageVO);
	}
	@SuppressWarnings("unchecked")
	public int itemUpdateItem(ItemManageVO itemManageVO) throws Exception {
		return update("ItemManageCounterDAO.itemUpdateItem", itemManageVO);
	}
	@SuppressWarnings("unchecked")
	public void goItemDelete(ItemVO itemVO) throws Exception {
		update("ItemManageCounterDAO.goItemDelete", itemVO);
	}
	@SuppressWarnings("unchecked")
	public ItemGroupVO groupMemo(GroupItemVO groupItemVO) throws Exception {
		return (ItemGroupVO)selectByPk("ItemManageCounterDAO.groupMemo", groupItemVO);
	}
	
	@SuppressWarnings("unchecked")
	public ItemGroupVO getItemInfo(GroupItemVO groupItemVO) throws Exception {
		return (ItemGroupVO)selectByPk("ItemManageCounterDAO.getItemInfo", groupItemVO);
	}
	@SuppressWarnings("unchecked")
	public void goItemAllUpdate(ItemVO itemVO) throws Exception {
		update("ItemManageCounterDAO.goItemAllUpdate",itemVO);
	}
	public List getItemInfoA(ItemInfoVO itemInfoVO) throws Exception{
		// TODO Auto-generated method stub
		return list("ItemManageCounterDAO.getItemInfoA", itemInfoVO);
	}
	public int saveItemInfoA(ItemInfoVO itemInfoVO) throws Exception{
		// TODO Auto-generated method stub
		int result = 0; 
		result  = update("ItemManageCounterDAO.updateItemInfoA", itemInfoVO);
		result += update("ItemManageCounterDAO.updateItemInfoAdd", itemInfoVO);
		return result;
	}
	public int getItemInfoACnt(ItemInfoVO itemInfoVO) throws Exception {
		// TODO Auto-generated method stub
		return (Integer)selectByPk("ItemManageCounterDAO.getItemInfoACnt",itemInfoVO);
	}
}
