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

var selectedPOI;

	$(function () {
		//사업장조회
		dataView1 = new Slick.Data.DataView();
		
		var columns1 = [
						{ id: "no", name: "No", field: "no", width: 25, sortable: true, cssClass: "slick-pointer" },
						{ id: "nameFull", name: "명칭", field: "nameFull", width: 200, sortable: true, cssClass: "slick-pointer" },
						{ id: "juso", name: "주소", field: "juso", width: 250, sortable: false, cssClass: "slick-pointer" },
						{ id: "ypos", name: "위도", field: "ypos", width: 150, sortable: false, cssClass: "slick-pointer" },
						{ id: "xpos", name: "경도", field: "xpos", width: 150, sortable: false, cssClass: "slick-pointer" }
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
			selectedPOI = grid1.getDataItem(grid1.getSelectedRows());
			console.log(selectedPOI);
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
	
	function panMap(){
		if(selectedPOI==null){
			alert('그리드에서 이동할 지점을 선택하세요.');
			return;
		}
		if(opener == null){
			alert('지도정보가 없습니다. 해당 창을 닫습니다.');
			window.close();
		}
		if(opener){
			opener._MapEventBus.trigger(opener._MapEvents.map_move, {x:selectedPOI.xpos, y:selectedPOI.ypos});
		}
// 		opener.GL_MOVE_XY(selectedPOI.xpos, selectedPOI.ypos);
	}
	
	function searchVworld(){
		
		var keyword = $("#keyword").val();
		if(keyword == null || keyword ==''){
			alert('검색어를 입력하세요.');
			return;
		}
		selectedPOI = null;
		showLoading();
		$.ajax({
			type:"get",
			url:"http://map.vworld.kr/search.do",
			data:{
					q:keyword,
					category:'poi',
					pageUnit:100,
					pageIndex:1,
					output:'json',
					apiKey:'767B7ADF-10BA-3D86-AB7E-02816B5B92E9'
				},
			dataType:"jsonp",
			success:function(result){
// 				console.log("사업장 result : ", result);
				closeLoading();
			   var tot = result.LIST.length;
				dataView1.setItems([]);
				
				$("#searchResult1").hide();
				$("#dataList1").css("height", "301px")
				
				var data = [];
				
				if( tot <= 0 ){
					$("#searchResult1").show();
					$("#dataList1").css("height", "25px");
					$("#resultText1").html("조회 결과가 없습니다.");
				}else{
					for(var i=0; i < tot; i++){
						result.LIST[i].no = i+1;
					}
					dataView1.beginUpdate();
					dataView1.setItems(result.LIST, 'no');
					dataView1.endUpdate();
				}
				
			},
			error:function(result){
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
	<div id="wrap" style="padding:10px;width:95%">
		<div id="container">
			<!--레이어-->
			<!-- Contents Begin Here -->
			<div id="content" class="sub_waterpolmnt" style="padding:0px;width:100%;">
				<div class="content_wrap page_alarmmng">
					<div class="con_tit_wrap">
						<h3>명칭검색</h3> 
					</div>
				</div>
				
				<div class="listView_write" style="padding:0px;width:100%;">
					<div class="popup_situReceive" style=" padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;">
						<fieldset class="first">
							<div style="float:right;margin:20px 0px;">
								<table id="" class="dataTable" style="width:100%; float:left;">
									<colgroup>
										<col width="120px"></col>
										<col></col>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">명칭</th>
											<td>
												<input type="text" id="keyword" name="keyword"  style="width:300px; background-color:#f2f2f2;" onkeypress="if(event.keyCode==13){searchVworld()}"/>
												<a onclick="javascript:searchVworld();" id="searchBtn" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>조회</em></span></a>&nbsp;
												<a onclick="javascript:panMap();" id="moveBtn" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>지도이동</em></span></a>&nbsp;
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="tabDisplayArea"></div>
							<div id="dataList1" style="height:301px; width:800px; text-align:center;"></div>
							<table id="searchResult1" style="display:none; border:1px solid #ccc; width:800px; height:25px;" summary="사업장정보"><tr><td style="text-align:center; vertical-align:middle;"><span id="resultText1">조회 결과가 없습니다.</span></td></tr></table>
		
						</fieldset>
					</div>
				</div>
			</div><!-- //content -->
		</div><!-- //Contents End Here -->
	</div><!-- //wrap -->
</body>
</html>