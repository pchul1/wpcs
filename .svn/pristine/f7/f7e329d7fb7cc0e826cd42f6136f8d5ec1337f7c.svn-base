<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUserPopup.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/smcube/tab.css' />" />

<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>

<script type="text/javascript">
	$(function () {
		//사업장조회
		dataView1 = new Slick.Data.DataView();
		
		var columns1 = [
						{ id: "nameFull", name: "명칭", field: "nameFull", width: 200, sortable: true, cssClass: "slick-pointer" },
						{ id: "juso", name: "주소", field: "juso", width: 250, sortable: false, cssClass: "slick-pointer" },
						{ id: "ypos", name: "위도", field: "ypos", width: 150, sortable: false, cssClass: "slick-pointer" },
						{ id: "xpos", name: "경도", field: "ㅌpos", width: 150, sortable: false, cssClass: "slick-pointer" }
					];
		var options = {
				enableColumnReorder: false,
				enableCellNavigation: true,
				multiColumnSort: false
		};
		
		grid1 = new Slick.Grid("#dataList1", dataView1, columns1, options);
		grid1.setSelectionModel(new Slick.RowSelectionModel());
		
		//관리자조회
		grid1.onSelectedRowsChanged.subscribe(function() {
			grid1.resetActiveCell();
			var obj = grid1.getDataItem(grid1.getSelectedRows());
			console.log(obj);
		});
		
		dataView1.onRowCountChanged.subscribe(function (e, args) {
			grid1.updateRowCount();
			grid1.render();
		});
		
// 		dataView1.onRowsChanged.subscribe(function (e, args) {
//			grid1.invalidateRows(args.rows);
//			grid1.render();
//		});
		
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
	});
	
	//사업장 정보를 가져옵니다.
	function getFactinfoList(pageNo){
	
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
// 				console.log("사업장 result : ", result);
				var tot = result['factinfoList'].length;
				
				dataView1.setItems([]);
				
				$("#factinfoLayer").show();
				$("#searchResult1").hide();
				$("#dataList1").css("height", "301px")
				
				var data = [];
				
				if( tot <= 0 ){
					$("#searchResult1").show();
					$("#dataList1").css("height", "25px");
					$("#resultText1").html("조회 결과가 없습니다.");
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
				$("#searchResult1").show();
				$("#dataList1").css("height", "25px");
				$("#resultText1").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}
	
</script>
</head>

<body style="overflow-x:hidden;overflow-y:hidden;background-image: none;">
	<div id='loadingDiv' style="visibility:hidden;position:absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
	</div>
	<div id="layerFullBgDiv"></div>
	
	<div id="wrap" style="padding:10px;width:95%">
		<div id="container">
			<!--레이어-->
			<div id="factinfoLayer" class="divPopup">
				<div id="dataList1" style="height:301px; width:500px; text-align:center;"></div>
				<table id="searchResult1" style="display:none; border:1px solid #ccc; width:500px; height:25px;" summary="사업장정보"><tr><td style="text-align:center; vertical-align:middle;"><span id="resultText1">조회 결과가 없습니다.</span></td></tr></table>
				<br/>
				<center>
					<input type="text" id="searchKeyword" name="searchKeyword" style="width:200px;"/>
					<a onclick="javascript:getFactinfoList();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>검색</em></span></a>&nbsp;
					<a onclick="javascript:layerController('factinfo');" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>
				</center>
			</div>
		</div><!-- //Contents End Here -->
	</div><!-- //wrap -->
</body>
</html>