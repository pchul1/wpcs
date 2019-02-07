 package daewooInfo.itemmanage.service;

import java.util.List;

import daewooInfo.itemmanage.bean.GroupItemVO;
import daewooInfo.itemmanage.bean.ItemGroupVO;
import daewooInfo.itemmanage.bean.ItemInfoVO;
import daewooInfo.itemmanage.bean.ItemVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.itemmanage.bean.GroupManageVO;
import daewooInfo.itemmanage.bean.ItemManageVO;
import daewooInfo.itemmanage.bean.SystemManageVO;



/**
 * @author  hyun
 */
public interface ItemManageCounterService {
	/*항목그룹리스트*/
	List getGroupList(ItemGroupVO itemGroupVO) throws Exception;
	/*항목그룹등록*/
	void groupInsert(ItemGroupVO itemGroupVO) throws Exception;
	/*항목그룹수정*/
	void groupUpdate(ItemGroupVO itemGroupVO) throws Exception;
	/*항목그룹삭제*/
	void goGroupDel(ItemGroupVO itemGroupVO) throws Exception;
	/*항목그룹저장*/
	void setSaveGroup(ItemGroupVO itemGroupVO) throws Exception;
	/*그룹항목리스트*/
	List getGroupItemList(GroupItemVO groupItemVO) throws Exception;
	/*그룹설명*/
	ItemGroupVO groupMemo(GroupItemVO groupItemVO) throws Exception;
	
	/*그룹설명*/
	ItemGroupVO getItemInfo(GroupItemVO groupItemVO) throws Exception;
	
	/*항목리스트*/
	List getItemList(GroupItemVO groupItemVO) throws Exception;
	/*그룹항목추가*/
	void saveItem(GroupItemVO groupItemVO) throws Exception;
	/*그룹항목삭제*/
	void deleteItem(GroupItemVO groupItemVO) throws Exception;
	/*항목상세보기*/
	ItemVO goItemView(ItemVO itemVO) throws Exception;
	/* 항목등록 */
	void goItemInsert(ItemVO itemVO) throws Exception;
	/* 항목수정저장 */
	void goItemUpdate(ItemVO itemVO) throws Exception;
	/* 단위 가져오기 */
	/**
	 * @uml.property  name="unitList"
	 */
	List getUnitList() throws Exception;
	/* 시스템 리스트 가져오기 */
	List getSystemListItem(SystemManageVO systemManageVO) throws Exception;
	/* 시스템구분자 가져오기 */
	List getSystemListGubun(SystemManageVO systemManageVO) throws Exception;
	/* 그룹 리스트 가져오기 */
	List getGroupListItem(GroupManageVO groupManageVO) throws Exception;
	/* 아이템 리스트 가져오기 */
	List getItemListItem(ItemManageVO itemManageVO) throws Exception;
	/* 시스템 사요여부,구분자 저장하기  */
	int systemSaveItem(SystemManageVO systemManageVO) throws Exception;
	/* 시스템 삽입하기 */
	int systemInsItem(SystemManageVO systemManageVO) throws Exception;
	
	/* 시스템 수정하기 */
	int systemUpdateItem(SystemManageVO systemManageVO) throws Exception;
	
	/* 시스템 삭제하기 */
	int systemDelItem(SystemManageVO systemManageVO) throws Exception;
	/* 그룹 리스트에 항목을 추가 */
	int groupInsItem(GroupManageVO groupManageVO) throws Exception;
	/* 그룹 리스트의 항목을 삭제 */
	int groupDelItem(GroupManageVO groupManageVO) throws Exception;
	/* 시스템 코드로 그룹에 추가 가능한 그룹 List 호출 */
	List getGroupAddListItem(GroupManageVO groupManageVO) throws Exception;
	/* 아이템의 사용여부 저장  */
	int itemUpdateItem(ItemManageVO itemManageVO) throws Exception;
	/* 아이템삭제처리  */
	void goItemDelete(ItemVO itemVO) throws Exception;
	
	SystemManageVO getSystemItemInfo(SystemManageVO systemManageVO) throws Exception;
	
	void goItemAllUpdate(ItemVO itemVO) throws Exception;
	
	List getItemInfoA(ItemInfoVO itemInfoVO) throws Exception;
	
	int getItemInfoACnt(ItemInfoVO itemInfoVO) throws Exception;
	
	int saveItemInfoA(ItemInfoVO itemInfoVO) throws Exception;
	
	
}
