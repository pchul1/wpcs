<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<%
	/** 
	 * Class Name : SmsGroupSearch.java
	 * Description : 사용자그룹조회 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * ----------	--------	---------------------------
	 * 2009.03.23	lee.m.j		최초 생성
	 * 2014.04.01	lkh			리뉴얼
	 *
	 * author lee.m.j
	 * since 2009.03.23
	 *
	 * Copyright (C) 2013 by  All right reserved.
	 */
%>
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/content.css' />" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/popup.css' />" rel="stylesheet" type="text/css" />

<title>그룹조회 팝업</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javaScript" language="javascript" defer="defer">

	$(function () {
		reloadData();
		
		dataView = new Slick.Data.DataView();
	
		var columns = [
						{ id: "groupId", name: "그룹 ID", field: "groupId", width: 190, sortable: true, cssClass: "slick-pointer"},
						{ id: "groupNm", name: "그룹 명", field: "groupNm", width: 385,  sortable: true, cssClass: "slick-pointer text-align-left"}
						];
		var options = {
			enableCellNavigation: true,
			enableColumnReorder: false,
			multiColumnSort: true
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function(e, args) {
			grid.resetActiveCell();
			var obj = grid.getDataItem(grid.getSelectedRows());
			fncSelectGroup(obj.groupId);
		});
	
		grid.onClick.subscribe(function(e, args) {
// 			if (args.cell == 1 || args.cell == 5) {	//상세조회 항목 클릭시 상세조회 창으로 이동
// 				var obj = grid.getDataItem(args.row);
// 				fncSelectGroup(obj.groupId);
// 			}
		});
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		dataView.onRowsChanged.subscribe(function (e, args) {
			grid.invalidateRows(args.rows);
			grid.render();
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
		
	});
	
	function reloadData(pageNo){
		showLoading();
		
		var searchCondition = "1";
		var searchKeyword = $("#searchKeyword").val();
// 		console.log("searchKeyword : ",searchKeyword);
		
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type: "POST",
			url: "<c:url value='/admin/security/SmsGroupSearchDetailView.do'/>",
			data: {
					searchCondition:searchCondition,
					searchKeyword:searchKeyword,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				dataView.setItems([]);
				
				$("#searchResult").hide();
				$("#dataList").css("height", "300px")
				
				var data = [];
				if( tot <= 0 ){
	//					console.log("tot : ",tot);
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("");
					$("#resultText").html("조회 결과가 없습니다.");
				
					closeLoading();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
				closeLoading();
			},
			error:function(result){
// 				console.log("결과 값 확인2 : ",result);
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) { 
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#searchResult").show();
				$("#dataList").css("height", "25px");
				$("#resultText").html("");
				$("#resultText").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}

function fncManageChecked() {

	var checkField = document.listForm.delYn;
	var checkId = document.listForm.checkId;
	var returnValue = "";
	var checkCount = 0;
	var returnBoolean = false;

	if(checkField) {
		if(checkField.length > 1) {
			for(var i=0; i<checkField.length; i++) {
				if(checkField[i].checked) {
					checkCount++;
					checkField[i].value = checkId[i].value;
					returnValue = checkField[i].value;
				}
			}

			if(checkCount > 1) {
				alert("하나 이상의 그룹이 선택되었습니다.");
				return;
			} else if(checkCount < 1) {
				alert("선택된 그룹이 없습니다.");
				return;
			}
		} else {
			if(checkField.checked == true) {
				returnValue = checkId.value;
			} else {
				alert("선택된 그룹이 없습니다.");
				return;
			}
		}

		returnBoolean = true;

	} else {
		alert("조회 결과가 없습니다.");
	}

	document.listForm.groupId.value = returnValue;

	return returnBoolean;
	
}

function fncSelectGroupList(pageNo){
	document.listForm.searchCondition.value = "1";
	document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/admin/security/SmsGroupSearchList.do'/>";
	document.listForm.submit();
}

function fncSelectGroup(groupId) {
 // window.returnValue = groupId;
	opener.listForm.searchKeyword.value = groupId;
	window.close();
}

function fncSelectGroupConfirm() {
	if(fncManageChecked()) {
		opener.listForm.searchKeyword.value = document.listForm.groupId.value;
	 // window.returnValue = document.listForm.groupId.value;
		window.close();
	}
}

function linkPage(pageNo){
	document.listForm.searchCondition.value = "1";
	document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/admin/security/SmsGroupSearchList.do'/>";
	document.listForm.submit();
}

function press() {

	if (event.keyCode==13) {
//	 	fncSelectGroupList('1');
		reloadData();
	}
}

</script>
</head>

<body class="subPop"><!-- 추가 및 수정 --> 
<div class="headerWrap"> 
	<div class="headerBg_r"> 
		<div class="header"> 
			<h1>그룹조회</h1> 
		</div> 
	</div> 
</div> 
<div class="contentWrap"> 
	<div class="contentBg_r"> 
		<div class="contentBox"> 
			<div class="contentPad">
				<!-- 내용 --> 
				<div id="managePage">
<%-- 					<form name="listForm" _action="<c:url value='/admin/security/SmsGroupSearchList1.do'/>" method="post"> --%>
						<ul class="menuList menuSpacing  highIndex">
							<li class="spacing">
								<span class="inputTit">그룹 명 :</span> 
<%-- 								<input name="searchKeyword" type="text" value="<c:out value="${groupManageVO.searchKeyword}"/>" title="검색" onkeypress="press();" /> --%>
								<input id="searchKeyword" name="searchKeyword" type="text" class="fixWidth13" value="${groupManageVO.searchKeyword}" maxlength="35" onkeydown="if(event.keyCode==13) javascript:reloadData()">
							</li>
							<li>
<!-- 								<a href="javascript:fncSelectGroupList('1')" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>조회</em></span></a> -->
<!-- 								<a href="javascript:reloadData()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>조회</em></span></a> -->
								<input type="button" id="btnInitlDeptList" name="btnInitlDeptList" value="조회" class="btn btn_search" onclick="javascript:reloadData();" alt="조회" />
							</li>
<!-- 							<li> -->
<!-- 								<a href="javascript:fncSelectGroupConfirm()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>확인</em></span></a> -->
<!-- 							</li> -->
						</ul>
						<table class="dataTable">
								<div id="dataList" style="height: 525px;"></div>
								<table id="searchResult" style="display:none" summary="이동형측정기기정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
						
<!-- 							<colgroup> -->
<!-- 								<col width="3%"> -->
<!-- 								<col width="15%"> -->
<!-- 								<col width="25%"> -->
<!-- 							</colgroup> -->
<!-- 							<thead>  -->
<!-- 								<tr>  -->
<!-- 									<th class="noOption">&nbsp;</th>   -->
<!-- 									<th>그룹 ID</th>  -->
<!-- 									<th>그룹 명</th>  -->
<!-- 								</tr>  -->
<!-- 							</thead>  -->
<!-- 							<tbody> -->
<%-- 								<c:forEach var="group" items="${groupList}" varStatus="status"> --%>
<!-- 									<tr>  -->
<%-- 										<td class="noOption"><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" /></td>  --%>
<%-- 										<td><a href="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a></td>  --%>
<%-- 										<td><c:out value="${group.groupNm}"/></td>  --%>
<!-- 									</tr>  -->
<%-- 								</c:forEach> --%>
<!-- 							</tbody> -->
						</table>
								<div class="paging">
									<div id="page_number">
										<ul class="paginate" id="pagination"></ul>
									</div>
								</div>
<%-- 						<c:if test="${!empty groupManageVO.pageIndex }"> --%>
<!-- 							<ul class="paginate"> -->
								
<%-- 								<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage"/> --%>
								
<!-- 								
<!-- 								<li><a href="#">이전..</a></li> -->
<!-- 								<li><em>1</em></li> -->
<!-- 								<li><a href="#">2</a></li> -->
<!-- 								<li><a href="#">..이후</a></li> -->
<!-- 								-->
<!-- 							</ul> -->
<%-- 						</c:if> --%>
						<input type="hidden" name="groupId"/>
						<input type="hidden" name="groupIds"/>
<%-- 						<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/> --%>
						<input type="hidden" name="searchCondition"/> 
<!-- 					</form> -->
				</div><!-- //managePage -->
			</div>
		</div> 
	</div> 
</div> 
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 --> 
</body> 
</html>
