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
		getUpperGroupCode();
		
		//대분류 (물품코드 조회)
		searchUpperGroupCode();
		
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
		
		$('#selectUpperGroupCode').change(function() {
			
			if ($("#selectUpperGroupCode option:selected").text() != "선택") {
				getGroupCode();
			}
		});
		
		$('#selectGroupCode').change(function() {
			
			if ($("#selectGroupCode option:selected").text() != "선택") {
// 				getNextItemCode();
			}
		});
		
		$('#upperGroupCode').change(function() {
			searchGroupCode();
		});
		
	});
	
	//대분류 코드 불러오기
	function getUpperGroupCode() {
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
			data : {},
			dataType : "json",
			beforeSend : function() {
				//$('#popupUpperGroupCode').attr("disabled", true);
			},
			success : function(result) {
				var dropDownSet = $('#selectUpperGroupCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', "VALUE", 'CAPTION');
				
				$('#selectUpperGroupCode').attr("disabled", false);
			}
		});
	}
	
	//중분류 코드  불러오기 
	function getGroupCode() {
		var upperGroupCode = $("#selectUpperGroupCode option:selected").val();
		
		if (upperGroupCode == '') {
			$('#selectGroupCode').html("<option value=''>선택</option>");
		} else {
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/itemManageGroupCode.do'/>",
				data : {
					upperGroupCode : upperGroupCode
				},
				dataType : "json",
				beforeSend : function() {
					$('#selectGroupCode').attr("disabled", true);
				},
				success : function(result) {
					
					if (result.codes == '')
						alert('중분류가 존재 하지 않습니다.');
					else {
						var dropDownSet = $('#selectGroupCode');
						dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
						
						
						if($("#mode").val() == 'update'){
							$('#selectGroupCode').val($('#hideGroupCode').val());
							$('#selectGroupCode').attr("disabled", true);
						}
						else
							$('#selectGroupCode').attr("disabled", false);
					}
				}
			});
		}
	}
	
	
	
	//검색 대분류 코드 불러오기
	function searchUpperGroupCode() {
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
			data : {},
			dataType : "json",
			beforeSend : function() {
			},
			success : function(result) {
				var dropDownSet = $('#upperGroupCode');
				dropDownSet.loadSelectWareHouse(result.codes, '전체', "VALUE", 'CAPTION');
				
				$('#upperGroupCode').attr("disabled", false);
				searchGroupCode();
			}
		});
	}
	
	//검색 중분류 코드  불러오기 
	function searchGroupCode() {
		var upperGroupCode = $("#upperGroupCode option:selected").val();
		
		if (upperGroupCode == '') {
			$('#groupCode').html("<option value=''>선택</option>");
		} else {
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/itemManageGroupCode.do'/>",
				data : {
					upperGroupCode : upperGroupCode
				},
				dataType : "json",
				beforeSend : function() {
				},
				success : function(result) {
					
					if (result.codes == '')
						alert('중분류가 존재 하지 않습니다.');
					else {
						var dropDownSet = $('#groupCode');
						dropDownSet.loadSelectWareHouse(result.codes, '전체', 'VALUE', 'CAPTION');
						
					}
				}
			});
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
		
		$("#txtGoodCode").val('');
		$("#txtGoodCode_2").val('');
		$("#mode").val("insert");
		
		$("#itemCode2").val('');
		$("#itemCodeDet").val('');
		$("#itemName").val('');
		$("#itemStan").val('');
		$("#itemUnit").val('');
		$("#itemCost").val('');
		
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
		
		getUpperGroupCode();
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
	
	function clickItemList(p_itemCode, p_itemCodeNum, p_itemCodeDet, p_itemName, p_itemStan, p_itemUnit, p_itemCost ,
			p_type1ApplFlag, p_type2ApplFlag,p_type3ApplFlag,p_type4ApplFlag,p_type5ApplFlag,
			p_type6ApplFlag,p_type7ApplFlag,p_type8ApplFlag,p_type9ApplFlag,p_type10ApplFlag,
			p_type11ApplFlag,p_type12ApplFlag, p_useFlag, upperGroupCode )
	{
		$('#selectUpperGroupCode').val(upperGroupCode);
		$('#selectUpperGroupCode').attr("disabled", true);
		$('#hideGroupCode').val(p_itemCodeDet);
		getGroupCode();
		
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
	}
	
	// 공통 함수
	function changeBoolean(bool) {
		var rtnVal = "N";
		if (bool == true) {
			rtnVal = "Y";
		}
		return rtnVal;
	}
	
	// 데이터 목록 불러오기
	function dataLoad(pageNo){
		showLoading();
		
		if (pageNo == null) pageNo = 1;
		
		var itemCode = "";
		var itemCodeNum = "";
		
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
						
						item += "<tr style='cursor:pointer;' onclick=\"clickItemList('"+obj.itemCode+"','"+obj.itemCodeNum+"','"+obj.itemCodeDet+"','"+obj.itemName+"','"+obj.itemStan+"','"+obj.itemUnit+"','"+obj.itemCost+"','"+
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
               			obj.upperGroupCode+"'"+
               			")\">"			                   	 
						+"<td><span>"+obj.num+"</span></td>"
                 		+"<td>"+obj.upperGroupName+"</td>"
                 		+"<td>"+obj.groupName+"</td>"
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
									
									<div class="searchBox">
										<ul>
											<li>
												<span class="fieldName">대분류</span>
												<select class="upperGroupfixWidth20" id="upperGroupCode" style="width: 80px" ></select>
											</li>
											<li>
												<span class="fieldName">중분류</span>
												<select class="groupFixWidth20" id="groupCode" style="width: 120px" ></select>
											</li>
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
							<div class="div60" style="float:left; width:662px">
								
								<div align="left" id="totcnt"></div>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 663px; height: 568px;">
									<table>
										<colgroup>
											<col width="40" />
											<col />
											<col />
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
											<th scope="col">대분류</th>
											<th scope="col">중분류</th>
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
							<div class="div40" style="float:right; width:322px">
								
								<form name="insertForm" action="" onsubmit="return false;">
									<input type="hidden" name="mode" id="mode" value="insert" />
									<input type="hidden" name="pageNo" id="pageNo" value="1" />
										
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
													<td class="txtL"><input type="text" id="txtRegType" value="신규"
														readonly="readonly" /></td>
												</tr>
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
												<tr>
													<th scope="row">물품코드</th>
													<td class="txtL"><input type="text" id="txtGoodCode" value="" /> <!--  <select class="fixWidth20" id="itemCode2"/> -->
													<input type="hidden" id="txtGoodCode_2" value="" readonly="readonly" style="width:20px"/> 
													</td>
												</tr>
												<tr>
													<th scope="row">물품명칭</th>
													<td class="txtL"><input style="width: 220px;" type="text" id="itemName" /></td>
												</tr>
												<tr>
													<th scope="row">규격</th>
													<td class="txtL"><input style="width: 220px;" type="text" id="itemStan" /></td>
												</tr>
												<tr>
													<th scope="row">단위</th>
													<td class="txtL"><input style="width: 220px;" type="text" id="itemUnit" /></td>
												</tr>
												<tr>
													<th scope="row">금액</th>
													<td class="txtL"><input style="width: 220px;" type="text" id="itemCost" /></td>
												</tr>
												<tr>
													<th scope="row">사고적용</th>
													<td style="text-align: left;" class="txtL">
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
													<th scope="row">사용유무</th>
													<td class="txtL">
														<select name="useFlag" id="useFlag" style="width: 220px;">
															<option value="Y">사용</option>
															<option value="N">미사용</option>
														</select>
													</td>
												</tr>
											</thead>
											<tbody id="sectionSpeedBody"></tbody>
										</table>
									</fieldset>
								</form>
								<!-- //물폼코드 등록(수정) -->
								<div style="float:right;margin-top:5px;">
									<input type="button" id="btnAddRow" name="btnAddRow" value="신규" class="btn btn_basic" onclick="javascript:addRow();" alt="신규" />
									<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:save();" alt="저장" />
								</div>
							</div>
							
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
</body>
</html>