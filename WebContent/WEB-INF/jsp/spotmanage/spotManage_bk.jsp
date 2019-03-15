<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : spotManage.jsp
	 * Description : 측정소(지점)관리 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<!-- <script type="text/javascript" src="http://js.arcgis.com/3.8/"></script> -->
<script type="text/javascript" src="<c:url value='/gis/js/new_editMap.js'/>"></script>
<script type="text/javascript">
//<![CDATA[
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	
	var options = {
					enableColumnReorder: false,
					enableCellNavigation: true,
					multiColumnSort: true
				};
	
	$(function () {
		var tab = $('.tabs');
		
		function onSelectTab(){
			var t = $(this);
			var myClass = t.parent('li').attr('class');
			
			t.parents('.tabs:first').attr('class', 'tabs '+myClass);
			t.parent().parent().find("li").removeClass("on");
			t.parent('li').addClass("on");
		}
		tab.find('>li>a').click(onSelectTab).focus(onSelectTab);
		//지점등록 레이어
		$("#layerBranchReg").draggable({
			containment: 'body',
			scroll: false
		});
		
		LayerDiv(1);
		reloadData();
		
		//지점등록 레이어
		$("#layerBranchReg").draggable({
			containment: 'body',
			scroll: false
		});
		//측정소 등록/수정 레이어
		$("#layerBranchModify").draggable({
			containment: 'body',
			scroll: false
		});
		//탭1 관리자 등록/변경 레이어
		$("#layerMember").draggable({
			containment: 'body',
			scroll: false
		});
		//측정소 조회 레이어
		$("#factinfoLayer").draggable({
			containment: 'body',
			scroll: false
		});
		//측정소등록 관리자등록 조회 레이어
		$("#memberLayer").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	//저장된 항목 가져오기
	var itemList;
	
	//측정소 리스트 상태를 저장
	function updateLoadData(vRow, val){
		showLoading();
		
		var date = new Date();
			date = date.getFullYear() + addzero(date.getMonth()+1) + addzero(date.getDate());
		var pageNo = $("#rpage").val();	//측정소 수정을 위한 페이지 확인
		var objs = dataView.getItem(vRow);
		var fact_code = objs.factCode;
		var branch_no = objs.branchNo;
		var branchName = objs.branchName;
		var riverDiv = objs.riverDiv;
		var riverName = objs.riverName;
		var sysKind = objs.sysKind;
		var longitude = objs.longitude;
		var latitude = objs.latitude;
		var factAddr = objs.factAddr;
		var branchUseFlag = val;
		var useStr = (branchUseFlag == "Y")? "사용" : "미사용";
		
		var obj = {};
			obj.BRANCH_NO = branch_no;		//지점번호
			obj.DATE= date;					//일력일자
			obj.FACI_ADDR = factAddr;		//주소
			obj.FACI_NM = riverName + sysKindName(sysKind) + "("+ branchName + "-" + branch_no + ")";	//예) 한강IP_USN(양평-3)
			obj.FACT_CODE = fact_code;		//측정소코드
			obj.RV_CD = riverDiv;			//수계	예)R01
			obj.X = latitude;				//위도
			obj.Y = longitude;				//경도
			obj.USE_FLAG = branchUseFlag	//사용여부
			
		if (branchUseFlag == "Y" && (sysKind == "A" || sysKind == "U")){
			
			$editMap.model.addMemtPoint(sysKind, obj , function(result){
// 				console.log('[저장]editMap.result', result);
				
				if(result.callbacktype == 'S' || result.callbacktype == 'R'){
// 					console.log('[저장]', result.callbacktype);
					
					$.ajax({
						type:"post",
						url:"<c:url value='/spotmanage/saveLoadData.do'/>",
						data:{
								fact_code:fact_code,
								branch_no:branch_no,
								branchUseFlag:branchUseFlag
							},
						dataType:"json",
						success:function(result){
							reloadData(pageNo);
							alert(branchName + "-" + branch_no + "지점을 "+ useStr + "으로 변경 등록했습니다.");
						},
						error:function(result){
							var oraErrorCode = "";
							if (result.responseText != null ) {
								var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
								if (matchedValue != null && matchedValue.length > 0) {
									oraErrorCode = matchedValue[0].replace('ORA-', '');
								}
							}
							alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
							closeLoading();
						}
					});
				}
				else{
					alert("서버접속에 실패하였습니다.\n다시 확인해주세요.");
					closeLoading();
					return;
				}
			});
		} else if (branchUseFlag == "N" && (sysKind == "A" || sysKind == "U")){
			$editMap.model.removeMemtPoint(sysKind, obj , function(result){
				console.log('[삭제]editMap.result', result);
				if(result.callbacktype == 'S')
				{
					console.log('[삭제]', result.callbacktype);
					$.ajax({
						type:"post",
						url:"<c:url value='/spotmanage/saveLoadData.do'/>",
						data:{
								fact_code:fact_code,
								branch_no:branch_no,
								branchUseFlag:branchUseFlag
							},
						dataType:"json",
						success:function(result){
							reloadData(pageNo);
							alert(branchName + "-" + branch_no + "지점을 "+ useStr + "으로 변경 등록했습니다.");
						},
						error:function(result){
							var oraErrorCode = "";
							if (result.responseText != null ) {
								var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
								if (matchedValue != null && matchedValue.length > 0) {
									oraErrorCode = matchedValue[0].replace('ORA-', '');
								}
							}
							alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
							closeLoading();
						}
					});
				}
				else{
					alert("서버접속에 실패하였습니다.\n다시 확인해주세요.");
					closeLoading();
					return;
				}
			});
		} else {
			
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/saveLoadData.do'/>",
				data:{
						fact_code:fact_code,
						branch_no:branch_no,
						branchUseFlag:branchUseFlag
					},
				dataType:"json",
				success:function(result){
					reloadData(pageNo);
					alert(branchName + "-" + branch_no + "지점을 "+ useStr + "으로 변경 등록했습니다.");
				},
				error:function(result){
					var oraErrorCode = "";
					if (result.responseText != null ) {
						var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
						if (matchedValue != null && matchedValue.length > 0) { 
							oraErrorCode = matchedValue[0].replace('ORA-', '');
						}
					}
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
					closeLoading();
				}
			});
			
		}
// 		reloadData();
		closeLoading();
	}
	
	function reloadData(pageNo){
		var selectFormatter = function(row, cell, value, columnDef, dataContext) {
			var strSelect = "<select id='branchUseFlag' name='branchUseFlag' onchange='javascript:updateLoadData(" + row + ", this.value);'>";
			
			if(value == "Y"){
				strSelect += "<option value='Y' selected='true'>사용</option>"
							+ "<option value='N'>미사용</option>";
			}else{
				strSelect += "<option value='Y'>사용</option>"
							+ "<option value='N' selected='true'>미사용</option>";
			}
			strSelect += "</select>";
			return strSelect;
		}
		//측정소(지점)정보
		dataView = new Slick.Data.DataView();
		
		var columns = [
						{ id: "no", name: "NO", field: "no", width: 45, sortable: false, cssClass: "slick-pointer" },
						{ id: "factCode", name: "지점코드", field: "factCode", width: 140, sortable: false, cssClass: "slick-pointer" },
						{ id: "branchNameNo", name: "지점(장비)명", field: "branchNameNo", width: 205, sortable: false, cssClass: "slick-pointer" },
						{ id: "areaName", name: "권역", field: "areaName", width: 120, sortable: false, cssClass: "slick-pointer" },
						{ id: "riverName", name: "수계", field: "riverName", width: 120, sortable: false, cssClass: "slick-pointer" },
						{ id: "sysName", name: "시스템", field: "sysName", width: 120, sortable: false, cssClass: "slick-pointer" },
						{ id: "mgrOrg", name: "관리주체", field: "mgrOrg", width: 120, sortable: false, cssClass: "slick-pointer" },
						{ id: "branchUseFlag", name: "사용여부", field: "branchUseFlag", width: 120, formatter: selectFormatter }
					];
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		grid.onClick.subscribe(function(e, args) {
			if (args.cell !==7) {
				EventDiv(args.row);
			}
		});
		
		grid.onSort.subscribe(function (e, args) {
			var cols = args.sortCols;
			
			dataView.sort(function (dataRow1, dataRow2) {
				for (var i = 0, l = cols.length; i < l; i++) {
					var field = cols[i].sortCol.field;
					var sign = cols[i].sortAsc ? 1 : -1;
					var value1 = dataRow1[field], value2 = dataRow2[field];
					var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
					if (result != 0) {
						return result;
					}
				}
				return 0;
			});
			grid.invalidate();
			grid.render();
		});
		
		showLoading(); 
		var riverDiv = $("select[name=c_river_div]").val();
		var sysKind = $("select[name=c_sys_kind]").val();
		var branchName=$("#c_branch_name").val();
		var searchText;
		if($("#c_branch_name").val()!=""){
			searchText = branchName;
		}else{
			searchText = "";
		}
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getSpotmgrList.do'/>",
			data:{
					pageIndex:pageNo,
					sysKind:sysKind,
					riverDiv:riverDiv,
					searchText:searchText
				},
			dataType:"json",
			success:function(result){
				console.log("reload getSpotmgrList : ",result);
				var tot = result['detailViewList'].length;
				
				dataView.setItems([]);
				
				//var height = sGridCmn(1,result['detailViewList'],10);
				var height = sGridCmn(1,result['detailViewList'],10,26);
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				var data = [];
				
				if( tot <= 0 ){
					dataView.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					data.push({no:"조회 결과가 없습니다."});
					dataView.setItems(data, 'no');
					
					var height = sGridCmn(1,data,1);
					$("#dataList").css("height", height + "px");
					grid.resizeCanvas();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var pageInfo = result['paginationInfo'];
						
						obj.no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.sysName = sysKindName(obj.sysKind);
						obj.branchNameNo = obj.branchName + " - " + obj.branchNo;
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
					
					// 페이징 정보
					var pageStr = makePaginationInfo(result['paginationInfo']);
					$("#pagination").empty();
					$("#pagination").append(pageStr);
					$("#rpage").val(pageNo);
				}
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
				dataView.getItemMetadata = function () {
					return {"columns":{0:{"colspan":"*"}}};
				}
				var data = [];
				data.push({no:"서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]"});
				dataView.setItems(data, 'no');
				
				var height = sGridCmn(1,data,1);
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				closeLoading();
			}
		});
	}
	
	//지점 상세보기
	function getSpotView(vRow){
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var sysKind = objs.sysKind;
		var riverNo = objs.riverNo;
		
		showLoading(); 
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getSpotView.do'/>",
			data:{
					riverNo:riverNo,
					sysKind:sysKind,
					factCode:factCode,
					branchNo:branchNo
				},
			dataType:"json",
			success:function(result){
				console.log("getSpotView : ",result);
					var obj = result['getSpotView'];
					
					$("#factCode").html(obj.factCode);
					$("#branchNo").val(obj.branchNo);
					$("#mgrOrg").html(obj.mgrOrg);
					$("#operOrg").html(obj.operOrg);
					$("#riverName").html(obj.riverName);
					$("#areaName").html(obj.areaName);
					$("#sido").html(obj.sido);
					$("#gugun").html(obj.gugun);
					$("#longitude").html(obj.longitude);
					$("#latitude").html(obj.latitude);
					$("#rlongitude").val(obj.longitude);
					$("#rlatitude").val(obj.latitude);
					$("#dong").html(obj.dong);
					$("#factAddr").html(obj.factAddr);
					$("#riverDivName").html(obj.sysKind);
					
					var tot = result['memList'].length;
					var tot1 = result['sysItemList'].length;
					
					$("#memList").html("");
					var item;
					
					if(tot<=0){
						item = "<li>등록된 관리자가 없습니다.</li>";
						$("#memList").append(item);
					}else{
						for(var i=0; i<tot; i++){
							obj = result['memList'][i];
							item = "<li>"+obj.memberName+"<a href=javascript:memDel('"+i+"')><img src='/images/popup/btn_close.gif' /></a>";
							item += "<input type='hidden' id='Dfc"+i+"' name='factCode' value='"+obj.factCode+"' />";
							item += "<input type='hidden' id='Dbn"+i+"' name='branchNo' value='"+obj.branchNo+"' />";
							item += "<input type='hidden' id='Dms"+i+"' name='memberSeq' value='"+obj.memberSeq+"' />";
							item += "</li>";
							$("#memList").append(item);
						}
					}
					$("#sysList").html("");
					if(tot1<=0){
						item = "<li>등록된 그룹이 없습니다.</li>";
						$("#sysList").append(item);
					}else{
						for(var i=0; i<tot1; i++){
							obj = result['sysItemList'][i];
							item = "<li>"+obj.groupName+"</li>";
							$("#sysList").append(item);
						}
					}
					$("#riverDivName").html(obj.sysKind);
					
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
				$("#memList").html("<tr><td colspan='12'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//Usn 관리 리스트
	function getUsnList(vRow){
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var sysKind = objs.sysKind;
		
		$("#usnBranchName").html(objs.branchName);
		showLoading(); 
		$("#usnDataList").html("");
		if(sysKind == "U"){
			$("#usnAdd").attr("style","display: block");
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/getUsnList.do'/>",
				data:{
						factCode:factCode,
						branchNo:branchNo
					},
				dataType:"json",
				success:function(result){
					var tot = result['getUsnList'].length;
					if(tot<=0){
					
					}else{
						for(var i=0;i<tot;i++){
							var obj = result['getUsnList'][i];
							var pageInfo = result['paginationInfo'];
							var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
							var item;
							item ="<tr>";
							item += "<td>"+no+"<input type='hidden' id='is"+i+"' value="+obj.itemseq+" /></td>"
								+ "<td>"+obj.branchName+"</td>"
								+ "<td>"+obj.frdate+"</td>"
								+ "<td>"+obj.todate+"</td>"
								+ "<td>"+obj.longitude+"</td>"
								+ "<td>"+obj.latitude+"</td>";
								
								if(obj.orignlFileName==""){
									item+="<td></td>";
								}else{
									item+="<td><a href=javascript:fileDown('"+i+"') ><img src='<c:url value='/images/board/ico_file.gif'/>' /></a> "+obj.orignlFileName+"</td>";
								}
								item += "<td>"+obj.memo+"</td>"
								+ "<td><input type='button' id='btnUpdate' name='btnUpdate' value='수정' class='btn btn_basic' onclick='javascript:usnUpdatePopup("+i+");' alt='수정'/>"
								+ "<input type='button' id='btnDelete' name='btnDelete' value='삭제' class='btn btn_basic' onclick='javascript:usnDel("+i+");' alt='삭제'/>"
								+ "</td>";
							item +="</tr>";
							$("#usnDataList").append(item);
							$("#usnDataList tr:odd").attr("class","add"); 
						}
					}
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
					};
					$("#usnDataList").html("<tr><td colspan='12'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}else{
			$("#usnDataList").html("<tr><td colspan='9'> 이동형측정기기만 사용이 가능합니다. </td></td>");
			$("#usnAdd").attr("style","display: none");
		}
		
	}
	
	//설치 장비 리스트
	function getEqList(vRow){
		showLoading();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
		$("#eqItemName").html(objs.branchName);
		$("#eqDataList").html("");
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getEqList.do'/>",
			data:{
					factCode:factCode,
					branchNo:branchNo
				},
			dataType:"json",
			success:function(result){
				var tot = result['getEqList'].length;
				if(tot<=0){
					
				}else{
					for(var i=0;i<tot;i++){
						 var obj = result['getEqList'][i];
						 var pageInfo = result['paginationInfo'];
						 var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						 var item;
						 item ="<tr>";
						 item += "<td>"+no+"<input type='hidden' id=es"+i+" value="+obj.eqSeq+" /></td>"
							+"<td>"+obj.eqName+"</td>"
							+"<td>"+obj.itemName+"</td>"
							+"<td>"+obj.introDate+"</td>"
							+"<td>"+obj.conpanySeq+"</td>"
							+"<td>"+obj.modelSeq+"</td>"
							+"<td><input type='button' id='btnAdminHistoryInfo' name='btnAdminHistoryInfo' value='관리이력' class='btn btn_basic' onclick='javascript:goAdminHistoryInfo("+i+");' alt='관리이력'/>"
							+"<td>"+obj.memo+"</td>"
							+"<td><input type='button' id='btnEqUpdate' name='btnEqUpdate' value='수정' class='btn btn_basic' onclick='javascript:eqUpdatePopup("+i+");' alt='수정'/>"
							+ "<input type='button' id='btnEqDelete' name='btnEqDelete' value='삭제' class='btn btn_basic' onclick='javascript:eqDel("+i+");' alt='삭제'/>"
							+"</td>";
						item +="</tr>";
						$("#eqDataList").append(item);
						$("#eqDataList tr:odd").attr("class","add"); 
					}
				}
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
				$("#eqDataList").html("<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//항목리스트
	function getItemList(vRow){
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var sysKind = objs.sysKind;
		
		//var sysType;
		// A=국가수질자동측정망
		// T=탁수모니터링
		// U=IP_USN
		// W=방류수질정보
		
		showLoading();
		
		$("#itemDataList").html("");
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getItemList.do'/>",
			data:{
					factCode:factCode,
					branchNo:branchNo,
					sysType:sysKind
				},
			dataType:"json",
			success:function(result){
				var tot = result['branchItemList'].length;
				var tot1 = result['getItemList'].length;
				itemList = result['getItemList'];
				$("#itemCnt").val(tot);
				if(tot<=0){
					$("#itemDataList").html("<tr><td colspan='9'> 조회 데이터가 없습니다. </td></tr>");
				}else{
					for(var i=0; i<tot; i++){
						var obj = result['branchItemList'][i];
						var pageInfo = result['paginationInfo'];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						var item;
						var itemFlag = false;
						for(var j=0; j<tot1; j++){
							var obj1 = result['branchItemList'][j];
							if(obj.itemCode == obj1.itemCode){
								itemFlag = true;
								var selected = "selected";
								var nullText = null;
								item = "<tr>"
									+ "<td>"+no+"<input type='hidden' id='itemCode"+i+"' name='itemCode"+i+"' value='"+obj.itemCode+"' /><input type='hidden' id='insertCheck"+i+"' name='insertCheck"+i+"' value='update' /></td>"
									+ "<td>"+obj.itemName+"</td>"
									+ "<td><input type='text' id='itemValueHi"+i+"' name='itemValueHi"+i+"' value='"+obj.itemValueHi+"' style='width:60px;' /></td>"
									+ "<td><input type='text' id='itemValueLo"+i+"' name='itemValueLo"+i+"' value='"+obj.itemValueLo+"' style='width:60px;' /></td>"
									+ "<td>";
								item+=obj.legYn=='Y'?"<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' checked='checked'/>":"<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' />";
								item+="</td>";
								item+="<td><input type='text' id='drySeasonFromMm"+i+"' name='drySeasonFromMm"+i+"' value='"+obj.drySeasonFromMm+"' style='width:60px;' /></td>"
								+ "<td><input type='text' id='drySeasonToMm"+i+"' name='drySeasonToMm"+i+"' value='"+obj.drySeasonToMm+"' style='width:60px;' /></td>"
								+ "<td><input type='text' id='itemDryValueHi"+i+"' name='itemDryValueHi"+i+"' value='"+obj.itemDryValueHi+"' style='width:60px;' /></td>"
								+ "<td><input type='text' id='itemDryValueLo"+i+"' name='itemDryValueLo"+i+"' value='"+obj.itemDryValueLo+"' style='width:60px;' /></td>";
								item+="<td>";
								item+=obj.drySeasonYn=='Y'?"<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' checked='checked'/>":"<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' />";
								item+="</td>";
								item+="<td>";
								item+=obj.userFlag=='Y'?"<input type='checkbox' id=AllSave"+i+" name='AllSave' value='"+i+"' checked='checked'/>":"<input type='checkbox' id='AllSave"+i+"' name='AllSave' value='"+i+"' />";
								item+="</td>";
								item+="</tr>";
							}
						}
						if(!itemFlag){
							item = "<tr>"
								+ "<td>"+no+"<input type='hidden' id='itemCode"+i+"' name='itemCode"+i+"' value='"+obj.itemCode+"' /><input type='hidden' id='insertCheck"+i+"' name='insertCheck"+i+"' value='insert' /></td>"
								+ "<td>"+obj.itemName+"</td>"
								+ "<td><input type='text' id='itemValueHi"+i+"' name='itemValueHi"+i+"' value='"+obj.itemValueHi+"' style='width:60px;' /></td>"
								+ "<td><input type='text' id='itemValueLo"+i+"' name='itemValueLo"+i+"' value='"+obj.itemValueLo+"' style='width:60px;' /></td>"
								+ "<td>";
							item+=obj.legYn=='Y'?"<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' checked='checked'/>":"<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' />";
							item+="</td>";
							item+="<td><input type='text' id='drySeasonFromMm"+i+"' name='drySeasonFromMm"+i+"' value='"+obj.drySeasonFromMm+"' style='width:60px;' /></td>"
								+"<td><input type='text' id='drySeasonToMm"+i+"' name='drySeasonToMm"+i+"' value='"+obj.drySeasonToMm+"' style='width:60px;' /></td>"
								+"<td><input type='text' id='itemDryValueHi"+i+"' name='itemDryValueHi"+i+"' value='"+obj.itemDryValueHi+"' style='width:60px;' /></td>"
								+"<td><input type='text' id='itemDryValueLo"+i+"' name='itemDryValueLo"+i+"' value='"+obj.itemDryValueLo+"' style='width:60px;' /></td>"
							item+="<td>";
							item+=obj.legYn=='Y'?"<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' checked='checked'/>":"<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' />";
							item+="</td>";
							item+="<td>";
							item+=obj.userFlag=='Y'?"<input type='checkbox' id=AllSave"+i+" name='AllSave' value='"+i+"' checked='checked'/>":"<input type='checkbox' id='AllSave"+i+"' name='AllSave' value='"+i+"' />";
							item+="</td>";
							item+="</tr>";
						}
						$("#itemDataList").append(item);
						$("#itemDataList tr:odd").attr("class","add");
					}
				}
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
				$("#dataList").html("<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	//탭에 따른 분기 화면 설정
	function EventDiv(index){
		$("#indexNum").val(index);
		//var sysKind = $("#st"+i).html();
		var div;
		for(var i=1; i<=4; i++){
			var a = $(".m"+i).attr("class");
			if(a.match(/tabs */)!=null){
				div=i;
				break;
			}
		}
		LayerDiv(div);
		
		getSpotView(index);
		getUsnList(index);
		getEqList(index);
		getItemList(index);
	}
	
	function LayerDiv(div){
		for(var j=1;j<=4; j++){
			var pop = document.getElementById("tpl_tab_"+j);
			if(div==j){
				pop.style.display = "block";
			}else{
				pop.style.display = "none";
			}
		}
		layerPopCloseAll();//DIV 전환시 레이어 닫기
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	//담당자 불러오기
	function memberDiv(){
		if($("#factCode").html()==""){
			alert("지점을 선택하여주세요.");
			return;
		}
		layerPopOpen("layerMember");
		var branchName=$("#memIdSearchTxt").val();
		$("#MemberList").html("");
		var searchText;
		if($("#memIdSearchTxt").val()!=""){
			searchText = branchName;
		}else{
			searchText = "";
		}
		showLoading();
		
		var factCode = $("#factCode").html();
		var branchNo = $("#branchNo").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getMemberList.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				searchText:searchText
			},
			dataType:"json",
			success:function(result){
				var tot = result['getMemberList'].length;
				var item;
				if(tot <= 0){
					item = "<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>"
					$("#MemberList").html(item);
				}else{
					for(var i=0; i<tot; i++)
					{
						obj = result['getMemberList'][i];
						item = "<tr>"
						+ "<td id=mi"+i+">"+obj.memberId+"</td><td>"+obj.memberName+"</td>"
// 						+ "<td><a href='javascript:memberInsert("+i+")' style='selector-dummy:expression(this.hideFocus=false);' class='btn_mng'><span><em>추가</em></span></a>&nbsp;</td>"
						+ "<td><input type='button' id='btnMemberInsert' name='btnMemberInsert' value='추가' class='btn btn_basic' onclick='javascript:memberInsert("+i+")' alt='추가'/></td>"
						+ "</tr>";
						
						$("#MemberList").append(item);
						$("#MemberList tr:odd").attr("class","add"); 
					}
				}
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
				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//담당자 등록하기
	function memberInsert(index){
		showLoading();
		
		var factCode = $("#factCode").html();
		var branchNo = $("#branchNo").val();
		var memberId = $("#mi"+index).html();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/branchmemberInsert.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				memberId:memberId
			},
			dataType:"json",
			success:function(result){
				$("#memList").html("");
				if($("#indexNum").val() !=""){
					EventDiv($("#indexNum").val());
				}
				memberDiv();
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
				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//담당자 삭제 쿼리
	function memDel(index){
		if(confirm("담당자를 삭제 하시겠습니까?")){
			showLoading();
			var factCode = $("#Dfc"+index).val();
			var branchNo = $("#Dbn"+index).val();
			var memberSeq = $("#Dms"+index).val();
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/branchmemberdel.do'/>",
				data:{
					factCode:factCode,
					branchNo:branchNo,
					memberSeq:memberSeq
				},
				dataType:"json",
				success:function(result){
					$("#memList").html("");
					if($("#indexNum").val() !=""){
						EventDiv($("#indexNum").val());
					}
					memberDiv();
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
					$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}
	
	// 측정일정추가 팝업
	function usnInsertPopup() {
		window.open("<c:url value='/spotmanage/usninsertform.do'/>",
				'usnInsertPopup','width=600,height=390,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	// 측정장비추가 팝업
	function eqInsertPopup() {
		window.open("<c:url value='/spotmanage/eqinsertform.do'/>",
				'eqInsertPopup','width=600,height=450,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	//수정 화면 팝업 요청
	function usnUpdatePopup(index) {
		window.open("<c:url value='/spotmanage/usnupdateform.do'/>", 
				'usnUpdatePopup','width=600,height=390,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	//측정장비 수정 화면 팝업 요청
	function eqUpdatePopup(index) {
		$("#UpdateSeq").val($("#es"+index).val());
		
		window.open("<c:url value='/spotmanage/equpdateform.do'/>", 
				'usnUpdatePopup','width=600,height=450,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	//usn 데이터 삭제 처리 (Update-User_flag='N')
	function usnDel(index){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		var itemseq = $("#is"+index).val();
		
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/usndel.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				itemseq:itemseq
			},
			dataType:"json",
			success:function(result){
				var obj = result['result'];
				if(obj=="1"){
					$("#memList").html("");
					if($("#indexNum").val() !=""){
						EventDiv($("#indexNum").val());
					}
				}
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
				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//설치장비 데이터 삭제 처리 (Update-User_flag='N')
	function eqDel(index){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
		var eqSeq = $("#es"+index).val();
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/eqDel.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				eqSeq:eqSeq
			},
			dataType:"json",
			success:function(result){
				var obj = result['result'];
				if(obj=="1"){
					$("#memList").html("");
					if($("#indexNum").val() !=""){
						EventDiv($("#indexNum").val());
					}
				}
				
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
				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	function fileDown(index){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
// 		var itemseq = $("#is"+index).val();
		
		$("#UpdateSeq").val($("#is"+index).val());
		document.all.downFrame.src="<c:url value='/spotmanage/fileDownform.do'/>";
	}
	
	function goAdminHistoryInfo(index){
		var pop = document.getElementById("layerAdminHistory");
		pop.style.display = "block";
		pop.style.top = "50%";
		pop.style.left = "50%";
		
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
		var eqSeq = $("#es"+index).val();
		$("#index").val(index);
		$("#UpdateSeq").val(eqSeq);
		
		showLoading();
		
		var item;
		$("#AdminHistoryInfo").html("");
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getAdminHistoryList.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				eqSeq:eqSeq
			},
			dataType:"json",
			success:function(result){
				var tot = result['getAdminHistoryList'].length;
				
				if(tot <= 0){
					item = "<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>"
					$("#AdminHistoryInfo").html(item);
				}else{
					for(var i=0; i<tot; i++)
					{
						obj = result['getAdminHistoryList'][i];
						item = "<tr><a href='javascript:goAHView("+i+","+obj.hsSeq+")'>";
						item += "<td>"+obj.crtDate+"</td>";
						if(obj.content.length>10){
							item +="<td>"+obj.content.substring(0,10)+"....</td>";
						}else{
							item += "<td>"+obj.content+"</td>";
						}
						item += "<td><div style='position:absolute;display:none;border:1px solid #ccc;padding:10px;background:White;'><textarea id=AHistory"+i+">"+obj.content+" </textarea></div></td>";
						item += "</a></tr>";
						$("#AdminHistoryInfo").append(item);
						$("#AdminHistoryInfo tr:odd").attr("class","add"); 
					}
				}
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
				$("#AdminHistoryInfo").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	function adminHistoryInsert(){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
		var eqSeq = $("#UpdateSeq").val();
		var content = $("#ahCoutent").val();
		
		if(content!=""){
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/adminHistoryInsert.do'/>",
				data:{
					factCode:factCode,
					branchNo:branchNo,
					eqSeq:eqSeq,
					content:content
				},
				dataType:"json",
				success:function(result){
					$("#AdminHistoryInfo").html("");
					$("#ahCoutent").val("");
					goAdminHistoryInfo($("#index").val());
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
					$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}else{
			alert("관리이력을 입력해주세요.");
			$("#ahCoutent").foucs();
		}
	}
	
	function goAHView(index,hsSeq){
		$("#hsSeq").val(hsSeq);
		$("#hsView").val($("#AHistory"+index).val());
		var pop = document.getElementById("layerUpdateDel");
		pop.style.display = "block";
		pop.style.top = "50%";
		pop.style.left = "50%";
	}
	
	function adminHistoryUpdate(){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
		var eqSeq = $("#UpdateSeq").val();
		var hsSeq = $("#hsSeq").val();
		var content = $("#hsView").val();
		
		if(content!=""){
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/adminHistoryUpdate.do'/>",
				data:{
					factCode:factCode,
					branchNo:branchNo,
					eqSeq:eqSeq,
					hsSeq:hsSeq,
					content:content
				},
				dataType:"json",
				success:function(result){
					goAdminHistoryInfo($("#index").val());
					layerPopClose('layerUpdateDel');
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
					$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}else{
			alert("관리이력을 입력해주세요.");
			$("#hsView").foucs();
		}
	}
	function adminHistoryDel(){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
		var eqSeq = $("#UpdateSeq").val();
		var hsSeq = $("#hsSeq").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/adminHistorydel.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				eqSeq:eqSeq,
				hsSeq:hsSeq
			},
			dataType:"json",
			success:function(result){
				layerPopClose('layerUpdateDel');
				goAdminHistoryInfo($("#index").val());
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
				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//측정소신규등록 팝업창
	function spotManageInsertPop() {
		window.open("<c:url value='/spotmanage/spotManageInsertPop.do'/>",
				'spotManageInsertPop','width=550,height=410,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	//측정소수정 팝업창
	function spotManageUpdatePop() {
		window.open("<c:url value='/spotmanage/spotManageUpdatePop.do'/>", 
				'spotManageUpdatePop','width=550,height=410,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
// 	function SingleSave(index){
// 		var vRow = $("#indexNum").val();
// 		var objs = dataView.getItem(vRow);
// 		var factCode = objs.factCode;
// 		var branchNo = objs.branchNo;

// 		var itemCode = $("#itemCode"+index).val();
// 		var itemValueHi = $("#itemValueHi"+index).val();
// 		var itemValueLo = $("#itemValueLo"+index).val();
// 		var legYn = $("#legYn"+index).attr("checked")?"Y":"N";
// 		var AllSave;
		
// 		if($("#AllSave"+index).attr("checked")){
// 			AllSave = 'Y';
// 		}else{
// 			AllSave = 'N';
// 		}
// 		$.ajax({
// 			type:"post",
// 			url:"<c:url value='/spotmanage/SingleSave.do'/>",
// 			data:{
// 				factCode:factCode
// 				,branchNo:branchNo
// 				,itemCode:itemCode
// 				,itemValueHi:itemValueHi
// 				,itemValueLo:itemValueLo
// 				,legYn:legYn
// 				,allSave:AllSave
// 			},
// 			dataType:"json",
// 			success:function(result){
// 				EventDiv($("#indexNum").val());
// 				closeLoading();
// 			},
// 			error:function(result){
// 				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
// 				var oraErrorCode = "";
// 				if (result.responseText != null ) {
// 					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
// 					if (matchedValue != null && matchedValue.length > 0) { 
// 						oraErrorCode = matchedValue[0].replace('ORA-', '');	
// 					}
// 				}
// 				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
// 				closeLoading();
// 			}
// 		});
// 	}
	
	//4탭 항목관리의 저장
	function MultiSave(){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		
		if($("input[name=AllSave]").length>0){
			for(var i=0;i<$("input[name=AllSave]").length;i++){
				var data = $("input[name=AllSave]")[i];
				var itemCode = $("#itemCode"+data.value).val();
				var legYn = $("#legYn"+i).attr("checked")?"Y":"N";
				var itemValueHi = $("#itemValueHi"+i).val();
				var itemValueLo = $("#itemValueLo"+i).val();
				var drySeasonYn = $("#drySeasonYn"+i).attr("checked")?"Y":"N";
				var drySeasonFromMm = $("#drySeasonFromMm"+i).val();
				var drySeasonToMm = $("#drySeasonToMm"+i).val();
				var itemDryValueHi = $("#itemDryValueHi"+i).val();
				var itemDryValueLo = $("#itemDryValueLo"+i).val();
				var AllSave;
				var insertCheck = $("#insertCheck"+i).val();
				
				if(data.checked){
					AllSave = "Y";
				}else{
					AllSave = "N";
				}
				
				var Multi;
				Multi = insertCheck;
				
				$.ajax({
					type:"post",
					url:"<c:url value='/spotmanage/goMultiSave.do'/>",
					data:{
						 factCode:factCode
						,branchNo:branchNo
						,itemCode:itemCode
						,itemValueHi:itemValueHi
						,itemValueLo:itemValueLo
						,legYn:legYn
						,drySeasonFromMm:drySeasonFromMm
						,drySeasonToMm:drySeasonToMm
						,itemDryValueHi:itemDryValueHi
						,itemDryValueLo:itemDryValueLo
						,drySeasonYn:drySeasonYn
						,allSave:AllSave
						,userFlag:Multi
					},
					dataType:"json",
					success:function(result){
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
						$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
			}
			EventDiv($("#indexNum").val());
		}
	}
	
	//지점 등록 기능
	function saveBranchReg(){
		var factCode = $("#branchRegForm [name=fact_code]").val();
		var factName = $("#branchRegForm [name=fact_name]").val();
		var riverDiv = $("#branchRegForm [name=river_div]").val();
		var sysKind = $("#branchRegForm [name=sys_kind]").val();
		var factIp = $("#branchRegForm [name=fact_ip]").val();
		
		if(factCode == null || factCode == ""){
			alert("지점 코드를 넣어주세요.");
			return;
		}
		//alert("branchRegForm");
		if(factName == null || factName == ""){
			alert("지점이름을 넣어주세요.");
			return;
		}
		
		if(riverDiv == null || riverDiv == ""){
			alert("수계를 선택해주세요.");
			return;
		}
		
		if(sysKind == null || sysKind == ""){
			alert("시스템을선택해주세요.");
			return;
		}
		
		if(factIp == null || factIp == ""){
			alert("아이피를 넣어주세요.");
			return;
		}
		
		$('#branchRegForm').ajaxForm({
			success:function(result){
				alert("저장했습니다");
				//getSystemList();
				layerPopCloseAll();
			}
		}).submit();
	}
	
	function excelDown() {
		var riverDiv = $("select[name=c_river_div]").val();	
		var sysKind = $("select[name=c_sys_kind]").val();
		var branchName=$("#c_branch_name").val();
		var searchText;
		
		if($("#c_branch_name").val()!=""){
			searchText = branchName;
		}else{
			searchText = "";
		}
		var param = "sysKind="+sysKind + "&riverDiv=" + riverDiv + "& searchText=" + searchText;
		location.href="<c:url value='/spotmanage/getExcelSpotmgrList.do'/>?"+param;
	}
	
	function popupMapOpen(){
		var longitude = $("#rlongitude").val();
		var latitude = $("#rlatitude").val();
		
		if (longitude == "" || latitude == ""){
			alert("지점을 선택하신 후  지도보기를 해주세요.");
			return;
		}
		
		window.open("/psupport/WPCS_POP.html?riverid=" + user_riverid + "&menuid=spot&longitude=" + longitude + "&latitude=" + latitude,
				'wpcsView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerMember");
		layerPopClose("layerUpdateDel");
		layerPopClose("layerBranchReg");
		layerPopClose("layerAdminHistory");
		layerPopClose("layerBranchModify")
		layerPopClose("factinfoLayer")
		layerPopClose("memberLayer")
	}
	
	function LayerPopEditOpen(flag) {
		
		if (flag == "reg") {
			// 등록을 위한 레이어에 초기화
			$("#sys_kind").val("");
			$("#fact_code").val("");
			$("#river_div").val("");
			$("#river_no").val("");
			$("#fact_name").val("");
			$("#branch_no").val("");
			$("#branch_name").val("");
			$("#fact_addr").val("");
			$("#longitude1").val("")
			$("#latitude1").val("");
			$("#branch_mgr").val("");
			$("#branch_mgr_name").val("");
			$("#branch_mgr_tel_no").val("");
			
			$("#btnBranchRegMod").attr({ value: "등록", alt: "등록" });
			$("#branch_use_flag > option:first").attr("selected", "true");
			$("#fact_name").attr("disabled",false);
			$("#btnFactSearch").attr("disabled",false);
		} else {
			
			if($("#indexNum").val() == ""){
				alert("지점을 선택 하신 후 수정하여 주십시오.");
				return;
			}else{
				var vRow = $("#indexNum").val();
				var obj = dataView.getItem(vRow);
				
				getFactbranchInfoAdd(obj.factCode, obj.branchNo);
			}
			$("#btnBranchRegMod").attr({ value: "수정", alt: "수정" });
			$("#fact_name").attr("disabled",true);
			$("#btnFactSearch").attr("disabled",true);
		}
		$("#mode").val(flag);
		layerPopOpen("layerBranchModify");
	}
	
	//지점코드로 측정소에 대한 정보 가져오기
	function getFactbranchInfoAdd(factCode, branchNo){
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getFactbranchInfoAdd.do'/>",
			data:{
				fact_code:factCode
				,branch_no:branchNo
			},
			dataType:"json",
			success:function(result){
				console.log("getFactbranchInfoAdd result : ",result);
				var tot = result['getFactbranchInfoAdd'].length;
				
				if( tot <= 0 ){
					alert("조회 결과가 없습니다.");
				}else{
					var obj = result['getFactbranchInfoAdd'][0];
					
					$("#sys_kind").val(obj.sys_kind);
					$("#fact_code").val(obj.fact_code);
					$("#fact_name").val(obj.fact_name);
					$("#river_div").val(obj.river_div);
					$("#river_no").val(obj.river_no);
					$("#branch_no").val(obj.branch_no);
					$("#branch_name").val(obj.branch_name);
					$("#fact_addr").val(obj.fact_addr);
					$("#latitude1").val(obj.latitude);
					$("#longitude1").val(obj.longitude);
					$("#branch_mgr").val(obj.branch_mgr);
					$("#branch_mgr_name").val(obj.branch_mgr_name);
					$("#branch_mgr_tel_no").val(obj.branch_mgr_tel_no);
					
					if (obj.branch_use_flag == "Y")
						$("#branch_use_flag > option:first").attr("selected", "true");
					else
						$("#branch_use_flag > option:last").attr("selected", "true");
				}
				closeLoading();
			},
			error:function(result){
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) { 
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}
	
	function validateItem(){
		
		if($('#fact_name').val().length == 0){
			alert("사업장을 선택해 주세요");
			return false;
		}
		
		if($('#branch_name').val().length < 2){
			alert("측정소명을 넣어주세요(2자리이상)");
			return false;
		}
		
		if($("#latitude1").val().length == 0){
			alert('좌표를 선택해 주세요');
			return false;
		}
		
		if($("#branch_mgr_name").val().length == 0 || $("#branch_mgr_tel_no").val().length == 0){
			alert("관리자를 선택해주세요");
			return false;
		}
		
	//		if($("#leave_distance").val().length == 0){
	//			if (!confirm("유효거리를 설정하지 않았습니다.\n계속하시려면'예' 아니시면 아니오를 누르세요.")){
	//				return false;
	//			}
	//		}
		return true;
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	//등록,수정
	function updateFactBranch(){
		var vRow = $("#indexNum").val();
		var objs = dataView.getItem(vRow);
		var factCode = $("#fact_code").val();
		var sysKind = $("#sys_kind").val();
		var mode = $("#mode").val();
		var pageNo = $("#rpage").val();	//측정소 수정을 위한 페이지 확인
		var branchUseFlag = $("#branch_use_flag").val();
		var modeName = "수정";
		
		if(mode == "reg"){
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/getMaxBranchNo.do'/>",
				data:{
						factCode:factCode
					},
				dataType:"json",
				success:function(result){
					console.log("BranchNo : ", result);
					
					$("#branch_no").val(result.branchNo);
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
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				}
			});
			modeName = "등록";
		}
		
		if(validateItem() == true){
			
			if (sysKind == "A" || sysKind == "U"){
				
				var date = new Date();
				date = date.getFullYear() + addzero(date.getMonth()+1) + addzero(date.getDate());
				
				var obj = {};
				
				obj.BRANCH_NO = $("#branch_no").val();
				obj.DATE_= date;
				obj.FACI_ADDR = $("#fact_addr").val();
				obj.FACI_NM = $("#fact_name").val() + "("+ $("#branch_name").val() + ")";
				obj.FACT_CODE = $("#fact_code").val();
				obj.RV_CD = $("#river_div").val();
				obj.X = $("#latitude1").val();
				obj.Y = $("#longitude1").val();
				obj.USE_FLAG = $("#branch_use_flag").val();
				console.log("esri 등록정보 : ",obj);
				
				$editMap.model.addMemtPoint(sysKind, obj , function(result){
//	 				console.log('[저장]editMap.result', result);
					
					if(result.callbacktype == 'S' || result.callbacktype == 'R'){
//	 					console.log('[저장]', result.callbacktype);
						
						$('#factBranchForm').ajaxForm({
							success:function(result){
								alert(modeName + " 하였습니다.");
								layerPopClose("layerBranchModify");
								reloadData(pageNo);
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
								alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
							}
						}).submit();
					}else{
						alert("서버 접속에 실패하였습니다.");
					}
				})
			}else{
				$('#factBranchForm').ajaxForm({
					success:function(result){
						alert(modeName + " 하였습니다.");
						layerPopClose("layerBranchModify");
						reloadData(pageNo);
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
						alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
					}
				}).submit();
			}
		}
	}
	
	//사업장 정보를 가져오기
	function getFactinfoList(pageNo){
		//사업장정보
		dataView1 = new Slick.Data.DataView();
		
		var columns1 = [
						{ id: "no", name: "NO", field: "no", width: 45, sortable: false, cssClass: "slick-pointer" },
						{ id: "fact_code", name: "사업장코드", field: "fact_code", width: 200, sortable: false, cssClass: "slick-pointer" },
						{ id: "fact_name", name: "사업장명", field: "fact_name", width: 255, sortable: false, cssClass: "slick-pointer" }
					];
		
		grid1 = new Slick.Grid("#dataList1", dataView1, columns1, options);
		grid1.setSelectionModel(new Slick.RowSelectionModel());
		
		grid1.onSelectedRowsChanged.subscribe(function() {
			grid1.resetActiveCell();
			var obj = grid1.getDataItem(grid1.getSelectedRows());
			setFactinfoCode(obj);
		});
		
		dataView1.onRowCountChanged.subscribe(function (e, args) {
			grid1.updateRowCount();
			grid1.render();
		});
		
		grid1.onSort.subscribe(function (e, args) {
			var cols = args.sortCols;
			
			dataView1.sort(function (dataRow1, dataRow2) {
				for (var i = 0, l = cols.length; i < l; i++) {
					var field = cols[i].sortCol.field;
					var sign = cols[i].sortAsc ? 1 : -1;
					var value1 = dataRow1[field], value2 = dataRow2[field];
					var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
					if (result != 0) {
						return result;
					}
				}
				return 0;
			});
			grid1.invalidate();
			grid1.render();
		});
		
		if (pageNo == null) pageNo = 1;
		var searchKeyword = $("#searchKeyword").val();
		
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getFactinfoList.do'/>",
			data:{
					pageIndex:pageNo,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success:function(result){
				console.log("getFactinfoList : ", result);
				var tot = result['factinfoList'].length;
				
				dataView1.setItems([]);
				layerPopOpen("factinfoLayer");
				
				var height = sGridCmn(1,result['factinfoList'],10);
				$("#dataList1").css("height", height + "px");
				grid1.resizeCanvas();
				
				var data = [];
				
				if( tot <= 0 ){
					dataView1.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					data.push({no:"조회 결과가 없습니다."});
					dataView1.setItems(data, 'no');
					
					var height = sGridCmn(1,data,1);
					$("#dataList1").css("height", height + "px");
					grid1.resizeCanvas();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['factinfoList'][i];
						var pageInfo = result['paginationInfo'];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
						
						data.push(obj);
					}
					dataView1.beginUpdate();
					dataView1.setItems(data, 'no');
					dataView1.endUpdate();
				}
				// 페이징 정보
// 				var pageStr = makePaginationInfo(result['paginationInfo']);
// 				$("#pagination").empty();
// 				$("#pagination").append(pageStr);
				
// 				$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
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
				dataView1.getItemMetadata = function () {
					return {"columns":{0:{"colspan":"*"}}};
				}
				var data = [];
				data.push({no:"서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]"});
				dataView1.setItems(data, 'no');
				
				var height = sGridCmn(1,data,1);
				$("#dataList1").css("height", height + "px");
				grid1.resizeCanvas();
				
				closeLoading();
			}
		});
	}
	
// 	// 페이지 번호 클릭
// 	function linkPage(pageNo){
// 		getFactinfoList(pageNo);
// 	}
	//사업장정보에서 선택한 코드를 텍스트박스에 입력
	function setFactinfoCode(obj){
		$("#fact_code").val(obj.fact_code);
		$("#fact_name").val(obj.fact_name);
		$("#river_div").val(obj.river_div);
		$("#river_no").val(obj.river_no);
		$("#sys_kind").val(obj.sys_kind);
// 		$("#branch_no").val(obj.branch_cnt);
		
		layerPopOpen("layerBranchModify");
	}
	
	//좌표 지정 팝업
	function lon_lat(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$('#latitude1').val(lat);
		$('#longitude1').val(lon);
		$("#fact_addr").val(addr.replace('대한민국 ',''));
	}
	
	//관리자 검색  (정)
	function onSearch_member(){
		dataView2 = new Slick.Data.DataView();
		
		var columns2 = [
						{ id: "no", name: "NO", field: "no", width: 45, sortable: false, cssClass: "slick-pointer" },
						{ id: "deptName", name: "부서", field: "deptName", width: 185, sortable: false, cssClass: "slick-pointer" },
						{ id: "gradeName", name: "직급", field: "gradeName", width: 150, sortable: false, cssClass: "slick-pointer" },
						{ id: "memberName", name: "성명", field: "memberName", width: 120, sortable: false, cssClass: "slick-pointer" }
					];
		
		grid2 = new Slick.Grid("#dataList2", dataView2, columns2, options);
		grid2.setSelectionModel(new Slick.RowSelectionModel());
		
		grid2.onSelectedRowsChanged.subscribe(function() {
			grid2.resetActiveCell();
			var obj = grid2.getDataItem(grid2.getSelectedRows());
			onSelMember(obj);
		});
		
		dataView2.onRowCountChanged.subscribe(function (e, args) {
			grid2.updateRowCount();
			grid2.render();
		});
		
		grid2.onSort.subscribe(function (e, args) {
			var cols = args.sortCols;
			
			dataView2.sort(function (dataRow1, dataRow2) {
				for (var i = 0, l = cols.length; i < l; i++) {
					var field = cols[i].sortCol.field;
					var sign = cols[i].sortAsc ? 1 : -1;
					var value1 = dataRow1[field], value2 = dataRow2[field];
					var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
					if (result != 0) {
						return result;
					}
				}
				return 0;
			});
			grid2.invalidate();
			grid2.render();
		});
		
		var searchKey = $('#branch_mgr_name').val();
		
		if(searchKey.length < 2)
			alert("2자리 이상 검색 가능합니다.");
		else{
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/getSearchMember.do'/>",
				data : {
					searchKeyword:searchKey,
					searchCondition:'name'
				},
				dataType : "json",
				success : function(result) {
					console.log("getSearchMember : ", result);
					var tot = result['list'].length;
					
					dataView2.setItems([]);
					layerPopOpen("memberLayer");
					
					var height = sGridCmn(1,result['list'],10);
					$("#dataList2").css("height", height + "px");
					grid2.resizeCanvas();
					
					var data = [];
					
					if( tot <= 0 ){
						dataView2.getItemMetadata = function () {
							return {"columns":{0:{"colspan":"*"}}};
						}
						data.push({no:"조회 결과가 없습니다."});
						dataView2.setItems(data, 'no');
						
						var height = sGridCmn(1,data,1);
						$("#dataList2").css("height", height + "px");
						grid2.resizeCanvas();
					}else{
						for(var i=0; i < tot; i++){
							var obj = result['list'][i];
							
							obj.no = i+1;
							
							data.push(obj);
						}
						dataView2.beginUpdate();
						dataView2.setItems(data, 'no');
						dataView2.endUpdate();
					}
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
					dataView2.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					var data = [];
					data.push({no:"서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]"});
					dataView2.setItems(data, 'no');
					
					var height = sGridCmn(1,data,1);
					$("#dataList2").css("height", height + "px");
					grid2.resizeCanvas();
					
					closeLoading();
				}
			});
		}
	}
	
	function onSelMember(obj){
		$('#branch_mgr_name').val(obj.memberName);
		$('#branch_mgr_tel_no').val(obj.mobileNo);
		$('#branch_mgr').val(obj.memberId);
		
		layerPopOpen("layerBranchModify");
	}
//]]>
</script>
</head>

<body>
	<iframe id="downFrame" id="downFrame" width="0" height="0" frameborder="0"></iframe>
	
	<input type="hidden" id="indexNum" name="indexNum" />
	<input type="hidden" id="index" name="index" />
	<input type="hidden" id="UpdateSeq" name="UpdateSeq" />
	<input type="hidden" id="itemCnt" name="itemCnt" />
	
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
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
					
					<div class="searchBox dataSearch">
						<ul>
							<li>
								<span class="fieldName">수계</span>
								<select name="c_river_div">
									<option value="ALL">전체</option>
									<option value="R01">한강</option>
									<option value="R02">낙동강</option>
									<option value="R03">금강</option>
									<option value="R04">영산강</option>
								</select>
							</li>
							<li>
								<span class="fieldName">시스템</span>
								<select name="c_sys_kind">
									<option value="U">이동형측정기기</option>
<!-- 									<option value="T">탁수모니터링</option> -->
									<option value="A">국가수질자동측정망</option>
									<option value="W">방류수질정보</option>
								</select>
							</li>
							<li>
								<span class="fieldName">명칭</span>
								<input type="text" id="c_branch_name" name="c_branch_name" style="width:130px;" onkeydown="javascript:if(event.keyCode == 13)reloadData();"/>
							</li>
						</ul>
					</div>
					<div class="btnSearchDiv">
						<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
					</div>

					<!--top Search Start-->
					<div id="btArea">
						<input type="button" id="btnExcel" name="btnExcel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
<!-- 						<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:updateLoadData();" alt="저장"/> -->
						<input type="button" id="btnRegist" name="btnRegist" value="지점등록" class="btn btn_basic" onclick="javascript:layerPopOpen('layerBranchReg');" alt="지점등록"/>
						<input type="button" id="btnSpotManageInsert" name="btnSpotManageInsert" value="측정소등록" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('reg');" alt="측정소등록"/>
<!-- 						<input type="button" id="btnSpotManageInsert" name="btnSpotManageInsert" value="측정소등록" class="btn btn_basicM" onclick="javascript:spotManageInsertPop();" alt="측정소등록"/> -->
						<input type="button" id="btnSpotManageUpdate" name="btnSpotManageUpdate" value="측정소수정" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('mod');" alt="측정소수정"/>
						<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basic" onclick="javascript:popupMapOpen()" alt="지도보기" />
					</div>
					<!--top Search End-->
					
					<input type="hidden" id="rlongitude" name="rlongitude" />
					<input type="hidden" id="rlatitude" name="rlatitude" />
					<input type="hidden" id="rpage" name="rpage" />
					
					<!--tab Contnet Start-->
					<div class="table_wrapper">
						<div id="dataList" class="dataList"></div>
						<div class="paging">
							<div id="page_number">
								<ul class="paginate" id="pagination"></ul>
							</div>
						</div>
					</div>
					
					<!--tab menu Start-->
					<ul class="tabs m1">
						<li class="m1 on"><a href="javascript:LayerDiv(1);"><span>기본정보</span></a></li>
						<li class="li_space"></li>
						<li class="m2"><a href="javascript:LayerDiv(2);"><span>USN관리</span></a></li>
						<li class="li_space"></li>
						<li class="m3"><a href="javascript:LayerDiv(3);"><span>설치장비</span></a></li>
						<li class="li_space"></li>
						<li class="m4"><a href="javascript:LayerDiv(4);"><span>항목관리</span></a></li>
					</ul>
					<!--tab menu End-->
					
					<!-- tab1 -->
					<div id="tpl_tab_1">
						
						<fieldset class="second">
						<legend class="hidden_phrase">지점관리 상세 정보(기본정보, USN관리, 설치장비, 항목관리)</legend>
						
						<div class="divisionBx" >
							<div class="div50">
								<div class="table_wrapper">
								
									<table id="tab_1_1" summary="기본정보">
										<caption>기본정보</caption>
										<colgroup>
											<col width="120px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<th>지점코드</th>
												<td><span id="factCode"></span><input type="hidden" id="branchNo"/></td>
											</tr>
											<tr>
												<th>관리주체</th>
												<td><span id="mgrOrg"></span></td>
											</tr>
											<tr>
												<th>운영기관</th>
												<td><span id="operOrg"></span></td>
											</tr>
											<tr>
												<th>수계</th>
												<td><span id="riverName"></span></td>
											</tr>
											<tr>
												<th>권역</th>
												<td><span id="areaName"></span></td>
											</tr>
											<tr>
												<th>시도</th>
												<td><span id="sido"></span></td>
											</tr>
											<tr>
												<th>시군구</th>
												<td><span id="gugun"></span></td>
											</tr>
											<tr>
												<th rowspan="2">주소</th>
												<td><span id="dong"></span></td>
											</tr>
											<tr>
												<td><span id="factAddr"></span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="div50 last">
								<div class="table_wrapper">
									<table id="tab_1_2" summary="시스템정보">
										<caption>시스템정보</caption>
										<colgroup>
											<col width="120px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<th>시스템</th>
												<td><span id="riverDivName"></span></td>
											</tr>
											<tr>
												<th rowspan="3" height="50px;">담당자</th>
												<td rowspan="3">
<!--													<input type="button" id="btnSave" name="btnSave" value="등록/변경" class="btn btn_basic" onclick="javascript:memberDiv();"/> -->
													<div align="right" style="margin-right:10px;margin-top:5px;margin-bottom:5px;">
														<input type="button" id="btnMemberDive" name="btnMemberDive" value="등록/변경" class="btn btn_basic" onclick="javascript:memberDiv();" alt="등록/변경"/>
													</div>
													<div style="border:1px solid #CCC !important; overflow:auto; width:95%; height: 50px;" align="center">
														<ul>
															<li id="memList"></li>
														</ul>
													</div>
												</td>
											</tr>
											<tr>
											</tr>
											<tr>
											</tr>
											<tr>
												<th rowspan="3" height="50px;">측정항목</th>
												<td rowspan="3">
												<div style="border:1px solid #CCC !important; overflow:auto; width:95%; height: 70px; " align="center">
													<ul>
														<li id="sysList"></li>
													</ul>
												</div>
												</td>
											</tr>
											<tr>
											</tr>
											<tr>
											</tr>
												<tr>
												<th>X 좌표</th>
												<td><span id="longitude"></span></td>
											</tr>
											<tr>
												<th>Y 좌표</th>
												<td><span id="latitude"></span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						</fieldset>
					</div>
					<!-- //tab1 -->
					
					<!-- tab2 -->
					<!--top Search Start-->
					<div id="tpl_tab_2">
						<div class="topBx">
							<span>USN 이력 관리</span>
							<span id="usnBranchName"></span>
							<input type="button" id="btnUsnInsert" name="btnUsnInsert" value="측정일정추가" class="btn btn_basic" onclick="javascript:usnInsertPopup();" alt="측정일정추가"/>
						</div>
						<!--top Search End-->
						
						<div class="table_wrapper">
						
							<table id="tab_1_1" summary="usn정보">
								<colgroup>
									<col width="7%" />
									<col />
									<col width="8%" />
									<col width="8%" />
									<col width="8%" />
									<col width="8%" />
									<col width="20%" />
									<col width="10%" />
									<col width="17%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">연번</th>
										<th scope="col">지점명</th>
										<th scope="col">시작일</th>
										<th scope="col">종료일</th>
										<th scope="col">X좌표</th>
										<th scope="col">Y좌표</th>
										<th scope="col">설치근거</th>
										<th scope="col">비고</th>
										<th scope="col">-</th>
									</tr>
								</thead>
								<tbody id="usnDataList">
									<tr>
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //tab2 -->
					
					<!-- tab3-->
					<div id="tpl_tab_3">
						<div class="topBx">
							<span>측정장비관리</span>
							<span id="eqItemName"></span>
							<input type="button" id="btnEqInsert" name="btnEqInsert" value="측정장비추가" class="btn btn_basic" onclick="javascript:eqInsertPopup();" alt="측정장비추가"/>
						</div>
						<!--top Search End-->
						
						<div class="table_wrapper">
						
							<table id="tab_1_1" summary="측정장비정보">
								<colgroup>
									<col width="7%" />
									<col />
									<col />
									<col width="7%" />
									<col width="7%" />
									<col width="7%" />
									<col width="7%" />
									<col width="7%" />
									<col width="17%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">연번</th>
										<th scope="col">장비명</th>
										<th scope="col">항목명</th>
										<th scope="col">도입일</th>
										<th scope="col">제조사</th>
										<th scope="col">모델명</th>
										<th scope="col">관리이력</th>
										<th scope="col">비고</th>
										<th scope="col">-</th>
									</tr>
								</thead>
								<tbody id="eqDataList">
									<tr>
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //tab3 -->
					
					<!-- tab4-->
					<div id="tpl_tab_4">
						<div class="topBx">
							<span>측정항목관리</span>
							<span id="itemName"></span>
							<input type="button" id="btnMultiSave" name="btnMultiSave" value="저장" class="btn btn_basic" onclick="javascript:MultiSave();" alt="저장"/>
						</div>
						<!--top Search End-->
						
						<div class="table_wrapper">
						
							<form id="itemForm" name="itemForm">
							<table id="tab_1_1" summary="측정장비정보">
								<colgroup>
									<col width="45px" />
									<col width="200px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
									<col width="80px" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">연번</th>
										<th scope="col">항목명</th>
										<th scope="col">경보기준<br/>상한값</th>
										<th scope="col">경보기준<br/>하한값</th>
										<th scope="col">경보<br/>적용여부</th>
										<th scope="col">갈수기<br/>시작월</th>
										<th scope="col">갈수기<br/>종료월</th>
										<th scope="col">갈수기<br/>상한값</th>
										<th scope="col">갈수기<br/>하한값</th>
										<th scope="col">갈수기여부</th>
										<th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="itemDataList">
									<tr>
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
							</form>
						</div>
					</div>
					<!-- //tab4 -->
					
				</div>
				<!--tab Contnet End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
		
	</div>
		
	<!-- 레이어 팝업(layerMember) div start -->
	<div id="layerMember" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnMemXbox" name="btnMemXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerMember');" alt="닫기"/>
		</div>
		<div class="fixed-table-container-inner" style="height:200px">
			<table summary="사용자정보">
				<caption>사용자정보</caption>
				<colgroup>
					<col width="100px" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">선택</th>
					</tr>
				</thead>
				<tbody id="MemberList"></tbody>
			</table>
		</div>
		<div id="btCarea">
			<input type="text" id="memIdSearchTxt" name="memIdSearchTxt" style="width:100px;" onkeydown="javascript: if(event.keyCode == 13) {memberDiv();}" title="검색"/>
			<input type="button" id="btnMemberSearch" name="btnMemberSearch" value="검색" class="btn btn_search" onclick="javascript:memberDiv();" alt="검색"/>
		</div>
	</div>
	<!-- 레이어 팝업(layerMember) div end -->
	<!-- 레이어 팝업(layerAddr) div start -->
	<div id='layerAddr' class="divPopup">
	
	</div>
	<!-- 레이어 팝업(layerAddr) div end -->
	
	<div id="layerBranchReg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnBranRegXbox" name="btnBranRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerBranchReg');" alt="닫기"/>
		</div>
		<form id="branchRegForm" name="branchRegForm" action="/spotmanage/saveBranchReg.do" method="post">
		
			<table summary="지점정보">
				<caption>지점정보</caption>
				<colgroup>
					<col width="120px" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>지점 코드</th>
						<td><input type="text" name="fact_code" maxlength="7" /></td>
					</tr>
					<tr>
						<th>지점이름</th>
						<td><input type="text" name="fact_name" maxlength="10" /></td>
					</tr>
					<tr>
						<th>수계</th>
						<td>
							<select name="river_div">
								<option value="ALL">전체</option>
								<option value="R01">한강</option>
								<option value="R02">낙동강</option>
								<option value="R03">금강</option>
								<option value="R04">영산강</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>시스템</th>
						<td>
							<select name="sys_kind">
								<option value="ALL">전체</option>
								<option value="U">이동형측정기기</option>
								<option value="A">국가수질자동측정망</option>
								<option value="W">방류수질정보</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>아이피</th>
						<td><input type="text" name="fact_ip" maxlength="16" /></td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td>
							<select name="fact_use_flag">
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnSaveBranchReg" name="btnSaveBranchReg" value="저장" class="btn btn_white" onclick="javascript:saveBranchReg();" alt="저장"/>
		</div>
	</div>
	
	<!-- tab3 에서 사용 하는 관리 이력 레이어 팝업 start -->
	<div id="layerAdminHistory" class="divPopup">
		<textarea rows="3" cols="28" id="ahCoutent" name="ahCoutent"></textarea>
		<input type="button" id="btnAdminHistoryInsert" name="btnAdminHistoryInsert" value="추가" class="btn btn_basic" onclick="javascript:adminHistoryInsert();" alt="추가"/>
		<table summary="관리정보">
			<colgroup>
				<col width="30%" />
				<col width="*" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">등록일</th>
					<th scope="col">관리이력</th>
					<th scope="col">-</th>
				</tr>
			</thead>
			<tbody id="AdminHistoryInfo">
			</tbody>
		</table>
		<input type="button" id="btnCloseCommonLayer" name="btnCloseCommonLayer" value="닫기" class="btn btn_basic" onclick="javascript:layerPopClose('layerAdminHistory');" alt="닫기"/>
	</div>
	
	<div id="layerUpdateDel" class="divPopup">
		<input type="hidden" id="hsSeq" name="hsSeq"/>
		<textarea id="hsView" name="hsView" rows="19" cols="35"></textarea>
		<input type="button" id="btnAdminHistoryUpdate" name="btnAdminHistoryUpdate" value="수정" class="btn btn_basic" onclick="javascript:adminHistoryUpdate();" alt="수정"/>
		<input type="button" id="btnAdminHistoryDel" name="btnAdminHistoryDel" value="삭제" class="btn btn_basic" onclick="javascript:adminHistoryDel();" alt="삭제"/>
		<input type="button" id="btnCloseUpdateDel" name="btnCloseUpdateDel" value="닫기" class="btn btn_basic" onclick="javascript:layerPopClose('layerUpdateDel');" alt="닫기"/>
	</div>
	<!-- tab3 에서 사용 하는 관리 이력 레이어 팝업 end-->
	
	<!-- 측정소 등록 수정 레이어 -->
	<div id="layerBranchModify" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnBranModXbox" name="btnBranModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerBranchModify');" alt="닫기"/>
		</div>
		<form id="factBranchForm" name="factBranchForm" action="/spotmanage/updateFactbranchInfoAdd.do" method="post">
			<input type="hidden" id="fact_code" name="fact_code" />
			<input type="hidden" id="river_div" name="river_div" />
			<input type="hidden" id="river_no" name="river_no" />
			<input type="hidden" id="sys_kind" name="sys_kind" />
			<input type="hidden" id="branch_mgr" name="branch_mgr" />
			<input type="hidden" id="branch_no" name="branch_no" />
			<input type="hidden" id="mode" name="mode" />
			
			<table summary="지점정보">
				<caption>지점정보</caption>
				<colgroup>
					<col width="120px" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">사업장이름</th>
						<td>
							<input type="text" id="fact_name" name="fact_name" readonly="readonly" onclick="javascript:getFactinfoList()" style="width:300px; background-color:#f2f2f2;"/>
							<input type="button" id="btnFactSearch" name="btnFactSearch" value="지점선택" class="btn btn_search" onclick="javascript:getFactinfoList();" alt="지점선택"/>
						</td>
					</tr>
					<tr>
						<th scope="row">측정소명</th>
						<td><input type="text" id="branch_name" name="branch_name" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td><input type="text" id='fact_addr' name="fact_addr" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
					</tr>
					<tr>
						<th scope="row">좌표</th>
						<td>
							<input type="text" id="latitude1" name="latitude" style="width:142px; background-color:#f2f2f2;" readonly="readonly" />&nbsp;&nbsp;
							<input type="text" id="longitude1" name="longitude" style="width:142px; background-color:#f2f2f2;" readonly="readonly" />
							<input type="button" id="btnlonlat" name="btnlonlat" value="좌표선택" class="btn btn_search" onclick="javascript:lon_lat();" alt="좌표선택"/>
						</td>
					</tr>
					 <tr>
						<th scope="row">관리자명</th>
						<td>
							<input type="text" id="branch_mgr_name" name="branch_mgr_name" value="" style="width:220px"/>
							(두글자 이상 입력)
							<input type="button" id="btnMemberSearch" name="btnMemberSearch" value="조회" class="btn btn_search" onclick="javascript:onSearch_member()" alt="조회"/>
						</td>
					</tr>
					<tr>
						<th scope="row">관리자전화번호</th>
						<td><input type="text" id="branch_mgr_tel_no" name="branch_mgr_tel_no" value="" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
					</tr>
<!-- 										<tr> -->
<!-- 											<th scope="row">이탈유효거리(M)</th> -->
<!-- 											<td><input type="text" id="leave_distance" name="leave_distance" style="width:380px" /></td> -->
<!-- 										</tr> -->
					<tr>
						<th scope="row">사용여부</th>
						<td>
							<select name="branch_use_flag" id="branch_use_flag" style="width:380px;">
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnBranchRegMod" name="btnBranchRegMod" value="등록/수정" class="btn btn_white" onclick="javascript:updateFactBranch();" alt="등록/수정"/>
		</div>
	</div>
	<!-- 측정소 등록 수정 레이어 -->
	<!--측정소 검색 레이어-->
	<div id="factinfoLayer" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFactInfoXbox" name="btnFactInfoXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('factinfoLayer');" alt="닫기"/>
		</div>
		<div id="dataList1" class="dataList" style="width:500px; text-align:center;"></div>
		<br/>
		<center>
			<span style="color:#fff;">사업장코드 : </span>
			<input type="text" id="searchKeyword" name="searchKeyword" style="width:100px;"/>
			<input type="button" id="btnPopFactSearch" name="btnPopFactSearch" value="검색" class="btn btn_search" onclick="javascript:getFactinfoList();" alt="검색"/>
<!-- 			<input type="button" id="btnPopFactClose" name="btnPopFactClose" value="닫기" class="btn btn_basic" onclick="javascript:layerPopClose('factinfoLayer');" alt="닫기"/> -->
		</center>
	</div>
	<!--//측정소 검색 레이어-->
	<!--관리자 검색 레이어-->
	<div id="memberLayer" class="divPopup" style="margin-top:50px;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnMemberXbox" name="btnMemberXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('memberLayer');" alt="닫기"/>
		</div>
		<div id="dataList2" class="dataList" style="width:500px; text-align:center;"></div>
	</div>
	<!--//관리자 검색 레이어-->
</body>
</html>