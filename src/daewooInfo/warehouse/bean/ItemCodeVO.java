package daewooInfo.warehouse.bean;

import java.io.Serializable;

public class ItemCodeVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	/**
	 * @uml.property  name="itemCodeDet"
	 */
	private String itemCodeDet;
	/**
	 * @uml.property  name="itemName"
	 */
	private String itemName;
	/**
	 * @uml.property  name="itemUnit"
	 */
	private String itemUnit;
	/**
	 * @uml.property  name="itemStan"
	 */
	private String itemStan;
	/**
	 * @uml.property  name="itemDate"
	 */
	private String itemDate;
	/**
	 * @uml.property  name="itemCost"
	 */
	private String itemCost;
	/**
	 * @uml.property  name="itemAmtCost"
	 */
	private String itemAmtCost;
	/**
	 * @uml.property  name="itemTotalCost"
	 */
	private String itemTotalCost;
	/**
	 * @uml.property  name="amt"
	 */
	private String amt;
	/**
	 * @uml.property  name="num"
	 */
	private String num;
	/**
	 * @uml.property  name="whCode"
	 */
	private String whCode;
	/**
	 * @uml.property  name="calcOption"
	 */
	private String calcOption;
	/**
	 * @uml.property  name="calcSeq"
	 */
	private String calcSeq;
	/**
	 * @uml.property  name="itemDesc"
	 */
	private String itemDesc;
	/**
	 * @uml.property  name="price"
	 */
	private String price;
	
	/**
	 * @uml.property  name="type1ApplFlag"
	 */
	private String type1ApplFlag;
	/**
	 * @uml.property  name="type2ApplFlag"
	 */
	private String type2ApplFlag;
	/**
	 * @uml.property  name="type3ApplFlag"
	 */
	private String type3ApplFlag;
	/**
	 * @uml.property  name="type4ApplFlag"
	 */
	private String type4ApplFlag;
	/**
	 * @uml.property  name="type5ApplFlag"
	 */
	private String type5ApplFlag;
	/**
	 * @uml.property  name="type6ApplFlag"
	 */
	private String type6ApplFlag;
	/**
	 * @uml.property  name="type7ApplFlag"
	 */
	private String type7ApplFlag;
	/**
	 * @uml.property  name="type8ApplFlag"
	 */
	private String type8ApplFlag;
	/**
	 * @uml.property  name="type9ApplFlag"
	 */
	private String type9ApplFlag;
	/**
	 * @uml.property  name="type10ApplFlag"
	 */
	private String type10ApplFlag;
	/**
	 * @uml.property  name="type11ApplFlag"
	 */
	private String type11ApplFlag;
	/**
	 * @uml.property  name="type12ApplFlag"
	 */
	private String type12ApplFlag;
	/**
	 * @uml.property  name="useFlag"
	 */
	private String useFlag;
	/**
	 * @uml.property  name="regId"
	 */
	private String regId;
	/**
	 * @uml.property  name="startDate"
	 */
	private String startDate;
	/**
	 * @uml.property  name="endDate"
	 */
	private String endDate;
	/**
	 * @uml.property  name="whName"
	 */
	private String whName; 
	/**
	 * @uml.property  name="ordr_date"
	 */
	private String ordr_date;
	/**
	 * @uml.property  name="status"
	 */
	private String status;
	
	/**
	 * @uml.property  name="regDt"
	 */
	private String regDt;
	/**
	 * @uml.property  name="uptDt"
	 */
	private String uptDt;
	
	/**
	 * @uml.property  name="groupCode"
	 */
	private String groupCode;
	/**
	 * @uml.property  name="groupName"
	 */
	private String groupName;

	/**
	 * @uml.property  name="upperGroupCode"
	 */
	private String upperGroupCode;
	/**
	 * @uml.property  name="upperGroupName"
	 */
	private String upperGroupName;
	
	/**
	 * @uml.property  name="deleteItemCode"
	 */
	private String deleteItemCode;
	/**
	 * @uml.property  name="storDesc"
	 */
	private String storDesc;
	/**
	 * @uml.property  name="releDesc"
	 */
	private String releDesc;
	
	/**
	 * @uml.property  name="riverDiv"
	 */
	private String riverDiv;
	/**
	 * @uml.property  name="riverDivName"
	 */
	private String riverDivName;
	
	/**
	 * @uml.property  name="amtWh"
	 */
	private String amtWh;
	/**
	 * @uml.property  name="amtItem"
	 */
	private String amtItem;
	/**
	 * @uml.property  name="amtRiver"
	 */
	private String amtRiver;
	
	/**
	 * @uml.property  name="conditionDate"
	 */
	private String conditionDate;
	/**
	 * @uml.property  name="conditionTime"
	 */
	private String conditionTime;
	/**
	 * @uml.property  name="condition"
	 */
	private String condition;
	
	//t_item_stock에서 사용
	/**
	 * @uml.property  name="uptId"
	 */
	private String uptId;
	/**
	 * @uml.property  name="itemCnt"
	 */
	private String itemCnt;
	/**
	 * @uml.property  name="inCnt"
	 */
	private String inCnt;
	/**
	 * @uml.property  name="outCnt"
	 */
	private String outCnt;
	
	
	private String itemCodeNum;
	
	private String riverName;
	
	private String deptCode;
	
	private String deptName;

	private String memberName;
	
	private String adminTelNo;
	
	private String atchFileId;
	
	private String itemDetail;
	
	private String itemPurpose;
	
    private String itemStockType;
	
    private String fileUploadChk;
    
    private String itemRetainCnt;
	/**
	 * @return
	 * @uml.property  name="inCnt"
	 */
	public String getInCnt() {
		return inCnt;
	}
	/**
	 * @param inCnt
	 * @uml.property  name="inCnt"
	 */
	public void setInCnt(String inCnt) {
		this.inCnt = inCnt;
	}
	/**
	 * @return
	 * @uml.property  name="outCnt"
	 */
	public String getOutCnt() {
		return outCnt;
	}
	/**
	 * @param outCnt
	 * @uml.property  name="outCnt"
	 */
	public void setOutCnt(String outCnt) {
		this.outCnt = outCnt;
	}

	/**
	 * @return
	 * @uml.property  name="uptId"
	 */
	public String getUptId() {
		return uptId;
	}
	/**
	 * @param uptId
	 * @uml.property  name="uptId"
	 */
	public void setUptId(String uptId) {
		this.uptId = uptId;
	}
	/**
	 * @return
	 * @uml.property  name="itemCnt"
	 */
	public String getItemCnt() {
		return itemCnt;
	}
	/**
	 * @param itemCnt
	 * @uml.property  name="itemCnt"
	 */
	public void setItemCnt(String itemCnt) {
		this.itemCnt = itemCnt;
	}
	/**
	 * @return
	 * @uml.property  name="deleteItemCode"
	 */
	public String getDeleteItemCode() {
		return deleteItemCode;
	}
	/**
	 * @param deleteItemCode
	 * @uml.property  name="deleteItemCode"
	 */
	public void setDeleteItemCode(String deleteItemCode) {
		this.deleteItemCode = deleteItemCode;
	}
	/**
	 * @return
	 * @uml.property  name="groupCode"
	 */
	public String getGroupCode() {
		return groupCode;
	}
	/**
	 * @param groupCode
	 * @uml.property  name="groupCode"
	 */
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	/**
	 * @return
	 * @uml.property  name="upperGroupCode"
	 */
	public String getUpperGroupCode() {
		return upperGroupCode;
	}
	/**
	 * @param upperGroupCode
	 * @uml.property  name="upperGroupCode"
	 */
	public void setUpperGroupCode(String upperGroupCode) {
		this.upperGroupCode = upperGroupCode;
	}
	
	/**
	 * @return
	 * @uml.property  name="regDt"
	 */
	public String getRegDt() {
		return regDt;
	}
	/**
	 * @param regDt
	 * @uml.property  name="regDt"
	 */
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	/**
	 * @return
	 * @uml.property  name="uptDt"
	 */
	public String getUptDt() {
		return uptDt;
	}
	/**
	 * @param uptDt
	 * @uml.property  name="uptDt"
	 */
	public void setUptDt(String uptDt) {
		this.uptDt = uptDt;
	}
	/**
	 * @return
	 * @uml.property  name="calcOption"
	 */
	public String getCalcOption() {
		return calcOption;
	}
	/**
	 * @param calcOption
	 * @uml.property  name="calcOption"
	 */
	public void setCalcOption(String calcOption) {
		this.calcOption = calcOption;
	}
	/**
	 * @return
	 * @uml.property  name="itemDesc"
	 */
	public String getItemDesc() {
		return itemDesc;
	}
	/**
	 * @param itemDesc
	 * @uml.property  name="itemDesc"
	 */
	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}
	
	/**
	 * @return
	 * @uml.property  name="startDate"
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate
	 * @uml.property  name="startDate"
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return
	 * @uml.property  name="endDate"
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate
	 * @uml.property  name="endDate"
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return
	 * @uml.property  name="whCode"
	 */
	public String getWhCode() {
		return whCode;
	}
	/**
	 * @param whCode
	 * @uml.property  name="whCode"
	 */
	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	/**
	 * @return
	 * @uml.property  name="regId"
	 */
	public String getRegId() {
		return regId;
	}
	/**
	 * @param regId
	 * @uml.property  name="regId"
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}
	/**
	 * @return
	 * @uml.property  name="num"
	 */
	public String getNum() {
		return num;
	}
	/**
	 * @param num
	 * @uml.property  name="num"
	 */
	public void setNum(String num) {
		this.num = num;
	}
	/**
	 * @return
	 * @uml.property  name="whName"
	 */
	public String getWhName() {
		return whName;
	}
	/**
	 * @param whName
	 * @uml.property  name="whName"
	 */
	public void setWhName(String whName) {
		this.whName = whName;
	}
	/**
	 * @return
	 * @uml.property  name="itemDate"
	 */
	public String getItemDate() {
		return itemDate;
	}
	/**
	 * @param itemDate
	 * @uml.property  name="itemDate"
	 */
	public void setItemDate(String itemDate) {
		this.itemDate = itemDate;
	}
	 
	 
	/**
	 * @return
	 * @uml.property  name="amt"
	 */
	public String getAmt() {
		return amt;
	}
	/**
	 * @param amt
	 * @uml.property  name="amt"
	 */
	public void setAmt(String amt) {
		this.amt = amt;
	}
	/**
	 * @return
	 * @uml.property  name="itemCode"
	 */
	public String getItemCode() {
		return itemCode;
	}
	/**
	 * @param itemCode
	 * @uml.property  name="itemCode"
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	/**
	 * @return
	 * @uml.property  name="itemCodeDet"
	 */
	public String getItemCodeDet() {
		return itemCodeDet;
	}
	/**
	 * @param itemCodeDet
	 * @uml.property  name="itemCodeDet"
	 */
	public void setItemCodeDet(String itemCodeDet) {
		this.itemCodeDet = itemCodeDet;
	}
	/**
	 * @return
	 * @uml.property  name="itemName"
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName
	 * @uml.property  name="itemName"
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return
	 * @uml.property  name="itemUnit"
	 */
	public String getItemUnit() {
		return itemUnit;
	}
	/**
	 * @param itemUnit
	 * @uml.property  name="itemUnit"
	 */
	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}
	/**
	 * @return
	 * @uml.property  name="itemStan"
	 */
	public String getItemStan() {
		return itemStan;
	}
	/**
	 * @param itemStan
	 * @uml.property  name="itemStan"
	 */
	public void setItemStan(String itemStan) {
		this.itemStan = itemStan;
	}
	/**
	 * @return
	 * @uml.property  name="type1ApplFlag"
	 */
	public String getType1ApplFlag() {
		return type1ApplFlag;
	}
	/**
	 * @param type1ApplFlag
	 * @uml.property  name="type1ApplFlag"
	 */
	public void setType1ApplFlag(String type1ApplFlag) {
		this.type1ApplFlag = type1ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type2ApplFlag"
	 */
	public String getType2ApplFlag() {
		return type2ApplFlag;
	}
	/**
	 * @param type2ApplFlag
	 * @uml.property  name="type2ApplFlag"
	 */
	public void setType2ApplFlag(String type2ApplFlag) {
		this.type2ApplFlag = type2ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type3ApplFlag"
	 */
	public String getType3ApplFlag() {
		return type3ApplFlag;
	}
	/**
	 * @param type3ApplFlag
	 * @uml.property  name="type3ApplFlag"
	 */
	public void setType3ApplFlag(String type3ApplFlag) {
		this.type3ApplFlag = type3ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type4ApplFlag"
	 */
	public String getType4ApplFlag() {
		return type4ApplFlag;
	}
	/**
	 * @param type4ApplFlag
	 * @uml.property  name="type4ApplFlag"
	 */
	public void setType4ApplFlag(String type4ApplFlag) {
		this.type4ApplFlag = type4ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type5ApplFlag"
	 */
	public String getType5ApplFlag() {
		return type5ApplFlag;
	}
	/**
	 * @param type5ApplFlag
	 * @uml.property  name="type5ApplFlag"
	 */
	public void setType5ApplFlag(String type5ApplFlag) {
		this.type5ApplFlag = type5ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type6ApplFlag"
	 */
	public String getType6ApplFlag() {
		return type6ApplFlag;
	}
	/**
	 * @param type6ApplFlag
	 * @uml.property  name="type6ApplFlag"
	 */
	public void setType6ApplFlag(String type6ApplFlag) {
		this.type6ApplFlag = type6ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type7ApplFlag"
	 */
	public String getType7ApplFlag() {
		return type7ApplFlag;
	}
	/**
	 * @param type7ApplFlag
	 * @uml.property  name="type7ApplFlag"
	 */
	public void setType7ApplFlag(String type7ApplFlag) {
		this.type7ApplFlag = type7ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type8ApplFlag"
	 */
	public String getType8ApplFlag() {
		return type8ApplFlag;
	}
	/**
	 * @param type8ApplFlag
	 * @uml.property  name="type8ApplFlag"
	 */
	public void setType8ApplFlag(String type8ApplFlag) {
		this.type8ApplFlag = type8ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type9ApplFlag"
	 */
	public String getType9ApplFlag() {
		return type9ApplFlag;
	}
	/**
	 * @param type9ApplFlag
	 * @uml.property  name="type9ApplFlag"
	 */
	public void setType9ApplFlag(String type9ApplFlag) {
		this.type9ApplFlag = type9ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type10ApplFlag"
	 */
	public String getType10ApplFlag() {
		return type10ApplFlag;
	}
	/**
	 * @param type10ApplFlag
	 * @uml.property  name="type10ApplFlag"
	 */
	public void setType10ApplFlag(String type10ApplFlag) {
		this.type10ApplFlag = type10ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type11ApplFlag"
	 */
	public String getType11ApplFlag() {
		return type11ApplFlag;
	}
	/**
	 * @param type11ApplFlag
	 * @uml.property  name="type11ApplFlag"
	 */
	public void setType11ApplFlag(String type11ApplFlag) {
		this.type11ApplFlag = type11ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="type12ApplFlag"
	 */
	public String getType12ApplFlag() {
		return type12ApplFlag;
	}
	/**
	 * @param type12ApplFlag
	 * @uml.property  name="type12ApplFlag"
	 */
	public void setType12ApplFlag(String type12ApplFlag) {
		this.type12ApplFlag = type12ApplFlag;
	}
	/**
	 * @return
	 * @uml.property  name="useFlag"
	 */
	public String getUseFlag() {
		return useFlag;
	}
	/**
	 * @param useFlag
	 * @uml.property  name="useFlag"
	 */
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	/**
	 * @param itemCost
	 * @uml.property  name="itemCost"
	 */
	public void setItemCost(String itemCost) {
		this.itemCost = itemCost;
	}
	/**
	 * @return
	 * @uml.property  name="itemCost"
	 */
	public String getItemCost() {
		return itemCost;
	}
	/**
	 * @param calcSeq
	 * @uml.property  name="calcSeq"
	 */
	public void setCalcSeq(String calcSeq) {
		this.calcSeq = calcSeq;
	}
	/**
	 * @return
	 * @uml.property  name="calcSeq"
	 */
	public String getCalcSeq() {
		return calcSeq;
	}
	/**
	 * @param itemAmtCost
	 * @uml.property  name="itemAmtCost"
	 */
	public void setItemAmtCost(String itemAmtCost) {
		this.itemAmtCost = itemAmtCost;
	}
	/**
	 * @return
	 * @uml.property  name="itemAmtCost"
	 */
	public String getItemAmtCost() {
		return itemAmtCost;
	}
	/**
	 * @param itemTotalCost
	 * @uml.property  name="itemTotalCost"
	 */
	public void setItemTotalCost(String itemTotalCost) {
		this.itemTotalCost = itemTotalCost;
	}
	/**
	 * @return
	 * @uml.property  name="itemTotalCost"
	 */
	public String getItemTotalCost() {
		return itemTotalCost;
	}
	/**
	 * @param price
	 * @uml.property  name="price"
	 */
	public void setPrice(String price) {
		this.price = price;
	}
	/**
	 * @return
	 * @uml.property  name="price"
	 */
	public String getPrice() {
		return price;
	}
	/**
	 * @param ordr_date
	 * @uml.property  name="ordr_date"
	 */
	public void setOrdr_date(String ordr_date) {
		this.ordr_date = ordr_date;
	}
	/**
	 * @return
	 * @uml.property  name="ordr_date"
	 */
	public String getOrdr_date() {
		return ordr_date;
	}
	/**
	 * @param status
	 * @uml.property  name="status"
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return
	 * @uml.property  name="status"
	 */
	public String getStatus() {
		return status;
	}
	
	/**
	 * @return
	 * @uml.property  name="groupName"
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName
	 * @uml.property  name="groupName"
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	/**
	 * @return
	 * @uml.property  name="upperGroupName"
	 */
	public String getUpperGroupName() {
		return upperGroupName;
	}
	/**
	 * @param upperGroupName
	 * @uml.property  name="upperGroupName"
	 */
	public void setUpperGroupName(String upperGroupName) {
		this.upperGroupName = upperGroupName;
	}
	/**
	 * @return
	 * @uml.property  name="storDesc"
	 */
	public String getStorDesc() {
		return storDesc;
	}
	/**
	 * @param storDesc
	 * @uml.property  name="storDesc"
	 */
	public void setStorDesc(String storDesc) {
		this.storDesc = storDesc;
	}
	/**
	 * @return
	 * @uml.property  name="releDesc"
	 */
	public String getReleDesc() {
		return releDesc;
	}
	/**
	 * @param releDesc
	 * @uml.property  name="releDesc"
	 */
	public void setReleDesc(String releDesc) {
		this.releDesc = releDesc;
	}
	/**
	 * @return
	 * @uml.property  name="riverDiv"
	 */
	public String getRiverDiv() {
		return riverDiv;
	}
	/**
	 * @param riverDiv
	 * @uml.property  name="riverDiv"
	 */
	public void setRiverDiv(String riverDiv) {
		this.riverDiv = riverDiv;
	}
	/**
	 * @return
	 * @uml.property  name="riverDivName"
	 */
	public String getRiverDivName() {
		return riverDivName;
	}
	/**
	 * @param riverDivName
	 * @uml.property  name="riverDivName"
	 */
	public void setRiverDivName(String riverDivName) {
		this.riverDivName = riverDivName;
	}
	/**
	 * @return
	 * @uml.property  name="amtWh"
	 */
	public String getAmtWh() {
		return amtWh;
	}
	/**
	 * @param amtWh
	 * @uml.property  name="amtWh"
	 */
	public void setAmtWh(String amtWh) {
		this.amtWh = amtWh;
	}
	/**
	 * @return
	 * @uml.property  name="amtItem"
	 */
	public String getAmtItem() {
		return amtItem;
	}
	/**
	 * @param amtItem
	 * @uml.property  name="amtItem"
	 */
	public void setAmtItem(String amtItem) {
		this.amtItem = amtItem;
	}
	/**
	 * @return
	 * @uml.property  name="amtRiver"
	 */
	public String getAmtRiver() {
		return amtRiver;
	}
	/**
	 * @param amtRiver
	 * @uml.property  name="amtRiver"
	 */
	public void setAmtRiver(String amtRiver) {
		this.amtRiver = amtRiver;
	}	
	/**
	 * @return
	 * @uml.property  name="condition"
	 */
	public String getCondition() {
		return condition;
	}
	/**
	 * @param condition
	 * @uml.property  name="condition"
	 */
	public void setCondition(String condition) {
		this.condition = condition;
	}
	/**
	 * @return
	 * @uml.property  name="conditionDate"
	 */
	public String getConditionDate() {
		return conditionDate;
	}
	/**
	 * @param conditionDate
	 * @uml.property  name="conditionDate"
	 */
	public void setConditionDate(String conditionDate) {
		this.conditionDate = conditionDate;
	}
	/**
	 * @return
	 * @uml.property  name="conditionTime"
	 */
	public String getConditionTime() {
		return conditionTime;
	}
	/**
	 * @param conditionTime
	 * @uml.property  name="conditionTime"
	 */
	public void setConditionTime(String conditionTime) {
		this.conditionTime = conditionTime;
	}
	public String getItemCodeNum() {
		return itemCodeNum;
	}
	public void setItemCodeNum(String itemCodeNum) {
		this.itemCodeNum = itemCodeNum;
	}
	public String getRiverName() {
		return riverName;
	}
	public void setRiverName(String riverName) {
		this.riverName = riverName;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getAdminTelNo() {
		return adminTelNo;
	}
	public void setAdminTelNo(String adminTelNo) {
		this.adminTelNo = adminTelNo;
	}
	public String getItemDetail() {
		return itemDetail;
	}
	public void setItemDetail(String itemDetail) {
		this.itemDetail = itemDetail;
	}
	public String getItemPurpose() {
		return itemPurpose;
	}
	public void setItemPurpose(String itemPurpose) {
		this.itemPurpose = itemPurpose;
	}
	public String getItemStockType() {
		return itemStockType;
	}
	public void setItemStockType(String itemStockType) {
		this.itemStockType = itemStockType;
	}
	public String getFileUploadChk() {
		return fileUploadChk;
	}
	public void setFileUploadChk(String fileUploadChk) {
		this.fileUploadChk = fileUploadChk;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getItemRetainCnt() {
		return itemRetainCnt;
	}
	public void setItemRetainCnt(String itemRetainCnt) {
		this.itemRetainCnt = itemRetainCnt;
	}
	
	
}