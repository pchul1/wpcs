<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : ipusn.jsp
	 * Description : IP-USN 모니터링  화면
	 * Modification Information
	 * 
	 * 수정일			수정자 		수정내용
	 * -------		--------    ---------------------------
	 * 2010.05.17	kisspa		최초 생성
	 * 2013.10.20	lkh			 리뉴얼
	 *
	 * author kisspa
	 * since 2010.07.02
	 * version 1.0
	 * see
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
<style type="text/css">
.nogood { color: red }
.good{ color: green } 
.device{ color: blue } 
</style>
<script type="text/javascript">
//<![CDATA[
	$(function () {
		selectedSugyeInMemberId(user_riverid , 'sugye');
		// 목록 데이터 가져오기
		showLoading();
		reloadData();
		
		adjustGongku();
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		});
		
	});
	
	// 데이터 목록 불러오기
	function reloadData(pageNo){
		dataView = new Slick.Data.DataView();
		
		
		var columns = [
						{ id: "rn", name: "순번", field: "rn", width: 60, sortable: false},
						{ id: "river_div_name", name: "수계", field: "river_div_name", width: 100, sortable: false},
						{ id: "branch_name", name: "지점명", field: "branch_name", width: 120, sortable: false, cssClass: "slick-pointer" },
						{ id: "temperature", name: "온도", field: "temperature", width: 60, sortable: false},
						{ id: "humidity", name: "습도", field: "humidity", width: 60, sortable: false},
						{ id: "battery", name: "배터리", field: "battery", width: 70, sortable: false},
						{ id: "input_time", name: "접속시간", field: "input_time", width: 150, sortable: false},
						{ id: "nowlocation", name: "위치", field: "nowlocation", width: 120, sortable: false, cssClass: "slick-pointer" },
						{ id: "device_st", name: "장비상태", field: "device_st", width: 250, sortable: false}
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
		
		
		//그리드 클릭
		grid.onClick.subscribe(function(e, args) {
			var obj = grid.getDataItem(args.row);
			var param = "branch_no="+ obj.branch_no + "&fact_code=" + obj.fact_code;
			if (args.cell == 2) {
				window.open("/ipusn/ipusnbranchhistorylist.do?"+param, "getView", "width=1025, height=700,left=200,top=200,toolbar=no,status=yes,scrollbars=no,resizable=no");
			}
			if (args.cell == 7) {
				OpenWindow(param);
			}
		});
		
		/////////////////////////////////////검색//////////////////////////////////
		showLoading();
		//수계
		var sugye = $("#sugye option:selected").val();
		var branch_name = $("#branchNo option:selected").text();
		if(branch_name == "전체"){
			branch_name = "";
		}
		
		if (pageNo == null) pageNo = 0;
		var data = [];

		$.ajax({
			type: "POST",
			url: "<c:url value='/ipusn/getipusnlist.do'/>",
			data: {
					pageIndex:pageNo,
					sugye:sugye,
					branch_name:branch_name
				},
			dataType:"json",
			success : function(result){
				var tot = result['resultList'].length;
				
				dataView.setItems([]);
				
				//var height = sGridCmn(1,result['resultList'],20);
				var height = sGridCmn(1,result['resultList'],20,25);
				$("#dataList").css("height", height + 9+ "px");
				grid.resizeCanvas();
				
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
					var backcolor = new Array(); 
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						obj.no = i;
						
						sub = new Object();
						sub["branch_name"] =  "blue";
						switch(SelectIpUsnDistance(obj.latitude1, obj.longitude1, obj.latitude2, obj.longitude2, "M", obj.gps_dist)){
							case 0 : 
								obj.nowlocation = "위치불명";
								break;
							case 1 :
								obj.nowlocation = "위치없음";
								break;
							case 2 : 
								obj.nowlocation = "위치이탈";
								sub["nowlocation"] =  "nogood";
								break;
							case 3 :
								obj.nowlocation = "위치정상";
								sub["nowlocation"] =  "good";
								break;
						}
						backcolor[i] = sub;
						
						obj.device_st = SelectIpUsnstr(obj.device_st);
						data.push(obj);
					}
					//색상 넣기
					grid.setCellCssStyles("Location_Highright", backcolor);
					
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
				}
				// 총건수 표시
 				$("#p_total_cnt").html("[총 " + tot + "건]");
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
				data.push({no:"서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]"});
				dataView.setItems(data, 'no');
				
				var height = sGridCmn(1,data,1);
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				closeLoading();
			}
		});
	}
	
	function excelDown(){
		var branch_name = $("#branchNo option:selected").text();
		if(branch_name == "전체"){
			branch_name = "";
		}
		document.frm1.branch_name.value=branch_name;
		document.frm1.action = "/ipusn/getExcelipusnlist.do";
		document.frm1.submit();
	}
	function SelectIpUsnDistance(latitude1, longitude1, latitude2, longitude2, mode, desc_dist){
		if(!latitude2){
			return 0;
		}else{
		    var gps_dist = Number(desc_dist);
			var Lat1 = Number(latitude1);
			var Long1 = Number(longitude1);
			var Lat2 = Number(latitude2);
			var Long2 = Number(longitude2);
			 
	        var dLat1InRad = Lat1 * (3.14159265358979323846/ 180.0);
	        var dLong1InRad = Long1 * (3.14159265358979323846/ 180.0);
	        var dLat2InRad = Lat2 * (3.14159265358979323846/ 180.0);
	        var dLong2InRad = Long2 * (3.14159265358979323846/ 180.0);
	
	        var dLongitude = dLong2InRad - dLong1InRad;
	        var dLatitude = dLat2InRad - dLat1InRad;
	
	        // Intermediate result a.
	        var a = Math.pow(Math.sin(dLatitude / 2.0), 2.0) + 
	            Math.cos(dLat1InRad) * Math.cos(dLat2InRad) * 
	            Math.pow(Math.sin(dLongitude / 2.0), 2.0);
	
	        // Intermediate result c (great circle distance in Radians).
	        var c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1.0 - a));
	
	        // Distance.
	        // const Double kEarthRadiusMiles = 3956.0;
	        var kEarthRadiusKms = 6376.5;
	        dDistance = kEarthRadiusKms * c;
	        
	        if(mode == "M"){	//미터
	        	dDistance = dDistance*1000;
	        }else if(mode == "K"){	//킬로미터
	        	dDistance = dDistance;
	        }
	        	
			if(dDistance > gps_dist) {
				if(latitude2 == "0" ) {
					return 1;
				} else {
					return 2;
				}
			} else {
				return 3;
			}
		}
    }		
	
	function SelectIpUsnstr(device_st){
		switch(device_st){
			case "OK" : return "정상"; break; 
			case "A0" : return "전원이상 - 메인전원"; break;
			case "B0" : return "점검/보수중 - 측정기기 보수"; break; 
			case "B1" : return "점검/보수중 - 측정기기 부품 교환(센서, 기타)"; break;
			case "B2" : return "점검/보수중 - 측정기기 부품 교환"; break;
			case "B3" : return "점검/보수중 - 측정기기 Overhaul cleaning"; break;
			case "B4" : return "점검/보수중 - 측정기기 점검(정기, 수시)"; break;
			case "B5" : return "점검/보수중 - 전송장비 점검/보수"; break;
			case "C0" : return "장비이상 - 측정기기 이상"; break;
			case "E1" : return "교정중 - 수동 교정"; break;
			case "E2" : return "교정중 - 정도 관리"; break;
			case "F0" : return "시운전 - 시운전"; break;
			case "G0" : return "가동중지 - 가동중지(측정기)"; break;
			case "Z9" : return "영구중단"; break;
		}
	}

	function OpenWindow(param) {
		url = "/ipusn/getipusnmap.do?" + param;

		var qResult = window.open( url, "getipusnmap", "width=600, height=600,left=200,top=200,toolbar=no,status=yes,scrollbars=no,resizable=no");
		//return qResult;
	}
	
	function adjustGongku()
	{
		var sugyeCd = $('#sugye').val();
		var sys_kind = 'U';
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					adjustBranchList();
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranchList()
	{
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#branchNo');
		
		if( factCode == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//console.log("결과:",data);
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					reloadData('1');
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="/images/common/ajax-loader2.gif" alt="로딩중.." />
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
						<div class="tab_container">
							<form method="post" name="frm1">
							<input type="hidden" name="branch_name" value="">
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">측정소 위치</span>
										<select class="fixWidth7" id="sugye" name="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<span style="display:none;">&gt;</span>
										<select class="fixWidth11" id="factCode" name="factCode" style="display:none;">
											<option value="all">전체</option>
										</select>
										<span>&gt;</span>
										<select class="fixWidth11" id="branchNo" name="branchNo"  disabled="disabled">
											<option value="all">전체</option>
										</select>
									</li>
								</ul>
							</div>
							<div class="btnSearchDiv">
<!-- 								<a id="btnSearch" name="btnSearch" class="btn roundBox" onclick="javascript:reloadData();" style="float:right;">조회하기</a> -->
								<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
							</div>							
							</form>
							<div id="btArea">
								<span id="p_total_cnt">▶ 검색결과 [총 ${totCnt}건]</span>
								<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
							</div>
							<div class="table_wrapper">
								<div id="dataList" class="dataList"></div>
							</div>
							<!-- 2014-10-21 mypark 페이징 추가-->
							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
									<%-- <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" /> --%>
								</div>
							</div>
						</div>
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