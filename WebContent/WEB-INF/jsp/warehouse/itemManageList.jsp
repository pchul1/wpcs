<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : itemManageList.jsp
	 * Description : 방제물품 물품관리 목록 화면
	 * Modification Information
	 * 
	 *	수정일			수정자			수정내용
	 *  -------		--------	---------------------------
	 * 2012.11.07	 윤일권		최초 생성
	 * 2013.10.30	lkh			리뉴얼
	 *
	 * author 윤일권
	 * since 2012.11.07
	 * version 1.0
	 * see
	 *  
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

	function init_first(){
		getUpperGroupCode();
	
		<sec:authorize  ifAnyGranted="ROLE_ADMIN">
			$('#btnRegist').show();		
		</sec:authorize>	
	}
	
	//페이징 처리 함수
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/warehouse/itemManageList.do'/>";
		document.listForm.submit();
	}
	
	//조회 처리
	function fnSearch(){
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	
	//등록 처리 함수
	function fnRegist(){
		location.href = "<c:url value='/warehouse/itemManageRegist.do'/>";
	}

	//상세회면 처리 함수
	function fnDetail(codeId){
		//alert(codeId);
		var varForm = document.all["godetailForm"];
		varForm.action = "<c:url value='/warehouse/itemManageModify.do'/>";
		varForm.itemCode.value = codeId;
		varForm.submit();
	}
	
	//대분류 코드 불러오기
	function getUpperGroupCode(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				$('#searchUpperGroupCode').attr("disabled", true);
			},
			success:function(result){
				var dropDownSet = $('#searchUpperGroupCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#searchUpperGroupCode').attr("disabled", false);
				
				if(	$('#search_UpperGroupCode').val() != ''){
					$('#searchUpperGroupCode').val($('#search_UpperGroupCode').val());
					getGroupCode();
					$('#search_UpperGroupCode').val(''); 
				}
			}
		});
	}
	
	//중분류 코드 불러오기
	function getGroupCode(){
		var upperGroupCode = $('#searchUpperGroupCode').val();
	
		if(upperGroupCode == ''){
			$('#searchGroupCode').html("<option value=''>선택</option>");
		}else{
			$.ajax({
				type:"POST",
				url:"<c:url value='/warehouse/itemManageGroupCode.do'/>",
				data:{
					upperGroupCode : upperGroupCode
					},
				dataType:"json",
				beforeSend:function(){
					$('#searchGroupCode').attr("disabled", true);
				},
				success:function(result){
					var dropDownSet = $('#searchGroupCode');
					dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
					$('#searchGroupCode').attr("disabled", false);
					
					if($('#search_GroupCode').val() != ''){
						$('#searchGroupCode').val($('#search_GroupCode').val());
						$('#search_GroupCode').val('');
					}
				}
			});
		}
	}
	
	$(function () {
		reloadData();
		
		dataView = new Slick.Data.DataView();
		
		var CommaFormatter = function (row, cell, value, columnDef, dataContext) {
			if (value === null || value === "" || !(value > 0)) {
				return value;
			} else {
				return comma(value);
			}
		}
		
		var buttonFormatter = function (row, cell, value, columnDef, dataContext) {
			var s = "";
			
			for(var i = 1 ; i < 13 ; i++ ) {
				if (dataContext["type" + i + "ApplFlag"] == "Y") {
					s = s + "<img src='/images/warehouse/type" + i  + ".png' style='vertical-align:middle;'/>&nbsp;";
				}
			}
			return s;
		};
		
		var columns = [
						{ id: "nog", name: "No", field: "no", width: 45, sortable: true},
						{ id: "groupCodeg", name: "물품분류", field: "groupCode", width: 170, sortable: true },
						{ id: "itemCodeg", name: "물품코드", field: "itemCode", width: 120, sortable: true },
						{ id: "itemNameg", name: " 물품명", field: "itemName", width: 180, sortable: true },
						{ id: "itemUnitg", name: "규격", field: "itemUnit", width: 110, sortable: true },
						{ id: "itemStang", name: "단위", field: "itemStan", width: 70, sortable: true },
						{ id: "priceg", name: "금액", field: "price", width: 110, formatter: CommaFormatter, sortable: true },
						{ id: "usepictureg", name: "사고적용여부", field: "usepicture", width: 170, formatter: buttonFormatter/* , sortable: true */ }
					];
		var options = {
				enableCellNavigation: true,
				enableColumnReorder: false,
				multiColumnSort: true,
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function() {
			grid.resetActiveCell();
			var obj = grid.getDataItem(grid.getSelectedRows())
			fnDetail(obj.itemCode);
		});
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
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
		
		var searchUpperGroupCode = $('#searchUpperGroupCode').val();
		var searchGroupCode = $('#searchGroupCode').val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getItemManageList.do'/>",
			data: { searchUpperGroupCode:searchUpperGroupCode,
					searchGroupCode:searchGroupCode,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
				//console.log("getItemManageList : ",result);
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				dataView.setItems([]);
				$("#searchResult").hide();
				
				var height = sGridCmn(1,result['resultList'],20);
// 				height += 17;	//컬럼의 width사이즈가 화면영역 보다 큰 경우 하단 스크롤을 위해 15를 더해준다.(예.기본 contants width가 900인데 이보다 큰경우)
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				var data = [];
				
				if( tot <= 0 ){
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("조회 결과가 없습니다.");
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
</script>
</head>

<body onload="init_first();">
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
							<input type="hidden" name="itemCode" id="itemCode"/>
						</form>
						<form name="listForm" method="post">
						
							<div class="searchBox">
								<ul>
									<li>
										<input type="hidden" id="search_UpperGroupCode" name="search_UpperGroupCode" value="${searchVO.searchUpperGroupCode}">
										<input type="hidden" id="search_GroupCode"	  name="search_GroupCode"	  value="${searchVO.searchGroupCode}">
										<select class="fixWidth20" name="searchUpperGroupCode" id="searchUpperGroupCode" onchange="javascript:getGroupCode();">
											<option value="">선택</option> 
										</select>
										<select class="fixWidth20" name="searchGroupCode" id="searchGroupCode">
											<option value="">선택</option> 
										</select>
									</li>
									<li class="last">
<!--										<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:fnSearch();"/> -->
										<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();"/>
									</li>
								</ul>
							</div>
						
						</form>
							
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:fnRegist();" style="display:none" />
						</div>
						
						<div class="table_wrapper">
						
							<input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
							
							<div id="dataList" style="height: 400px;"></div>
							<table id="searchResult" style="display:none" summary="결과정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
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