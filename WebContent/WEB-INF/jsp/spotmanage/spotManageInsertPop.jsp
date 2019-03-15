<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : spotManageInsertPop.jsp
	 * Description : 측정소 등록 팝업 화면
	 * Modification Information
	 * 
	 * 수정일				수정자			수정내용
	 * ----------		--------	---------------------------
	 * 2012.11.07		이용			최초작성
	 * 2013.11.15		lkh			리뉴얼
	 *
	 * author 이용
	 * since 2012.11.07
	 * 
	 * Copyright (C) 2012by 이용  All right reserved.
	 */
%>
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

<!-- <script type="text/javascript" src="http://js.arcgis.com/3.8/"></script> -->
<script type="text/javascript" src="<c:url value='/gis/js/new_editMap.js'/>"></script>

<script type="text/javascript">
	$(function () {
		//사업장조회
		dataView1 = new Slick.Data.DataView();
		
		var columns1 = [
						{ id: "no", name: "NO", field: "no", width: 45, sortable: true },
						{ id: "fact_code", name: "사업장코드", field: "fact_code", width: 200, sortable: true, cssClass: "slick-pointer" },
						{ id: "fact_name", name: "사업장명", field: "fact_name", width: 240, sortable: true, cssClass: "slick-pointer" }
					];
		var options = {
				enableColumnReorder: false,
				enableCellNavigation: true,
				multiColumnSort: true
		};
		
		grid1 = new Slick.Grid("#dataList1", dataView1, columns1, options);
		grid1.setSelectionModel(new Slick.RowSelectionModel());
		
		//관리자조회
		grid1.onSelectedRowsChanged.subscribe(function() {
			grid1.resetActiveCell();
			var obj = grid1.getDataItem(grid1.getSelectedRows());
			setFactinfoCode(obj);
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
		
		dataView = new Slick.Data.DataView();
		
		var columns = [
// 						{ id: "no", name: "NO", field: "no", width: 45, sortable: true },
						{ id: "deptName", name: "부서", field: "deptName", width: 185, sortable: true },
						{ id: "gradeName", name: "직급", field: "gradeName", width: 150, sortable: true },
						{ id: "memberName", name: "성명", field: "memberName", width: 150, sortable: true }
					];
		var options = {
				enableColumnReorder: false,
				enableCellNavigation: true,
				multiColumnSort: true
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function() {
			grid.resetActiveCell();
			var obj = grid.getDataItem(grid.getSelectedRows());
			onSelMember(obj);
		});
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
// 		dataView.onRowsChanged.subscribe(function (e, args) {
//			grid.invalidateRows(args.rows);
//			grid.render();
//		});
		
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
	/** 레이어 열기,닫기등 처리
	* 파라미터 값으로 던진 레이어ID의 Display속성이 none이면 block으로 변경하고 block이면 none으로 변경 
	* 파라미터 값이 없으면 모든 divPopup 클래스의 레이어를 none처리
	* 사용할 레이어 ID는 [layerName]Layer 형식
	*/
	function layerController(layer){
		if(layer==null || layer==""){
			$("[class=divPopup]").css({"display":"none"});
			$("#layerFullBgDiv").hide();
			return false;
		}
		
		var divId = "#"+layer+"Layer";
		var divObj = $(divId);
		var divDis = divObj.css("display");
		
		if(divDis == "none"){
			var cssWHLT = ["100px","30px","c","m"];//WH사용안함, LT의 경우 c,m일때 가운데 정렬
			//레이어별 위치값 설정 시작
			//위치 세부 설정, Div 전환, a태그의 style을 변경을 위해
			if(layer == "factinfo"){
				$("#fact_code").blur();
				cssWHLT[2] = $("#tab_1_1").position().left;
				cssWHLT[3] = $("#tab_1_1").position().top;
			}
			//레이어 가운데 정렬
			if(cssWHLT[2]=="c")cssWHLT[2] = parseInt(($(window).width()/2)-(divObj.width()/2),10);
			if(cssWHLT[3]=="m")cssWHLT[3] = parseInt(($(window).height()/2)-(divObj.height()/2),10);
			//레이어별 위치값 설정 끝
			
			$("[class=divPopup]").css({"display":"none"});//해당 레이어 열기전 모든 레이어 닫기
			divObj.css("display","block");
			divObj.css({"left":cssWHLT[2],"top":cssWHLT[3]});
// 			$(divId+" tbody").html("");
			$(divId+" input").val("");
			$(divId+" textarea").val("");
			
			$("#layerFullBgDiv").show();
			
			return true;
		}else{
			divObj.css("display","none");
			$("#layerFullBgDiv").hide();
		}
		return false;
	}
	
	function vaildateItem(){
	
		if($('#fact_name').val().length == 0){
			alert("사업장을 선택해 주세요");
			return false;
		}
		//창고명 
		if($('#branch_name').val().length < 2){
			alert("측정소명을 넣어주세요(2자리이상)");
			return false;
		}
		
		//좌표
		if($("#fact_addr").val().length == 0){
			alert('좌표를 선택해 주세요');
			return false;
		}
		
		//관리자명
		if($("#branch_mgr_name").val().length == 0 || $("#branch_mgr_tel_no").val().length == 0){
			alert("관리자를 선택해주세요");
			return false;
		}
		
		//유효거리
// 		if($("#leave_distance").val().length == 0){
// 			if (!confirm("유효거리를 설정하지 않았습니다.\n계속하시려면'예' 아니시면 아니오를 누르세요.")){
// 				return false;
// 			}
// 		}
		return true;
	}
	
	//등록
	function saveFactbranchInfoAdd(){
		
		if(vaildateItem() == true){
			var sysKind = $('#syskind').val();
			var obj = {};
			
			if (sysKind == "A" || sysKind == "U"){
				
				var date = new Date();
				date = date.getFullYear() + addzero(date.getMonth()+1) + addzero(date.getDate());
				
				obj.BRANCH_NO = $("#gis_branch_no").val();
				obj.DATE_= date;
				obj.FACI_ADDR = $("#fact_addr").val();
				obj.FACI_NM = $("#fact_name").val() + "("+ $("#branch_name").val() + ")";
				obj.FACT_CODE = $("#fact_code").val();
				obj.RV_CD = $("#river_div").val();
				obj.X = $("#latitude").val();
				obj.Y = $("#longitude").val();
				obj.USE_FLAG = $("#branch_use_flag").val();
			}
			
			$('#factBranchForm').ajaxForm({
				success:function(result){
					$editMap.model.addMemtPoint(sysKind, obj , function(result){
						
						if(result.callbacktype == 'S')
						{
							alert("저장했습니다");
							self.close();
						}
						else{
							alert("서버접속에 실패하였습니다.\n다시 확인해주세요.");
							return;
						}
					});
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
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		getFactinfoList(pageNo);
	}
	//사업장정보에서 선택한 코드를 텍스트박스에 입력
	function setFactinfoCode(obj){
		$("#fact_code").val(obj.fact_code);
		$("#fact_name").val(obj.fact_name);
		$("#river_div").val(obj.river_div);
		$("#river_no").val(obj.river_no);
		
		layerController("factinfo");
	}
	
	//좌표 지정 팝업
	function lon_lat(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$('#latitude').val(lat);
		$('#longitude').val(lon);
		$("#fact_addr").val(addr.replace('대한민국 ',''));
	}
	
	//관리자 검색  (정)
	function onSearch_member(){
		var searchKey = $('#branch_mgr_name').val();
		
		if(searchKey.length < 2)
			alert("2자리 이상 검색 가능 합니다.");
		else{
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/getSearchMember.do'/>",
				data : {
					searchKeyword:searchKey,
					searchCondition:'name'
				},
				dataType : "json",
// 				beforeSend : function() {
// 				},
				success : function(result) {
// 					console.log("결과 값 확인 : ",result);
					var tot = result['list'].length;
					
					dataView.setItems([]);
					
					$('#memberLayer').show();
					$("#layerFullBgDiv").show();
					
					$("#searchResult").hide();
					$("#dataList").css("height", "276px")
					
					var data = [];
					
					if( tot <= 0 ){
						$("#searchResult").show();
						$("#dataList").css("height", "25px");
						$("#resultText").html("조회 결과가 없습니다.");
					}else{
						for(var i=0; i < tot; i++){
							var obj = result['list'][i];
							
							obj.no = i+1;
							
							data.push(obj);
						}
						dataView.beginUpdate();
						dataView.setItems(data, 'no');
						dataView.endUpdate();
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
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
					
					closeLoading();
				}
			});
		}
	}
	
	function onSelMember(obj){
		$('#branch_mgr_name').val(obj.memberName);
		$('#branch_mgr_tel_no').val(obj.mobileNo);
		$('#branch_mgr').val(obj.memberId);
		
		layerController("member");
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
		
			<!-- Contents Begin Here -->
			<div id="content" class="sub_waterpolmnt" style="padding:0px;width:100%;">
				<div class="content_wrap page_alarmmng">
					<div class="con_tit_wrap">
						<h3>측정소 등록</h3> 
					</div>
				</div>
				
				<div class="listView_write" style="padding:0px;width:100%;">
					<div class="popup_situReceive" style=" padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;">
						<fieldset class="first">
							<div class="tabDisplayArea"></div>
							<form id="factBranchForm" name="factBranchForm" action="/spotmanage/saveFactbranchInfoAdd.do" method="post" >
								<input type="hidden" id="fact_code" name="fact_code" value="" />
								<input type="hidden" id="river_div" name="river_div" value="" />
								<input type="hidden" id="syskind" name="syskind" value="" />
								<input type="hidden" id="branch_mgr" name="branch_mgr" value="" />
								<input type="hidden" id="gis_branch_no" name="gis_branch_no" value="" />
								
								<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
									<colgroup>
										<col width="120px"></col>
										<col></col>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">사업장이름</th>
											<td>
												<input type="text" id="fact_name" name="fact_name" readonly="readonly" onclick="if(layerController('factinfo'))getFactinfoList()" style="width:300px; background-color:#f2f2f2;"/>
												<a onclick="javascript:if(layerController('factinfo'))getFactinfoList()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>지점선택</em></span></a>
											</td>
										</tr>
										<tr>
											<th scope="row">측정소명</th>
											<td><input type="text" id="branch_name" name="branch_name" style="width:380px" /></td>
										</tr>
										<tr>
											<th scope="row">주소</th>
											<td><input type="text" id="fact_addr" name="fact_addr" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
										</tr>
										<tr>
											<th scope="row">좌표</th>
											<td>
												<input type="text" id="latitude" name="latitude" style="width:145px; background-color:#f2f2f2;" readonly="readonly" />&nbsp;
												<input type="text" id="longitude" name="longitude" style="width:145px; background-color:#f2f2f2;" readonly="readonly" />
												<a onclick="javascript:lon_lat();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>좌표선택</em></span></a>
											</td>
										</tr>
										 <tr>
											<th scope="row">관리자명</th>
											<td>
												<input type="text" id="branch_mgr_name" name="branch_mgr_name" value="" style="width:220px"/>
												(두글자 이상 입력)
												<a onclick="javascript:onSearch_member();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>조회</em></span></a>
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
							<div style="float:right;margin:20px 0px;">
								<a onclick="javascript:saveFactbranchInfoAdd();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>&nbsp;
								<a onclick="javascript:window.close();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>
							</div>
						</fieldset>
					</div>
				</div>
			</div><!-- //content -->
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
	
	<div id="memberLayer" class="divPopup" style="margin-top:50px;">
		<div id="dataList" style="height:276px; width:500px; text-align:center;"></div>
		<table id="searchResult" style="display:none; border:1px solid #ccc; width:500px; height:25px;" summary="관리자정보"><tr><td style="text-align:center; vertical-align:middle;"><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
	</div>
	<!--//레이어-->
		</div><!-- //Contents End Here -->
	</div><!-- //wrap -->
</body>
</html>