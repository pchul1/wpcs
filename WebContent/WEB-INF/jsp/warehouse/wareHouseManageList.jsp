<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : wareHouseManageList.jsp
	 * Description : 방제물품 창고관리 목록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2012.11.07	윤일권		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author 윤일권
	 * since 2012.11.07
	 *
	 * Copyright (C) 2012by 윤일권  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript">
//<![CDATA[
	function init(){
		<sec:authorize ifAnyGranted="ROLE_ADMIN">
			$('#registGruopCodeBtn').show();
		</sec:authorize>
	}
	
	//페이징 처리 함수
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/warehouse/wareHouseManageList.do'/>";
		document.listForm.submit();
	}
	//조회 처리 
//	function fnSearch(){
//		document.listForm.pageIndex.value = 1;
//		document.listForm.submit();
//	}
	
	function fnFirstSearch(){
		var varForm = document.all["listForm"];
		varForm.action = "<c:url value='/warehouse/wareHouseManageList.do'/>";
		
		varForm.searchWhName.value = '';
		varForm.searchDeptName.value = '';
		
		varForm.submit();
	}
	//등록 처리 함수 
	function fnRegist(){
		location.href = "<c:url value='/warehouse/wareHouseManageRegist.do'/>";
	}
	//상세회면 처리 함수
	function fnDetail(codeId){
		var varForm = document.all["godetailForm"];
		varForm.action = "<c:url value='/warehouse/wareHouseManageModify.do'/>";
		varForm.whCode.value = codeId;
		varForm.submit();
	}
	
	var dataView = null;
	var grid	 = null;
	
	$(function () {
		
		reloadData();
		
		dataView = new Slick.Data.DataView();
		
		var columns = [
						{ id: "nog", name: "No", field: "no", width: 45, sortable: true, cssClass: "slick-pointer" },
						{ id: "whCodeg", name: "창고코드", field: "whCode", width: 120, sortable: true, cssClass: "slick-pointer" },
						{ id: "whNameg", name: "창고명", field: "whName", width: 350, sortable: true, cssClass: "slick-pointer" },
						{ id: "adminDeptg", name: "담당부서", field: "adminDept", width: 130, /* sortable: true, */ cssClass: "slick-pointer" },
						{ id: "adminNameg", name: "담당자", field: "adminName", width: 90, /* sortable: true, */ cssClass: "slick-pointer" },
						{ id: "adminTelnog", name: "연락처", field: "adminTelno", width: 140, /* sortable: true, */ cssClass: "slick-pointer" },
						{ id: "useFlagg", name: "사용여부", field: "useFlag", width: 100, /* sortable: true, */ cssClass: "slick-pointer" }
					];
		var options = {
				enableColumnReorder: false,
				multiColumnSort: false,
				enableCellNavigation: true
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function() {
			grid.resetActiveCell();
			var obj = grid.getDataItem(grid.getSelectedRows())
			fnDetail(obj.whCode);
		});
		
		// wire up model events to drive the grid
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		function comparer(a,b) {
			var x = a[sortcol], y = b[sortcol];
			 
			if(sortcol == 'whCode' || sortcol == 'whName' || sortcol == 'no')
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
			
			// using native sort with comparer
			// preferred method but can be very slow in IE with huge datasets
			dataView.sort(comparer, args.sortAsc);
		});
	});
	
	function reloadData(pageNo){
		showLoading();
		
		var searchWhName = $("#searchWhName").val();
		var searchDeptName = $("#searchDeptName").val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getWareHouseManageList.do'/>",
			data: { searchWhName:searchWhName,
					searchDeptName:searchDeptName,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
				//console.log("결과 값 확인 : ",result);
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				dataView.setItems([]);
				$("#searchResult").hide();
				
				var height = sGridCmn(1,result['resultList'],20);
// 				height += 17;	//컬럼의 width사이즈가 화면영역 보다 큰 경우 하단 스크롤을 위해 15를 더해준다.(예.기본 contants width가 900인데 이보다 큰경우)
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				if( tot <= 0 ){
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("조회 결과가 없습니다.");
				}else{
					var data = [];
					
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						obj.useFlag = (obj.useFlag == 'Y') ? "사용" : "미사용";
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
				}
				// 페이징 정보
//				var pageStr = makePaginationInfo(result['paginationInfo']);
//				$("#pagination").empty();
//				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("총 " + result['totCnt'] + "건");
				
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
				$("#searchResult").show();
				$("#dataList").css("height", "25px");
				$("#resultText").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
//]]>
</script>
</head>

<body onload="init();">
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

						<form name="godetailForm" action="" method="post">
							<input type="hidden" name="whCode"/>
						</form>
						
						<form name="listForm" action="<c:url value='/warehouse/wareHouseManageList.do'/>" method="post">
									
						<div class="searchBox">
							<ul>
								<li>
									<span>창고명</span>
									<input type="text" name="searchWhName" id="searchWhName" size="35" value="${searchVO.searchWhName}" maxlength="35" style="ime-mode:active;"/>
								</li>
								<li>
									<span>담당부서명</span>
									<input type="text" name="searchDeptName" id="searchDeptName" size="35" value="${searchVO.searchDeptName}" maxlength="35" style="ime-mode:active;"/>
								</li>
								<li class="last">
<!--									<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:fnSearch();"/> -->
									<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();"/>
<!--									<input type="button" id="btnFirstSearch" name="btnFirstSearch" value="전체조회" class="btn btn_search" onclick="javascript:fnFirstSearch();"/> -->
								</li>
							</ul>
						</div>
						
						<div id="btArea" >
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<!-- //방제물품 창고관리의 등록과 같으므로 생량 김경환 20140522 -->
<!-- 							<input type="button" id="registGruopCodeBtn" name="registGruopCodeBtn" value="등록" class="btn btn_basic" onclick="javascript:fnRegist();" style="display: none;"/> -->
						</div>
						
						<input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						
						<div class="table_wrapper">
						
							<div id="dataList" style="height: 400px;"></div>
							<table id="searchResult" style="display:none" summary="결과정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
							
<!--							<ul class="paginate"> -->
<%--								<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage"/> --%>
<!--							</ul> -->
								<div class="paging">
									<div id="page_number">
										<ul class="paginate" id="pagination"></ul>
									</div>
								</div>
							
						</div>
						</form>
				
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