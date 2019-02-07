<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : waterPollutionReportList.jsp
	 * Description : 수질오염리포트 리스트 화면
	 * Modification Information
	 * 
	 * 수정일				 수정자		 수정내용
	 * ----------		--------	---------------------------
	 * 2014.02.10		lkh			모바일용을 마이그레이션
	 *
	 * author lkh
	 * since 2014.0210
	 *
	 * Copyright (C) 2014 by lkh All right reserved.
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

<script type="text/javascript">
//<![CDATA[
	
// 	var dataView = null;
// 	var grid	 = null;
	
	$(function () {
		
		reloadData();
		
		dataView = new Slick.Data.DataView();
		
		var contentFormatter = function (row, cell, value, columnDef, dataContext) {
// 			console.log("dataContext : ",dataContext);
			var w = "";
			
// 			var w = "[최초] <a href='report_modify.jsp?id=dataContext.id&s=1&{{list_query}}'>dataContext.reptDate</a>"
// 					+ "&nbsp;<font style='background:red;color:#ffffff;' onclick=OpenWindows('report.jsp?id=dataContext.id&no=01&ek={{list.ek}}', '', 900, 1200)'>보고서</font>';
			var w = "[최초] <a href='report_modify.jsp?id=" + dataContext.id + "&s=1&'>" + dataContext.reptDate + "</a>"
					+ " <font style='background:red;color:#ffffff;cursor:pointer;' onclick=javascript:OpenWindows('report.jsp?id=" + dataContext.id + "&no=01&ek=', '', 900, 1200)'>보고서</font>";
					
			if (dataContext.reptDate2 != " :") {
				//w = w + "<br/>[<span style='letter-spacing:0.6px'>2 </span>차] <a href='javascript:fnModify(report_modify.jsp?id=" + dataContext.id + "&s=2&'>" + dataContext.reptDate2 + "</a>"
				w = w + "<br/>[<span style='letter-spacing:0.6px'>2 </span>차] <a href=javascript:fnModify(" + dataContext.id + ",'2')>" + dataContext.reptDate2 + "</a>"
				+ " <font style='background:red;color:#ffffff;cursor:pointer;' onclick=javascript:OpenWindows('report.jsp?id=" + dataContext.id + "&no=02&ek=', '', 900, 1200)'>보고서</font>";
			} else {
				w = w + "<br/>[<span style='letter-spacing:0.6px'>2 </span>차] <a href=javascript:fnModify(" + dataContext.id + ",'2')><font style='background:lightgreen;color:#ffffff;'>작성</font></a>";
			}
			
			if (dataContext.reptDate3 != " :"){
				w = w + "<br/>[최종] <a href=javascript:fnModify(" + dataContext.id + ",'3')>" + dataContext.reptDate3 + "</a>"
				+ " <font style='background:red;color:#ffffff;cursor:pointer;' onclick=javascript:OpenWindows('report.jsp?id=" + dataContext.id + "&no=03&ek=', '', 900, 1200)'>보고서</font>";
			}else if(dataContext.reptDate2 != " :"){
				w = w + "<br/> [최종] <a href=javascript:fnModify(" + dataContext.id + ",'3')><font style='background:lightgreen;color:#ffffff;'>작성</font></a>";
			}else {
				w = w + "<br/> [최종] -";
			}
			
			return w;
		}
		
		var verticalalignFormatter = function (row, cell, value, columnDef, dataContext) {
			var s = "<br/>" + value;
			return s;
		}
		
		var columns = [
						{ id: "no", name: "No", field: "no", width: 45, formatter: verticalalignFormatter, sortable: true },
						{ id: "reptDate", name: "사고일시", field: "reptDate", width: 130, formatter: verticalalignFormatter,sortable: true },
						{ id: "caseArea", name: "사고장소", field: "caseArea", width: 400, formatter: verticalalignFormatter,sortable: true },
						{ id: "alertName", name: "신고자성명", field: "alertName", width: 90, formatter: verticalalignFormatter,sortable: true },
						{ id: "alertYn", name: "신고사실여부", field: "alertYn", width: 110, formatter: verticalalignFormatter,sortable: true },
						{ id: "reptDate2", name: "보고일시", field: "reptDate2", width: 200, cssClass: "text-align-left line-height padding-left", formatter: contentFormatter/* sortable: true */ }
					];
		var options = {
				enableCellNavigation: true,
				enableColumnReorder: false,
				multiColumnSort: false,
				rowHeight: 55
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function() {
			grid.resetActiveCell();
// 			var obj = grid.getDataItem(grid.getSelectedRows())
// 			view(obj.asId, obj.currentPageNo, obj.alertStep, obj.itemTypeCode);
		});
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		dataView.onRowsChanged.subscribe(function (e, args) {
			grid.invalidateRows(args.rows);
			grid.render();
		});
		
		function comparer(a,b) {
			var x = a[sortcol], y = b[sortcol];
			
			if(sortcol == 'reptDate' || sortcol == 'caseArea' || sortcol == 'no')
				return (x == y ? 0 : (x > y ? 1 : -1));
			else
			{
				x = parseFloat(x);
				y = parseFloat(y);
				if(isNaN(x) && isNaN(y))
					return 0;
				else if(isNaN(x))
					return -1;
				else if(isNaN(y))
					return 1;
					
				return (x == y ? 0 : (x > y ? 1 : -1));
			}
		}
		
		var sortcol = "";
		var sortdir = 1;
		
		grid.onSort.subscribe(function(e, args) {
			
			sortdir = args.sortAsc ? 1 : -1;
			sortcol = args.sortCol.field;
			dataView.sort(comparer, args.sortAsc);
		});
		
// 		selectedSugyeInMemberId(user_riverid , 'sugye');
	});
	
	function reloadData(pageNo){
		showLoading();
		
		var searchCondition = $("#searchCondition").val();
		var searchKeyword = $("#searchKeyword").val();
// 		console.log("searchCondition : ",searchCondition);
// 		console.log("searchKeyword : ",searchKeyword);
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpollution/waterPollutionReportDetail.do'/>",
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
				$("#dataList").css("height", "525px")
				
				var data = [];
				
				if( tot <= 0 ){
// 					console.log("tot : ",tot);
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
				$("#resultText").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}
	
	function view(asId, page, step, itemType){
		
		var system	= $("#system").val();
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		
		startDate = startDate.split('/').join('');
		endDate = endDate.split('/').join('');
		
		var minOr = $('#minOr').val();
		
		document.location.href = "<c:url value='/alert/alertMngView.do'/>?asId="+asId
								+ "&step=" + step
								+ "&pageIndex=" + page
								+ "&itemType=" + itemType
								+ "&system=" + system
								+ "&startDate=" + startDate
								+ "&endDate=" + endDate
								+ "&minOr=" + minOr;
	}
	
	//페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	//상세회면 처리 함수
	function fnModify(id,no){
		var varForm = document.gomodifyForm;
		varForm.action = "<c:url value='/waterpollution/waterPollutionReportModify.do'/>";
		varForm.id.value = id;
		varForm.no.value = no;
		varForm.submit();
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
						
						<form name="Form" action="" method="post">
							<input type="hidden" name="memberId" />
						</form>
						
						<form name="gomodifyForm" action="" method="post">
							<input type="hidden" name="id"/>
							<input type="hidden" name="no"/>
						</form>
						
						<form name="listForm" method="post">
							<!--top Search Start-->
							<div class="topBx">
								<span id="p_total_cnt">[총 0건]</span>
								검색 :
								<select id="searchCondition" name="searchCondition" class="select">
										<option selected="selected" value=''>--선택하세요--</option>
										<option value='name' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>신고자성명</option>
										<option value='phone' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>신고자전화번호</option>
										<option value='area' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>>사고장소</option>
								</select>
								<input id="searchKeyword" name="searchKeyword" type="text" class="fixWidth13" value="${searchVO.searchKeyword}" maxlength="35" onkeydown="if(event.keyCode==13) javascript:reloadData()" />
								
								<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();"/>
								<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_search" onclick="javascript:fnRegist();"/>
							</div>
							<!--top Search End-->
						</form>
						
						<div class="table_wrapper">
							<div id="dataList" style="height: 525px;"></div>
							<table id="searchResult" style="display:none" summary="이동형측정기기정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
							<!-- <div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
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
</body>
</html>