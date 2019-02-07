<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : systemItemDefine.jsp
	 * Description : 시스템항목정의 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * -------		--------	---------------------------
	 * 2010.06.18	kisspa		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author kisspa
	 * since 2010.07.02
	 * 
	 * Copyright (C) 2010 by kisspa All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" /><!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no" />
<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
//<![CDATA[
	var pageNo = null;
	
	//페이지로드 후 실행
	$(function() {
		getSystemList();
		//시스템 등록 레이어
		$("#layerSystemReg").draggable({
			containment: 'body',
			scroll: false
		});
		//시스템 등록 레이어
		$("#layerGroupDel").draggable({
			containment: 'body',
			scroll: false
		});
		//항목그룹 추가 레이어
		$("#layerGroupReg").draggable({
			containment: 'body',
			scroll: false
		});
		//시스템 등록 레이어
		$("#layerGroupDel").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	//시스템리스트를 가져옵니다.
	function getSystemList() {
		showLoading();
		
		if (pageNo == null)
			pageNo = 1;
			
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanager/getSystemListItem.do'/>",
			data : {
				pageIndex : pageNo
			},
			dataType : "json",
			success : function(result) {
				var tot = result['systemList'].length;
				
				$("#systemList").html("");
				
				if (tot <= 0) {
					$("#systemList").html("<tr><td colspan='6' style='text-align:center;'>조회 결과가 없습니다</td></td>");
					closeLoading();
				} else {
					for ( var i = 0; i < tot; i++) {
						var obj = result['systemList'][i];
						var pageInfo = result['paginationInfo'];
						
						var no = i + ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage) + 1;
						var css = "style='cursor:pointer;' onclick=getGroupList2('" + obj.sys_code + "');";
						var css2 = "style='text-transform:uppercase; ime-mode:disabled;'";
						
						var trNo = i+1;
						var sysYnName = "";
						if(obj.sys_yn=="Y"){
							sysYnName = "사용"; 
						}else{
							sysYnName = "미사용"; 
						}
						
						var item = "<tr id='tr"+trNo+"' class='tr"+i+"' onclick=\"javascript:clickTrEvent(this);setSysCode('"+obj.sys_code+"');getGroupList2('"+obj.sys_code+"');\" style='cursor:pointer;'>"
								+ "<td style='text-align:center;'><span>"
								+ no
								+ "</span></td></a>"
								+ "<td "+css+" >"
								+ obj.sys_code
								+ "</td>"
								+ "<td "+css+" >"
								+ obj.sys_name
								+ "</td>"
								+ "<td style='margin:0px; padding:0px;'>"
								+ sysKindName(obj.sys_type)
								+ "</td>"
								+ "<td "+css+">"
								+ obj.sys_memo
								+ "</td>"
								+ "<td>"
								+ sysYnName
								+ "</tr>";
								
						$("#systemList").append(item);
						
						$("#systemList tr:odd").attr("class", "add");
						$("#systemList input:odd").css("background-color", "#f2f2f2");
						
// 						$("#" + obj.sys_code).val(obj.sys_yn);
						
						// 페이징 정보
						var pageStr = makePaginationInfo(result['paginationInfo']);
						$("#pagination").empty();
						$("#pagination").append(pageStr);
					}
				}
				//시스템 구분자 입력
				$("#sys_type").html("");
				var tot1 = result['systemGubunList'].length;
				
				for ( var i = 0; i < tot1; i++) {
					var obj1 = result['systemGubunList'][i];
				
					$("#sys_type").append("<option value='"+obj1.sysKind+"' >" + sysKindName(obj1.sysKind) + "</option>");
				}
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-',
								'');
					}
				}
				$("#systemList").html("<tr><td colspan='6' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
		groupListReset();
	}
	
	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");		
		$(tr).find("td").addClass("tr_on");
    }
	//시스템 구분자 입력 모드 변경
