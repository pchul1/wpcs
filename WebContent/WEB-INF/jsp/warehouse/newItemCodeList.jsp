<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemCodeList.jsp
	 * Description : 방제물품코드관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2013.11.06	lkh			리뉴얼
	 * 
	 * author lkh
	 * since 2013.11.06
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />
<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1,user-scalable=no" />

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<style>
#itemDataList li {
	text-align: left;
	padding-left: 10px;
	line-height: 25px;
}
.highlight {
	font-weight: bold;
	color: red;
	background: yellow; 
}
</style>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.cycle2.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/html/util/ckeditor/ckeditor.js'/>" ></script>

<script type="text/javascript">
//<![CDATA[
	$(function() {
		//$('#addRow').click(addRow);
		//$('#save').click(save);
		
		// 물품코드를 가져온다. (공통코드)
		getItemCommonCodeList();
		
		// 등록된 물품코드
		getItemCodeList();

		//대분류 (물품코드 등록)
		//getUpperGroupCode("forward");
		
		//대분류 (물품코드 조회)
		//searchUpperGroupCode();
		
		$.datepicker.setDefaults({
			monthNames : [ '년 1월', '년 2월', '년 3월', '년 4월', '년 5월', '년 6월', '년 7월', '년 8월', '년 9월', '년 10월', '년 11월', '년 12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			dateFormat : 'yymmdd',
			showOn : 'both',
			buttonImage : "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly : true
		});
		
		dataLoad();
		
		$("#imgDelChk").click(function(){
			$("#atchImg").html("");			
			$("#imageDel").val("Y");
		});
	});
	
	
	//저장후에 값 셋팅
	function AfterSave(){
		var p_itemCode = '${itemListVal.itemCodeN}';
		var p_itemCodeNum = '${itemListVal.itemCodeNum}';
		var p_itemCodeDet = '${itemListVal.itemCodeDet}';
		var p_itemName = '${itemListVal.itemName}';
		var p_itemStan = '${itemListVal.itemStan}';
		var p_itemUnit = '${itemListVal.itemUnit}';
		var p_itemCost = '${itemListVal.itemCost}';
		var p_type1ApplFlag = '${itemListVal.type1ApplFlagYN}';
		var p_type2ApplFlag = '${itemListVal.type2ApplFlagYN}';
		var p_type3ApplFlag = '${itemListVal.type3ApplFlagYN}';
		var p_type4ApplFlag = '${itemListVal.type4ApplFlagYN}';
		var p_type5ApplFlag = '${itemListVal.type5ApplFlagYN}';
		var p_type6ApplFlag = '${itemListVal.type6ApplFlagYN}';
		var p_type7ApplFlag = '${itemListVal.type7ApplFlagYN}';
		var p_type8ApplFlag = '${itemListVal.type8ApplFlagYN}';
		var p_type9ApplFlag = '${itemListVal.type9ApplFlagYN}';
		var p_type10ApplFlag = '${itemListVal.type10ApplFlagYN}';
		var p_type11ApplFlag = '${itemListVal.type11ApplFlagYN}';
		var p_type12ApplFlag = '${itemListVal.type12ApplFlagYN}';
		var p_useFlag = '${itemListVal.useFlag}';
		var atchFileId = '${itemListVal.atchFileId}';
		var upperGroupCode = '${itemListVal.upperGroupCodeN}';

		if(p_itemCode != ""){
			clickItemList(p_itemCode, p_itemCodeNum, p_itemCodeDet, p_itemName, p_itemStan, p_itemUnit, p_itemCost ,
					p_type1ApplFlag, p_type2ApplFlag,p_type3ApplFlag,p_type4ApplFlag,p_type5ApplFlag,
					p_type6ApplFlag,p_type7ApplFlag,p_type8ApplFlag,p_type9ApplFlag,p_type10ApplFlag,
					p_type11ApplFlag,p_type12ApplFlag, p_useFlag, atchFileId, upperGroupCode);
		}
	}
	
	//물품 코드 생성 
	function getNextItemCode() {
		var upperGroupCode = $("#selectUpperGroupCode option:selected").val();
		var itemCodeDet = $('#selectGroupCode option:selected').val();
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getMaxItemCode.do'/>",
			data : {
				upperGroupCode : upperGroupCode,
				itemCodeDet : itemCodeDet
			},
			dataType : "json",
			beforeSend : function() {
			},
			success : function(result) {
				
				var code = result["codes"];
				if (code == null) {
					$('#txtGoodCode').val(itemCodeDet + "001");
				} else {
					$('#txtGoodCode').val(itemCodeDet + code);
				}
			}
		});
	}
	
	// 입력폼 초기화
	function addRow() {
		$('#txtRegType').val("신규");
		$("#selectUpperGroupCode").empty();
		$("#selectGroupCode").empty();
		
		$('#txtGoodCode').attr("disabled", false);
		$("#txtGoodCode").val('');
		$("#txtGoodCode_2").val('');
		$("#mode").val("insert");
		
		$("#itemCode2").val('');
		$("#itemCodeDet").val('');
		$("#itemName").val('');
		$("#itemStan").val('');
		$("#itemUnit").val('');
		$("#itemCost").val('');
		$("#itemPurpose").val('');
		$("#itemDetail").val('');
		$("#itemStockType").val('A');
		$("#atchFileId").val('');
		
		$("#type1ApplFlag").attr('checked', false);
		$("#type2ApplFlag").attr('checked', false);
		$("#type3ApplFlag").attr('checked', false);
		$("#type4ApplFlag").attr('checked', false);
		$("#type5ApplFlag").attr('checked', false);
		$("#type6ApplFlag").attr('checked', false);
		$("#type7ApplFlag").attr('checked', false);
		$("#type8ApplFlag").attr('checked', false);
		$("#type9ApplFlag").attr('checked', false);
		$("#type10ApplFlag").attr('checked', false);
		$("#type11ApplFlag").attr('checked', false);
		$("#type12ApplFlag").attr('checked', false);
		
		$("#useFlag").val('Y');
		$("#atchImg").html('');
		$("#itemDetailStatus").html('미등록');
		$("#regItemDetailButton").val('등록');
		
		//getUpperGroupCode("new");
	}
	
	function clickItemList(p_itemCode, p_itemCodeNum, p_itemCodeDet, p_itemName, p_itemStan, p_itemUnit, p_itemCost ,
			p_type1ApplFlag, p_type2ApplFlag,p_type3ApplFlag,p_type4ApplFlag,p_type5ApplFlag,
			p_type6ApplFlag,p_type7ApplFlag,p_type8ApplFlag,p_type9ApplFlag,p_type10ApplFlag,
			p_type11ApplFlag,p_type12ApplFlag, p_useFlag, atchFileId, upperGroupCode )
	{
		$('#selectUpperGroupCode').val(upperGroupCode);
		$('#selectUpperGroupCode').attr("disabled", true);
		$('#hideGroupCode').val(p_itemCodeDet);
		//getGroupCode();
		
		$('#txtRegType').val("수정");
		$("#txtGoodCode").val(p_itemCode);
		$("#txtGoodCode_2").val(p_itemCodeNum);
		
		$("#itemCode2").val(p_itemCode);
		$("#itemCodeDet").val(p_itemCodeDet);
		$("#itemName").val(p_itemName);
		$("#itemStan").val(p_itemStan);
		$("#itemUnit").val(p_itemUnit);
		$("#itemCost").val(p_itemCost);

		$("#type1ApplFlag").attr('checked', p_type1ApplFlag == 'Y' ? true : false );  
		$("#type2ApplFlag").attr('checked', p_type2ApplFlag == 'Y' ? true : false );
		$("#type3ApplFlag").attr('checked', p_type3ApplFlag == 'Y' ? true : false );
		$("#type4ApplFlag").attr('checked', p_type4ApplFlag == 'Y' ? true : false );
		$("#type5ApplFlag").attr('checked', p_type5ApplFlag == 'Y' ? true : false );
		$("#type6ApplFlag").attr('checked', p_type6ApplFlag == 'Y' ? true : false );
		$("#type7ApplFlag").attr('checked', p_type7ApplFlag == 'Y' ? true : false );
		$("#type8ApplFlag").attr('checked', p_type8ApplFlag == 'Y' ? true : false );
		$("#type9ApplFlag").attr('checked', p_type9ApplFlag == 'Y' ? true : false );
		$("#type10ApplFlag").attr('checked', p_type10ApplFlag == 'Y' ? true : false );
		$("#type11ApplFlag").attr('checked', p_type11ApplFlag == 'Y' ? true : false );
		$("#type12ApplFlag").attr('checked', p_type12ApplFlag == 'Y' ? true : false );

		$("#useFlag").val(p_useFlag);
		$("#mode").val("update");
		
		$("#chkFileId").val(atchFileId);
	}
	
	function fn_click_forward(p_itemCode, p_itemCodeNum, p_itemCodeDet, p_itemName, p_itemStan, p_itemUnit, p_itemCost ,
			p_type1ApplFlag, p_type2ApplFlag,p_type3ApplFlag,p_type4ApplFlag,p_type5ApplFlag,
			p_type6ApplFlag,p_type7ApplFlag,p_type8ApplFlag,p_type9ApplFlag,p_type10ApplFlag,
			p_type11ApplFlag,p_type12ApplFlag, p_useFlag, atchFileId, upperGroupCode){
		
		showLoading();
		
		$("#mode").val("update");
		//$("#chkFileId").val(atchFileId);
		$("#txtGoodCode").val(p_itemCode);
		$('#txtRegType').val("수정");
		$("#txtGoodCode_2").val(p_itemCodeNum);
		$('#txtGoodCode').attr("disabled", true);	// 아이템코드는 수정되면 재고 및 입/출고 내역에 영향을 줌
		
		$("#itemQRLayer").html("<img src=\"/cmmn/getQRCodeImage.do?itemCode="+p_itemCode+"&itemCodeNum="+p_itemCodeNum
								+"&qrUseType=warehouse\""+" style=\"padding:2px 2px;cursor:pointer;width:140px;height:140px\" "
								+" onclick=\'javascript:f_closeQRCode();\' />");
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/showItemDetailView.do'/>",
			data: {
				itemCode : p_itemCode,
				itemCodeNum : p_itemCodeNum
			},
			dataType:"json",
			success : function(result){
				
				var itemVO = result["itemVO"];
				
				if(itemVO.itemDetail == null || jQuery.trim(itemVO.itemDetail) == ''){
					$("#itemDetailStatus").html("미등록");
					$("#regItemDetailButton").val('등록');
					$("#itemDetail").val('');
				}else{
					$("#itemDetailStatus").html("등록됨");
					$("#regItemDetailButton").val('수정');	
					$("#itemDetail").val(itemVO.itemDetail);
				}
				$("#itemPurpose").val(itemVO.itemPurpose);
				$("#itemStockType").val(itemVO.itemStockType);
				
				$("#itemName").val(itemVO.itemName);
				$("#itemUnit").val(itemVO.itemUnit);
				$("#itemStan").val(itemVO.itemStan);
				$("#itemCost").val(itemVO.itemCost);
				$("#useFlag").val(itemVO.useFlag);
				$("#atchFileId").val(itemVO.atchFileId);
				
				$("#type1ApplFlag").attr('checked', itemVO.type1ApplFlag == 'Y' ? true : false );  
				$("#type2ApplFlag").attr('checked', itemVO.type2ApplFlag == 'Y' ? true : false );
				$("#type3ApplFlag").attr('checked', itemVO.type3ApplFlag == 'Y' ? true : false );
				$("#type4ApplFlag").attr('checked', itemVO.type4ApplFlag == 'Y' ? true : false );
				$("#type5ApplFlag").attr('checked', itemVO.type5ApplFlag == 'Y' ? true : false );
				$("#type6ApplFlag").attr('checked', itemVO.type6ApplFlag == 'Y' ? true : false );
				$("#type7ApplFlag").attr('checked', itemVO.type7ApplFlag == 'Y' ? true : false );
				$("#type8ApplFlag").attr('checked', itemVO.type8ApplFlag == 'Y' ? true : false );
				$("#type9ApplFlag").attr('checked', itemVO.type9ApplFlag == 'Y' ? true : false );
				$("#type10ApplFlag").attr('checked', itemVO.type10ApplFlag == 'Y' ? true : false );
				$("#type11ApplFlag").attr('checked', itemVO.type11ApplFlag == 'Y' ? true : false );
				$("#type12ApplFlag").attr('checked', itemVO.type12ApplFlag == 'Y' ? true : false );
				
				$.ajax({
					type : "POST",
					url : "<c:url value='/cmmn/getImageFileInfs.do'/>",
					data : {
						atchFileId : itemVO.atchFileId
					},
					dataType : "json",
					beforeSend : function() {},
					success : function(result) {
						$("#atchImg").html("");
						$("#itemImageLayer").html("");
						var count = result['fileList'].length;
						if( count <= 0 ) {
							// 첨부파일 없음
							$("#itemImageLayer").html("<img src=\"\" alt=\"등록된 이미지가 없습니다.\" style=\"background-color:#E0E0F8;width:200px;height:200px;padding:5px 5px;\" />");
						}else{
							for(var i=0; i<count; i++){
								var obj = result['fileList'][i];
								$("#atchImg").append("<a style=\'cursor:pointer;color:blue;\' onclick=\"javascript:f_itemImagePopup(\'/cmmn/getImage.do?atchFileId="
												+obj.atchFileId+"&fileSn="+obj.fileSn+"\');\">"+obj.orignlFileNm+"</a>"+"<img src=/images/util/bu5_close.gif " 
												+ "style=\"cursor: pointer; padding-top: 0px; padding-left: 10px;\" id=\"delAttachFile\""
												+ "onclick=\"fn_delAttachFile('"+obj.atchFileId+"','"+obj.fileSn+"')\"/><br>");
								$("#itemImageLayer").append("<img src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn
										+"\""+" id=\"smallItemImage\" style=\"padding:5px 5px;\" width=\"200\" height=\"200\""
										+" onclick=\"f_itemImagePopup(\'/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn+"\');\" />");
								//$("#cycleImage3").attr("src", "/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn);
							}
						}
					}
				});
				
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
		
		closeLoading();
	}
	
	function fn_afterSaveReload(p_itemCode, p_itemCodeNum){
		
		showLoading();
		
		$("#mode").val("update");
		//$("#chkFileId").val(atchFileId);
		$("#txtGoodCode").val(p_itemCode);
		$('#txtRegType').val("수정");
		$("#txtGoodCode_2").val(p_itemCodeNum);
		$('#txtGoodCode').attr("disabled", true);	// 아이템코드는 수정되면 재고 및 입/출고 내역에 영향을 줌
		
		$("#itemQRLayer").html("<img src=\"/cmmn/getQRCodeImage.do?itemCode="+p_itemCode+"&itemCodeNum="+p_itemCodeNum
								+"&qrUseType=warehouse\""+" style=\"padding:2px 2px;cursor:pointer;width:140px;height:140px\" "
								+" onclick=\'javascript:f_closeQRCode();\' />");
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/showItemDetailView.do'/>",
			data: {
				itemCode : p_itemCode,
				itemCodeNum : p_itemCodeNum
			},
			dataType:"json",
			success : function(result){
				
				var itemVO = result["itemVO"];
				
				if(itemVO.itemDetail == null || jQuery.trim(itemVO.itemDetail) == ''){
					$("#itemDetailStatus").html("미등록");
					$("#regItemDetailButton").val('등록');
					$("#itemDetail").val('');
				}else{
					$("#itemDetailStatus").html("등록됨");
					$("#regItemDetailButton").val('수정');	
					$("#itemDetail").val(itemVO.itemDetail);
				}
				$("#itemPurpose").val(itemVO.itemPurpose);
				$("#itemStockType").val(itemVO.itemStockType);
				
				$("#itemName").val(itemVO.itemName);
				$("#itemUnit").val(itemVO.itemUnit);
				$("#itemStan").val(itemVO.itemStan);
				$("#itemCost").val(itemVO.itemCost);
				$("#useFlag").val(itemVO.useFlag);
				$("#atchFileId").val(itemVO.atchFileId);
				
				$("#type1ApplFlag").attr('checked', itemVO.type1ApplFlag == 'Y' ? true : false );  
				$("#type2ApplFlag").attr('checked', itemVO.type2ApplFlag == 'Y' ? true : false );
				$("#type3ApplFlag").attr('checked', itemVO.type3ApplFlag == 'Y' ? true : false );
				$("#type4ApplFlag").attr('checked', itemVO.type4ApplFlag == 'Y' ? true : false );
				$("#type5ApplFlag").attr('checked', itemVO.type5ApplFlag == 'Y' ? true : false );
				$("#type6ApplFlag").attr('checked', itemVO.type6ApplFlag == 'Y' ? true : false );
				$("#type7ApplFlag").attr('checked', itemVO.type7ApplFlag == 'Y' ? true : false );
				$("#type8ApplFlag").attr('checked', itemVO.type8ApplFlag == 'Y' ? true : false );
				$("#type9ApplFlag").attr('checked', itemVO.type9ApplFlag == 'Y' ? true : false );
				$("#type10ApplFlag").attr('checked', itemVO.type10ApplFlag == 'Y' ? true : false );
				$("#type11ApplFlag").attr('checked', itemVO.type11ApplFlag == 'Y' ? true : false );
				$("#type12ApplFlag").attr('checked', itemVO.type12ApplFlag == 'Y' ? true : false );
				
				$.ajax({
					type : "POST",
					url : "<c:url value='/cmmn/getImageFileInfs.do'/>",
					data : {
						atchFileId : itemVO.atchFileId
					},
					dataType : "json",
					beforeSend : function() {},
					success : function(result) {
						$("#atchImg").html("");
						$("#itemImageLayer").html("");
						var count = result['fileList'].length;
						if( count <= 0 ) {
							// 첨부파일 없음
							$("#itemImageLayer").html("<img src=\"\" alt=\"등록된 이미지가 없습니다.\" style=\"background-color:#E0E0F8;width:200px;height:200px;padding:5px 5px;\" />");
						}else{
							for(var i=0; i<count; i++){
								var obj = result['fileList'][i];
								$("#atchImg").append("<a style=\'cursor:pointer;color:blue;\' onclick=\"javascript:f_itemImagePopup(\'/cmmn/getImage.do?atchFileId="
												+obj.atchFileId+"&fileSn="+obj.fileSn+"\');\">"+obj.orignlFileNm+"</a>"+"<img src=/images/util/bu5_close.gif " 
												+ "style=\"cursor: pointer; padding-top: 0px; padding-left: 10px;\" id=\"delAttachFile\""
												+ "onclick=\"fn_delAttachFile('"+obj.atchFileId+"','"+obj.fileSn+"')\"/><br>");
								$("#itemImageLayer").append("<img src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn
										+"\""+" id=\"smallItemImage\" style=\"padding:5px 5px;\" width=\"200\" height=\"200\""
										+" onclick=\"f_itemImagePopup(\'/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn+"\');\" />");
								//$("#cycleImage3").attr("src", "/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn);
							}
						}
					}
				});
				
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
		
		closeLoading();
	}
	
	function f_itemImagePopup(src){
		$("#itemImagePopFullscreen").attr("src", src);
		$("#itemImagePopLayer").fadeIn();
		$("#itemImagePopLayer").centerPop();
	}
	
	function f_itemImagePopClose(){
		$("#itemImagePopLayer").fadeOut();
	}
	
	function fn_delAttachFile(atchFileId,fileSn){		
			
		var itemCode = $("#txtGoodCode").val();
		var itemCodeNum = $("#txtGoodCode_2").val();
		
		if (confirm('<spring:message code="common.delete.msg" />')) {
		
			showLoading();
			
			$.ajax({
				type : "POST",
				url : "<c:url value='/cmmn/delImageFileInfs.do'/>",
				data : {
					itemCode : itemCode,
					itemCodeNum : itemCodeNum,
					atchFileId : atchFileId,
					fileSn : fileSn
				},
				dataType : "json",
				beforeSend : function() {},
				success : function(result) {
					if(result.delFileResult == "SUCCESS"){
						alert('<spring:message code="success.common.delete" />');
					}else{
						alert('<spring:message code="fail.common.delete" />');
					}
					
					$.ajax({
						type : "POST",
						url : "<c:url value='/cmmn/getImageFileInfs.do'/>",
						data : {
							atchFileId : atchFileId
						},
						dataType : "json",
						beforeSend : function() {},
						success : function(result) {
							$("#atchImg").html("");
							$("#itemImageLayer").html("");
							var count = result['fileList'].length;
							if( count <= 0 ) {
								// 첨부파일 없음
								$("#itemImageLayer").html("<img src=\"\" alt=\"등록된 이미지가 없습니다.\" style=\"background-color:#E0E0F8;width:200px;height:200px;padding:5px 5px;\" />");
							}else{
								for(var i=0; i<count; i++){
									var obj = result['fileList'][i];
									$("#atchImg").append("<a style=\'cursor:pointer;color:blue;\' onclick=\"javascript:f_itemImagePopup(\'/cmmn/getImage.do?atchFileId="
											+obj.atchFileId+"&fileSn="+obj.fileSn+"\');\">"+obj.orignlFileNm+"</a>"+"<img src=/images/util/bu5_close.gif " 
											+ "style=\"cursor: pointer; padding-top: 0px; padding-left: 10px;\" id=\"delAttachFile\""
											+ "onclick=\"fn_delAttachFile('"+obj.atchFileId+"','"+obj.fileSn+"')\"/><br>");
									$("#itemImageLayer").append("<img src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn
											+"\""+" id=\"smallItemImage\" style=\"padding:5px 5px;\" width=\"200\" height=\"200\""
											+" onclick=\"f_itemImagePopup(\'/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn+"\');\" />");
								}
							}
						}
					});
				}
			});

			closeLoading();
		}
		
	}
	
	function fn_egov_regist_save() {
		var mode = $("#mode").val();
		var itemCode = $('#txtGoodCode').val();
		var itemCodeNum = $('#txtGoodCode_2').val();
		var itemCodeDet = $('#selectGroupCode option:selected').val();
		var itemName = $("#itemName").val();
		var itemUnit = $("#itemUnit").val();
		var itemStan = $("#itemStan").val();
		var itemCost = $("#itemCost").val();
		var upperGroupCode = $("#selectUpperGroupCode option:selected").val();
		
		var type1ApplFlag = changeBoolean($("#type1ApplFlag").attr('checked'));
		var type2ApplFlag = changeBoolean($("#type2ApplFlag").attr('checked'));
		var type3ApplFlag = changeBoolean($("#type3ApplFlag").attr('checked'));
		var type4ApplFlag = changeBoolean($("#type4ApplFlag").attr('checked'));
		var type5ApplFlag = changeBoolean($("#type5ApplFlag").attr('checked'));
		var type6ApplFlag = changeBoolean($("#type6ApplFlag").attr('checked'));
		var type7ApplFlag = changeBoolean($("#type7ApplFlag").attr('checked'));
		var type8ApplFlag = changeBoolean($("#type8ApplFlag").attr('checked'));
		var type9ApplFlag = changeBoolean($("#type9ApplFlag").attr('checked'));
		var type10ApplFlag = changeBoolean($("#type10ApplFlag").attr('checked'));
		var type11ApplFlag = changeBoolean($("#type11ApplFlag").attr('checked'));
		var type12ApplFlag = changeBoolean($("#type12ApplFlag").attr('checked'));
		
		var useFlag = $("#useFlag").val();
		var pageNo = $("#pageNo").val();
		
		var itemPurpose = $("#itemPurpose").val();
		var itemDetail = $("#itemDetail").val();
		var itemStockType = $("#itemStockType").val();
		
		if (itemCode == '' || itemCodeDet == '' || itemName == '') {
			closeLoading();
			alert('수정 및 입력하려는 데이터가 정확하지 않습니다.');
			return;
		}
		
		if (pageNo == null){
			pageNo = 1;
		}
		
		$("#mode").val(mode);
		$("#itemCodeDet").val(itemCodeDet);
		$("#itemName").val(itemName);
		$("#itemUnit").val(itemUnit);
		$("#itemStan").val(itemStan);
		$("#itemCost").val(itemCost);
		$("#useFlag").val(useFlag);
		$("#itemCodeN").val(itemCode);
		$("#groupCodeN").val(itemCodeDet);
		$("#upperGroupCodeN").val(upperGroupCode);
		$("#itemCodeNum").val(itemCodeNum);
		$("#type1ApplFlagYN").val(type1ApplFlag);
		$("#type2ApplFlagYN").val(type2ApplFlag);
		$("#type3ApplFlagYN").val(type3ApplFlag);
		$("#type4ApplFlagYN").val(type4ApplFlag);
		$("#type5ApplFlagYN").val(type5ApplFlag);
		$("#type6ApplFlagYN").val(type6ApplFlag);
		$("#type7ApplFlagYN").val(type7ApplFlag);
		$("#type8ApplFlagYN").val(type8ApplFlag);
		$("#type9ApplFlagYN").val(type9ApplFlag);
		$("#type10ApplFlagYN").val(type10ApplFlag);
		$("#type11ApplFlagYN").val(type11ApplFlag);
		$("#type12ApplFlagYN").val(type12ApplFlag);
		$("#itemPurpose").val(itemPurpose);
		$("#itemDetail").val(HtmlDecode(itemDetail));
		$("#itemStockType").val(itemStockType);
		if($("#egovComFileUploader").val() != ""){
			$("#fileUploadChk").val("Y");
		}
		
		document.insertForm.action = "<c:url value='/warehouse/mergeWareHouseItemCodeN.do'/>";
		document.insertForm.submit();			
	}
	
	function fn_saveRegistItem() {
		
		showLoading();
		
		var itemCodeN = $('#txtGoodCode').val();
		var itemName = $('#itemName').val();
		var itemCodeNum = $('#txtGoodCode_2').val();
		
		var type1ApplFlagYN = changeBoolean($("#type1ApplFlag").attr('checked'));
		var type2ApplFlagYN = changeBoolean($("#type2ApplFlag").attr('checked'));
		var type3ApplFlagYN = changeBoolean($("#type3ApplFlag").attr('checked'));
		var type4ApplFlagYN = changeBoolean($("#type4ApplFlag").attr('checked'));
		var type5ApplFlagYN = changeBoolean($("#type5ApplFlag").attr('checked'));
		var type6ApplFlagYN = changeBoolean($("#type6ApplFlag").attr('checked'));
		var type7ApplFlagYN = changeBoolean($("#type7ApplFlag").attr('checked'));
		var type8ApplFlagYN = changeBoolean($("#type8ApplFlag").attr('checked'));
		var type9ApplFlagYN = changeBoolean($("#type9ApplFlag").attr('checked'));
		var type10ApplFlagYN = changeBoolean($("#type10ApplFlag").attr('checked'));
		var type11ApplFlagYN = changeBoolean($("#type11ApplFlag").attr('checked'));
		var type12ApplFlagYN = changeBoolean($("#type12ApplFlag").attr('checked'));
		
		if (itemCodeN == '' || itemName == '') {
			alert('수정 및 입력하려는 데이터가 정확하지 않습니다.');
			return;
		}
		
		$("#itemCodeN").val(itemCodeN);
		$("#itemCodeNum").val(itemCodeNum);
		
		$("#type1ApplFlagYN").val(type1ApplFlagYN);
		$("#type2ApplFlagYN").val(type2ApplFlagYN);
		$("#type3ApplFlagYN").val(type3ApplFlagYN);
		$("#type4ApplFlagYN").val(type4ApplFlagYN);
		$("#type5ApplFlagYN").val(type5ApplFlagYN);
		$("#type6ApplFlagYN").val(type6ApplFlagYN);
		$("#type7ApplFlagYN").val(type7ApplFlagYN);
		$("#type8ApplFlagYN").val(type8ApplFlagYN);
		$("#type9ApplFlagYN").val(type9ApplFlagYN);
		$("#type10ApplFlagYN").val(type10ApplFlagYN);
		$("#type11ApplFlagYN").val(type11ApplFlagYN);
		$("#type12ApplFlagYN").val(type12ApplFlagYN);
		
		if($("#egovComFileUploader").val() != ""){
			$("#fileUploadChk").val("Y");
		}
		
		//var formData = new FormData($("#insertForm"));
		var insertForm = $('#insertForm');
		var stringData = insertForm.serialize();
		
		insertForm.ajaxSubmit({
			type : "POST",
			url : "<c:url value='/warehouse/saveWareHouseItemCodeDetail.do'/>",
			data : stringData,
			dataType : "json",
			beforeSend : function(){},
			success : function(result) {
				
				if (result.updateCnt == 1) {
					alert('<spring:message code="success.common.save" />');
					fn_afterSaveReload(itemCodeN, itemCodeNum);
				} else {
					alert('<spring:message code="fail.common.save" />');
					var errMsg = result.errorMsg;
					if(errMsg != null && jQuery.trim(errMsg) != ''){
						// 서버파트 오류를 화면에 띄워준다.
						alert(result.errorMsg);
					}
				}
			},
			error : function(result) {
				closeLoading();
			}
		});
		
		closeLoading();
		
	}
	
	// 입력폼에 있는 데이터 저장 / 수정
	function save() {
		var mode = $("#mode").val();
		/* var itemCode = $("#itemCode2").val();
		var itemCodeDet = $("#itemCodeDet").val(); */
		var itemCode = $('#txtGoodCode').val();
		var itemCodeNum = $('#txtGoodCode_2').val();
		var itemCodeDet = $('#selectGroupCode option:selected').val();
		var itemName = $("#itemName").val();
		var itemUnit = $("#itemUnit").val();
		var itemStan = $("#itemStan").val();
		var itemCost = $("#itemCost").val();
		var upperGroupCode = $("#selectUpperGroupCode option:selected").val();
		
		var type1ApplFlag = changeBoolean($("#type1ApplFlag").attr('checked'));
		var type2ApplFlag = changeBoolean($("#type2ApplFlag").attr('checked'));
		var type3ApplFlag = changeBoolean($("#type3ApplFlag").attr('checked'));
		var type4ApplFlag = changeBoolean($("#type4ApplFlag").attr('checked'));
		var type5ApplFlag = changeBoolean($("#type5ApplFlag").attr('checked'));
		var type6ApplFlag = changeBoolean($("#type6ApplFlag").attr('checked'));
		var type7ApplFlag = changeBoolean($("#type7ApplFlag").attr('checked'));
		var type8ApplFlag = changeBoolean($("#type8ApplFlag").attr('checked'));
		var type9ApplFlag = changeBoolean($("#type9ApplFlag").attr('checked'));
		var type10ApplFlag = changeBoolean($("#type10ApplFlag").attr('checked'));
		var type11ApplFlag = changeBoolean($("#type11ApplFlag").attr('checked'));
		var type12ApplFlag = changeBoolean($("#type12ApplFlag").attr('checked'));
		
		var useFlag = $("#useFlag").val();
		
		if (itemCode == '' || itemCodeDet == '' || itemName == '') {
			alert('수정 및 입력하려는 데이터가 정확하지 않습니다.');
			return;
		}
		
		var pageNo = $("#pageNo").val();
		
		if (pageNo == null)
			pageNo = 1;
			
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/mergeWareHouseItemCode.do'/>",
			data : {
				mode : mode,
				itemCode : itemCode,
				itemCodeDet : itemCodeDet,
				itemName : itemName,
				itemUnit : itemUnit,
				itemStan : itemStan,
				itemCost : itemCost,
				type1ApplFlag : type1ApplFlag,
				type2ApplFlag : type2ApplFlag,
				type3ApplFlag : type3ApplFlag,
				type4ApplFlag : type4ApplFlag,
				type5ApplFlag : type5ApplFlag,
				type6ApplFlag : type6ApplFlag,
				type7ApplFlag : type7ApplFlag,
				type8ApplFlag : type8ApplFlag,
				type9ApplFlag : type9ApplFlag,
				type10ApplFlag : type10ApplFlag,
				type11ApplFlag : type11ApplFlag,
				type12ApplFlag : type12ApplFlag,
				useFlag		: useFlag,
				groupCode		: itemCodeDet,
				upperGroupCode   : upperGroupCode,
				itemCodeNum : itemCodeNum
			},
			dataType : "json",
			beforeSend : function() {
			
			},
			success : function(result) {
				
				if (result.duplicateCnt == '1') {
					alert('이미 등록된 물품 코드 입니다.');
				} else {
					if (result.updateCnt == '1') {
						alert('반영되었습니다.');
						addRow();
						dataLoad(pageNo);
						getItemCodeList();
						
					} else {
						alert('반영되지 않았습니다.\n잠시후 다시 시도 해 보시기 바랍니다.');
					}
				}
			}
		});
	}
	
	// 물품코드를 가져온다. (공통코드)
	function getItemCommonCodeList() {
		$.ajax({
			type : "POST",
			url : "<c:url value='/cmmn/getCode.do'/>",
			data : {
				code_id : '36'
			},
			dataType : "json",
			beforeSend : function() {
				$('#itemCode2').attr("disabled", true);
			},
			success : function(result) {
				var dropDownSet = $('#itemCode2');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#itemCode2').attr("disabled", false);
			}
		});
	}
	
	// 물품코드를 가져온다. 
	function getItemCodeList() {
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/selectWareHouseItemCodeList.do'/>",
			data : "",
			dataType : "json",
			beforeSend : function() {
				$('#itemCode').attr("disabled", true);
			},
			success : function(result) {
				var dropDownSet = $('#itemCode');
				dropDownSet.loadSelectWareHouse(result.list, '전체', 'itemCode',	'itemName');
				$('#itemCode').attr("disabled", false);
			}
		});
	}
	
	// 공통 함수
	function changeBoolean(bool) {
		var rtnVal = "N";
		if (bool == true || bool == "checked") {
			rtnVal = "Y";
		}
		return rtnVal;
	}
	
	// 데이터 목록 불러오기
	function dataLoad(pageNo){
		showLoading();
		addRow();
		if (pageNo == null) pageNo = 1;
		
		var itemCode = "";
		var itemCodeNum = "";
		
		$("#itemQRLayer").fadeOut();
		
		if($('#itemCode').val() != null && $('#itemCode').val() != ""){
			itemCodeNum = $('#itemCode').val().split('-')[1];
			itemCode = $('#itemCode').val().split('-')[0];
		}
				
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemCodeDataList.do'/>",
			data: {
					itemName:$('#itemCode option:selected"').text(),
					upperGroupCode:$('#upperGroupCode option:selected"').val(),
					groupCode:$('#groupCode option:selected"').val(),
					itemCode:itemCode,
					itemCodeNum:itemCodeNum,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				var item = "";
				if( tot <= 0 ) {
					$('#dataList').html("<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>");
				} else {
					var item = "";
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						
						
						var useFlag = (obj.useFlag =="Y")?"사용":"미사용";
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						obj.useFlagView = useFlag;
						
						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";
						var trNo = i+1;
						
						item += "<tr "+trclass+" id='wtr"+trNo+"' class='tr"+i+"' style='cursor:pointer;' onclick=\"clickTrEvent(this);fn_click_forward('"+obj.itemCode+"','"+obj.itemCodeNum+"','"+obj.itemCodeDet+"','"+obj.itemName+"','"+obj.itemStan+"','"+obj.itemUnit+"','"+obj.itemCost+"','"+
               			obj.type1ApplFlag+"','"+
               			obj.type2ApplFlag+"','"+
               			obj.type3ApplFlag+"','"+
               			obj.type4ApplFlag+"','"+
               			obj.type5ApplFlag+"','"+
               			obj.type6ApplFlag+"','"+
               			obj.type7ApplFlag+"','"+
               			obj.type8ApplFlag+"','"+
               			obj.type9ApplFlag+"','"+
               			obj.type10ApplFlag+"','"+
               			obj.type11ApplFlag+"','"+
               			obj.type12ApplFlag+"','"+
               			obj.useFlag+"','"+
               			obj.atchFileId+"','"+
               			obj.upperGroupCode+"'"+
               			")\">"			                   	 
						+"<td><span>"+obj.num+"</span></td>"
                 		//+"<td>"+obj.upperGroupName+"</td>"
                 		//+"<td>"+obj.groupName+"</td>"
                 		+"<td>"+obj.itemName+"</td>"
                 		+"<td>"+obj.itemUnit+"</td>"
                 		+"<td>"+obj.itemStan+"</td>"
                 		+"<td>"+obj.price+"</td>"
                 		+"<td>"+getTypeIcon(obj)+"</td>"
                 		+"<td>"+obj.useFlag+"</td>"
             		 	+"</tr>";

		          		$("#dataList").html(item);
		          		$("#dataList tr:odd").attr("class","even");
					}
				}
				// 총건수 표시
				$("#totcnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$('#dataList').html("<tr><td colspan='7'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	// 사고유형 아이콘 
	function getTypeIcon(obj) {
		var rtnStr = "";

		if (obj.type1ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type1.png'/>\" alt=\"오탁수 발생\">&nbsp;&nbsp;";
		}

		if (obj.type2ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type2.png'/>\" alt=\"준설저니용출\">&nbsp;&nbsp;";
		}

		if (obj.type3ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type3.png'/>\" alt=\"준설장비전복\">&nbsp;&nbsp;";
		}

		if (obj.type4ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type4.png'/>\" alt=\"선박사고\">&nbsp;&nbsp;";
		}

		if (obj.type5ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type5.png'/>\" alt=\"선박페인트\">&nbsp;&nbsp;";
		}

		if (obj.type6ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type6.png'/>\" alt=\"탱크로리\">&nbsp;&nbsp;";
		}

		if (obj.type7ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type7.png'/>\" alt=\"홍수기\">&nbsp;&nbsp;";
		}

		if (obj.type8ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type8.png'/>\" alt=\"취정수장\">&nbsp;&nbsp;";
		}

		if (obj.type9ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type9.png'/>\" alt=\"유류유출\">&nbsp;&nbsp;";
		}

		if (obj.type10ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type10.png'/>\" alt=\"페놀\">&nbsp;&nbsp;";
		}

		if (obj.type11ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type11.png'/>\" alt=\"유해물질\">&nbsp;&nbsp;";
		}

		if (obj.type12ApplFlag == "Y") {
			rtnStr += "<img src=\"<c:url value='/images/warehouse/type12.png'/>\" alt=\"물고기 폐사\">&nbsp;&nbsp;";
		}
		
		return rtnStr;
	}	

	
	// 페이지 번호 클릭
	function linkPage(pageNo) {
		dataLoad(pageNo);
	}
	
	function f_showItemDetail(){

		// 입력 파라미터 검사
		if ($("#txtGoodCode").val() == null || jQuery.trim($("#txtGoodCode").val()) == ''
			|| $("#txtGoodCode_2").val() == null || jQuery.trim($("#txtGoodCode_2").val()) == '') {
			alert('물품을 선택하지 않습니다.');
			return;
		}
		
		showLoading();
		
		$("#itemDetailViewLayer").fadeIn();
		$("#itemDetailViewLayer").center();
		$("#itemDetailTopLayer").fadeIn();
		$("#htmlDataSetLayer").fadeIn();
		$("#itemStockLayer").fadeIn();
		$("#saveItemButton").fadeIn();
		$("#itemImageLayer").fadeIn();
		$("#itemStockLayer").fadeIn();
		//$("#itemQRLayer").fadeIn();
		
		$("#itemDetailEditLayer").fadeOut();
		$("#itemDetailEditTopLayer").fadeOut();
		$("#saveItemDetail").fadeOut();
		$("#cancelModItemButton").fadeOut();
		$("#htmlEditor").fadeOut();
		$("#itemQRLayer").fadeOut();
		
		$("#modifyItemButton").fadeIn();
		
		//var txtGoodCode = $("#txtGoodCode").val();
		//var txtGoodCode_2 = $("#txtGoodCode_2").val();
		
		var itemCode = $("#txtGoodCode").val();
		var itemCodeNum = $("#txtGoodCode_2").val();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/showItemDetailView.do'/>",
			data: {
				itemCode : itemCode,
				itemCodeNum : itemCodeNum
			},
			dataType:"json",
			success : function(result){
				
				if (result.reqRst == 'SUCCESS') {
					var itemVO = result["itemVO"];
					
					if(itemVO.itemPurpose == null || jQuery.trim(itemVO.itemPurpose) == ''){
						$("#itemPurposeDesc").html("<table width=\"620px\"height=\"30px\"><tr><td>물품(장비) 용도 정보가 등록되지 않았습니다.</td></tr></table>");
						// $("#itemPurposeDesc").html("<font color=gray> - 미등록</font>");
					}else{
						$("#itemPurposeDesc").html("<table width=\"620px\"height=\"30px\"><tr><td>"+ itemVO.itemPurpose +"</td></tr></table>");
						// $("#itemPurposeDesc").html("<font color=gray> - "+itemVO.itemPurpose+"</font>");
					}
					
					if(itemVO.itemDetail == null || jQuery.trim(itemVO.itemDetail) == ''){
						$("#itemDataList").html("<table width=\"620px\"height=\"450px\"><tr><td>물품(장비) 제원 정보가 등록되지 않았습니다.</td></tr></table>");
					}else{
						$("#itemDataList").html(decodeHTMLEntities(HtmlDecode(itemVO.itemDetail)));
					}
					
					// 배치현황
					var tot = result['itemLocationStockList'].length;
					var item = "";
					if( tot <= 0 ) {
						$("#itemLocationStock").html("<table width=\"620px\"height=\"50px\"><tr><td>해당 물품(장비)은 배치되지 않았습니다.</td></tr></table>");
					}else{
						item += "<table><tr>";
						for(var i=0; i < tot; i++){
							var obj = result['itemLocationStockList'][i];
							item += "<th width=\"100px\">"+obj.deptName+"</th>";
						}
						item += "</tr>";
						item += "<tr>";
						for(var i=0; i < tot; i++){
							var obj = result['itemLocationStockList'][i];
							
							item += "<td id=\'wtd"+i+"\' class=\'td"+i+"\' style=\'cursor:pointer;\' onclick=\'clickTdEvent(this);f_itemLocationStock(\""
									+itemCode+"\",\""+itemCodeNum+"\",\""+obj.deptCode+"\");\'>"+obj.itemCnt+"</td>";
						}
						item += "</tr>";
						item += "</table>";
						$("#itemLocationStock").html(item);
					}
					$("#itemLocationStockDept").html("");
				}else{
					alert('<spring:message code="fail.common.select" />');
					var reqErr = result.reqErr;
					if(reqErr != null && jQuery.trim(reqErr) != ''){
						// 서버파트 오류를 화면에 띄워준다.
						alert(reqErr);
					}
				}
				
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
		
		closeLoading();
	}
	
	function f_itemLocationStock(itemCode, itemCodeNum, deptCode){
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/showItemLocationStock.do'/>",
			data: {
				itemCode : itemCode,
				itemCodeNum : itemCodeNum,
				deptCode : deptCode
			},
			dataType:"json",
			success : function(result){
				
				if (result.reqRst == 'SUCCESS') {
					// 배치현황
					var tot = result['itemLocationStockList'].length;
					var item = "";
					if( tot <= 0 ) {
						// 결과 없음 
					}else{
						item += "<table><tr>";
						for(var i=0; i < tot; i++){
							var obj = result['itemLocationStockList'][i];
							item += "<th width=\"50px\">"+obj.whName+"</th>";
						}
						item += "</tr>";
						item += "<tr>";
						for(var i=0; i < tot; i++){
							var obj = result['itemLocationStockList'][i];
							item += "<td>"+obj.itemCnt+"</td>";
						}
						item += "</tr>";
						item += "</table>";
						$("#itemLocationStockDept").html(item);
					}
					
				}else{
					alert('<spring:message code="fail.common.select" />');
					var reqErr = result.reqErr;
					if(reqErr != null && jQuery.trim(reqErr) != ''){
						// 서버파트 오류를 화면에 띄워준다.
						alert(reqErr);
					}
				}
				
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
		
		closeLoading();
	}
	
	function f_colCal(itemArray,itemCol,i,j){
		if(jQuery.trim(itemArray[i][j-1]) == 'x'){
			f_colCal(itemArray,itemCol,i,j-1);
		}else{
			itemCol[i][j-1] += 1;
		}
	}
	
	function f_rowCal(itemArray,itemRow,i,j){
		if(jQuery.trim(itemArray[i-1][j]) == 'y'){
			f_rowCal(itemArray,itemRow,i-1,j);
		}else{
			itemRow[i-1][j] += 1;
		}
	}
	
	function f_regItemDetail(){
				
		showLoading();
		
		$("#itemDetailEditLayer").fadeIn();;
		$("#itemDetailEditLayer").center();
		$("#itemDetailEditTopLayer").fadeIn();
		//$("#htmlDataSetLayer").fadeIn();
		//$("#itemStockLayer").fadeIn();
		$("#saveItemButton").fadeIn();
		//$("#itemImageLayer").fadeIn();
		//$("#itemStockLayer").fadeIn();
		
		//$("#cancelModItemButton").fadeIn();
		$("#saveItemDetail").fadeIn();
		$("#htmlEditor").fadeIn();
		$("#modifyItemButton").fadeOut();
		$("#itemQRLayer").fadeOut();
		
		$("#itemDataList").html("");
		
		var itemCode = $("#txtGoodCode").val();
		var itemCodeNum = $("#txtGoodCode_2").val();
		var itemDetail = $("#itemDetail").val();
		
		if(itemDetail == null || jQuery.trim(itemDetail) == ''){
			editor.setData("");
		}else{
			editor.editable().setHtml(decodeHTMLEntities(HtmlDecode(itemDetail)));
		}
		
		
		closeLoading();
	}
	
	function f_modifyItemDetail(){
		
		// 입력 파라미터 검사
		if ($("#txtGoodCode").val() == null || jQuery.trim($("#txtGoodCode").val()) == ''
			|| $("#txtGoodCode_2").val() == null || jQuery.trim($("#txtGoodCode_2").val()) == '') {
			alert('물품코드가 정의되지 않습니다.');
			return;
		}
		
		showLoading();
		
		$("#itemDetailEditLayer").fadeIn();;
		$("#itemDetailEditLayer").center();
		$("#itemDetailEditTopLayer").fadeIn();
		//$("#htmlDataSetLayer").fadeIn();
		//$("#itemStockLayer").fadeIn();
		$("#saveItemButton").fadeIn();
		//$("#itemImageLayer").fadeIn();
		//$("#itemStockLayer").fadeIn();
		
		//$("#cancelModItemButton").fadeIn();
		$("#saveItemDetail").fadeIn();
		$("#htmlEditor").fadeIn();
		
		$("#modifyItemButton").fadeOut();
		
		$("#itemDataList").html("");
		
		//var txtGoodCode = $("#txtGoodCode").val();
		//var txtGoodCode_2 = $("#txtGoodCode_2").val();
		
		var itemCode = $("#txtGoodCode").val();
		var itemCodeNum = $("#txtGoodCode_2").val();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/showItemDetailView.do'/>",
			data: {
				itemCode : itemCode,
				itemCodeNum : itemCodeNum
			},
			dataType:"json",
			success : function(result){
				
				var itemVO = result["itemVO"];
				
				if(itemVO.itemDetail != null && jQuery.trim(itemVO.itemDetail) != ''){
					//editor.setData(itemVO.itemDetail);
					editor.editable().setHtml(decodeHTMLEntities(HtmlDecode(itemVO.itemDetail)));
				}else{
					editor.setData("");
				}
				
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
		
		closeLoading();
	}
	
	function f_hideItemDetail(){
		
		$("#itemDataList").html("");
		//$("#itemImageLayer").html("");
		$("#itemDetailEditTopLayer").fadeOut();
		$("#itemDetailEditLayer").fadeOut();
		$("#itemDetailTopLayer").fadeOut();
		$("#htmlDataSetLayer").fadeOut();
		$("#itemStockLayer").fadeIn();
		$("#saveItemButton").fadeOut();
		$("#itemImageLayer").fadeOut();
		$("#itemStockLayer").fadeOut();
		$("#itemDetailViewLayer").fadeOut();
		//$("#itemQRLayer").fadeOut();
		
		$("#cancelModItemButton").fadeOut();
		$("#modifyItemButton").fadeOut();
		$("#htmlEditor").fadeOut();
		
		$("#itemQRLayer").fadeOut();
		f_itemImagePopClose();
	}
	
	function f_saveItemDetail(){
		var itemDetail = editor.getData();
		//alert(itemDetail);
		//alert(HtmlEncode(itemDetail));
		$("#itemDetailStatus").html("등록됨");
		$("#regItemDetailButton").val('수정');
		$("#itemDetail").val(HtmlEncode(itemDetail));
		
		f_hideItemDetail();
	}
	
	function f_saveItemDetail_old(){
		
		// 입력 파라미터 검사
		var itemCode = $("#txtGoodCode").val();
		var itemCodeNum = $("#txtGoodCode_2").val();
		var itemDetail = editor.getData();
		
		if(itemCode == null || jQuery.trim(itemCode) == '' || itemCodeNum == null || jQuery.trim(itemCodeNum) == ''){
			alert("물품 코드 정보가 없습니다.");
			return;
		}
		if(itemDetail == null || jQuery.trim(itemDetail) == ''){
			alert("상세 정보를 입력하세요.");
			return;
		}
		
		showLoading();
		
		$("#cancelModItemButton").fadeOut();
		$("#saveItemDetail").fadeOut();
		$("#htmlEditor").fadeOut();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/saveItemDetailView.do'/>",
			data: {
				itemCode:itemCode,
				itemCodeNum:itemCodeNum,
				itemDetail:itemDetail
			},
			dataType:"json",
			success : function(result){
				var saveCount = result.saveCount;
				if( saveCount > 0 ) {
					alert("정상적으로 저장하였습니다.");
				} else {
					alert("오류가 발생하였습니다. 관리자에게 문의하세요.");
				}
				
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
		
		f_hideItemDetail();
		closeLoading();
	}
	
	/* CK 에디터  */
    var editor;
    CKEDITOR.on( 'instanceReady', function( ev ) {
        editor = ev.editor;
        editor.resize( '100%', '500', true );
    });
	
    function HtmlEncode(s) {
        return $('<div>').text(s).html();
    }
    
    function HtmlDecode(s) {
        return $('<div>').html(s).text();
    }
    
    function decodeHTMLEntities(text) {
        var entities = [
            ['amp', '&'],
            ['apos', '\''],
            ['#x27', '\''],
            ['#x2F', '/'],
            ['#39', '\''],
            ['#47', '/'],
            ['lt', '<'],
            ['gt', '>'],
            ['nbsp', ' '],
            ['quot', '"']
        ];

        for (var i = 0, max = entities.length; i < max; ++i) 
            text = text.replace(new RegExp('&'+entities[i][0]+';', 'g'), entities[i][1]);

        return text;
    }
    
	jQuery.fn.center = function () {
	    this.css("position","absolute");
	    //alert(Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	    //alert(Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	    //this.css("top", 210 + "px");
	    //this.css("left", 220 + "px");
	    
	    var searchBox = $("#searchBox");
	    this.css("top", (searchBox.offset().top) + "px");
	    this.css("left", (searchBox.offset().left) + "px");
	    return this;
	}
	
	jQuery.fn.centerPop = function () {
	    this.css("position","fixed");
	    //alert(Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	    //alert(Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	    this.css("top", Math.max(0, ($(window).height() - $(this).outerHeight()) / 2));
	    this.css("left", Math.max(0, ($(window).width() - $(this).outerWidth()) / 2));
	    
	    return this;
	}
	
	jQuery.fn.showQRPop = function () {
	    this.css("position","absolute");
	    //alert(Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	    //alert(Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	    //this.css("top", 272 + "px");
	    //this.css("left", 956 + "px");
	    var showQRCode = $("#showQRCode");
	    this.css("top", (showQRCode.offset().top - 20) + "px");
	    this.css("left", (showQRCode.offset().left - 30) + "px");
	    return this;
	}
	
	function f_showQRCode(){
		// 입력 파라미터 검사
		if ($("#txtGoodCode").val() == null || jQuery.trim($("#txtGoodCode").val()) == ''
			|| $("#txtGoodCode_2").val() == null || jQuery.trim($("#txtGoodCode_2").val()) == '') {
			alert('등록된 물품이 아닙니다. \n저장 후 QR코드를 확인할 수 있습니다.');
			return;
		}
		
		$("#itemQRLayer").fadeIn();
		$("#itemQRLayer").showQRPop();
	}
	function f_closeQRCode(){
		$("#itemQRLayer").fadeOut();
	}
	
	$(window).resize(function(){
		// 브라우저가 리사이즈될 때마다 팝업의 위치를 재조정한다.
		$("#itemDetailEditLayer").center();
		$("#itemDetailViewLayer").center();
		$("#itemQRLayer").showQRPop();
	});
	
//]]>
</script>
</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
				
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
					
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
					<!--tab Contnet Start-->
					<div class="tab_container">
						
						<div class="divisionBx" style="margin-top:0px; margin-bottom:20px; display:inline-block;">
							
							<form action="" onsubmit="return false;">
								<fieldset>
									<legend class="hidden_phrase">방제물품 현황검색 폼</legend>
									
									<div class="searchBox" id="searchBox">
										<ul>
											<!-- 대분류 중분류 삭제 2016.12.22 KANG JI NAM
											<li>
												<span class="fieldName">대분류</span>
												<select class="upperGroupfixWidth20" id="upperGroupCode" style="width: 80px" ></select>
											</li>
											<li>
												<span class="fieldName">중분류</span>
												<select class="groupFixWidth20" id="groupCode" style="width: 120px" ></select>
											</li>
											 -->
											 <input type="hidden" class="upperGroupfixWidth20" id="upperGroupCode">
 											 <input type="hidden" class="groupFixWidth20" id="groupCode">
											<li>
												<span class="fieldName">물품명</span>
												<select style="width: 120px;" id="itemCode"></select>
										
											</li>
										</ul>
									</div>
									<div class="btnSearchDiv">
										<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:dataLoad();" alt="조회하기" style="float:right;"/>
									</div>
								</fieldset>
							</form>
						
						
							<!-- 목록폼 -->
							<div class="div60" style="float:left; width:534px">
								
								<div align="left" id="totcnt"></div>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 534px; height: 568px;">
									<table>
										<colgroup>
											<col width="40" />
											<!-- <col />
											<col /> -->
											<col />
											<col width="60" />
											<col width="40" />
											<col width="60" />
											<col width="80" />
											<col width="50" />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<!-- 
											<th scope="col">대분류</th>
											<th scope="col">중분류</th>
											 -->
											<th scope="col">물품명</th>
											<th scope="col">규격</th>
											<th scope="col">단위</th>
											<th scope="col">금액</th>
											<th scope="col">사고유형</th>
											<th scope="col">사용여부</th>
										</tr>
										</thead>
										<tbody  id="dataList">
										<tr>
											<td colspan="9">조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
							
							<!-- 등록 폼 -->
							<div class="div40" style="float:right; width:450px">
								 <form:form commandName="insertForm" id="insertForm" name="insertForm" method="post" enctype="multipart/form-data" >
								<!-- <form name="insertForm" action="" onsubmit="return false;" method="post" enctype="multipart/form-data"> -->
									<input type="hidden" name="mode" id="mode" value="insert" />
									<input type="hidden" name="pageNo" id="pageNo" value="1" />									
									<input type="hidden" name="posblAtchFileNumber" value="3" />
									<input type="hidden" name="posblAtchFileSize" value="" />
									<input type="hidden" name="itemCodeNum" id="itemCodeNum" value=""/>
									<input type="hidden" name="itemCodeDet" id="itemCodeDet" value="" />
									<input type="hidden" name="upperGroupCodeN" id="upperGroupCodeN" value=""/>	
									<input type="hidden" name="groupCodeN" id="groupCodeN" value=""/>
									<input type="hidden" name="itemCodeN" id="itemCodeN" value="${itemListVal.itemCodeN}"/>
									<input type="hidden" name="type1ApplFlagYN" id="type1ApplFlagYN" value="" />
									<input type="hidden" name="type2ApplFlagYN" id="type2ApplFlagYN" value="" />
									<input type="hidden" name="type3ApplFlagYN" id="type3ApplFlagYN" value="" />
									<input type="hidden" name="type4ApplFlagYN" id="type4ApplFlagYN" value="" />
									<input type="hidden" name="type5ApplFlagYN" id="type5ApplFlagYN" value="" />
									<input type="hidden" name="type6ApplFlagYN" id="type6ApplFlagYN" value="" />
									<input type="hidden" name="type7ApplFlagYN" id="type7ApplFlagYN" value="" />
									<input type="hidden" name="type8ApplFlagYN" id="type8ApplFlagYN" value="" />
									<input type="hidden" name="type9ApplFlagYN" id="type9ApplFlagYN" value="" />
									<input type="hidden" name="type10ApplFlagYN" id="type10ApplFlagYN" value="" />
									<input type="hidden" name="type11ApplFlagYN" id="type11ApplFlagYN" value="" />
									<input type="hidden" name="type12ApplFlagYN" id="type12ApplFlagYN" value="" />	
									<input type="hidden" name="chkFileId" id="chkFileId" value="${valiFileId}" />
									<input type="hidden" name="searchFirstCode" id="searchFirstCode" value="${itemListVal.searchFirstCode}" />
									<input type="hidden" name="searchSecondCode" id="searchSecondCode" value="${itemListVal.searchSecondCode}" />
									<input type="hidden" name="searchThirdCode" id="searchThirdCode" value="${itemListVal.searchThirdCode}" />
									<input type="hidden" name="fileUploadChk" id="fileUploadChk" value="N"/>
									<input type="hidden" name="imageDel" id="imageDel" value="N"/>
									<input type="hidden" name="atchFileId" id="atchFileId" value=""/>
										
									<fieldset>
										<legend class="hidden_phrase">물품 코드관리(수정) 폼</legend>
										
										<div align="left">[물품코드 등록(수정)]</div>
										<table summary="물품코드정보" style="text-align: left; height:568px;">
											<colgroup>
												<col width="80px" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="row">등록유형</th>
													<td class="txtL" colspan="3"><input style="width: 251px;" type="text" id="txtRegType" value="신규" readonly="readonly" />
													<input style="width: 88px;" type="button" id="showQRCode" name="showQRCode" class="btn btn_basic" value="QR코드보기" onclick="javascript:f_showQRCode();" />
													</td>
												</tr>
												<!-- 대분류 중분류 삭제 2016.12.22 KANG JI NAM
												<tr>
													<th scope="row">대분류</th>
													<td class="txtL">
														<select class="upperGroupfixWidth20" id="selectUpperGroupCode" style="width: 220px" />
													</td>
												</tr>
												<tr>
													<th scope="row">중분류</th>
													<td class="txtL">
														<select class="groupFixWidth20" id="selectGroupCode" style="width: 220px" />
														<input type="hidden" id="hideGroupCode" name="hideGroupCode"/>
													</td>
												</tr>
												 -->
												<input type="hidden" class="upperGroupfixWidth20" id="selectUpperGroupCode"/> 
												<input type="hidden" class="groupFixWidth20" id="selectGroupCode"/> 
												<input type="hidden" id="hideGroupCode" name="hideGroupCode"/>
												 
												<tr>
													<th scope="row">물품코드</th>
													<td class="txtL" colspan="3"><input style="width: 251px;" type="text" id="txtGoodCode" value="" /> <!--  <select class="fixWidth20" id="itemCode2"/> -->
													<input type="hidden" id="txtGoodCode_2" value="" readonly="readonly" style="width:20px"/>
													<input style="width: 88px;" type="button" id="showItemDetail" name="showItemDetail" class="btn btn_basic" value="물품정보상세" onclick="javascript:f_showItemDetail();" />
													<p><a href="http://www.g2b.go.kr:8100/detailSearch.do?lefttab=detail" target="_blank" style="color: red">※ 클릭: 목록정보시스템 ※</a></p>
													</td>
												</tr>
												<tr>
													<th scope="row">물품명칭</th>
													<td class="txtL" colspan="3"><input style="width: 348px;" type="text" name="itemName" id="itemName" /></td>
												</tr>
												<tr>
													<th scope="row">용도</th>
													<td class="txtL" colspan="3"><input style="width: 348px;" type="text" name="itemPurpose" id="itemPurpose" /></td>
												</tr>
												<tr>
													<th scope="row">유형</th>
													<td class="txtL" colspan="1">
														<select name="itemStockType" id="itemStockType" style="width: 133px;">
															<option value="A">물품</option>
															<option value="B">장비</option>
															<option value="C">장비(적제가능)</option>
														</select>
													</td>
													<th scope="row">제원</th>
													<td class="txtL" colspan="1">
														<span id="itemDetailStatus" name="itemDetailStatus"></span><input type="hidden" id="itemDetail" name="itemDetail"></input>
														<input type="button" name="regItemDetailButton" id="regItemDetailButton" class="btn btn_basic" value="등록" onclick="javascript:f_regItemDetail();"/>
													</td>
													
												</tr>
												<tr>
													<th scope="row">사용유무</th>
													<td class="txtL" colspan="1">
														<select name="useFlag" id="useFlag" style="width: 133px;">
															<option value="Y">사용</option>
															<option value="N">미사용</option>
														</select>
													</td>
													<th scope="row">금액</th>
													<td class="txtL" colspan="1"><input style="width: 125px;" type="text" name="itemCost" id="itemCost" /></td>
												</tr>
												<tr>
													<th scope="row">규격</th>
													<td class="txtL" colspan="1"><input style="width: 125px;" type="text" name="itemStan" id="itemStan" /></td>
													<th scope="row" style="width: 70px;">단위</th>
													<td class="txtL" colspan="1"><input style="width: 125px;" type="text" name="itemUnit" id="itemUnit" /></td>
												</tr>
												
												<tr>
													<th scope="row">사고적용</th>
													<td style="text-align: left;" class="txtL" colspan="1">
														<input type="checkbox" id="type1ApplFlag" style="width: 15px;" />
														<label for="type1ApplFlag"> <img src="<c:url value='/images/warehouse/type1.png'/>" alt="오탁수 발생" style="vertical-align: middle;" /> 오탁수 발생</label> <br /> 
														<input type="checkbox" id="type2ApplFlag" style="width: 15px;" />
														<label for="type2ApplFlag"><img src="<c:url value='/images/warehouse/type2.png'/>" alt="준설저니용출" style="vertical-align: middle;" /> 준설저니용출</label> <br />
														<input type="checkbox" id="type3ApplFlag" style="width: 15px;" />
														<label for="type3ApplFlag"> <img src="<c:url value='/images/warehouse/type3.png'/>" alt="준설장비전복" style="vertical-align: middle;" /> 준설장비전복</label> <br />
														<input type="checkbox" id="type4ApplFlag" style="width: 15px;" />
														<label for="type4ApplFlag"> <img src="<c:url value='/images/warehouse/type4.png'/>" alt="선박사고" style="vertical-align: middle;" /> 선박사고</label> <br />
														<input type="checkbox" id="type5ApplFlag" style="width: 15px;" />
														<label for="type5ApplFlag"> <img src="<c:url value='/images/warehouse/type5.png'/>" alt="선박페인트" style="vertical-align: middle;" /> 선박페인트</label> <br />
														<input type="checkbox" id="type6ApplFlag" style="width: 15px;" />
														<label for="type6ApplFlag"> <img src="<c:url value='/images/warehouse/type6.png'/>" alt="탱크로리" style="vertical-align: middle;" /> 탱크로리</label> <br />
													</td>
													<td style="text-align: left;" class="txtL" colspan="2">
														<input type="checkbox" id="type7ApplFlag" style="width: 15px;" />
														<label for="type7ApplFlag"> <img src="<c:url value='/images/warehouse/type7.png'/>" alt="홍수기" style="vertical-align: middle;" /> 홍수기</label> <br />
														<input type="checkbox" id="type8ApplFlag" style="width: 15px;" />
														<label for="type8ApplFlag"> <img src="<c:url value='/images/warehouse/type8.png'/>" alt="취정수장" style="vertical-align: middle;" /> 취정수장</label> <br />
														<input type="checkbox" id="type9ApplFlag" style="width: 15px;" />
														<label for="type9ApplFlag"> <img src="<c:url value='/images/warehouse/type9.png'/>" alt="유류유출" style="vertical-align: middle;" /> 유류유출</label> <br />
														<input type="checkbox" id="type10ApplFlag" style="width: 15px;" />
														<label for="type10ApplFlag"> <img src="<c:url value='/images/warehouse/type10.png'/>" alt="페놀" style="vertical-align: middle;" /> 페놀</label> <br />
														<input type="checkbox" id="type11ApplFlag" style="width: 15px;" />
														<label for="type11ApplFlag"> <img src="<c:url value='/images/warehouse/type11.png'/>" alt="유해물질" style="vertical-align: middle;" /> 유해물질</label> <br /> 
														<input type="checkbox" id="type12ApplFlag" style="width: 15px;" />
														<label for="type12ApplFlag"> <img src="<c:url value='/images/warehouse/type12.png'/>" alt="물고기폐사" style="vertical-align: middle;" /> 물고기폐사</label>
													</td>
												</tr>
												<tr>
													<th scope="row">파일</th>	
													<td class="txtL" colspan="3" style="height:100px;">
														<span id="atchImg">
														<!-- <c:if test="${!empty valiFileId }">
															<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
																<c:param name="atchFileId" value="${valiFileId }" />
																<c:param name="thumbnailFlag" value="Y"/>
															</c:import>
															<img src="/images/util/bu5_close.gif" style="cursor: pointer; padding-top: 40px; padding-left: 10px;" id="imgDelChk"/>
														</c:if> -->
														
														</span>
														<input name="file_1" id="egovComFileUploader" type="file"  style="width:357px;"/>&nbsp;&nbsp;	
														<p>새로운 이미지로 업로드 (최대 3개)</p>
														<p><font color=red>※ 이미지 지원 목록: jpg, gif, png ※</font></p>
														<div id="egovComFileList"></div>
													</td>
												</tr>
												<script type="text/javascript">
													var maxFileNum = document.insertForm.posblAtchFileNumber.value;
												    	if(maxFileNum==null || maxFileNum==""){
												    		maxFileNum = 3; // 파일 업로드 갯수 제한
												     	}     
													var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
													multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
											    </script>	
											    
											</thead>
											<tbody id="sectionSpeedBody"></tbody>
										</table>
									</fieldset>
									</form:form>
								<!-- </form> -->
								<!-- //물폼코드 등록(수정) -->
								<div style="float:right;margin-top:5px;">
								<span id="menuAuth1">
									<input type="button" id="btnAddRow" name="btnAddRow" value="신규" class="btn btn_basic" onclick="javascript:dataLoad();" alt="신규" />
								</span>
								<span id="menuAuth2">
									<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:fn_saveRegistItem();" alt="저장" />
								</span>
								</div>
							</div>
							
						</div>
						
						<div id="itemDetailViewLayer" style="background-color:white;display:none;border:2px solid #3571B5;z-index:10;padding:15px 20px;">
							<div id="itemDetailTopLayer" style="width:620px;height:50px;text-align:right;display:none;">
								<input type="button" id="hideItemButton" name="hideItemButton" class="btn btn_basic" value="닫기 X" onclick="javascript:f_hideItemDetail();"></input>
							</div>
							
							<div id="itemImageLayer" style="text-align:left;width:100%;height:220px;display:none;">
							<!--<div id="itemImageLayer" class="cycle-slideshow" style="text-align:left;width:100%;height:220px;display:none;">
								 <img id="cycleImage1" width="640" height="480" src="">
								<img id="cycleImage2" width="640" height="480" src="">
								<img id="cycleImage3" width="640" height="480" src=""> -->
							</div>
							
							<div id="htmlDataSetLayer" style="width:100%;display:none;">
								<div align="left">※ 용도</div>
								<div id="itemPurposeDesc" style="text-align:center;margin-bottom:15px;"></div>
								<div align="left">※ 배치현황</div>
								<div id="itemLocationStock" style="text-align:center;"></div>
								<div id="itemLocationStockDept" style="text-align:center;margin-bottom:15px;"></div>
								<div align="left">※ 제원</div>
								<div id="itemDataList" style="text-align:center;">
								</div>
							</div>
							
							<div id="itemStockLayer" style="width:100%;display:none;">
								<table>
									<tbody id="itemDataList1">
									</tbody>
								</table>
							</div>
							
							
						</div>
						
						<div id="itemImagePopLayer" style="background-color:white;display:none;border:2px solid #3571B5;z-index:10;padding:1px 1px;">
							<img id="itemImagePopFullscreen" style="width:100%;height:100%;cursor:pointer;" src="" onclick="f_itemImagePopClose();">
						</div>
						
						<div id="itemQRLayer" style="background-color:white;text-align:right;border:2px solid #3571B5;display:none;">
							<!-- <img src="/cmmn/getQRCodeImage.do" /> -->
						</div>
						
						<div id="itemDetailEditLayer" style="background-color:white;display:none;border:2px solid #3571B5;z-index:10;padding:15px 20px;">
							<div id="htmlEditor" style="width:100%;display:none;">
								<textarea class="ckeditor" id="Contents" name="Contents"></textarea>
							</div>
							<div id="itemDetailEditTopLayer" style="width:620px;height:50px;text-align:right;display:none;">
								<!-- <input type="button" id="cancelModItemButton" name="cancelModItemButton" class="btn btn_basic" style="display:none;" value="수정취소" onclick="javascript:f_showItemDetail();"></input>
								<input type="button" id="modifyItemButton" name="modifyItemButton" class="btn btn_basic" value="수정" onclick="javascript:f_modifyItemDetail();"></input> -->
								<input type="button" id="hideItemButton" name="hideItemButton" class="btn btn_basic" value="닫기 X" onclick="javascript:f_hideItemDetail();"></input>
								<input type="button" id="saveItemDetail" name="saveItemDetail" class="btn btn_basic" value="저장" onclick="javascript:f_saveItemDetail();"></input>
							</div>									
							<!-- <div id="saveItemButton" style="width:620px;text-align:right;display:none;">
							</div> -->
						</div>
						
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
			
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
	<script language="javascript" >
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
	if("1" == menuAuth("C")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	if("1" == menuAuth("U")){
		$("#menuAuth2").show();
	}else{
		$("#menuAuth2").hide();
	}
	
	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}
	
	function clickTdEvent(tdObj) {
		var td = eval("document.getElementById(\"" + tdObj.id + "\")");
		$(td).parent().find("td").removeClass("highlight");
		$(td).addClass("highlight");
	}
	
	CKEDITOR.replace('Contents',{
	        toolbar: 'Full',
	        uiColor: '#9AB8F3',
	    }
	);
	
	// 버튼 클릭시 이미지 팝업창 닫기
	$('#regItemDetailButton').click(function(){
		f_itemImagePopClose();
	});
	$('#showItemDetail').click(function(){
		f_itemImagePopClose();
	});
	$('#btnAddRow').click(function(){
		f_itemImagePopClose();
	});
	$('#btnSave').click(function(){
		f_itemImagePopClose();
	});
	$('#btnSearch').click(function(){
		f_itemImagePopClose();
	});
	$("#showQRCode").click(function(){
		f_itemImagePopClose();
	});
	
	function reset_html(id) {
	    $('#'+id).html($('#'+id).html());
	}
	
	</script>
</body>
</html>