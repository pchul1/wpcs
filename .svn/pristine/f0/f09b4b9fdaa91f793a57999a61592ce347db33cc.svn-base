package daewooInfo.itemmanage.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import daewooInfo.itemmanage.bean.GroupItemVO;
import daewooInfo.itemmanage.bean.ItemGroupVO;
import daewooInfo.itemmanage.bean.ItemInfoVO;
import daewooInfo.itemmanage.bean.ItemVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.itemmanage.bean.GroupManageVO;
import daewooInfo.itemmanage.bean.ItemManageVO;
import daewooInfo.itemmanage.bean.SystemManageVO;
import daewooInfo.itemmanage.dao.ItemManageCounterDAO;
import daewooInfo.itemmanage.service.ItemManageCounterService;
import daewooInfo.spotmanage.bean.SpotInfoVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("ItemManageCounterService")
public class ItemManageCounterServiceImpl extends AbstractServiceImpl implements ItemManageCounterService {
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * @uml.property  name="itemManageCounterDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "ItemManageCounterDAO")
    private ItemManageCounterDAO itemManageCounterDAO;
	
	public List getGroupList(ItemGroupVO itemGroupVO) throws Exception {
		return itemManageCounterDAO.getGroupList(itemGroupVO);
	}
	public void groupInsert(ItemGroupVO itemGroupVO) throws Exception {
		itemManageCounterDAO.groupInsert(itemGroupVO);
	}
	public void groupUpdate(ItemGroupVO itemGroupVO) throws Exception {
		itemManageCounterDAO.groupUpdate(itemGroupVO);
	}
	public void goGroupDel(ItemGroupVO itemGroupVO) throws Exception {
		itemManageCounterDAO.goGroupDel(itemGroupVO);
	}
	public void setSaveGroup(ItemGroupVO itemGroupVO) throws Exception{
		itemManageCounterDAO.setSaveGroup(itemGroupVO);
	}
	public List getGroupItemList(GroupItemVO groupItemVO) throws Exception{
		return itemManageCounterDAO.getGroupItemList(groupItemVO);
	}
	public List getItemList(GroupItemVO groupItemVO) throws Exception{
		return itemManageCounterDAO.getItemList(groupItemVO);
	}
	public void saveItem(GroupItemVO groupItemVO) throws Exception {
		itemManageCounterDAO.saveItem(groupItemVO);
	}
	public void deleteItem(GroupItemVO groupItemVO) throws Exception {
		itemManageCounterDAO.deleteItem(groupItemVO);
	}
	public ItemVO goItemView(ItemVO itemVO) throws Exception {
		return itemManageCounterDAO.goItemView(itemVO);
	}
	public void goItemInsert(ItemVO itemVO) throws Exception {
		itemManageCounterDAO.goItemInsert(itemVO);
	}
	public void goItemUpdate(ItemVO itemVO) throws Exception {
		itemManageCounterDAO.goItemUpdate(itemVO);
	}
	public List getUnitList() throws Exception {
		return itemManageCounterDAO.getUnitList();
	}
	public List getSystemListItem(SystemManageVO systemManageVO) throws Exception {
		return itemManageCounterDAO.getSystemListItem(systemManageVO);
	}
	public List getSystemListGubun(SystemManageVO systemManageVO) throws Exception {
		return itemManageCounterDAO.getSystemListGubun(systemManageVO);
	}
	public List getGroupListItem(GroupManageVO groupManageVO) throws Exception {
		return itemManageCounterDAO.getGroupListItem(groupManageVO);
	}
	
	public List getItemListItem(ItemManageVO itemManageVO) throws Exception {
		return itemManageCounterDAO.getItemListItem(itemManageVO);
	}
	
	public int systemSaveItem(SystemManageVO systemManageVO) throws Exception {
		return itemManageCounterDAO.systemSaveItem(systemManageVO);
	}
	
	public int systemInsItem(SystemManageVO systemManageVO) throws Exception {
		return itemManageCounterDAO.systemInsItem(systemManageVO);
	}
	
	public int systemUpdateItem(SystemManageVO systemManageVO) throws Exception {
		return itemManageCounterDAO.systemUpdateItem(systemManageVO);
	}
	
	public int systemDelItem(SystemManageVO systemManageVO) throws Exception {
		return itemManageCounterDAO.systemDelItem(systemManageVO);
	}
	
	public int groupInsItem(GroupManageVO groupManageVO) throws Exception {
		return itemManageCounterDAO.groupInsItem(groupManageVO);
	}
	
	public int groupDelItem(GroupManageVO groupManageVO) throws Exception {
		return itemManageCounterDAO.groupDelItem(groupManageVO);
	}
	
	public List getGroupAddListItem(GroupManageVO groupManageVO) throws Exception {
		return itemManageCounterDAO.getGroupAddListItem(groupManageVO);
	}
	
	public int itemUpdateItem(ItemManageVO itemManageVO) throws Exception {
		return itemManageCounterDAO.itemUpdateItem(itemManageVO);
	}
	public void goItemDelete(ItemVO itemVO) throws Exception {
		itemManageCounterDAO.goItemDelete(itemVO);
	}
	public ItemGroupVO groupMemo(GroupItemVO groupItemVO) throws Exception {
		return itemManageCounterDAO.groupMemo(groupItemVO);
	}
	public ItemGroupVO getItemInfo(GroupItemVO groupItemVO) throws Exception {
		return itemManageCounterDAO.getItemInfo(groupItemVO);
	}
	
	public SystemManageVO getSystemItemInfo(SystemManageVO systemManageVO) throws Exception {
		return itemManageCounterDAO.getSystemItemInfo(systemManageVO);
	}
	@Override
	public void goItemAllUpdate(ItemVO itemVO) throws Exception {
		itemManageCounterDAO.goItemAllUpdate(itemVO);
	}
	public List getItemInfoA(ItemInfoVO itemInfoVO) throws Exception {
		return itemManageCounterDAO.getItemInfoA(itemInfoVO);
	}
	public int saveItemInfoA(ItemInfoVO itemInfoVO) throws Exception {
		// TODO Auto-generated method stub
		return (int)itemManageCounterDAO.saveItemInfoA(itemInfoVO);
	}
	public int getItemInfoACnt(ItemInfoVO itemInfoVO) throws Exception{
		return itemManageCounterDAO.getItemInfoACnt(itemInfoVO);
	}
}