// 	function selectSystype(obj){
// 		$("#"+obj.id+" span" ).css({'display':'none'});
// 		$("#"+obj.id+" input" ).css({'display':'inline'});
// 		$("#"+obj.id+" input" ).focus();
// 	}
	
	//시스템리스트를 가져옵니다.
	function getSystemDelList() {
		showLoading();
		
		if (pageNo == null)
			pageNo = 1;
			
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanager/getSystemListItem.do'/>",
			data : {
				pageIndex : pageNo
			//
			},
			dataType : "json",
			success : function(result) {
				var tot = result['systemList'].length;
				$("#systemDelList").html("");
				
				if (tot <= 0) {
					$("#systemDelList").html(
						"<option value=''>조회 결과가 없습니다.</option>");
					closeLoading();
				} else {
					for ( var i = 0; i < tot; i++) {
						var obj = result['systemList'][i];
						var pageInfo = result['paginationInfo'];
						var no = i + ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage) + 1;
						var item = "<option value='"+obj.sys_code+"'>"
								+ obj.sys_code + "</option>";
						$("#systemDelList").append(item);
						$("#systemDelList tr:odd").attr("class", "add");
						// 페이징 정보
						var pageStr = makePaginationInfo(result['paginationInfo']);
						$("#pagination").empty();
						$("#pagination").append(pageStr);
					}
				}
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#systemDelList").html("<option value=''>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
				closeLoading();
			}
		});
	}
	
	function setSysCode(sys_code){
		$("#modSysCode").val(sys_code);
	}
	//선택한 시스템코드의 그룹리스트를 가져옵니다.
	var sel_sys_code = "";
	function getGroupList2(sys_code) {
		
		if (sys_code != null && sys_code != "") {
			sel_sys_code = sys_code;
		} else if (sel_sys_code != null && sel_sys_code != "") {
			sys_code = sel_sys_code;
		}
		$("#groupAddForm [name=sys_code]").val(sel_sys_code);
		$("#groupDelForm [name=sys_code]").val(sel_sys_code);
		showLoading();
		
		if (pageNo == null)
			pageNo = 1;
		
		if (sys_code == null && sys_code == '')
			return;
			
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanager/getGroupListItem.do'/>",
			data : {
				pageIndex : pageNo,
				sys_code : sys_code
			},
			dataType : "json",
			success : function(result) {
				var tot = result['groupList'].length;
				
				$("#groupList").html("");
				
				if (tot <= 0) {
					$("#groupList").html("<tr><td colspan='2' style='text-align:center;'>조회 결과가 없습니다</td></td>");
					closeLoading();
				} else {
					for ( var i = 0; i < tot; i++) {
						var obj = result['groupList'][i];
						var pageInfo = result['paginationInfo'];
						
						var no = i + ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage) + 1;
						
						var item = "<tr style='cursor:pointer;cursor:hand;' onclick=getItemList2('"
								+ obj.group_code
								+ "');>"
								+ "<td style='text-align:center;'><span>"
								+ obj.group_code
								+ "</span></td></a>"
								+ "<td>" + obj.group_name + "</td>"
								+ "</tr>";
								
						$("#groupList").append(item);
						$("#groupList tr:odd").attr("class", "add");
						
						// 페이징 정보
						var pageStr = makePaginationInfo(result['paginationInfo']);
						$("#pagination").empty();
						$("#pagination").append(pageStr);
						
					}
				}
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#groupList").html("<tr><td colspan='2' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
		itemListReset();
	}
	
	//선택한 시스템코드의 삭제할	그룹리스트를 가져옵니다.
	function getGroupDelList2(sys_code) {
		sys_code = sel_sys_code;
		if (sys_code == null || sys_code == "") {
			alert("시스템을 선택하세요");
			return false;
		}
		showLoading();
		
		if (pageNo == null)
			pageNo = 1;
			
		if (sys_code == null && sys_code == '')
			return;
			
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanager/getGroupListItem.do'/>",
			data : {
				pageIndex : pageNo,
				sys_code : sys_code
			},
			dataType : "json",
			success : function(result) {
				var tot = result['groupList'].length;
				
				$("#groupDelList").html("");
				
				if (tot <= 0) {
					$("#groupDelList").html("<option value=''>조회 결과가 없습니다.</option>");
					closeLoading();
				} else {
					for ( var i = 0; i < tot; i++) {
						
						var obj = result['groupList'][i];
						var pageInfo = result['paginationInfo'];
						
						var no = i + ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage) + 1;
						var item = "<option value='"+obj.group_code+"'>" + obj.group_code + " (" + obj.group_name + ")</option>";
						
						item += "</tr>";
						
						$("#groupDelList").append(item);
						$("#groupDelList tr:odd").attr("class", "add");
						
						// 페이징 정보
						var pageStr = makePaginationInfo(result['paginationInfo']);
						$("#pagination").empty();
						$("#pagination").append(pageStr);
					}
				}
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#groupDelList").html("<option value=''>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
				closeLoading();
			}
		});
		return true;
	}
	
	//선택한 시스템코드의 삭제하며 그룹리스트를 가져옵니다.
	function getGroupAddList2(sys_code) {
		sys_code = sel_sys_code;
		
		if (sys_code == null || sys_code == "") {
			alert("시스템을 선택하세요");
			return false;
		}
		showLoading();
		
		if (pageNo == null)
			pageNo = 1;
			
		if (sys_code == null && sys_code == '')
			return;
			
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanager/getGroupAddListItem.do'/>",
			data : {
				pageIndex : pageNo,
				sys_code : sys_code
			},
			dataType : "json",
			success : function(result) {
				var tot = result['groupList'].length;
				
				$("#groupAddList").html("");
				
				if (tot <= 0) {
					$("#groupAddList").html("<option value=''>조회 결과가 없습니다.</option>");
				} else {
					for ( var i = 0; i < tot; i++) {
						
						var obj = result['groupList'][i];
						var pageInfo = result['paginationInfo'];
						
						var no = i + ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage) + 1;
						var item = "<option value='" + obj.group_code + "'>" + obj.group_code + " (" + obj.group_name + ")</option>";
						
						item += "</tr>";
						
						$("#groupAddList").append(item);
						$("#groupAddList tr:odd").attr("class", "add");
						
						// 페이징 정보
						var pageStr = makePaginationInfo(result['paginationInfo']);
						$("#pagination").empty();
						$("#pagination").append(pageStr);
						
					}
				}
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#groupAddList").html("<option value=''>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
				closeLoading();
			}
		});
		return true;
	}
	
	//선택한 시스템코드의 그룹리스트를 가져옵니다.
	function getItemList2(group_code) {
		showLoading();
		
		if (pageNo == null)
			pageNo = 1;
		
		if (group_code == null && group_code == '')
			return;
			
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanager/getItemListItem.do'/>",
			data : {
				pageIndex : pageNo,
				sys_code : sel_sys_code,
				group_code : group_code
			},
			dataType : "json",
			success : function(result) {
				var tot = result['itemList'].length;
				
				$("#itemList").html("");
				
				if (tot <= 0) {
					$("#itemList").html("<tr><td colspan='3' style='text-align:center;'>조회 결과가 없습니다</td></td>");
				} else {
					for ( var i = 0; i < tot; i++) {
						
						var obj = result['itemList'][i];
						var pageInfo = result['paginationInfo'];
						
						var no = i + ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage) + 1;
						var dpy = obj.dp_yn.toUpperCase() == 'Y' ? "selected" : "";
						var dpn = obj.dp_yn.toUpperCase() != 'Y' ? "selected" : "";
						
						var item = "<tr>"
								+ "<td style='text-align:center;' ><span>"
								+ obj.item_code
								+ "</span></td></a>"
								+ "<td>"
								+ obj.item_name
								+ "</td>"
								+ "<td>"
								+ " <select syscode='"+obj.sys_code+"' groupcode='"+obj.group_code+"' itemcode='"+obj.item_code+"' name='dpyn'>"
								+ "	 <option value='Y' "+dpy+">사용</option>"
								+ "	 <option value='N' "+dpn+">미사용</option>"
								+ " </select>" + "</td>"
								+ "</tr>";
						
						$("#itemList").append(item);
						$("#itemList tr:odd").attr("class", "add");
						
						var pageStr = makePaginationInfo(result['paginationInfo']);
						$("#pagination").empty();
						$("#pagination").append(pageStr);
					}
				}
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#itemList").html("<tr><td colspan='3' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//시스템리스트에 항목을 추가합니다.
	function systemIns() {
		var mod = $("#modInsert").val(); 
		
		var sys_name = $("#sys_name").val();
		var sys_memo = $("#sys_memo").val();
		var sys_type = $("select[name=sys_type]").val();
		var sys_yn = $("select[name=sys_yn]").val();
		var sys_code = $("#modSysCode").val();
		
		if(mod == "reg"){
			$.ajax({
				type:"post",
				url:"<c:url value='/itemmanager/systemInsertItem.do'/>",
				data:{
					sys_name:sys_name,
					sys_memo:sys_memo,
					sys_type:sys_type,
					sys_yn:sys_yn
				},
				dataType:"json",
				success:function(result){
					layerPopClose('layerSystemReg');
					getSystemList();
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
					$("#systemList").html("<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}else{
			$.ajax({
				type:"post",
				url:"<c:url value='/itemmanager/systemUpdateItem.do'/>",
				data:{
					sys_name:sys_name,
					sys_memo:sys_memo,
					sys_type:sys_type,
					sys_yn:sys_yn,
					sys_code:sys_code
				},
				dataType:"json",
				success:function(result){
					layerPopClose('layerSystemReg');
					getSystemList();
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
					$("#systemList").html("<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
		
	}
	
	//시스템리스트의 항목을 삭제합니다.
	function systemDel() {
		var code = $("#systemDelForm [name=sys_code]").val();
		if (code == null || code == "") {
			alert("시스템 코드를 선택하세요!");
			return;
		}
		
		$('#systemDelForm').ajaxForm({
			success : function(result) {
				alert("삭제했습니다");
				getSystemList();
				layerPopClose('layerSystemDel');
			}
		}).submit();
	}
	
	//시스템리스트의 사용여부(체크) 상태를 수정합니다.
	function systemSave() {
		
		var idArr = new Array();
		var valArr = new Array();
		var typeArr = new Array();
		
		$("select[name=sysyn]").each(function() {
			idArr.push(this.id);
			valArr.push(this.value);
		});
		$("select[name=systype]").each(function() {
			typeArr.push(this.value);
		});
		$("#idArr").val(idArr);
		$("#valArr").val(valArr);
		$("#typeArr").val(typeArr);
		
		$('#listFrm').ajaxForm({
			success : function(result) {
				alert("저장했습니다");
				getSystemList();
			}
		}).submit();
	}
	
	//시스템리스트의 사용여부(체크) 상태를 수정합니다.
	function groupAdd() {
		//$("#groupAddForm [name=sys_code]").val(sel_sys_code);
		var code = $("#groupAddForm [name=group_code]").val();
		
		if (code == null || code == "") {
			alert("시스템 코드를 선택하세요!");
			return;
		}
		$('#groupAddForm').ajaxForm({
			success : function(result) {
				alert("추가했습니다");
				layerPopClose('layerGroupReg');
				getGroupList2(sel_sys_code);
			}
		}).submit();
	}
	
	//시스템리스트의 사용여부(체크) 상태를 수정합니다.
	function groupDel() {
		var code = $("#groupDelForm [name=group_code]").val();
		if (code == null || code == "") {
			alert("시스템 코드를 선택하세요!");
			return;
		}
		
		$('#groupDelForm').ajaxForm({
			success : function(result) {
				alert("삭제했습니다");
				layerPopClose('layerGroupDel');
				getGroupList2(sel_sys_code);
			}
		}).submit();
	}
	
	//시스템리스트의 사용여부(체크) 상태를 수정합니다.
	function itemSave() {
		var dpynArr = new Array();
		var itemcodeArr = new Array();
		var groupcodeArr = new Array();
		var syscodeArr = new Array();
		
		$("#itemList select[name=dpyn]").each(function() {
			dpynArr.push($(this).val());
			itemcodeArr.push($(this).attr("itemcode"));
			groupcodeArr.push($(this).attr("groupcode"));
			syscodeArr.push($(this).attr("syscode"));
		});
		
		$("#dpynArr").val(dpynArr);
		$("#itemcodeArr").val(itemcodeArr);
		$("#groupcodeArr").val(groupcodeArr);
		$("#syscodeArr").val(syscodeArr);
		$('#itemListFrm').ajaxForm({
			success : function(result) {
				alert("저장했습니다");
				//getSystemList();
			}
		}).submit();
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerGroupDel");
		layerPopClose("layerGroupReg");
		layerPopClose("layerSystemReg");
		layerPopClose("layerSystemDel");
	}
	
	//지정 폼의 내용 초기화
//	function formReset(frm) {
//		$('#' + frm + " input").val("");
//		$('#' + frm + " textarea").val("");
//	}
	
	//그룹 리스트 초기화
	function groupListReset() {
		$("#groupList").html("<tr><td colspan='2' style='text-align:center;'>시스템 리스트에서 시스템을 선택하세요</td></td>");
		itemListReset();
	}
	//아이템 리스트 초기화
	function itemListReset() {
		$("#itemList").html("<tr><td colspan='3' style='text-align:center;'>그룹 리스트에서 그룹을 선택하세요</td></td>");
	}
	
	function LayerPopEditOpen(flag) {
		$("#modInsert").val(flag);
	
		if (flag == "reg") {
			// 등록을 위한 레이어에 초기화
			$("#sys_name").val("");
			$("#sys_memo").val("");
			$("#sys_type > option:first").attr("selected", "true");
			$("#sys_yn > option:first").attr("selected", "true");
		} else {
			var sys_code = $("#modSysCode").val();
			
			if(sys_code == ''){
				alert("시스템을 선택하세요.");
				return;
			}else{
				$.ajax({
					type:"post",
					url:"<c:url value='/itemmanager/getSystemItemInfo.do'/>",
					data:{
						mod_sys_code:sys_code
					},
					dataType:"json",
					success:function(result){
						var systemItemInfo = result['systemItemInfo'];
						
						$("#sys_name").val(systemItemInfo.sys_name);
						$("#sys_memo").val(systemItemInfo.sys_memo);
// 						$("#sys_type > option:first").attr("selected", "true");
						$("#sys_type > option[value="+systemItemInfo.sys_type+"]").attr("selected", "true");
						$("#sys_yn > option[value="+systemItemInfo.sys_yn+"]").attr("selected", "true");
						
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
						closeLoading();
					}
				});
			}
		}
		
		layerPopOpen("layerSystemReg");
	}
	
	function delSystemItemInfo(){
		var sys_code = $("#modSysCode").val();
		
		if(sys_code == ''){
			alert("시스템을 선택해주세요.");
			return;
		}
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"<c:url value='/itemmanager/systemDeleteItem.do'/>",
				data:{
					sys_code:sys_code
				},
				dataType:"json",
				success:function(result){
					$("#modInsert").val();
					$("#modSysCode").val();
					
					alert("정상적으로 삭제되었습니다.");
					getSystemList();					
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
					closeLoading();
				}
			});
		}
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>"
			alt="로딩중.." />
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
					<!--tab Contnet Start-->
					<fieldset class="first">
						<legend class="hidden_phrase">지점관리 검색조건 폼 및 엑셀,
							신규등록(수계, 시스템, 명칭 및 )</legend>
						
						<form id="listFrm" name="listFrm" action="/itemmanager/systemSaveItem.do" method="post">
							<input name="idArr" id="idArr" type="hidden" />
							<input name="valArr" id="valArr" type="hidden" />
							<input name="typeArr" id="typeArr" type="hidden" />
						</form>
						<form id="hiddenFrm" name="hiddenFrm">
							<input type="hidden" name="modInsert" id="modInsert" />
							<input type="hidden" name="modSysCode" id="modSysCode" />
						</form>
						<div class="overBox" style="height:170px">
							<table summary="시스템항목정보" class="mtop10">
								<caption>시스템설명</caption>
								<colgroup>
									<col width="45px" />
									<col width="120px" />
									<col width="150px" />
									<col width="160px" />
									<col width="400px" />
									<col width="90px" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">연번</th>
										<th scope="col">시스템 코드</th>
										<th scope="col">시스템명</th>
										<th scope="col">구분자</th>
										<th scope="col">시스템 설명</th>
										<th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="systemList">
								</tbody>
							</table>
						</div>
						<!--top Search Start-->
						<div class="topBx">
							<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('reg');" />
							<input type="button" id="btnModify" name="btnModify" value="수정" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('mod');" />
							<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:delSystemItemInfo();" />
<!-- 							<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:layerPopOpen('layerSystemDel');getSystemDelList();" /> -->
<!-- 							<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:systemSave();" /> -->
						</div>
						<!--top Search End-->
					</fieldset>
					
					<fieldset class="second">
					<legend class="hidden_phrase">지점관리 상세 정보(기본정보, USN관리, 설치장비, 항목관리)</legend>
					
					<div class="divisionBx">
						<div class="div50">
							<div style="text-align:left;font-weight:bold;">
								<span>[항목그룹]</span>
							</div>
							<div class="table_wrapper">
								<div class="overBox" style="height:330px">
									<table summary="그룹정보">
										<colgroup>
											<col width="120px" />
											<col />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">그룹 코드</th>
												<th scope="col">그룹 명</th>
											</tr>
										</thead>
										<tbody id="groupList">
										</tbody>
									</table>
								</div>
							</div>
							<div style="text-align:right;">
								<input type="button" id="btnGroupAddList" name="btnGroupAddList" value="추가" class="btn btn_basic" onclick="javascript:if(getGroupAddList2())layerPopOpen('layerGroupReg');" />
								<input type="button" id="btnGroupDelete" name="btnGroupDelete" value="삭제" class="btn btn_basic" onclick="javascript:if(getGroupDelList2())layerPopOpen('layerGroupDel');" />
							</div>
						</div>
						<div class="div50 last">
							<div style="text-align:left;font-weight:bold;">
								<span>[항목관리]</span>
							</div>
							
							<form id="itemListFrm" name="itemListFrm" action="/itemmanager/itemUpdateItem.do" method="post">
								<input name="dpynArr" id="dpynArr" type="hidden" />
								<input name="itemcodeArr" id="itemcodeArr" type="hidden" />
								<input name="groupcodeArr" id="groupcodeArr" type="hidden" />
								<input name="syscodeArr" id="syscodeArr" type="hidden" />
							</form>
							<div class="table_wrapper">
								<div class="overBox" style="height:330px">
									<table summary="항목정보">
										<colgroup>
											<col width="150px" />
											<col />
											<col width="90px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">항목코드</th>
												<th scope="col">항목명</th>
												<th scope="col">체크</th>
											</tr>
										</thead>
										<tbody id="itemList">
										</tbody>
									</table>
								</div>
							</div>
							<div style="text-align:right;">
								<input type="button" id="btnItemSave" name="btnItemSave" value="등록" class="btn btn_basic" onclick="javascript:itemSave();" alt="등록"/>
							</div>
						</div>
					</div>
					</fieldset>
					
					<!--tab Contnet End-->
				</div>
			</div>
		</div>
		<!-- Body End-->
	
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>

	<!-- 레이어 팝업 -->
	<div id="layerSystemReg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSysRegXbox" name="btnSysRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerSystemReg');" alt="닫기"/>
		</div>
		<table summary="시스템등록">
			<colgroup>
				<col width="80" />
				<col />
			</colgroup>
			<tr>
				<th scope="col">시스템 명</th>
				<td><input type="text" id="sys_name" name="sys_name" style="width:155px;" maxlength="15" /></td>
			</tr>
			<tr>
				<th scope="col">시스템</th>
				<td>
					<select id="sys_type" name="sys_type" style="float:left; width:100%;">
						<option value="">시스템을 선택해주세요.</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="col">시스템 설명</th>
				<td><textarea id="sys_memo" name="sys_memo" style="width:150px; height:100px;"></textarea></td>
			</tr>
			<tr>
				<th scope="col">사용여부</th>
				<td>
					<select id="sys_yn" name="sys_yn" style="float:left; width:100px;">
						<option value="Y" selected="selected">사용</option>
						<option value="N">미사용</option>
					</select>
				</td>
			</tr>
		</table>
		
		<div id="btCarea">
			<input type="button" id="btnRegist" name="btnRegist" value="저장" class="btn btn_white" onclick="javascript:systemIns();" alt="저장"/>
		</div>
	</div>
	
	<div id="layerSystemDel" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSysDelXbox" name="btnSysDelXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerSystemDel');" alt="닫기"/>
		</div>
		<form id="systemDelForm" name="systemDelForm" action="/itemmanager/systemDeleteItem.do" method="post">
			
			<table summary="시스템삭제">
				<colgroup>
					<col width="180" />
				</colgroup>
				<tr>
					<th scope="col">시스템 코드</th>
				</tr>
				<tr>
					<td>
						<select id="systemDelList" name="sys_code" style="width:100%;">
							<option value="">시스템코드를 선택해주세요.</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnSystemDel" name="btnSystemDel" value="삭제" class="btn btn_white" onclick="javascript:systemDel();" alt="삭제"/>
		</div>
	</div>
	
	<div id="layerGroupReg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroRegXbox" name="btnGroRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerGroupReg');" alt="닫기"/>
		</div>
		<form id="groupAddForm" name="groupAddForm" action="/itemmanager/groupInsertItem.do" method="post">
			<input type="hidden" name="sys_code" value="" />
			
			<table summary="그룹추가">
				<colgroup>
					<col />
				</colgroup>
				<tr>
					<th scope="col">그룹 코드</th>
				</tr>
				<tr>
					<td>
						<select id="groupAddList" name="group_code" style="width:100%;">
							<option value="">그룹코드를 선택해주세요.</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnGroupAdd" name="btnGroupDel" value="추가" class="btn btn_white" onclick="javascript:groupAdd();" alt="추가"/>
		</div>
	</div>
	
	<div id="layerGroupDel" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroDelXbox" name="btnGroDelXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerGroupDel');" alt="닫기"/>
		</div>
		<form id="groupDelForm" name="groupDelForm" action="/itemmanager/groupDeleteItem.do" method="post">
			<input type="hidden" name="sys_code" value="" />
			
			<table summary="항목그룹삭제">
				<colgroup>
					<col />
				</colgroup>
				<tr>
					<th scope="col">그룹 코드</th>
				</tr>
				<tr>
					<td>
						<select id="groupDelList" name="group_code" style="width:100%">
							<option value="">시스템 코드를 선택해주세요.</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnGroupDel" name="btnGroupDel" value="삭제" class="btn btn_white" onclick="javascript:groupDel();" alt="삭제"/>
		</div>
	</div>
	<!-- //레이어 팝업 -->
</body>
</html>